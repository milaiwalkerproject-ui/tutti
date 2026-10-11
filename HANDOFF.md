# Tutti — Project Handoff

**Tutti** is a map-first directory that helps people — primarily **parents looking for a youth orchestra for their kid** — find local orchestras, ensembles, and symphonies, then see season, ticket prices, ensemble tiers, and audition info at a glance.

Tagline: *find an ensemble near you.* ("Tutti" = the musical instruction meaning *everyone plays* — chosen for an inclusive, join-friendly feel.)

This document orients anyone (human or Claude) continuing the build; it points to the files that define things (`schema.json`, `CLAUDE.md`, the phase plans). Read it fully before changing the app. **Last refreshed 2026-10-10 (Phase 5).**

---

## 1. Vision & audience

- **Primary user:** a parent with a school-age child who plays an instrument and wants to find a suitable youth orchestra to join. They are *not* music professionals; the experience must be friendly and obvious.
- **Secondary users:** student/collegiate/adult players hunting for auditions; concertgoers looking for what's on.
- **Core job of the landing page:** drop in a location → see nearby orchestras as map pins → open one and understand *is this right for my kid, what does it cost, and how do they get in.*
- **Must-have, explicitly requested:** an **Auditions** section in the left nav covering auditions across levels, each linking out to the org's own page.
- **Families first (Phase 5, 2026-10-10):** youth and student auditions are Tutti's job. Professional auditions move to **Auditioner**'s feed once it launches (they stay on Tutti until then).

Not a ticketing platform and not a competitor to any single orchestra's site — Tutti is the **discovery + comparison layer** that routes people to the real org.

**Sister project — Auditioner** (`milaiwalkerproject-ui/auditioner`): an iPhone/iPad app that helps players prepare for orchestra auditions. Tutti helps families *find* an orchestra; Auditioner helps players *win the seat*. Same honesty contract. How the two connect is in `PHASE-5-PLAN.md` and `CLAUDE.md`.

---

## 2. Current state (2026-10-10)

**Live** at **https://tutti-orchestra.com** since July 2026: 36 published, curated organizations across Southern California (24 youth, 10 professional, 2 community) in six regions — Greater Los Angeles, Orange County, San Diego County, Ventura County, Kern County, Inland Empire.

**What works**
- Map-first landing (Leaflet + Stadia tiles), location search, **Near me**, quick-location chips, note-head pins coloured by type.
- Results rail with type / player age / instrument filters, sorting, and an "Auditions open now" toggle; **Compare** for 2–3 orgs.
- Orchestra panel: blurb, "Good fit if…", facts at a glance, ensembles by tier, upcoming performances, tickets/tuition, auditions, **Apply on their site**, **Visit website**, **Share**, "Details last checked <month>", **Report a problem**, "How we check listings".
- **Auditions board** with date-driven badges (Phase 5): Open now · until <date> / Apply by <date> / Opens <date> / Year-round / Dates: check their site / Closed for this round (grouped last).
- **Concerts board** — upcoming only; past dates drop off by themselves.
- **Saved**, synced to an account with Google sign-in (Apple sign-in prepared, not yet switched on).
- **Share links:** every orchestra at `/o/<id>`; link preview image; favicon.
- "How Tutti works" dialog; "Suggest an orchestra" (email to the report inbox).
- Phones, keyboard focus, reduced motion (the map jumps instead of flying).

**Every parent-facing fact** is either verified with a cited source and an as-of date, or shown as "Check their site". The database enforces it (see §7).

**What's still open** — see `PHASE-5-PLAN.md` → *Next tasks* (rollout, sweeps, Auditioner links, Google-readable org pages, "Confirmed by the organization", Apple sign-in).

---

## 3. Tech architecture

| Concern | Choice | Notes |
|---|---|---|
| App | One file, `tutti-orchestra-finder.html` — vanilla JS, no framework, no build step | Also renders as a Claude artifact (falls back to the embedded dataset). |
| Config | `config.js` (public values only: Supabase URL + anon key, Stadia key, report inbox) | Loaded as `/config.js` so it resolves on `/o/<id>` share addresses. |
| Data | **Supabase** Postgres — RLS (published-only), honesty CHECKs, `org_listings` read view | Load order: API → `/data.json` → embedded copy. |
| Source of truth | `data.json` → `node scripts/sync-data.mjs` regenerates `supabase/seed.sql` and the embedded copy | `--check` fails on any drift. Live refresh: `scripts/audition-updates-sql.mjs`. |
| Map | Leaflet 1.9.4 (cdnjs); **Stadia** "Alidade Smooth" tiles with the key, Carto fallback | Note-head `L.divIcon` pins. |
| Search | Matches a known listing area first, then OpenStreetMap **Nominatim** (best-effort, rate-limited) | New orgs get coordinates once, at curation time. |
| Accounts | Supabase Auth — Google (Apple ready to switch on) | Powers Saved only. |
| Hosting | **Cloudflare** static assets (`wrangler.jsonc`) — deploys on every push to `main` | `_redirects`: `/` and `/o/*` serve the app. |
| Fonts | Fraunces (display), Mulish (body) via Google Fonts | |
| State | In memory + Supabase | **No `localStorage`/`sessionStorage`.** |

Run it locally: `BACKEND.md`. Put it online / roll out a phase: `LAUNCH-CHECKLIST.md`.

---

## 4. Data model

> **The canonical data contract now lives in `schema.json` (machine-checkable) and `SCHEMA.md` (plain-English explainer).** Read those before changing data shape. This section is the orientation; those two files are the source of truth.

There are effectively two models, and it matters which one you're touching:

The app, `data.json`, the database and the API all use the one model `schema.json` defines (the early prototype's plain-value `DATA[]` array is gone).

**Three things you must know before touching anything:**

1. **Verifiable facts carry a status, not just a value.** The volatile, parent-facing fields — `season`, `tuition`, `rehearsal`, `commitment`, `financialAid`, each performance's price (`from`), and each audition's `window` — are now small objects with `status: "verified" | "unverified" | "not_applicable"`. The UI shows the value when **verified** (which requires a cited `source`), **"Check their site"** when **unverified**, and hides the row when **not_applicable**. The schema forbids an unverified field from carrying a value, so a guess can't masquerade as confirmed. Stable identity fields (name, type, lat/lng, website) and editorial fields (`blurb`, `goodFit`) stay plain values. See `SCHEMA.md` for the full list and examples.

2. **Ratings are absent until a real source exists.** The prototype's `rating` / `reviewCount` / `ratingSource` were fake. The real model has a single `reviews` object that is **`null` until a genuine aggregated source exists** — never invented, never self-reported by orgs. Any code that renders stars or offers a "Highest rated" sort must handle `reviews: null` gracefully.

3. **Dates decide (Phase 5).** An audition may carry `opensOn` / `closesOn`, restating dates from its *verified* window. The badge parents see is computed from them and today's date — the hand-set `status` never says "open" on its own any more. Only on verified windows (schema, sync script, DB CHECK). Table of badges: `SCHEMA.md`.

The real model also adds lifecycle hooks — `listingStatus` (draft / in_review / **published**), `provenanceType` (curated / self_submitted / scraped), and `submittedBy` — so self-serve submissions and scrape-then-review can plug in later (Phase 3) without a schema change. Only `published` listings should reach parents.

Prototype-only config that is **not** org data: `PRESETS[]` = quick map locations `{ label, lat, lng, z }`. Stays in the app, out of the schema.

**Derived behavior to preserve when editing:**
- Type → pin color and badge color (youth=brass, professional=garnet, community=teal, collegiate=slate).
- A performance price of `0` renders as "Free"; the detail-panel price range is computed across all performance prices.
- A tuition row is hidden when tuition is `not_applicable` (pro orgs); shown as a value when `verified`; shown as **"Check their site"** when `unverified`.
- Age filter checks **ensemble** age overlap, not just org `ages`.
- Auditions board sorts open now → apply-by → coming up → year-round → dates unknown → closed (closed rounds grouped last).
- Concerts and the price range only use performances dated today or later.

---

## 5. Design system

The aesthetic is "modern map app meets concert programme" — warm, refined, but friendly enough for parents. Avoid generic SaaS defaults.

**Tokens (CSS variables in `:root`)**
```
--paper      #F2F1EC   warm programme paper (app background)
--surface    #FFFFFF   panels/cards
--ink        #1E2E37   deep slate-teal — primary text + dark nav/footer
--ink-soft   #52636C   secondary text
--ink-faint  #8A989F   tertiary / placeholders
--brass      #B5832A   YOUTH accent + primary actions
--brass-deep #946A1E   hover/active brass
--garnet     #8C2F36   PROFESSIONAL
--teal       #2E6E6A   COMMUNITY
--slate      #3E5360   COLLEGIATE / labels
```
- **Display font:** Fraunces (optical serif). **Body/UI:** Mulish.
- **Signature element:** note-head map pins (♪ youth, ♫ professional) + the five-line music-staff motif behind the detail panel header. Keep this; it's the thing the app is remembered by.
- Pin/badge color must always match `type`. Don't add a fifth accent without a reason.

**Naming/copy conventions:** plain verbs, sentence case, name things by what the user controls ("Player age", "Visit website", "Save"). Errors/empties give direction, not mood.

---

## 6. Code layout (within the single file)

Top-to-bottom: head (link-preview tags, `/config.js`, supabase-js) → `<style>` (tokens → shell → topbar → nav → explore/rail/map → detail → boards → modals → ribbon/toast → mobile) → markup (topbar, nav, four `<section class="view">` blocks, dialogs, ribbon, toast) → the embedded dataset (`<script id="bootstrap-data">`, generated) → `<script>` (loader → verifiable-field helpers → state → audition timing → filters → rail → map → panel → share links → saved/auth → compare → boards → view switching → dialogs → suggest → search → events → boot).

**Watch-outs learned the hard way**
- CSS specificity traps: a class like `.board { display:flex }` will silently override `.view { display:none }` (equal specificity, later rule wins) and make hidden views leak. Keep **display** controlled by `.view` / `.view.is-active`, and use separate classes only for non-display styling. (This bug already bit us once — the boards overlapped the map.)
- Leaflet needs `map.invalidateSize()` after a hidden container becomes visible (handled on view switch + boot).
- `.map-wrap` uses `isolation:isolate` so Leaflet's own z-indexes (zoom buttons at 1000) stay under the panel and dialogs.
- Anything off-screen but still in the DOM (closed panel, hidden compare tray) is `inert`, so Tab can't land in it and scroll the shell.
- Use `mapGo()`, not `map.flyTo()`, so reduced-motion visitors get a jump.

---

## 7. Honest-data rules (enforced, not just intended)

- **A fact is shown as a value only when it's `verified`** — value + cited `source` + `asOf`. Anything else renders **"Check their site"**. The database refuses a verified fact without source/as-of and an unverified fact with a value.
- **Time-sensitive claims expire by themselves.** Audition badges come from confirmed dates; past concerts vanish. Never render a hand-set status as current.
- **Only published listings reach parents** (RLS, and the view filters too). **Scope** is a closed list of six Southern California regions (DB CHECK).
- **Never invent or self-report ratings.** `reviews` stays `null`.
- **Curated only.** No public submission form; suggestions arrive by email and a person checks them.
- **Refresh:** two seasonal sweeps a year (late Feb, early June) plus a re-check for every report (CURATION.md).

---

## 8. Product decisions — made, and still open

**Made** (details in the phase plans): curated sourcing with Milai's approval (Phase 2); Southern California scope, six regions (2026-07-06); Stadia tiles, free at launch, dedicated report inbox (Phase 4); families first, dates decide, seasonal sweeps, share links, Auditioner link rules (Phase 5).

**Still open (Milai's call):**
1. When and how professional auditions hand over to Auditioner (waits on Auditioner's feed).
2. Becoming findable on Google — one generated page per orchestra (Phase 5 task 5.6).
3. "Confirmed by the organization" badge and the email loop with orgs.
4. Sustainability beyond "free" — revisit only with real usage (there is no analytics, by design).
5. A second region beyond Southern California (`EXPANSION-PLAYBOOK.md`).

---

## 9. Glossary (for non-music-readers continuing the build)

- **Ensemble / orchestra / symphony** — a group that plays together; an org may run several at different levels.
- **Tier** — graded ensembles within one org (beginner → advanced), usually by skill/age.
- **Youth orchestra** — for students; usually charges tuition and requires placement or audition.
- **Pre-professional** — top youth/young-adult level, conservatory-grade.
- **Side-by-side** — youth players performing alongside a professional orchestra.
- **Tutti** — "everyone plays together"; the product name and brand idea.

---

*App: `tutti-orchestra-finder.html`. Data contract: `schema.json` + `SCHEMA.md`. Design tokens: section 5. Standing rules: `CLAUDE.md`. Current phase: `PHASE-5-PLAN.md`. Treat the contracts as stable — change them deliberately, not incidentally.*
