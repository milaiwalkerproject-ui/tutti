-- Phase 5 — "dates decide" (approved by Milai 2026-10-10; see PHASE-5-PLAN.md).
--
-- Until now an audition's badge ("Open now", "Upcoming") came from a status a
-- curator typed by hand, and nothing ever expired it: labels set in July were
-- still saying "Open now" in October. From this migration on, a round's timing
-- is carried as two optional dates and the app computes the badge from them:
--
--   opens_on   first day families can apply for this round
--   closes_on  last day to get in: the application deadline, or the last
--              audition day when there is no deadline
--
-- Both restate dates from the audition's VERIFIED "window" (same cited source,
-- same as-of date), so the database only accepts them on a verified window —
-- a guessed date can't enter through any path — and a round can't close before
-- it opens. Nothing is renamed or removed; existing rows simply carry no dates
-- until a curation pass fills them in, and the app shows "Check their site"
-- for those in the meantime.
--
-- Append-only: new columns and named CHECKs here, plus the read view re-created
-- with the same columns. Audition entries gain "opensOn" / "closesOn" keys only
-- when set, so the API stays field-for-field identical to data.json.

begin;

alter table public.auditions
  add column opens_on  date,
  add column closes_on date;

alter table public.auditions
  add constraint auditions_dates_need_verified_window
    check ((opens_on is null and closes_on is null)
           or ("window" ->> 'status') = 'verified'),
  add constraint auditions_dates_in_order
    check (opens_on is null or closes_on is null or opens_on <= closes_on);

comment on column public.auditions.opens_on is
  'First day families can apply for this round. Only allowed with a verified window (restates its cited date).';
comment on column public.auditions.closes_on is
  'Last day to get in for this round: the application deadline, or the last audition day if there is none. Only allowed with a verified window.';

-- Same view as 20260623120001_listings_view.sql, with the two dates added to
-- each audition entry when present. Column list and order are unchanged, so
-- `create or replace` keeps the existing grants and RLS behaviour.
create or replace view public.org_listings
  with (security_invoker = true)
as
select
  o.id,
  o.name,
  o.type,
  o.lat,
  o.lng,
  o.area,
  o.metro,
  o.website,
  o.apply_url                                   as "applyUrl",
  o.blurb,
  o.season,
  to_jsonb(o.ages)                              as ages,
  coalesce(to_jsonb(o.instruments), '[]'::jsonb) as instruments,
  o.rehearsal,
  o.commitment,
  o.financial_aid                               as "financialAid",
  o.tuition,
  o.good_fit                                    as "goodFit",
  o.reviews,

  -- ensembles, ordered for display
  coalesce((
    select jsonb_agg(jsonb_build_object(
             'name',  e.name,
             'level', e.level,
             'ages',  to_jsonb(e.ages),
             'desc',  e."desc"
           ) order by e.position, e.id)
    from public.ensembles e
    where e.org_id = o.id
  ), '[]'::jsonb)                               as ensembles,

  -- performances, soonest first
  coalesce((
    select jsonb_agg(jsonb_build_object(
             'date',    to_char(p.date, 'YYYY-MM-DD'),
             'title',   p.title,
             'venue',   p.venue,
             'program', p.program,
             'from',    p."from",
             'source',  p.source
           ) order by p.date, p.id)
    from public.performances p
    where p.org_id = o.id
  ), '[]'::jsonb)                               as performances,

  -- auditions, in curated order; opensOn / closesOn only when set
  coalesce((
    select jsonb_agg(
             jsonb_build_object(
               'level',       a.level,
               'instruments', a.instruments,
               'window',      a."window",
               'status',      a.status,
               'ages',        to_jsonb(a.ages),
               'note',        a.note,
               'source',      a.source
             )
             || case when a.opens_on is null then '{}'::jsonb
                     else jsonb_build_object('opensOn', to_char(a.opens_on, 'YYYY-MM-DD')) end
             || case when a.closes_on is null then '{}'::jsonb
                     else jsonb_build_object('closesOn', to_char(a.closes_on, 'YYYY-MM-DD')) end
           order by a.position, a.id)
    from public.auditions a
    where a.org_id = o.id
  ), '[]'::jsonb)                               as auditions,

  -- sources (audit trail)
  coalesce((
    select jsonb_agg(jsonb_build_object(
             'url',         s.url,
             'label',       s.label,
             'retrievedAt', case when s.retrieved_at is null then null
                                 else to_char(s.retrieved_at, 'YYYY-MM-DD') end
           ) order by s.position, s.id)
    from public.org_sources s
    where s.org_id = o.id
  ), '[]'::jsonb)                               as sources,

  case when o.last_verified is null then null
       else to_char(o.last_verified, 'YYYY-MM-DD') end as "lastVerified",
  o.listing_status                              as "listingStatus",
  o.provenance_type                             as "provenanceType",
  o.submitted_by                                as "submittedBy"
from public.organizations o
where o.listing_status = 'published';

comment on view public.org_listings is
  'Public read API for the map/rail/boards. Returns published orgs in the front-end data.json shape.';

commit;
