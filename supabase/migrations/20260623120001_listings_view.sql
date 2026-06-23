-- Tutti — Phase 3.2 read API surface
--
-- `org_listings` reassembles each published organization into the EXACT JSON shape
-- the front-end already consumes (the data.json org object): camelCase keys, verifiable
-- facts passed through untouched, and child collections nested as arrays. The front-end
-- therefore needs no data-shape changes — only its fetch target moves to this view.
--
-- security_invoker = true  ->  the view runs with the *caller's* privileges, so the
-- public-read RLS policies (next migration) are enforced. Defense in depth: the view
-- also filters listing_status = 'published' itself.

begin;

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

  -- auditions, in curated order
  coalesce((
    select jsonb_agg(jsonb_build_object(
             'level',       a.level,
             'instruments', a.instruments,
             'window',      a."window",
             'status',      a.status,
             'ages',        to_jsonb(a.ages),
             'note',        a.note,
             'source',      a.source
           ) order by a.position, a.id)
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
