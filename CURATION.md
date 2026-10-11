# Tutti — Curation & Publish Workflow (Phase 3.3)

Tutti is **curated only** — you approve every listing. There is no public submission form and
no moderation queue. This is the repeatable way to add, verify, and publish an organization,
and to control exactly what parents see.

The gate is the `listing_status` field on each org:

| status | who sees it | use it for |
|---|---|---|
| `draft` | nobody (RLS hides it) | work in progress |
| `in_review` | nobody (RLS hides it) | finished, awaiting your final check |
| `published` | **parents** | approved and live |

RLS enforces this in the database: the public read API (`org_listings`) and the underlying
tables only ever return `published` rows. A `draft` or `in_review` org cannot leak to parents
even if the UI had a bug.

---

## The honesty rule, restated for curation

A parent-facing fact is shown as a value **only** when it's `verified` with a cited source.
Anything you can't confirm stays `unverified` and renders as **"Check their site."** The
database refuses to store a `verified` fact without a source, or an `unverified` fact that
carries a value — so a guess can't slip through.

`not_applicable` is only for professional orgs (e.g. tuition / financial aid don't apply).

---

## Two ways to curate

Both end at the same tables. Pick per task.

### A. Studio (day-to-day edits) — recommended for single listings

1. `supabase start`, then open Studio at `http://127.0.0.1:54323` (or the hosted dashboard).
2. **Table editor → `organizations`.** Add a row (or edit one). Set `listing_status = 'draft'`
   while you work. `provenance_type` stays `curated`.
3. Add child rows in `ensembles`, `performances`, `auditions`, `org_sources`, each with the
   matching `org_id` and a `position` for display order.
4. Fill verifiable fields as JSON, e.g.
   - confirmed: `{"status":"verified","value":"$650 / semester","source":"https://…","asOf":"2026-06-22"}`
   - unconfirmed: `{"status":"unverified"}`
   - N/A (pros only): `{"status":"not_applicable"}`
5. Record the pages you consulted in `org_sources` (the audit trail).
6. **Verify**, then flip `listing_status` to `published`. It appears to parents immediately.
   To pull a listing, set it back to `draft` / `in_review` — it disappears just as fast.

### B. data.json + reseed (bulk edits, full reproducibility)

`data.json` is the human-editable source of truth, validated by `schema.json`.

1. Edit `data.json` (add/verify orgs; cite sources; set `listingStatus`).
2. Sync the generated copies and apply locally:
   ```bash
   node scripts/sync-data.mjs      # validates data.json, then regenerates seed.sql AND the dataset embedded in the HTML
   npx supabase db reset
   ```
   The script refuses to write anything if `data.json` fails validation (bad shape, a
   value on an `unverified` fact, out-of-scope metro, duplicate id, …), so a mistake
   can't spread to the generated copies.
3. For the hosted DB, load the regenerated `seed.sql` deliberately (Studio SQL editor or
   `psql`) — and remember it's destructive (it clears listing tables and cascades to `saved`),
   so use this path for initial load / staging, not routine edits on a live DB with accounts.

> Keep `data.json` and the database in sync. Treat `data.json` as canonical for bulk work and
> Studio for one-off tweaks; if they diverge, reconcile before a reseed.
> `node scripts/sync-data.mjs --check` tells you instantly whether the generated file copies
> (seed + the dataset embedded in the HTML) still match `data.json` — it fails if anything drifted.

---

## Publish / unpublish checklist

- [ ] `name`, `type`, `lat`/`lng`, `area`, `website` correct; `metro` = the org's region:
      Greater Los Angeles / Orange County / San Diego County / Ventura County / Kern County /
      Inland Empire (scope: Bakersfield to San Diego, coast to ~Irvine, ±50 miles;
      Santa Barbara & Coachella out — borderline calls are Milai's).
- [ ] At least one ensemble.
- [ ] Every `verified` fact has a real, public `source`; everything else is `unverified`.
- [ ] `not_applicable` used only on professional orgs.
- [ ] `reviews` left `null` (no real aggregated source yet — never invent one).
- [ ] `sources[]` lists the pages you checked, with dates.
- [ ] `last_verified` set to today.
- [ ] Flip `listing_status` → `published`.

**Refresh cadence (Milai, 2026-10-10 — replaces the weekly plan of 2026-07-06):
two seasonal sweeps a year, in late February (ahead of spring auditions) and early
June (ahead of summer auditions), run as scheduled tasks in the Claude.ai project.**
Claude researches every orchestra with citations and drafts a review list; Milai
approves; nothing changes without her OK. Reports from the inbox trigger a
re-check of that listing in between.

Between sweeps the site stays honest on its own: audition badges are computed from
`opensOn` / `closesOn` ("dates decide", see SCHEMA.md), so a round closes itself on
its deadline, and past concerts drop off the boards. A re-check that confirms a value
updates its `asOf`; one that can't confirm it flips the fact back to `unverified` —
never leave a stale value looking fresh.

**Filling audition dates during a sweep**
- Only on a `verified` window, restating dates that page states: `closesOn` = the
  application deadline (soft deadline or late registration → the last day a family
  can still get in; no deadline → the last audition day); `opensOn` only when the
  page gives a start date.
- "Each spring", "usually in August", "by appointment" → no dates. The card then
  says "Dates: check their site", which is the honest answer.
- When a round has closed and the next one isn't posted, keep the closed dates —
  "Closed for this round" plus the last window tells families when to look again.

**Getting a sweep onto the live site without touching Saved lists**
1. Update `data.json`, then `node scripts/sync-data.mjs` (validates + regenerates).
2. `node scripts/audition-updates-sql.mjs > audition-updates.sql` — prints in-place
   UPDATEs for every audition and each org's `last_verified` (no truncate).
3. Supabase dashboard → **SQL Editor** → paste → **Run**. The last line returns the
   audition count; it should match the number the file's comment states.
Adding or removing an audition or an organization is still a Studio job (path A).

---

## Proposed (not built): a thin publish/unpublish admin view

The plan said to **propose before building** an internal admin view. Recommendation: for the
current handful of curated LA orgs, **Studio is enough** — it already gives you a table editor,
JSON fields, and one-click status changes behind your login. Building a custom admin screen now
would be effort spent on a problem Studio solves.

Revisit a small internal admin page when one of these is true: you're routinely toggling many
listings, a non-technical collaborator needs to publish without Studio access, or you add
self-service submissions (the `provenance_type` / `submitted_by` hooks already exist for that).
At that point a minimal authenticated page with a published-listings table and a publish/unpublish
toggle (writing `listing_status` via the service role) would be the right size. Say the word and
it's a focused follow-up.
