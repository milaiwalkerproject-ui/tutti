-- Scope expansion (decided by Milai 2026-07-06): Greater Los Angeles → Southern
-- California — the Bakersfield-to-San-Diego corridor, coast to roughly Irvine's
-- inland line, ±50 miles. See EXPANSION-PLAYBOOK.md.
--
-- The guard stays as strict as before: exactly one allowed region, so
-- out-of-area data still cannot be inserted. The old CHECK was written inline
-- and unnamed in 20260623120000_core_schema.sql (append-only — not edited), so
-- we find its auto-assigned name and drop it before adding the named
-- replacement.

do $$
declare
  metro_check text;
begin
  select conname into metro_check
  from pg_constraint
  where conrelid = 'public.organizations'::regclass
    and contype = 'c'
    and pg_get_constraintdef(oid) ilike '%metro%';
  if metro_check is not null then
    execute format('alter table public.organizations drop constraint %I', metro_check);
  end if;
end $$;

alter table public.organizations
  add constraint organizations_metro_check
  check (metro = 'Southern California');

comment on column public.organizations.metro is
  'Scope guard — constrained to ''Southern California'' (Bakersfield–San Diego, coast to ~Irvine, ±50 mi) so out-of-area data cannot be inserted.';
