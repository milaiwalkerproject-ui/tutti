# Tutti — Backend (Phase 3)

This is the hands-on guide to Tutti's backend: a Supabase (Postgres) project that mirrors
`schema.json`, serves the map/rail/boards through an auto-generated read API, and enforces
the honesty contract at the database with Row-Level Security (RLS).

> **What the front-end talks to.** The single-page app (`tutti-orchestra-finder.html`)
> reads from the `org_listings` API view, which returns published orgs in the **exact**
> shape of `data.json`. If the API is unreachable it falls back to `data.json`, then to the
> dataset embedded in the HTML — so the page always renders.

---

## What's in the repo

```
supabase/
  config.toml                  Supabase CLI config (ports, auth providers)
  migrations/
    …_core_schema.sql          enums, tables, honesty CHECK constraints, metro scope guard
    …_listings_view.sql        org_listings: published orgs in the front-end JSON shape
    …_public_read_rls.sql      RLS — anon can read ONLY published listings
    …_saved.sql                saved table (per-user) + RLS
  seed.sql                     GENERATED from data.json — the curated orgs
scripts/
  generate-seed.mjs            regenerates supabase/seed.sql from data.json
config.js                      front-end config: Supabase URL + anon key (public)
.env.example                   auth secrets template (Google / Apple)
```

The data model is unchanged from Phase 2 — these migrations are a faithful translation of
`schema.json` into tables. Verifiable facts (`season`, `tuition`, `rehearsal`, `commitment`,
`financialAid`, performance `from`, audition `window`) are stored as JSONB so their
`{status, value, source, asOf}` shape is preserved byte-for-byte.

---

## One-time local setup

You need **Node**, **Docker Desktop** (running), and the **Supabase CLI**.

```bash
# macOS
brew install supabase/tap/supabase
# or see https://supabase.com/docs/guides/local-development for other platforms
```

## Run it locally

```bash
cd tutti
supabase start          # boots Postgres + Auth + the read API in Docker, runs migrations + seed
```

`supabase start` prints local credentials. The two the front-end needs:

- **API URL** — `http://127.0.0.1:54321`
- **anon key** — a public client key

`config.js` already contains the CLI's standard local URL + anon key, so the front-end works
out of the box. If your CLI prints a different anon key, paste it into `config.js`.

Serve the front-end from the project folder (any static server works):

```bash
python3 -m http.server 3000      # then open http://127.0.0.1:3000/tutti-orchestra-finder.html
```

You should see the map render from the API. To confirm the API directly:

```bash
curl 'http://127.0.0.1:54321/rest/v1/org_listings?select=id,name,listingStatus' \
  -H "apikey: <anon-key>"
# → only published orgs come back
```

### Reset / reseed

```bash
supabase db reset       # drops, re-runs every migration, then re-applies seed.sql
```

After editing the curated `data.json`, regenerate the seed and reset:

```bash
node scripts/generate-seed.mjs && supabase db reset
```

> `seed.sql` is **destructive** (it truncates the listing tables, which cascades to `saved`).
> It's for local dev and first load only — never run it against a live database with real
> accounts. Production curation happens in Studio (see `CURATION.md`).

---

## How honesty is enforced in the database

The contract isn't just UI behavior — it's enforced in Postgres:

- **Only published reaches parents.** RLS lets the `anon` role `SELECT` a row only when its
  org's `listing_status = 'published'`. Children (ensembles, performances, auditions, sources)
  are readable only when their parent org is published. There are no write policies for the
  public, so all writes are denied by default.
- **No guesses masquerading as facts.** A CHECK constraint on every verifiable field requires
  a `verified` fact to carry a value **and** a source, and forbids an `unverified` fact from
  carrying a value.
- **Scope can't creep in through data.** `organizations.metro` is constrained to
  `'Greater Los Angeles'`; an out-of-area insert fails.

These were validated against Postgres 16 (view shape matches `data.json` exactly; draft orgs
and their children are hidden from `anon`; bad verifiable rows and non-LA rows are rejected).

---

## Deploying (when you're ready)

1. **Create a hosted project** at supabase.com. Link and push the schema:
   ```bash
   supabase link --project-ref <ref>
   supabase db push                 # applies migrations to the hosted DB
   ```
   Load the curated data once (Studio SQL editor, or `psql` with `seed.sql`).
2. **Front-end** → host the static files (Cloudflare Pages / Netlify, deploy from git).
   Set `config.js` to the hosted project's API URL + anon key (the anon key is public).
3. **Auth providers** → configure Google + Apple (see `PRIVACY.md` / `config.toml` for the
   redirect URIs), and set the secrets via `.env` locally or the dashboard in production.

Costs: Supabase free tier and Cloudflare/Netlify free tier cover one-metro scale; the Apple
Developer membership you already have covers Sign in with Apple.
