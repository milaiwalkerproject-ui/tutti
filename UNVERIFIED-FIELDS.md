# Tutti — Verification Ledger (Phase 2.2 / 2.3)

_Built: 2026-06-22 · 12 organizations · Greater Los Angeles._

> **Scope note (2026-07-06):** Tutti's scope expanded to **Southern California**
> (Bakersfield to San Diego, coast to ~Irvine, ±50 miles — Milai's decision).
> The 11 current orgs' `metro` label was updated accordingly; **no facts
> changed** and nothing new was verified in that commit. Orgs curated for the
> wider region get their own dated entries here as they are verified.
> Audition windows are re-checked **weekly** for now.

This file is the honesty audit for `data.json`. Every field that drives the UI
is either **verified** (carries a `value` + a `source` URL + `asOf` date) or
**unverified** (no value — the app shows a **"Check their site"** link instead
of inventing one). Ratings are deliberately `null` everywhere: we have no
trustworthy aggregated review source, so the app shows no stars at all.

> **How to read this:** anything listed under "Still needs confirmation" is a
> field where the app currently links the family out to the org's website
> rather than displaying a number/date we couldn't stand behind. Confirming one
> just means filling in `value` + `source` and flipping `status` to `verified`.

---

## ⚑ Judgment calls flagged for your review

1. **Culver City Symphony — classification ambiguity.** The Assoc. of California
   Symphony Orchestras profile describes it as *professional with paid
   musicians*, but the ensemble openly includes amateurs and students and runs
   free community concerts. I **kept `type: "community"`** to match the
   prototype and the apparent user intent, but this is a genuine either-way
   call. If you'd rather present it as professional, it's a one-line change.

2. **Ensemble / tier names are illustrative.** For several orgs the individual
   ensemble tier names and age bands (e.g. "Beginning Orchestra · ages 6–10")
   are reasonable representations of how the program is structured, not
   verbatim-confirmed roster names. They're shown as program *shape*, not as
   quotable fact. Treat them as "needs a pass against the current catalog."

3. **Two coordinates are approximate.** `layo` (Encino) and `smyo` (Santa
   Monica / Virginia Ave Park) are placed at approximate lat/lng for the map.
   Fine for a pin; not survey-grade.

4. **Audition statuses are date-relative (asOf 2026-06-22).** Colburn's string
   auditions (June 6–7 2026) are now **past**, so that org is shown as rolling/
   contact-to-enroll. LAYO's Aug 22–23 2026 auditions are **upcoming** and
   verified. SMYO is open-enrollment (no audition), verified. These will drift
   as dates pass and should be re-checked each season.

---

## Corrections made vs. the prototype's placeholder data

These were **wrong or stale** in the prototype and are now fixed + sourced:

| Org | Prototype said | Corrected to (verified) |
|---|---|---|
| **GYO** | "free" | **Not free — $875/yr** (incl. 5 tickets); scholarships exist |
| **SMYO** | "$500/sem" | **Tuition-free *and* audition-free**; open enrollment |
| **LAYO** | "West LA", `layo.org` | **Encino**; site `losangelesyouthorchestra.org`; tuition $750/sem or $1,400/yr |
| **PYSO** | `pasadenayouthsymphony.org` | Real site `pasadenasymphony-pops.org/education/pyso` |
| **GYO** | `.org` | Real site `glendaleyouthorchestra.com` |
| **YOLA** | `laphil.com/yola` | `laphil.com/learn/yola`; free, ages 6–18, instruments provided |
| **Colburn** | "$1,200/yr", "Youth Orchestra" | Mid-restructure → Youth Philharmonic 2026–27; tuition **not** verifiable; scholarships confirmed |
| **AYS** | generic | Tuition-free fellowship **+ stipend**, ages 15+ (no upper limit) |
| **Culver City** | "$90/season" | Price **not** verifiable; 3–4 free concerts + summer Marina del Rey series |

---

## Still needs confirmation, per organization

Legend: a field here means the app currently shows **"Check their site"** (or,
for performances, hides the price line) rather than displaying an unverified value.

- **YOLA** (youth) — season, rehearsal schedule, financial-aid specifics, both audition windows. _(tuition = Free, commitment: verified)_
- **Colburn Community School — Youth Orchestras** (youth) — season label, rehearsal, commitment, **tuition** (the conservatory is mid-restructure; no quotable youth-orchestra tuition), both audition windows.
- ~~**American Youth Symphony**~~ — **removed 2026-07-04**: org ceased operations Mar 2024 (see Pointer pass below).
- **LAYO** (youth) — ✅ **nothing outstanding** among displayed fields (tuition, audition window Aug 22–23 2026, etc. all verified).
- **PYSO** (youth) — season, tuition amount, audition window. _(financial aid available: verified)_
- **GYO** (youth) — season, rehearsal, commitment, audition window. _(tuition $875/yr + scholarships: verified)_
- **SMYO** (youth) — season, financial-aid specifics. _(tuition-free, audition-free open enrollment: verified)_
- **LA Phil** (professional) — season label, audition/fellowship window. _(no specific public dates verified → performances intentionally empty)_
- **LACO** (professional) — audition window; **ticket prices** for the 3 listed 2026/27 concerts (dates + programs verified, prices not).
- **Pasadena Symphony & POPS** (professional) — audition window. _(no specific dated performances embedded yet)_
- **Long Beach Symphony** (professional) — audition window; **ticket prices** for the 3 listed Classical concerts (dates + programs verified, prices not).
- **Culver City Symphony** (community) — rehearsal, commitment, financial aid, **tuition/price**, audition window. _(See classification flag above.)_

---

## Global notes

- **Reviews / ratings:** `null` for all 12 by design. No star UI renders. If a
  credible source is ever wired in, the schema already supports
  `reviews: { rating, count, source }`.
- **Self-submission form:** the "Add your orchestra" form in the HTML still
  builds the **old flat shape** and only `console.log`s — it is **not** fed into
  the dataset. Wiring it to the verifiable schema (so user submissions land as
  `provenanceType: "user_submitted"`, `listingStatus: "pending"`) is a **Phase 3**
  item, not done here.
- **Artifact vs. server:** the page tries `fetch("data.json")` first; when that
  fails (e.g. running as a standalone Claude artifact over `file://`), it falls
  back to the dataset embedded in `<script id="bootstrap-data">`. For a real
  static deploy, ship `data.json` next to the HTML and it loads that instead —
  edit one file, no rebuild.

---

## Pointer pass — 2026-07-04

Unverified fields can now carry a `source` **pointer** — the page a parent should
check — used as the "Check their site" link target (see SCHEMA.md). Results of
the research pass across all 12 orgs:

- **Every audition window and unverified ticket price** already deep-links via the
  audition/performance's own cited `source` (code change, no new data).
- **Colburn** — tuition → Community School registration page; season/rehearsal/
  commitment → ensembles page. **PYSO** — season/tuition → auditions page.
  **GYO** — season → auditions page. **YOLA** — season/rehearsal/financial aid →
  the YOLA program page (sites, Interest Form, free-instruction model).
  **LA Phil** — season → the official 2026/27 season page.
- **SMYO** — no change *on purpose*: its listing URL already **is** the program
  page carrying registration and the tuition-free model.
- **Culver City Symphony** — no change *on purpose*: the site has no player-facing
  info page (its "membership" pages are donor-focused), so the homepage remains
  the honest pointer.
- **American Youth Symphony** — found **defunct**: final performance Feb 25, 2024;
  ceased operations Mar 15, 2024 (Wikipedia; League of American Orchestras,
  symphony.org, Mar 2024). Site still online. **Removed from the dataset
  2026-07-04 with Milai's approval** (git history keeps the full record).
