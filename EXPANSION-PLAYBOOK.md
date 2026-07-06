# EXPANSION-PLAYBOOK.md — adding a metro to Tutti

*Written 2026-07-06 (Task 4.3). Audience: Milai + a future Claude Code session +
Milai's Claude.ai curation project. Goal: metro #2 is a **decision**, not a
project — every step below is written so it can be executed without inventing
process. Read `CLAUDE.md` first; it is binding. The honesty contract does not
bend for growth: a metro launches when its listings are verified, not when a
date arrives.*

**Status note:** this playbook assumes metro #1 (Greater Los Angeles) has
launched — hosted Supabase, real domain, `LAUNCH-CHECKLIST.md` done. If it
hasn't, finish that first; a second metro multiplies whatever is unfinished.

---

## 0 · What deciding metro #2 takes (read this part only, to decide)

Adding a metro is five phases: **decide → prepare the guards → find the orgs →
verify the orgs → QA and launch**. The middle three are the real work, and they
are curation work, not engineering: expect the discovery-and-verification
effort to be roughly what the LA dataset took, because every fact is verified
from scratch. Engineering is one focused session (the scope guards + per-metro
constants below). Nothing about the design has to change: the map, pins,
honesty rules, database, and sign-in all carry over as-is.

**Decisions that are Milai's, before anything is built:**

1. **Which metro, and why now.** Honest go/no-go questions: Are there plausibly
   15+ orgs there (the LA target is 25–40)? Is there capacity to *keep* them
   fresh — audition windows re-checked each season — without letting LA rot?
   Is anyone asking for this metro?
2. **One site or one site per metro** — see §1. Recommendation: **a separate
   deployment per metro for metro #2** (lowest risk, no schema-shape change, no
   new UI); revisit a combined site with a metro picker if metro #3 ever
   happens.
3. **URL shape** (only if per-metro deployments): subdomain (`sd.tutti…`) vs
   path (`tutti…/sd`). Note: a **new subdomain/domain means re-registering
   origins with Google and Apple sign-in** (that's why Apple was deferred to
   deploy day for LA); a path on the existing domain adds no auth work.
4. **Report-a-problem address**: the code supports exactly one `reportEmail`
   per deployment. Same inbox for all metros, or one each? (The mail subject
   already carries the org name, which disambiguates in practice.)
5. **Scope statement updates**: expanding scope changes sentences in
   `CLAUDE.md` ("Scope stays greater Los Angeles") and in the Claude.ai
   project's instructions ("Default geographic scope is greater Los Angeles").
   Approving the metro approves those edits; they land in the same commits as
   the change.

Say "metro #2 is <name>, per-metro deployment, path/subdomain, email <x>" and
the rest of this file is execution.

---

## 1 · Architecture: why per-metro deployment is the recommendation

The app today is exactly a one-metro machine, by design:

- `data.json` has a **single** top-level `"metro"` string (required by
  `schema.json`), so one dataset file = one metro. The seed and the dataset
  embedded in the HTML are generated from it by `scripts/sync-data.mjs`, which
  reads hardcoded paths (`data.json`, `supabase/seed.sql`, the one
  `bootstrap-data` block in `tutti-orchestra-finder.html`).
- The front end fetches `org_listings?select=*` with **no metro filter** and
  never reads the `metro` field; it pins whatever the database returns onto one
  LA-centered map. If two metros' rows shared a database today, their pins,
  auditions, and concerts would interleave with no label and no way to filter.

So the two options are:

- **A. One shared site + metro picker.** Requires: a metro dimension added
  throughout the front-end JS (filters, boards, markers, distance labels), a
  multi-metro dataset shape (a `schema.json` **shape change** — Milai approval,
  version bump, migration of the generated-files contract), and picker UI.
  Real project. Only worth it when metros multiply.
- **B. One deployment per metro.** The current code already behaves this way
  for LA. Each metro gets its own dataset file, its own generated HTML copy,
  its own Supabase project (or its own rows behind its own deployment — see
  §5), and a short list of per-metro constants (§2.3). Cost: more than one copy
  of the single-file app exists, so the sync script must be parameterized to
  regenerate **all** of them from their datasets (one command, all metros —
  drift between copies is the thing `sync-data.mjs --check` exists to kill).

**Recommendation: B for metro #2.** It requires no schema-shape change, no new
UI, and no change to the honesty machinery. Revisit A at metro #3.

---

## 2 · Phase one: engineering prep (Claude Code, one branch: `phase4/metro-<slug>` or `expansion/<slug>`)

Everything in this section is mechanical and verifiable. Work from the quoted
code, not the line numbers — lines drift.

### 2.1 The scope guard (the change this playbook must call out explicitly)

The greater-LA scope is enforced in **three layers**. All three must change
together, deliberately, or the new metro's data is rejected somewhere on its
way to parents:

1. **`schema.json` — two independent enums.**
   - Top-level dataset field (~line 14): `"metro": { "type": "string", "enum":
     ["Greater Los Angeles"], "description": "Scope guard for v1. Add a metro
     to this enum deliberately when expanding…" }` — the description already
     prescribes the mechanism: add the new metro string to the array.
   - Per-organization field (~line 221): `"metro": { "type": "string", "enum":
     ["Greater Los Angeles"] }` — extend this one too; **missing either enum
     leaves validation broken for the new metro.**
   - Also rewrite the LA sentence in the schema's top `description` ("Scope:
     Greater Los Angeles.") and **bump `version`** (the schema's own
     convention: "Bump when the shape changes") in both `schema.json`'s
     example text and `data.json`.
2. **The database CHECK constraint — a NEW migration, never an edit.**
   The guard lives in `supabase/migrations/20260623120000_core_schema.sql`:
   `metro text not null check (metro = 'Greater Los Angeles'),  -- scope guard`.
   Migrations are append-only (CLAUDE.md), so write a new numbered migration
   that drops and re-adds the constraint with the expanded list. Follow the
   existing filename convention — a `YYYYMMDDHHMMSS_name.sql` timestamp prefix,
   like `20260623120000_core_schema.sql` — e.g.
   `<today's timestamp>_metro_add_<slug>.sql`. The
   constraint is inline and unnamed, so confirm Postgres's auto-assigned name
   first:
   ```sql
   select conname from pg_constraint
   where conrelid = 'public.organizations'::regclass
     and pg_get_constraintdef(oid) ilike '%metro%';
   ```
   Then, in the new migration (shape, with the real names filled in):
   ```sql
   alter table public.organizations
     drop constraint <name-from-query-above>;
   alter table public.organizations
     add constraint organizations_metro_check
     check (metro in ('Greater Los Angeles', '<New Metro>'));
   comment on column public.organizations.metro is
     'Scope guard — constrained to the launched metros so out-of-area data cannot be inserted.';
   ```
   (A fresh `comment on column` in the new file is fine — it's a new statement,
   not an edit to the applied one. Do not touch the historical comments inside
   `20260623120000_core_schema.sql`.)
3. **`scripts/sync-data.mjs` — follows automatically.** Its validator reads
   `schema.json`, so once the enums are extended it accepts the new metro and
   still refuses anything else ("out-of-scope metro" stays a named refusal).
   No validator change needed. What *does* need work: the script reads exactly
   one hardcoded `data.json` and rewrites exactly one HTML file — under
   per-metro deployments it must be parameterized (e.g. `data.<slug>.json` →
   `tutti-<slug>.html` + per-metro seed), keeping `--check` covering **every**
   metro's copies in one run.

**Test the guard both ways after the migration:** an org with the new metro
inserts; an org with any other metro is still rejected (the Phase 3 acceptance
test "the metro guard rejects a non-LA insert" becomes "rejects a
non-launched-metro insert").

### 2.2 Scope statements in the docs (same commits as the code they describe)

- `CLAUDE.md`: "Scope stays greater Los Angeles" and "the greater-LA scope
  (CHECK constraints)" — update to name the launched metros.
- `SCHEMA.md`: the scope bullet ("Greater Los Angeles only…") and both metro
  rows in its field tables.
- `CURATION.md`: publish-checklist line "`metro` = Greater Los Angeles" →
  "`metro` = the org's launched metro, exactly as spelled in the enum".
- `tutti-project-instructions.md` (Milai pastes into her Claude.ai project):
  "Default geographic scope is greater Los Angeles unless I say otherwise" —
  add the new metro. (Also fix its stale "Listings are sample data" line while
  in there; the data has been real since Phase 2.)
- `UNVERIFIED-FIELDS.md` is a **single-metro ledger** ("… · Greater Los
  Angeles"). Start `UNVERIFIED-FIELDS-<slug>.md` for the new metro with the
  same structure: judgment-calls section, corrections table, per-org
  still-needs-confirmation lists, dated verification-pass appendices.

### 2.3 Per-metro front-end constants (the complete list)

These are the only LA-specific things in `tutti-orchestra-finder.html` — the
new metro's copy changes exactly these (all values below are the current LA
ones, quoted so they're greppable):

| What | Find | Change to |
|---|---|---|
| Map start view | `setView([34.05,-118.30], 11)` | new metro center + a zoom that shows the whole metro |
| Distance "home" | `let homePoint = {lat:34.05, lng:-118.30, label:"Greater Los Angeles"}` | new center + metro name (this label is parent-visible: "from <label>") |
| Quick-location chips | `const PRESETS = [ {label:"Downtown LA"…` (5 entries) | 4–6 hand-picked hubs of the new metro |
| Rail subtitle (first paint) | `Greater Los Angeles · curated listings` | `<New Metro> · curated listings` |
| State suffix | `${esc(o.area)}, CA` in the detail panel | fine for any California metro; a non-CA metro needs the right state (the state isn't in the data model — flag to Milai if metro #2 is out of state) |
| Form placeholders | `placeholder="Los Angeles Youth Orchestra"`, `"West LA"`, `"34.0561"`, `"-118.4715"` in List-your-organization | new-metro examples (prototype form; nothing persists) |
| Dev header comment | "Sample data (greater Los Angeles) is illustrative" (stale since Phase 2) | correct it while touching the file |

Metro-neutral already (verified — nothing to change): page title, brand
tagline, How-Tutti-works modal, privacy modal, sign-in copy, empty states,
curated ribbon. There are no meta-description/OG/analytics tags to update
(none exist).

**Known behavior to leave or fix deliberately (not silently):** "Near me" and
search geocoding are unbounded — a user outside the metro gets an empty map
with no "outside our coverage" message, and the Nominatim geocode call has no
viewbox. Same behavior LA shipped with; improving it is its own small task,
not a metro-add requirement.

---

## 3 · Phase two: how orgs get found (Milai's Claude.ai project)

This was never written down for LA (the original list predates the honesty
contract and was verified after the fact) — so this section **is** the
process now:

1. **Sweep the directories** (leads, not facts — every fact gets verified in
   phase three):
   - League of American Orchestras directory (symphony.org) — youth and
     community orchestras by state.
   - The state/regional orchestra association (for California it was the
     Association of California Symphony Orchestras; find the new metro's
     equivalent).
   - El Sistema–inspired program directories (the YOLA-equivalents).
   - City/county arts council program lists; school-district music/VAPA pages
     (they name the feeder youth ensembles).
   - University and conservatory community/prep divisions (the Colburn
     pattern) and collegiate orchestras that admit community players.
   - The metro's professional orchestras (parents also find auditions and
     concerts through Tutti; LA lists both types).
   - Plain search sweeps: "<metro> youth orchestra", "youth symphony",
     "children's orchestra", "<metro> chamber orchestra auditions".
2. **Build the candidate table**: name · website · probable type
   (youth/professional/community/collegiate) · city/area. Nothing else — no
   tuition, no dates, no facts yet.
3. **First cull with Milai**: drop defunct orgs (check the site is alive and
   the latest season is current — the American Youth Symphony lesson: it had
   ceased operations in March 2024 and we caught it in July 2026, over two
   years later), drop out-of-scope ones
   (private lesson studios, school-only ensembles that outside kids can't
   join), and flag classification judgment calls for Milai instead of
   deciding silently.
4. **Depth bar**: LA's target is 25–40 published orgs. A metro can launch
   with fewer — but if the sweep finds under ~15 real orgs, put the metro
   question back to Milai before spending verification effort: thin coverage
   may not serve parents there.

The reusable curation prompt (from `DELEGATION-PLAN.md`, already
metro-parameterized — run it in the Claude.ai project, not Claude Code):

> Help me build a real seed dataset for **[METRO]** youth orchestras. For each
> org, search for and cite official source pages, then draft a data record —
> but flag every field you couldn't verify rather than inventing it. Produce a
> `data.json` and a list of unverified fields I need to confirm.

---

## 4 · Phase three: curation & verification (unchanged rules, new ledger)

The entire honesty machinery is metro-agnostic and applies verbatim —
`CURATION.md` is the manual. The short form, per org:

- Every fact is `verified` (value + public source + `asOf`) or `unverified`
  (renders "Check their site"; an optional `source` is only a **pointer** a
  human actually consulted). `not_applicable` only where the question doesn't
  apply (e.g. tuition for professional orgs). **Never a value on an
  unverified fact** — the schema, the sync script, and the database all
  reject it independently.
- `reviews` stays `null` — no trustworthy source exists, in any metro.
- Coordinates are produced **once, at curation time**, and checked by eye on
  the map (no geocoding infrastructure — a curation step, not a service).
- `sources[]` records every page consulted (`url`, `label`, `retrievedAt`) —
  the audit trail behind the listing.
- `lastVerified` = the day the org's facts were last confirmed (it feeds the
  parent-visible "Details last checked <Month Year>" line).
- Log the work in `UNVERIFIED-FIELDS-<slug>.md` as you go: judgment calls,
  corrections, what's still unconfirmed per org, dated passes.
- Milai approves every listing; `listing_status` flows draft → in_review →
  published, and only `published` ever reaches parents (RLS enforces it).

Deliverables out of this phase: the metro's dataset (schema-valid, all facts
sourced or honestly unverified), its ledger file, and Milai's sign-off on
every org that will launch `published`.

---

## 5 · Phase four: load, QA, launch

**Load.** For a fresh per-metro database: `node scripts/sync-data.mjs` (as
parameterized in §2.1) then `npx supabase db push` + seed. For adding rows to
a **live** database: use Studio (per `CURATION.md`) — **never run the seed
against a live database**; it opens with `truncate table public.organizations
restart identity cascade;` and would wipe listings *and every parent's Saved
list*.

**QA gates (all must pass; same bar as LA):**

- [ ] `node scripts/sync-data.mjs --check` — everything in sync, all metros.
- [ ] Honesty gates against the hosted DB: a draft row is invisible to the
      public API; a verified-without-source insert fails; an
      unverified-with-value insert fails; the **new** metro inserts; any
      other metro string is still rejected.
- [ ] Every pin eyeballed on the map (right place, right org, note-shaped).
- [ ] "Details last checked" shows on every org; deep-link pointers open the
      right pages; report links appear (once `reportEmail` is set).
- [ ] Phones; keyboard (focus always visible); reduced-motion; Lighthouse
      pass. Test Safari with **Cmd+Shift+R** (it caches the single file
      aggressively). Local OAuth testing must use `http://127.0.0.1:3000`,
      not `localhost`.

**Launch (⚑ = Milai's hands/accounts):**

- [ ] ⚑ Hosting for the metro's page per the §0 URL decision (new
      subdomain/domain ⇒ re-register Google + Apple sign-in origins; path on
      the existing domain ⇒ no auth work).
- [ ] Stadia tiles: nothing to do — one key covers the planet.
- [ ] ⚑ `reportEmail` per the §0 decision.
- [ ] Update the public "How Tutti works" wording if it names coverage
      anywhere (today it doesn't — verify at launch time).
- [ ] Add the metro to the refresh calendar: **audition windows re-checked
      quarterly (each season), everything else twice a year.** A metro that
      can't be kept fresh should not stay launched — stale "verified" facts
      are worse than none.

---

## 6 · Dry run: executing this playbook for a test metro (no parents harmed)

To validate the playbook itself (or train a future session) without touching
production: run §2 on a branch (schema enums + new migration applied only to
the **local** database), run §3 for a small real sweep (5–8 orgs, real
sources, real ledger), load locally, keep every org `listing_status: "draft"`
(RLS keeps drafts invisible even if config pointed at a real database), and
run the §5 QA gates locally. Success = every gate passes and nothing needed
inventing that this file didn't cover. Then delete the branch or park it —
the dry run is evidence, not a launch.

---

## Appendix · The complete change map (for the executing session)

| Layer | File | What changes |
|---|---|---|
| Schema | `schema.json` | both `metro` enums (~lines 14, 221); top `description` scope sentence; version convention |
| Dataset | `data.<slug>.json` | new file: top-level `metro`, `version`, `generatedAt`, orgs |
| Database | new migration in `supabase/migrations/` | drop/re-add `organizations.metro` CHECK with expanded list; fresh column comment; **never edit applied migrations** |
| Pipeline | `scripts/sync-data.mjs` | parameterize per-metro dataset → seed + HTML copy; `--check` spans all metros |
| Front end | metro's copy of `tutti-orchestra-finder.html` | §2.3 table: setView, homePoint, PRESETS, rail subtitle, `, CA` suffix, 4 form placeholders, header comment |
| Config | metro's `config.js` | per-deployment values only (supabaseUrl/anonKey, stadiaApiKey, reportEmail, appleSignIn) — no metro key exists or is needed |
| Docs | `CLAUDE.md`, `SCHEMA.md`, `CURATION.md`, `tutti-project-instructions.md` | scope sentences (§2.2), same commit as the change |
| Ledger | `UNVERIFIED-FIELDS-<slug>.md` | new file, LA ledger's structure |
| Auth | Google/Apple consoles + Supabase | only if the URL decision adds a new domain/subdomain |

Open items this playbook leaves to their own tasks: the coverage/"outside our
area" UX for faraway users; bounding the search geocoder; a combined
multi-metro site (option A) if metro #3 arrives; per-metro analytics/SEO
metadata (none exists for LA either).
