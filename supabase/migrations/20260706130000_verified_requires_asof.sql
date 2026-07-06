-- Close the asOf gap (found in the Phase 4 Task 0 audit, approved by Milai):
-- the honesty contract says a verified fact is {status, value, source, asOf},
-- but the original tutti_verifiable_ok only enforced value + source. From this
-- migration on, a verified fact must also carry its "as of" date (the date the
-- value was confirmed), in YYYY-MM-DD shape.
--
-- All existing data already complies (audited 2026-07-05). Calendar validity
-- (no Feb 30) is enforced upstream by scripts/sync-data.mjs; this CHECK guards
-- the shape so an asOf-less verified fact can't enter through any path.
-- Replacing the function body in a NEW migration keeps the applied migration
-- untouched (append-only rule); every existing CHECK constraint picks up the
-- new definition automatically.

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
                                   and (v ->> 'asOf') is not null
                                   and (v ->> 'asOf') ~ '^\d{4}-\d{2}-\d{2}$'
            when 'unverified' then (v -> 'value') is null
                                   or jsonb_typeof(v -> 'value') = 'null'
            else true
          end
    );
$$;
