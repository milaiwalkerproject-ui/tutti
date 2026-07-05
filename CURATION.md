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

- [ ] `name`, `type`, `lat`/`lng`, `area`, `website` correct; `metro` = Greater Los Angeles.
- [ ] At least one ensemble.
- [ ] Every `verified` fact has a real, public `source`; everything else is `unverified`.
- [ ] `not_applicable` used only on professional orgs.
- [ ] `reviews` left `null` (no real aggregated source yet — never invent one).
- [ ] `sources[]` lists the pages you checked, with dates.
- [ ] `last_verified` set to today.
- [ ] Flip `listing_status` → `published`.

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
