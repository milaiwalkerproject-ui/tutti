# Tutti — Phase 3 Plan (Backend, persistence, Saved)

Locked after Phase 3 planning. This is the detailed build plan for Phase 3, in the same
format as `DELEGATION-PLAN.md`: each task has a **goal**, a **copy-paste prompt**, and a
**done when**. Do the tasks roughly in order. Add this file to project knowledge so we can
execute task-by-task.

> **The big shift:** Phase 3 is where Tutti stops being a single openable HTML file. It
> becomes a hosted site (a URL) backed by a real database, with a deploy step. The data model
> does **not** change — the Phase 2 schema already has the hooks (`listingStatus`,
> `provenanceType`, `submittedBy`).

---

## Decisions locked

| Decision | Choice | Consequence |
|---|---|---|
| **Listings** | **Curated only** — Milai approves all | No public submission form, no moderation queue. Task 3.3 collapses into a curation/publish workflow. |
| **Saved persistence** | **Real accounts** — Google + Apple sign-in | Survives reloads and syncs across devices. Introduces a parent account → needs a short privacy note (see pre-launch). |
| **Build path** | **Hands-on** — Claude Code + local dev | Real project folder, git, migrations as code. More control; you run the commands. |
| **Platform** | **Web app** (stays Leaflet) | No native iOS. Keeps the existing front-end. |
| **Scope** | **Greater Los Angeles** (unchanged) | Mirrored as a DB constraint so scope creep can't enter through data. |
| **Apple Developer** | **Paid membership active** | Sign in with Apple on web works (Services ID + key, no workaround). |

---

## Stack

| Concern | Choice | Notes |
|---|---|---|
| Front-end | Existing single-page Leaflet app | Now fetches from an API instead of `data.json`. Lives in a git repo. |
| Database | **Supabase (Postgres)** | Run the developer way: Supabase CLI + Docker locally, schema as version-controlled SQL **migrations** (a translation of `schema.json` into tables). |
| Read API | **PostgREST** (built into Supabase) | Auto-generated read API for the map and boards. No hand-written endpoints for reads. |
| Honesty enforcement | **Row-level security (RLS)** | Public role can only `SELECT` rows where `listingStatus = 'published'`. The contract is enforced at the database, not just the UI. |
| Auth | **Supabase Auth** — Google + Apple | Powers the Saved feature only. `saved` rows tied to `auth.uid()`. |
| Hosting | Static front-end on **Cloudflare Pages / Netlify** (deploy from git); Supabase hosts DB + auth | Custom domain optional (~$12/yr). |
| Local setup (one-time) | Node, git, **Supabase CLI**, **Docker Desktop** | Familiar ground for a hands-on build. |

**Why Supabase over a custom backend or Firebase:** Postgres is relational, which matches the
structured org → ensemble → performance → audition model and keeps `schema.json` as the real
source of truth. RLS lets the database itself guarantee "only published listings reach
parents." Google/Apple auth is built-in config rather than hand-rolled OAuth. Free tier covers
one-metro scale.

---

## Guardrails carried forward (unchanged from Phase 2)

- **Honesty:** a fact shows as a value only when `verified` with a cited source; `unverified`
  renders as "Check their site"; `not_applicable` hides the row. Curated-only makes this even
  cleaner — there are no self-reported facts to police.
- **Scope:** greater LA only. The DB mirrors the `metro` enum so out-of-area data fails to
  insert.
- **Design system:** Fraunces / Mulish, note-head pins, staff-line motif, type→color
  (youth=brass, professional=garnet, community=teal, collegiate=slate) — all unchanged.
- **Labeling:** the "prototype / sample data" labeling stays accurate per listing — real
  verified listings drop it; anything still sample stays flagged.
- **Persistence:** real Saved is via Supabase (not `localStorage`). During local dev the
  front-end keeps an in-memory fallback so it still previews when not signed in.

---

## Tasks

### 3.1 — Backend scaffolding
**Goal:** a working Supabase project that mirrors the schema, seeded from the curated data, with
a read API and the honesty contract enforced by RLS.

> Scaffold the Tutti backend in Supabase, run locally via the Supabase CLI. Translate
> `schema.json` into Postgres migrations: an `organizations` table plus child tables for
> `ensembles`, `performances`, and `auditions`, with the verifiable fields (`season`,
> `tuition`, `rehearsal`, `commitment`, `financialAid`, performance `from`, audition `window`)
> stored so their `{status, value, source, asOf}` shape is preserved. Add a `metro` constraint
> allowing only "Greater Los Angeles". Seed the database from the curated `data.json`. Add RLS
> so the public (anon) role can only read rows where `listingStatus = 'published'`. Keep
> everything as version-controlled migrations + a seed script. Explain anything I need to run.

**Done when:** `supabase start` brings up a local DB seeded with the curated orgs; the anon API
returns only published listings; migrations and seed are in the repo.

---

### 3.2 — Wire the front-end to the API
**Goal:** the map, rail, and boards read from the API instead of `data.json`, with proper states.

> Replace the front-end's `data.json` fetch with calls to the Supabase read API. Add clear
> loading, error, and empty states, and light in-memory caching so switching views doesn't
> refetch. Keep the existing render behaviors intact: "Check their site" for unverified,
> hidden rows for not_applicable, graceful handling of null `reviews`, and the
> price-of-0 = "Free" rule. Don't change the design tokens or data shape.

**Done when:** the live front-end renders entirely from the API; loading/error/empty states
behave; nothing about the look or the honesty rules changed.

---

### 3.3 — Curation & publish workflow
**Goal:** a reliable way for Milai to edit listings and control what parents see. (Collapsed from
the original "submission + moderation" task because listings are curated-only.)

> Set up the curation workflow: I edit listings in Supabase (Studio + the migration/seed flow),
> and the `listingStatus` field (`draft` / `in_review` / `published`) gates what reaches
> parents. Document the steps to add, edit, verify (with a cited source), and publish an org.
> No public submission form. If a thin internal "publish/unpublish" admin view would help,
> propose it before building.

**Done when:** I have a documented, repeatable way to add/verify/publish an org, and only
`published` listings appear to parents.

---

### 3.4 — Saved that persists (Google + Apple sign-in)
**Goal:** parents can save orgs and have the list survive reloads and follow them across devices.

> Add Supabase Auth with Google and Apple providers, and a `saved` table keyed to `auth.uid()`
> with RLS so a user can only read/write their own saved rows. Replace the in-memory `Set` with
> this, keeping an in-memory fallback for when a user isn't signed in (so the app still works
> unauthenticated and previews cleanly). Keep the sign-in copy parent-friendly ("Sign in to
> save"). Add a short, plain-language privacy note covering what sign-in stores.

**Done when:** signing in with Google or Apple persists Saved across reloads and devices; signed
-out users still get an in-memory Saved list; the privacy note is in place.

---

## Costs

- **Supabase:** free tier covers one-metro scale.
- **Hosting (Cloudflare Pages / Netlify):** free tier.
- **Apple Developer Program:** already active.
- **Custom domain:** optional, ~$12/yr.
- **Real cost:** your time on the hands-on setup and curation.

---

## Pre-launch items this phase creates

- **Privacy note** — because Saved now uses sign-in, the site needs a short, plain-language note
  on what an account stores (a basic identifier, the user's saved list). New, small, and owned
  in 3.4.
- **Retire "sample data" labeling per listing** as real verified listings replace samples.
- **Feedback channel** still needs a real destination (carried from earlier).

---

## Suggested order

3.1 → 3.2 → 3.3 (light) → 3.4. Do 3.4 (accounts) last — it's the only piece that touches parent
data and is otherwise independent. Hand me one task at a time; I'll build against this plan and
flag any decision that's yours before guessing.
