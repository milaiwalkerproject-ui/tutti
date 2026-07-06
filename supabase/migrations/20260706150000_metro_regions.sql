-- Region model for the Southern California scope (approved by Milai
-- 2026-07-06, batch-2 expansion — see UNVERIFIED-FIELDS-SOCAL.md decision 7):
-- each organization now carries its REGION (six values) instead of the single
-- blanket 'Southern California' label. The overall scope is unchanged —
-- Bakersfield to San Diego, coast to ~Irvine, ±50 miles; these are the
-- regions within it. The guard stays a closed list, so out-of-scope data
-- still cannot be inserted.
--
-- Statement order matters and is deliberate: the OLD constraint must drop
-- BEFORE the relabel (updating a row re-checks it against the standing
-- constraint), and the NEW constraint is added after (its addition validates
-- every existing row). The whole file runs in one transaction, so the table
-- is never actually unguarded. The first version of this file had the update
-- first; it failed against the hosted database (which has rows) and was
-- corrected before ever being recorded as applied anywhere durable.

alter table public.organizations
  drop constraint organizations_metro_check;

-- Rows written under the blanket label are the original Greater Los Angeles
-- orgs. (On a fresh `db reset` the table is empty here and this is a no-op.)
update public.organizations
  set metro = 'Greater Los Angeles'
  where metro = 'Southern California';

alter table public.organizations
  add constraint organizations_metro_check
  check (metro in (
    'Greater Los Angeles',
    'Orange County',
    'San Diego County',
    'Ventura County',
    'Kern County',
    'Inland Empire'
  ));

comment on column public.organizations.metro is
  'Region within the Southern California scope (Bakersfield–San Diego, coast to ~Irvine, ±50 mi). Closed list — out-of-scope data cannot be inserted.';
