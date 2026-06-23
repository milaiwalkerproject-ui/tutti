# Tutti — Phase 3 Status

Phase 3 turns Tutti from a single openable HTML file into a hosted site backed by a real
database. This is what got built against `PHASE-3-PLAN.md`, what was verified, and the few
steps that are yours to run (they need your machine / developer accounts).

The data model did **not** change — these are a faithful translation of the Phase 2
`schema.json` into a backend, plus the front-end and account work.

---

## What's built (in this repo)

| Task | Deliverable | Files |
|---|---|---|
| **3.1 Backend scaffolding** | Postgres schema mirroring `schema.json`, honesty CHECK constraints, metro scope guard, read API view, public-read RLS, seed generated from `data.json` | `supabase/migrations/*`, `supabase/config.toml`, `supabase/seed.sql`, `scripts/generate-seed.mjs` |
| **3.2 Wire front-end to API** | API-first data loader with loading/error/empty states and graceful fallback (API → `data.json` → embedded) | `tutti-orchestra-finder.html`, `config.js` |
| **3.3 Curation & publish** | Documented, repeatable add/verify/publish workflow; admin view proposed, not built (per plan) | `CURATION.md` |
| **3.4 Saved that persists** | Supabase Auth (Google + Apple), per-user `saved` table + RLS, front-end account UI with in-memory fallback, privacy note | `tutti-orchestra-finder.html`, `supabase/migrations/…_saved.sql`, `PRIVACY.md` |

Setup/run guide: **`BACKEND.md`**.

## Verified here (against Postgres 16)

- All migrations + seed apply cleanly.
- The `org_listings` API view reproduces `data.json` **field-for-field** for all 12 published
  orgs (the only addition is `submittedBy: null`, which the front-end never reads).
- RLS: the `anon` role sees only published orgs; flipping an org to `draft` hides it **and** its
  children from the API.
- Honesty CHECK constraints reject a `verified` fact with no source and an `unverified` fact
  that carries a value; the metro guard rejects a non-LA insert.
- `saved` RLS: users see only their own rows, can write only their own, and `anon` can't read
  the table at all.
- All inline front-end scripts parse; the auth/Saved layer is inert when no backend is
  configured, so the file still previews standalone.

---

## What's yours to run (needs your machine / accounts)

These can't be done from here — they need Docker, the Supabase CLI, and your Google/Apple
developer accounts.

1. **Run it locally** (`BACKEND.md` → "Run it locally"):
   ```bash
   supabase start          # Docker must be running
   python3 -m http.server 3000
   # open http://127.0.0.1:3000/tutti-orchestra-finder.html
   ```
   `config.js` already has the CLI's standard local URL + anon key; paste yours if it differs.

2. **Configure auth providers** for Saved (Task 3.4):
   - **Google** — OAuth client in Google Cloud Console; redirect URI
     `http://127.0.0.1:54321/auth/v1/callback` (local) and the hosted equivalent.
   - **Apple** — a Services ID + signed client-secret JWT (your paid membership covers this).
   - Put the secrets in `.env` (see `.env.example`); they feed `supabase/config.toml`.
   Until configured, the app runs fine signed-out with an in-memory Saved list.

3. **Deploy** when ready (`BACKEND.md` → "Deploying"): create a hosted Supabase project,
   `supabase db push`, host the static front-end (Cloudflare Pages / Netlify), and point
   `config.js` at the hosted API URL + anon key.

---

## Pre-launch items this phase created

- **Privacy note** — written (`PRIVACY.md`, surfaced in-app via the Saved view). Before public
  launch, also link it from the footer/ribbon.
- **Retire "sample data" labeling per listing** — the ribbon already reads "Curated listings."
  Drop it entirely once you're satisfied every published listing is genuinely verified.
- **Feedback channel** — still needs a real destination (carried from earlier phases).
