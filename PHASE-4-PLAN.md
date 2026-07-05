# Tutti — Phase 4 plan: scale & sustainability

*Drafted 2026-07-04. Phase 3 is complete and working locally (database, honest data
with deep links, Google sign-in, synced Saved). Phase 4 makes Tutti ready to live on
the internet and stay trustworthy without heroics.*

Per DELEGATION-PLAN.md, Phase 4 starts with **three decisions that are Milai's**,
then four build tasks. Each decision below has the options, the trade-offs in plain
words, and a recommendation. Nothing gets built until the matching decision is made.

---

## Decision 1 — Who serves the map (feeds task 4.1)

**What we have.** Leaflet (the open-source map library — this stays; the note-shaped
pins and Tutti's whole look are built on it) drawing basemap tiles from Carto's free
public "Positron" endpoint, with coordinates entered by hand when an org is curated.

**The real question** isn't the map library — it's who serves the *background tiles*
in production, and how new orgs get coordinates.

- **Option A — stay as-is.** $0. Risk: the public Carto endpoint is meant for light
  and development use; there's no contract, and it could rate-limit or change terms
  without notice. Fine for now, shaky as the site's foundation.
- **Option B — a keyed tile provider with the same quiet style** (Stadia Maps or
  MapTiler). Both offer Positron-style light basemaps, free tiers generous enough
  for a young directory, clear commercial terms, and a simple API key in config.
  The map looks the same; the pins don't change.
- **Option C — Google Maps.** Familiar to parents and includes geocoding, but it
  replaces Leaflet entirely — the note pins, colors, and styling would need
  rebuilding inside Google's system, it's heavier, and it costs at scale.

**Geocoding:** at 12–40 curated orgs, we don't need a live geocoding service at all.
A new org's address gets turned into coordinates **once, at curation time**, and
checked by eye on the map. That's a curation step, not infrastructure.

**Recommendation:** **B.** Same look, real terms, small change behind a config flag.
Needs a free account + key from you when we do it. A is acceptable right up until
launch; C only if you'd ever trade Tutti's signature look for Google familiarity.

> **Decided 2026-07-04: Stadia Maps.** Built same day — the app now uses Stadia's
> "Alidade Smooth" tiles whenever `stadiaApiKey` is set in config.js, and falls back
> to the current tiles when it isn't. Milai creates the free Stadia account + key at
> deploy time.

---

## Decision 2 — Money (this *is* task 4.4)

**Already locked by product principle:** parents never pay, parent data is never
collected or sold, and honesty is never for sale — no paying for rank, no paying to
be called "verified."

- **Option A — free, maybe a tip jar.** Running costs are tiny: static hosting free
  tier, Supabase free tier, a domain (~$15/yr). Trust stays pristine. Revenue ~$0.
- **Option B — org-side services, later.** A paid "enhanced profile" (photos, video,
  longer description) that **never** affects ranking or verification and is clearly
  labeled. Real but modest revenue; needs a firewall between money and honesty.
- **Option C — sponsorship / grants.** Arts foundations, local business sponsors
  ("This season supported by…"). Fits the mission; slow, and it's application work.
- **Option D — ads.** Recommend **never**: parents comparing programs for their kid
  next to ads is exactly the trust Tutti exists to protect.

**Recommendation:** **A at launch.** The costs don't force the question, and real
usage will teach us what orgs and parents actually value before we choose B or C.
Nothing to build now — the decision just sets the public "How Tutti works" wording.

> **Decided 2026-07-04: completely free at launch.** Now stated publicly in the
> "How Tutti works" panel. Revisit only with real usage data.

---

## Decision 3 — Trust & verification model (feeds task 4.2)

**Already built:** per-fact citations, "Check their site" pointers, curated-only
listings, and honesty enforced inside the database itself.

**Proposed parent-visible layer at launch:**
1. **"Details last checked <Month Year>"** on every org panel — the data already
   carries `lastVerified`; we just show it.
2. **One public "How we check listings" page** — AI-DISCLOSURE.md and
   DATA-ACCURACY-NOTICE.md merged into one page written for parents.
3. **A working "Report a problem" link** — the missing feedback destination.
   Options: a dedicated email address (simplest, personal), a lightweight form
   (Formspree/Tally free tier — gives structure, hides your inbox), or GitHub
   issues (too technical for parents — no). **Recommendation: dedicated email
   now, form later if volume grows.** *This one blocks launch.*

**Fast-follow after launch:** a **"Confirmed by the organization"** badge — we email
each org a link to review its listing; the badge shows the date they confirmed.
Cheap, powerful, and it starts the relationship with orgs. Needs the email channel
first. Alongside it, a **refresh calendar**: audition windows re-checked quarterly,
everything else twice a year.

> **Decided 2026-07-04: dedicated email.** Built same day — report links appear on
> every org panel and in "How Tutti works" as soon as `reportEmail` is set in
> config.js. Milai creates/chooses the address (form remains a later option).

---

## The build tasks (each waits on its decision)

**4.1 Production map** — after Decision 1.
> *Prompt:* Switch the basemap tiles to <provider> behind a config flag: key in
> config.js, identical visual style, graceful fallback to the current tiles if the
> key is missing. Don't touch pin design or map behavior.
> *Done when:* the map is visually unchanged, tiles load with the key, and removing
> the key still renders a working map.

**4.2 Trust layer** — after Decision 3.
> *Prompt:* Add "Details last checked <Month Year>" to the org panel from
> `lastVerified`; create a "How we check listings" page from AI-DISCLOSURE +
> DATA-ACCURACY-NOTICE in parent-plain words; wire "Report a problem" to
> <destination> from the org panel and the footer.
> *Done when:* every published org shows its checked date, the page reads clearly
> to a non-musician, and a test report reaches the destination.

**4.3 Expansion playbook** — no decision needed; do anytime.
> *Prompt:* Write EXPANSION-PLAYBOOK.md: the repeatable checklist for adding a new
> metro — how orgs get found, curated, verified, QA'd, and launched, with the schema
> scope-guard change called out. Written so metro #2 is a decision, not a project.
> *Done when:* a future session could execute it for one test metro without
> inventing process.

**4.4 Monetization analysis** — delivered by Decision 2 above; revisit with real
usage data after launch.

---

## Not in Phase 4

Public self-submissions, accounts beyond Saved, and actually launching metro #2.
Also assumed but tracked separately: deploy itself (hosted Supabase + static host +
Apple sign-in), CLAUDE.md for the repo, and growing LA toward the 25–40 org target.
