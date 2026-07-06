# Tutti — Verification Ledger (SoCal expansion · batch 2)

_Built: 2026-07-06 · reviewed by Milai same day · 25 organizations · Southern California scope (Bakersfield → San Diego, coast → ~Irvine ±50 mi; Inland Empire in, Santa Barbara & Coachella out)._

Every record is `listingStatus: "in_review"` — nothing reaches parents until you flip it to `published`. Every verified value carries a source URL fetched 2026-07-06; every fact we couldn't confirm is `unverified` with no value (renders as "Check their site"). Ratings are `null` everywhere by design.

**Counts:** 18 youth · 6 professional · 1 community. By region: Greater LA 6, Orange County 5, San Diego County 5, Ventura County 2, Kern County 2, Inland Empire 5. Core verifiable fields: 85 verified / 22 unverified / 18 not-applicable. Audition windows: 30 verified / 8 unverified.

---

## Decisions locked 2026-07-06 (Milai)

1. **Laby Harmony Project removed** from this batch (thin activity evidence). Moved to the batch-3 pipeline — reconfirm with the program director before it ever ships.
2. **Temecula Valley Youth Symphony stays as drafted.** Site is just slow to update; the rendered-browser reads stand.
3. **Coordinates: ±3 miles is the accepted tolerance.** All 25 pins are venue-, office-, or campus-based and sit well inside that. Resolved — no per-org coordinate review needed.
4. **Ensemble tier ages and grade→age conversions are accepted as representative ranges**, not quoted facts. No further confirmation needed on age bands.
5. **Pro anchors with empty auditions arrays are accepted as-is** (New West, Bakersfield SO, San Bernardino SO). Union processes gate/filter vacancy info, so absence of postings is normal — we only list what a site actually posts.
6. **Season labels may be approximate.** Orgs label seasons inconsistently; calendar-inferred labels (e.g. Pacific Symphony "2026–27") are fine without exact dates.
7. **Schema change approved:** org-level `metro` enum expanded to the six regions; dataset-level enum adds `"Southern California"`; version `2.1.0`. The live LA `data.json` re-validates unchanged against the new `schema.json`.

**Merging:** this `data.json` contains only the 25 new orgs. Append its `organizations` into the live file, set the merged file's top-level `metro` to `"Southern California"`, bump `version` to `2.1.0`. Ids have no collisions with the published 11.

---

## ⚑ Remaining flags (not covered by the decisions above)

- **San Diego Symphony July concerts** — the homepage lists dates without years (year inferred from the live 2026 page). Re-check July 12/17/31 before publishing, or drop the three performances; everything else on the record is solid.
- **Stale-but-labeled figures** shown as verified because the value says which cycle it belongs to: SBSYO season + tuition (2025–26), SCVYO $420 fee (Symphony Orchestra, Spring 2026), CSUN season (2025–26), RAA's $1,200 RYO tuition (page carries 25–26 PDFs). These will want a refresh when orgs post 2026–27 numbers.
- **MSLM audition FAQ dates are from 2021–22** — window left unverified; their office is the only current source.
- **OCYS's own site (ocyouthsymphony.com) is JS-walled**; the record is built from its parent Philharmonic Society pages (authoritative). Could browser-check like TVYS if you want the org's own site in sources.
- **SBSYO winter-concert price** (`from: 10`) comes from the page's standing "$10 general admission" policy for youth concerts, not a per-event listing.
- **ECYS `financialAid: true`** rests on stated $100–$500/semester stipends (program is tuition-free, so "aid" is arguably moot).
- **No-audition programs got verified windows** with explanatory values (ICYOLA "open enrollment via interest form"; MSLM La Petite "no audition — seating assessments"), matching the SMYO precedent.
- **Classification calls** (flagging, not blocking): ECYS typed `youth` though its Advanced Division runs to age 28; CSUN typed `youth` though university-hosted; San Bernardino Symphony typed `professional` on structure; Claremont SO `community` (Culver City pattern); Riverside Arts Academy listed because it operates the Riverside Youth Orchestra (its mariachi program excluded as non-orchestral); MSLM record scoped to the youth arm only; SCYSO kept in Orange County though one of its three rehearsal sites is Ontario; single mixed-level orgs use ensemble level `Intermediate` as nearest enum. Piano/saxophone admitted by several orgs sit outside the instruments enum — noted in ensemble descs.

---

## Still needs confirmation, per organization

A field listed here renders as **"Check their site"** until you confirm it.

### Greater Los Angeles (6)

- **ICYOLA** (youth) — rehearsal day/time/venue (site says only "weekly"); financial-aid policy; finale ticket price.
- **Claremont Young Musicians Orchestra** (youth) — tuition; financial aid; 2026–27 CYMO/Intermezzo audition dates (site says "posted July 2026" — re-check shortly).
- **Santa Clarita Valley Youth Orchestra** (youth) — financial aid; per-ensemble tuition beyond the verified Symphony Orchestra $420/Spring 2026 fee.
- **CSUN Youth Orchestras** (youth) — rehearsal schedule; commitment; tuition amount (payment portal behind a login); financial aid; 2026–27 audition dates (recurring windows verified in general terms).
- **Claremont Symphony** (community) — membership dues; financial aid; 2026–27 concert dates. Its association also sponsors the separate Claremont Youth Symphony Orchestra — batch-3 candidate; don't merge the two.
- **Musique Sur La Mer Youth Orchestras** (youth) — tuition amount (in a registration PDF); current audition dates.

### Orange County (5)

- **Pacific Symphony** (professional) — commitment terms; ticket prices for the two dated Segerstrom concerts (Aug 15 Symphony in the Cities verified free).
- **Pacific Symphony Youth Ensembles** (youth) — ✅ nothing outstanding among core fields; next spring's audition dates will need a refresh (2026–27 cycle closed May 1).
- **Orange County Youth Symphony & String Ensemble** (youth) — next audition window (2026–27 cycle closed May 13); 2026–27 concert dates ("calendar being finalized").
- **South Coast Youth Symphony Orchestra** (youth) — tuition and financial aid (in a registration packet PDF); opening-concert venue/price.
- **Community Youth Orchestra of SoCal** (youth) — ✅ nothing outstanding among core fields; 2026–27 rehearsal venue itself is "Irvine/Tustin area, TBC" (caveat inside the verified value).

### San Diego County (5)

- **San Diego Symphony** (professional) — July concert prices, and the July dates re-check above.
- **San Diego Youth Symphony & Conservatory** (youth) — ✅ nothing outstanding; registration is open right now (July 6–30). Use keynote-music.org, not the stale sdys.org, for re-checks.
- **San Diego Civic Youth Orchestra** (youth) — financial aid (a $25 audition fee appeared only in a search snippet and was deliberately left out).
- **Mainly Mozart Youth Orchestra** (youth) — beginner-enrollment window (enrollment live, no stated deadline).
- **East County Youth Symphony** (youth) — Nov 18 concert ticket price.

### Ventura County (2)

- **New West Symphony** (professional) — commitment terms; concert prices. (Blurb still truthfully mentions its Laby Harmony education program even though Laby is no longer a separate listing.)
- **Lyceum Oaks Youth Orchestra** (youth) — ✅ core fields all verified; concert ticket prices only. **This is the renamed Conejo Valley Youth Orchestra** (cvyo.org 301-redirects — verified), so CVYO searches should land here.

### Kern County (2)

- **Bakersfield Symphony** (professional) — commitment terms; concert prices.
- **Bakersfield Youth Symphony** (youth) — ✅ nothing outstanding ($275/yr, Sept 12 auditions, CSUB Sundays all verified); dated concerts live in a calendar PDF.

### Inland Empire (5)

- **San Bernardino Symphony Youth Orchestras** (youth) — 2026–27 audition dates and tuition (verified figures labeled 2025–26); winter-concert venue.
- **Riverside Arts Academy / Riverside Youth Orchestra** (youth) — specific audition dates; dollar tuition for the smaller classes; dated performances.
- **Temecula Valley Youth Symphony** (youth) — tuition; financial aid; 2026–27 session dates (kept per decision 2; rehearsal/commitment/season/rolling auditions verified via rendered pages).
- **Redlands Symphony** (professional) — ✅ core fields verified (75th-anniversary 2026–27 season, AFM Local 47, rolling substitute list); concert prices only.
- **San Bernardino Symphony** (professional) — season label; commitment; venues/prices for the Sep 5 and Dec 12 concerts. Kept because it anchors the SBSYO youth listing.

---

## Excluded — do not ship (with evidence)

- **Laby Harmony Project of New West Symphony** — removed from batch 2 by Milai (2026-07-06): activity evidence too thin (newest dated program evidence spring 2025; no public application page). In the batch-3 pipeline; confirm directly with New West before listing.
- **NYO New Youth Orchestra (San Diego/Sorrento Valley)** — site frozen in 2014 ("Spring Concerts 2014"); a same-address Yelp listing is marked closed.
- **Redlands Youth Symphony (U of Redlands CSMA)** — official page still says "RYS resumes September 2024!"; no 2025–26 or 2026–27 evidence. Email csma@redlands.edu before any future listing. (Reference if it revives: ages 11–18, Wed 6:30–8:30 PM, $110/semester.)
- **Ojai Youth Symphony** — no official site found; no activity evidence since 2024.
- **Youth Philharmonic Orchestra (San Diego)** — active nonprofit, but operates as City Heights Music School (classes/camps/mariachi), not a placement youth orchestra.
- **Valley Youth Orchestra** (Delta, **Colorado**) and **San Juan Symphony Youth Orchestras** (Durango, CO) — out of region; they surface in LA/OC searches.
- **Santa Barbara / Coachella / high desert** — out of scope per Milai's call; nothing drafted.

---

## Batch-3 pipeline (found, not drafted)

Youth: **Laby Harmony Project** (Ventura — needs direct activity confirmation), **Claremont Youth Symphony Orchestra** (claremontyouthsymphony.org — 44th season), **California Young Artists Symphony** (cyasymphony.org — LOYO's tuition-free pre-professional sister; straddles Ventura/LA — strong candidate), **Symphonie Jeunesse** (Redlands — 17th season per Nov 2025 news, no site found), **Orange County Symphony Youth Wind Symphony** (Anaheim), **Four Seasons Youth Orchestra** (Mission Viejo — unvetted), **California Philharmonic Youth Orchestra** (location unconfirmed), **The Opus Project** (Chula Vista — SDYS's free after-school sibling), **Fortissimo Orchestra Program** (San Marcos — school-program shape).

Community/pro/collegiate: Beach Cities Symphony (Torrance), Thousand Oaks Philharmonic, Channel Islands Chamber Orchestra, La Jolla Symphony & Chorus, Poway Symphony, Palomar Symphony (collegiate), Ventura College Symphony (collegiate), CSUSB Symphony (collegiate), Riverside Philharmonic (third IE anchor — active, no next-season listings yet), Redlands Community Orchestra, MSLM Chamber Orchestra (pro arm).

---

## Global notes

- `reviews: null` for all 25 by design; no stars render.
- All records `provenanceType: "curated"`, `lastVerified: 2026-07-06`.
- The approximation policies above (pins, age bands, season labels) don't loosen the honesty contract where it counts: **prices, tuition, and audition dates are still exact-or-unverified, never approximated.**
- Audition statuses are date-relative to 2026-07-06 and will drift — several windows close in late July (SDYS July 30, MMYO July 31, SD Civic July 18), so publishing the approved youth records this month preserves the most value.
- Research method: 5 parallel researchers; official-site fetches only for verified facts (search snippets never accepted); every org passed an activity check except TVYS (accepted, decision 2) — and Laby, which was removed.
