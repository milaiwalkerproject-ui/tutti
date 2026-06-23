-- Tutti — Phase 3.1 honesty contract as Row-Level Security
--
-- The contract "only published listings reach parents" is enforced at the database,
-- not just the UI. The public (anon) role can SELECT a row only when its org is
-- published. There are no INSERT/UPDATE/DELETE policies for anon/authenticated, so
-- RLS denies all writes by default — curation happens through the service role
-- (Supabase Studio / migrations), which bypasses RLS.

begin;

alter table public.organizations enable row level security;
alter table public.ensembles     enable row level security;
alter table public.performances  enable row level security;
alter table public.auditions     enable row level security;
alter table public.org_sources   enable row level security;

-- Organizations: only published rows are readable by the public.
create policy "Published orgs are publicly readable"
  on public.organizations
  for select
  to anon, authenticated
  using (listing_status = 'published');

-- Children: readable only when their parent org is published.
create policy "Ensembles of published orgs are readable"
  on public.ensembles
  for select
  to anon, authenticated
  using (exists (
    select 1 from public.organizations o
    where o.id = ensembles.org_id and o.listing_status = 'published'
  ));

create policy "Performances of published orgs are readable"
  on public.performances
  for select
  to anon, authenticated
  using (exists (
    select 1 from public.organizations o
    where o.id = performances.org_id and o.listing_status = 'published'
  ));

create policy "Auditions of published orgs are readable"
  on public.auditions
  for select
  to anon, authenticated
  using (exists (
    select 1 from public.organizations o
    where o.id = auditions.org_id and o.listing_status = 'published'
  ));

create policy "Sources of published orgs are readable"
  on public.org_sources
  for select
  to anon, authenticated
  using (exists (
    select 1 from public.organizations o
    where o.id = org_sources.org_id and o.listing_status = 'published'
  ));

-- Explicit privileges (RLS still gates the rows; the role must also hold table grants).
grant usage on schema public to anon, authenticated;
grant select on public.organizations, public.ensembles, public.performances,
                public.auditions, public.org_sources to anon, authenticated;
grant select on public.org_listings to anon, authenticated;

commit;
