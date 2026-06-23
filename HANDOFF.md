# Tutti — Project Handoff

**Tutti** is a map-first directory that helps people — primarily **parents looking for a youth orchestra for their kid** — find local orchestras, ensembles, and symphonies, then see season, ticket prices, ensemble tiers, and audition info at a glance.

Tagline: *find an ensemble near you.* ("Tutti" = the musical instruction meaning *everyone plays* — chosen for an inclusive, join-friendly feel.)

This document is the source of truth for anyone (human or Claude) continuing the build. Read it fully before changing the prototype.

---

## 1. Vision & audience

- **Primary user:** a parent with a school-age child who plays an instrument and wants to find a suitable youth orchestra to join. They are *not* music professionals; the experience must be friendly and obvious.
- **Secondary users:** student/collegiate/adult players hunting for auditions; concertgoers looking for what's on.
- **Core job of the landing page:** drop in a location → see nearby orchestras as map pins → open one and understand *is this right for my kid, what does it cost, and how do they get in.*
- **Must-have, explicitly requested:** an **Auditions** section in the left nav covering open + upcoming auditions across levels (student → professional), each linking out to the org's own page.

Not a ticketing platform and not a competitor to any single orchestra's site — Tutti is the **discovery + comparison layer** that routes people to the real org.

---

## 2. Current state

A working **front-end prototype** exists: `tutti-orchestra-finder.html`. It is a single self-contained HTML file (no build step). Everything below is implemented and functional.

**What works**
- Map-first landing using Leaflet, with location search (Enter), **Near me** (geolocation), and quick-location chips.
- Color-coded note-head pins; legend bottom-left.
- Left **results rail** synced to the map, filterable by **type** (All / Youth / Professional / Community) and **player age**.
- **Detail slide-over** (from right) per org: blurb, ensembles broken out by **tier + age + level**, **upcoming performances with ticket prices**, tickets/tuition, auditions, and **Visit website** link-out.
- Left icon nav with four views: **Explore** (map), **Auditions**, **Concerts**, **Saved**.
- **Auditions board:** every audition aggregated across orgs, filterable by status (Open / Upcoming / Rolling), level, and instrument/org search; each card links to the org's audition page.
- **Concerts board:** all performances, soonest first, with pricing.
- **Saved:** heart any org (session-only).
- Mobile: rail/map toggle, responsive boards, keyboard focus, reduced-motion support.
- A persistent "prototype — sample data" ribbon so nothing reads as a real claim.

**What is fake / not real yet**
- All listings in the prototype are **illustrative sample data**. Org *names* are real public organizations placed at approximate real coordinates, but **season, ticket prices, tuition, audition windows, and some website URLs are placeholders.**
- No backend, no database, no accounts. Saved state is in-memory and resets on reload.
- Geocoding is best-effort via the public Nominatim endpoint (rate-limited; usage-policy constrained).

> **Phase 2 in progress — the data model is changing.** The finalized real-data contract now lives in `schema.json` + `SCHEMA.md` (see section 4). Once the real LA dataset (Phase 2.2) lands, the blanket "everything is sample data" framing above stops being true: confirmed facts are shown with a cited source, and facts we *couldn't* confirm render as **"Check their site"** rather than a placeholder. The "sample data" ribbon stays only as long as listings are still sample data.

---

## 3. Tech architecture

| Concern | Choice | Notes |
|---|---|---|
| Structure | Single `.html` file, vanilla JS, no framework | Renders directly in a browser or as a Claude artifact. No build/tooling. |
| Map | **Leaflet 1.9.4** via cdnjs | `L.divIcon` note-head pins; `L.layerGroup` for markers. |
| Tiles | **CARTO Positron** (`light_all`) | Muted base so brass/garnet pins read clearly. |
| Geocoding | **Nominatim** (OpenStreetMap), best-effort | Falls back to matching a known `area` string first, so demo never hard-fails. |
| "Near me" | `navigator.geolocation` | |
| Fonts | Google Fonts: **Fraunces** (display), **Mulish** (body/UI) | |
| State | Plain JS module-scope variables + a `Set` for saved | **No `localStorage`** — it is unsupported in Claude artifacts and will break rendering there. Keep all state in memory. |

**Important constraint:** if work continues *inside Claude artifacts*, never introduce `localStorage`/`sessionStorage`, and keep external scripts to cdnjs. If/when the project graduates to a real hosted app, these constraints lift — see the Delegation Plan.

---

## 4. Data model

> **The canonical data contract now lives in `schema.json` (machine-checkable) and `SCHEMA.md` (plain-English explainer).** Read those before changing data shape. This section is the orientation; those two files are the source of truth.

There are effectively two models, and it matters which one you're touching:

- **Prototype model (current `tutti-orchestra-finder.html`):** the inline `DATA[]` array, where every fact is a plain value. This still describes the shipped prototype file.
- **Real-data model (Phase 2 onward):** what `schema.json` defines. The external `data.json` (Phase 2.2) and the HTML rebuild (Phase 2.3) target *this* one. Build new work against the schema, not against the inline prototype array.

**Two changes in the real model you must know before touching anything:**

1. **Verifiable facts carry a status, not just a value.** The volatile, parent-facing fields — `season`, `tuition`, `rehearsal`, `commitment`, `financialAid`, each performance's price (`from`), and each audition's `window` — are now small objects with `status: "verified" | "unverified" | "not_applicable"`. The UI shows the value when **verified** (which requires a cited `source`), **"Check their site"** when **unverified**, and hides the row when **not_applicable**. The schema forbids an unverified field from carrying a value, so a guess can't masquerade as confirmed. Stable identity fields (name, type, lat/lng, website) and editorial fields (`blurb`, `goodFit`) stay plain values. See `SCHEMA.md` for the full list and examples.

2. **Ratings are absent until a real source exists.** The prototype's `rating` / `reviewCount` / `ratingSource` were fake. The real model has a single `reviews` object that is **`null` until a genuine aggregated source exists** — never invented, never self-reported by orgs. Any code that renders stars or offers a "Highest rated" sort must handle `reviews: null` gracefully.

The real model also adds lifecycle hooks — `listingStatus` (draft / in_review / **published**), `provenanceType` (curated / self_submitted / scraped), and `submittedBy` — so self-serve submissions and scrape-then-review can plug in later (Phase 3) without a schema change. Only `published` listings should reach parents.

Prototype-only config that is **not** org data: `PRESETS[]` = quick map locations `{ label, lat, lng, z }`. Stays in the app, out of the schema.

**Derived behavior to preserve when editing:**
- Type → pin color and badge color (youth=brass, professional=garnet, community=teal, collegiate=slate).
- A performance price of `0` renders as "Free"; the detail-panel price range is computed across all performance prices.
- A tuition row is hidden when tuition is `not_applicable` (pro orgs); shown as a value when `verified`; shown as **"Check their site"** when `unverified`.
- Age filter checks **ensemble** age overlap, not just org `ages`.
- Auditions board sorts open → upcoming → rolling.

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

Top-to-bottom: `<style>` (tokens → shell → topbar → nav → explore/rail/map → detail → boards → mobile) → markup (topbar, nav, four `<section class="view">` blocks, ribbon) → `<script>` (DATA → PRESETS → state → filter logic → results rail → map → detail panel → saved → auditions board → concerts board → view switching → search/geocode → event listeners → boot).

**Watch-outs learned the hard way**
- CSS specificity traps: a class like `.board { display:flex }` will silently override `.view { display:none }` (equal specificity, later rule wins) and make hidden views leak. Keep **display** controlled by `.view` / `.view.is-active`, and use separate classes only for non-display styling. (This bug already bit us once — the boards overlapped the map.)
- Leaflet needs `map.invalidateSize()` after a hidden container becomes visible (handled on view switch + boot).

---

## 7. Known limitations & honest-data rules

- **Never present an unconfirmed fact as real.** In the prototype that means keeping the "sample data" labeling. In the real model it means the rule is enforced by the data: a fact is only shown as a value when its `status` is `verified` (with a cited `source`); anything `unverified` renders as **"Check their site"**, never as a guessed value. Don't hand-write a tuition, price, date, or audition window into a `verified` field without a real source.
- **Never invent or self-report ratings.** `reviews` stays `null` until a genuine aggregated source exists.
- The "prototype / sample data" ribbon stays until real published listings exist; retire it per-listing (or globally) only once data is genuinely real and verified.
- Some sample `website` URLs in the prototype are best-guess homepages; verify before any are treated as authoritative.
- Nominatim and CARTO tiles are free/community resources with rate limits and attribution requirements — fine for a prototype, not for production scale.

---

## 8. Open product decisions (need a human call)

1. **How does data get in and stay current?** Manual curation vs. org self-service submissions vs. scrape-then-review. This is the real business problem; the UI is the easy part.
2. **Geographic scope for v1.** Prototype is greater Los Angeles. One metro done well > thin national coverage.
3. **Map/geocoding/search at scale** (stay on OSM/Nominatim, or move to Mapbox/Google for reliability + quota).
4. **Monetization / sustainability**, if any (free directory, org listings, sponsorship).
5. **Trust:** how listings are verified so a parent can rely on them.

---

## 9. Glossary (for non-music-readers continuing the build)

- **Ensemble / orchestra / symphony** — a group that plays together; an org may run several at different levels.
- **Tier** — graded ensembles within one org (beginner → advanced), usually by skill/age.
- **Youth orchestra** — for students; usually charges tuition and requires placement or audition.
- **Pre-professional** — top youth/young-adult level, conservatory-grade.
- **Side-by-side** — youth players performing alongside a professional orchestra.
- **Tutti** — "everyone plays together"; the product name and brand idea.

---

*Current prototype build file: `tutti-orchestra-finder.html`. The data contract now lives in `schema.json` + `SCHEMA.md`; the design tokens are in section 5. Treat both as stable contracts — change them deliberately, not incidentally.*
