# PHASE-4-HANDOFF.md — Claude Code takes over Phase 4

*Written 2026-07-04. Audience: Claude Code sessions in this repo. Owner/approver:
Milai. Read `CLAUDE.md` first — it is binding. Then `HANDOFF.md` (product),
`PHASE-4-PLAN.md` (decisions + tasks), `SCHEMA.md`, `BACKEND.md`, `CURATION.md`,
`UNVERIFIED-FIELDS.md`.*

## Division of labor from here

- **Claude Code (you): all Phase 4 engineering** — verification, build tasks,
  deploy preparation. Feature branches, /code-review, plain-words summaries to
  Milai, merge on her OK.
- **Milai's Claude.ai project: curation and judgment** — org research, listing
  facts, honesty/scope/copy decisions. If your task needs a new fact about a real
  organization, stop and route it there.
- **Milai: approver of everything**, and the only one who creates accounts/keys.

## State of the world (verify, don't trust — see Task 0)

Phase 3 is complete and working on Milai's machine: Supabase backend with the
honesty rules enforced in-database (published-only RLS, verified/unverified CHECK,
greater-LA scope guard), front-end loading from the API with embedded fallback,
Google sign-in, synced Saved (note: **insert, not upsert** — the saved table
deliberately grants no UPDATE; do not "fix" this back), deep-link pointers on
unverified facts, flicker-free single-pin highlighting, deferred close-button
focus. Dataset: **11 organizations** (American Youth Symphony removed 2026-07-04 —
defunct since March 2024; the audit trail is in `UNVERIFIED-FIELDS.md`).

Phase 4 decisions are all made (recorded in `PHASE-4-PLAN.md`, 2026-07-04):
**Stadia Maps** tiles · **completely free at launch** · **dedicated email** for
report-a-problem. Tasks 4.1 (Stadia behind `stadiaApiKey` config flag) and 4.2
(trust layer: "Details last checked", report links, "How Tutti works" modal) were
built the same day in the Claude.ai project and handed to Milai as files — they
may or may not be on `main` yet.

Pending from Milai (do not block on these; features hide gracefully while empty):
`window.TUTTI_CONFIG.reportEmail` (this week) and `window.TUTTI_CONFIG.stadiaApiKey`
(deploy day).

## Tasks, in order

**Task 0 — Verify the base.** On a fresh pull of `main`: confirm which of the
above is actually present (grep for `stadiaApiKey`, `howModal`, `detail__checked`,
`insert` in the saved path, org count in `data.json`). Report to Milai in plain
words: what's on main, what's missing versus this spec, anything broken. Build
nothing until she acknowledges.
*Done when: Milai has a short, accurate state report and any gaps are named.*

**Task 4.0 — Data pipeline hygiene.** Today, changing `data.json` requires
regenerating BOTH `supabase/seed.sql` (script exists) and the JSON embedded in
`tutti-orchestra-finder.html` inside `<script id="bootstrap-data">` (currently a
manual step — drift risk). Write `scripts/sync-data.mjs` that, from `data.json`:
validates against `schema.json`, regenerates the seed, and rewrites the embedded
bootstrap byte-identically (2-space indent, UTF-8, same block). Add a `--check`
mode that fails on any drift, and document the one-command workflow in
`BACKEND.md` and `CURATION.md`.
*Done when: one command syncs everything; a deliberately introduced mismatch is
caught by `--check`; docs updated in the same commit.*

**Task 4.3 — Expansion playbook.** As specified in `PHASE-4-PLAN.md`: write
`EXPANSION-PLAYBOOK.md`, the repeatable checklist for adding a new metro — how
orgs get found, curated, verified, QA'd, and launched, with the schema
scope-guard change called out explicitly. Written so metro #2 is a decision, not
a project.
*Done when: a future session could execute it for one test metro without
inventing process.*

**Task 4.4 — Monetization.** Decided: free at launch. Nothing to build; just
verify the "What Tutti costs" copy exists in the How-Tutti-works modal once 4.2
is on main.

**Launch-prep track (start after 4.3; every ⚑ needs Milai's hands/accounts).**
Prepare configuration and step-by-step instructions; Milai executes account
steps:
1. ⚑ Hosted Supabase project → `supabase db push`, seed via the sync script.
2. ⚑ Static host — recommend **Cloudflare Pages** (Netlify equally fine; her
   call): serve the HTML + `config.js` (production values, no secrets — anon key
   is public by design; real secrets stay in Supabase auth provider settings).
3. ⚑ Google OAuth production redirect URL; ⚑ Apple sign-in (Services ID, key —
   needs the real domain, this is why it was deferred); ⚑ Stadia key;
   ⚑ `reportEmail`.
4. Pre-launch QA checklist: honesty gates against the hosted DB (draft row
   invisible, unverified-with-value rejected), auth round-trip on the real
   domain, phones, keyboard, reduced-motion, Lighthouse pass.
*Done when: a written LAUNCH-CHECKLIST.md exists with every ⚑ step in
click-by-click plain words, and everything non-⚑ is prepared on a branch.*

## Field notes (hard-won; save yourself the rediscovery)

- This Mac has **no Homebrew**; every Supabase CLI call is `npx supabase …`.
- OAuth is registered to `http://127.0.0.1:54321/auth/v1/callback`; the site must
  be opened at `http://127.0.0.1:3000/…` — **not** `localhost` — or Google
  sign-in breaks.
- `npx supabase db reset` wipes local auth users and saved rows — expected in
  dev; warn Milai so it never looks like a bug.
- The two `WARN: environment variable is unset: SUPABASE_AUTH_APPLE_*` lines are
  expected until deploy. A GOOGLE warning is not.
- Safari caches the single file aggressively; all testing instructions to Milai
  must say **Cmd+Shift+R**.
- The `saved` table grants select/insert/delete only — upsert fails on
  privileges by design. Keep writes as plain insert, treating error code 23505
  as success.
- When giving Milai terminal steps: full copy-paste blocks, plain-words
  annotations, and what success looks like. She is capable and careful, and not
  a programmer.

## Standing prohibitions (repeat of CLAUDE.md, because they matter)

No invented org facts. No schema-shape changes without Milai. No weakening of
RLS/CHECK constraints. No secrets in git or terminal output. No edits to applied
migrations. No touching listing data — route curation to the Claude.ai project.
