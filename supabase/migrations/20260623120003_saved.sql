-- Tutti — Phase 3.4 persistent Saved
--
-- One row per (user, org) a parent has starred. Tied to auth.uid(); RLS guarantees a
-- user can only read and write their OWN saved rows. Signed-out users keep an in-memory
-- list in the front-end (no row here) so the app still works unauthenticated.

begin;

create table public.saved (
  user_id    uuid not null references auth.users(id) on delete cascade,
  org_id     text not null references public.organizations(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, org_id)
);

comment on table public.saved is
  'Per-user saved organizations. RLS restricts every row to its owning auth.uid().';

create index saved_user_idx on public.saved (user_id);

alter table public.saved enable row level security;

create policy "Users read their own saved rows"
  on public.saved
  for select
  to authenticated
  using (auth.uid() = user_id);

create policy "Users add their own saved rows"
  on public.saved
  for insert
  to authenticated
  with check (auth.uid() = user_id);

create policy "Users remove their own saved rows"
  on public.saved
  for delete
  to authenticated
  using (auth.uid() = user_id);

grant select, insert, delete on public.saved to authenticated;

commit;
