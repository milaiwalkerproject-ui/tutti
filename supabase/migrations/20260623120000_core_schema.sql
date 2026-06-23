-- Tutti — Phase 3.1 core schema
-- Translates schema.json (the canonical Phase 2 data contract) into Postgres.
--
-- Design notes
-- ------------
-- * The verifiable facts (season, rehearsal, commitment, financialAid, tuition,
--   each performance's price `from`, each audition's `window`) are stored as JSONB
--   so their exact {status, value, source, asOf} shape is preserved — the same shape
--   the front-end already renders. A CHECK constraint enforces the honesty contract
--   at the database level: a `verified` field MUST carry a value + source, and an
--   `unverified` field MUST NOT carry a value. A guess cannot masquerade as confirmed.
-- * Stable identity fields (name, type, lat/lng, website) and editorial fields
--   (blurb, goodFit) stay plain columns.
-- * `metro` is constrained to the single allowed value so out-of-area data fails to
--   insert — scope creep cannot enter through the data (mirrors the schema.json enum).
-- * Child collections (ensembles, performances, auditions, sources) are real tables
--   keyed to the org, with a `position` column so display order is preserved.

begin;

-- ----------------------------------------------------------------------------
-- Enums (mirror the schema.json enums)
-- ----------------------------------------------------------------------------
create type public.org_type        as enum ('youth', 'professional', 'community', 'collegiate');
create type public.ensemble_level  as enum ('Beginner', 'Intermediate', 'Advanced', 'Pre-professional', 'Professional');
create type public.audition_status as enum ('open', 'upcoming', 'rolling');
create type public.listing_status  as enum ('draft', 'in_review', 'published');
create type public.provenance_type as enum ('curated', 'self_submitted', 'scraped');
create type public.instrument      as enum ('Strings', 'Winds', 'Brass', 'Percussion', 'Harp');

-- ----------------------------------------------------------------------------
-- Honesty contract, enforced in the database
-- ----------------------------------------------------------------------------
-- Validates a verifiable fact object. NULL is allowed (optional field absent).
--   verified       -> must have a non-null value AND a non-null source
--   unverified     -> must NOT carry a value (no guesses smuggled in)
--   not_applicable -> no further constraint (the row is hidden in the UI)
create or replace function public.tutti_verifiable_ok(v jsonb)
returns boolean
language sql
immutable
as $$
  select
    v is null
    or (
      jsonb_typeof(v) = 'object'
      and (v ->> 'status') in ('verified', 'unverified', 'not_applicable')
      and case (v ->> 'status')
            when 'verified'   then (v -> 'value') is not null
                                   and jsonb_typeof(v -> 'value') <> 'null'
                                   and (v ->> 'source') is not null
                                   and length(v ->> 'source') > 0
            when 'unverified' then (v -> 'value') is null
                                   or jsonb_typeof(v -> 'value') = 'null'
            else true
          end
    );
$$;

-- Validates the reviews object: NULL until a real aggregated source exists.
create or replace function public.tutti_reviews_ok(v jsonb)
returns boolean
language sql
immutable
as $$
  select
    v is null
    or (
      jsonb_typeof(v) = 'object'
      and jsonb_typeof(v -> 'rating') = 'number'
      and jsonb_typeof(v -> 'count')  = 'number'
      and (v ->> 'source') is not null
      and length(v ->> 'source') > 0
    );
$$;

-- ----------------------------------------------------------------------------
-- organizations
-- ----------------------------------------------------------------------------
create table public.organizations (
  id              text primary key
                    check (id ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$' and char_length(id) <= 40),
  name            text not null check (char_length(name) > 0),
  type            public.org_type not null,
  lat             double precision not null check (lat between -90 and 90),
  lng             double precision not null check (lng between -180 and 180),
  area            text not null check (char_length(area) > 0),
  metro           text not null check (metro = 'Greater Los Angeles'),  -- scope guard
  website         text not null,
  apply_url       text,
  blurb           text not null check (char_length(blurb) > 0),
  season          jsonb check (public.tutti_verifiable_ok(season)),
  ages            integer[] not null
                    check (array_length(ages, 1) = 2 and ages[1] <= ages[2]
                           and ages[1] >= 0 and ages[2] <= 99),
  instruments     public.instrument[],
  rehearsal       jsonb check (public.tutti_verifiable_ok(rehearsal)),
  commitment      jsonb check (public.tutti_verifiable_ok(commitment)),
  financial_aid   jsonb check (public.tutti_verifiable_ok(financial_aid)),
  tuition         jsonb check (public.tutti_verifiable_ok(tuition)),
  good_fit        text,
  reviews         jsonb check (public.tutti_reviews_ok(reviews)),
  last_verified   date,
  listing_status  public.listing_status  not null default 'draft',
  provenance_type public.provenance_type not null default 'curated',
  submitted_by    jsonb,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

comment on table public.organizations is
  'One listing per org. Only listing_status = ''published'' is exposed to the public (anon) role via RLS.';
comment on column public.organizations.metro is
  'Scope guard for v1 — constrained to ''Greater Los Angeles'' so out-of-area data cannot be inserted.';

-- Only published rows reach parents; index the gate.
create index organizations_published_idx on public.organizations (listing_status);
create index organizations_type_idx       on public.organizations (type);

-- ----------------------------------------------------------------------------
-- ensembles (graded groups within an org)
-- ----------------------------------------------------------------------------
create table public.ensembles (
  id        bigint generated always as identity primary key,
  org_id    text not null references public.organizations(id) on delete cascade,
  position  integer not null default 0,
  name      text not null check (char_length(name) > 0),
  level     public.ensemble_level not null,
  ages      integer[] not null
              check (array_length(ages, 1) = 2 and ages[1] <= ages[2]),
  "desc"    text
);
create index ensembles_org_idx on public.ensembles (org_id, position);

-- ----------------------------------------------------------------------------
-- performances (concerts)
-- ----------------------------------------------------------------------------
create table public.performances (
  id        bigint generated always as identity primary key,
  org_id    text not null references public.organizations(id) on delete cascade,
  position  integer not null default 0,
  date      date not null,
  title     text not null check (char_length(title) > 0),
  venue     text,
  program   text,
  "from"    jsonb not null check (public.tutti_verifiable_ok("from")),  -- ticket price; value 0 = free
  source    text
);
create index performances_org_idx  on public.performances (org_id, date);

-- ----------------------------------------------------------------------------
-- auditions (audition opportunities)
-- ----------------------------------------------------------------------------
create table public.auditions (
  id           bigint generated always as identity primary key,
  org_id       text not null references public.organizations(id) on delete cascade,
  position     integer not null default 0,
  level        public.ensemble_level not null,
  instruments  text not null check (char_length(instruments) > 0),
  "window"     jsonb not null check (public.tutti_verifiable_ok("window")),  -- most volatile field
  status       public.audition_status not null,
  ages         integer[] not null
                 check (array_length(ages, 1) = 2 and ages[1] <= ages[2]),
  note         text,
  source       text
);
create index auditions_org_idx on public.auditions (org_id, position);

-- ----------------------------------------------------------------------------
-- org_sources (audit trail: pages consulted when curating an org)
-- ----------------------------------------------------------------------------
create table public.org_sources (
  id           bigint generated always as identity primary key,
  org_id       text not null references public.organizations(id) on delete cascade,
  position     integer not null default 0,
  url          text not null,
  label        text,
  retrieved_at date
);
create index org_sources_org_idx on public.org_sources (org_id, position);

-- Keep updated_at honest on edits.
create or replace function public.tutti_touch_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end;
$$;
create trigger organizations_touch_updated_at
  before update on public.organizations
  for each row execute function public.tutti_touch_updated_at();

commit;
