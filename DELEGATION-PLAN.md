# Tutti — Delegation Plan

How to take Tutti from prototype to real product, broken into discrete tasks you can hand to Claude one at a time. Each task lists **goal**, a **copy-paste prompt**, and **done when**. Do phases roughly in order; tasks within a phase are mostly independent.

A rough guide on what to delegate vs. decide yourself: **Claude builds; you decide.** Anything in "Open product decisions" (data sourcing, scope, monetization, map provider) is a *you* call — make it, then delegate the build.

---

## Phase 0 — Prototype ✅ (done)
Single-file front-end with map, rail, detail panel, auditions/concerts/saved boards, sample LA data. File: `tutti-orchestra-finder.html`.

---

## Phase 1 — Polish & feature-complete the front-end
Goal: make the prototype demo-ready and convincing without a backend yet.

**1.1 Tier-comparison view**
> Add a "Compare" mode on the Explore view: let me select 2–3 orgs and see them side by side in a table. Compare program tuition, distance from home, concerts per season, and aggregated reviews/ratings of the organization — plus other parent-relevant fields. Keep the existing design tokens and data model.
- *Done when:* I can pick orgs and read a clean side-by-side comparison across those dimensions; works on mobile.
- *Note:* the reviews/ratings column needs a `rating` (and likely `reviewCount`/source) field added to the org data model — it isn't there yet. Flag the schema change before building so it stays in sync with Phase 2.1.

**1.2 "Submit your organization" form**
> Add a front-end "List your organization" form (modal or its own view) capturing every field in the org data model, with validation and a friendly empty/confirmation state. On submit, just log the object to console and show a success message — no backend yet. Keep copy parent-friendly.
- *Done when:* the form produces a valid org object matching the schema in HANDOFF.md.

**1.3 Richer filtering & sorting**
> On the Explore rail, add: distance-from-searched-location sorting, an "auditions open now" toggle, and an instrument filter. Update both the list and the map pins.
- *Done when:* filters compose correctly and the map stays in sync.

**1.4 Detail panel depth**
> Expand the org detail panel: add rehearsal schedule, commitment level, financial-aid flag, and a small "good fit if…" summary for parents. Use placeholder sample data, clearly labeled.

**1.5 Accessibility + mobile audit**
> Audit the whole prototype for accessibility (focus order, ARIA on the map pins and slide-over, contrast) and mobile layout. Produce a fixed file plus a short list of what you changed.

**1.6 "Apply" button → official site**
> On the org detail panel, add a single "Apply" button that opens the organization's official website in a new tab. Tutti never collects or submits anything itself — it's a discovery-and-routing layer, so this is purely an outbound handoff. No form, no backend, one reliable link per org.
- *Done when:* clicking Apply opens the correct org's official site every time, with no data entry on Tutti.

---

## Phase 2 — Real data for one metro
*Decision first (yours):* confirm v1 metro (default: greater LA) and how data is sourced.

**2.1 Define the canonical data schema**
> Based on the data model in HANDOFF.md, write a finalized JSON schema for organizations, ensembles, performances, and auditions, with field types, required/optional, and validation rules. Output it as a `schema.json` plus a short markdown explainer.

**2.2 Seed real listings (curated)**
> Help me build a real seed dataset for [METRO] youth orchestras. For each org, search for and cite official source pages, then draft a data record — but flag every field you couldn't verify rather than inventing it. Produce a `data.json` and a list of unverified fields I need to confirm.
- *Note:* this needs web search; have Claude cite sources and leave gaps explicit.

**2.3 Externalize data from the HTML**
> Refactor the prototype so org data loads from an external `data.json` instead of being inline, with a clear loading and error state. Keep it a static site (no backend yet).

---

## Phase 3 — Backend, persistence, submissions
*Decision first (yours):* hosting + stack (e.g., a simple serverless API + managed DB), and whether you want org self-service.

**3.1 Backend scaffolding**
> Propose a minimal backend for Tutti: data store for orgs/auditions/performances, a read API for the map/boards, and a submission endpoint with a review queue. Recommend a concrete lightweight stack and explain the trade-offs. Then scaffold it.

**3.2 Wire the front-end to the API**
> Replace the static `data.json` fetch with calls to the Tutti API, including loading/error/empty states and basic caching.

**3.3 Real submission + moderation flow**
> Implement the org-submission form against the backend with a moderation/review step before a listing goes live.

**3.4 Saved that persists**
> Add lightweight accounts (or anonymous device persistence) so "Saved" survives reloads, replacing the in-memory Set.

---

## Phase 4 — Scale & sustainability
*Decisions first (yours):* map/geocoding provider, monetization, trust/verification model.

**4.1 Production map + search**
> Evaluate moving from OSM/Nominatim to a paid map+geocoding provider for reliability and quota. Compare options on price, limits, and terms, then implement the switch behind a config flag.

**4.2 Trust & verification**
> Design a "verified listing" system: how an org claims/verifies its page, what badge the parent sees, and how stale data gets flagged. Spec it, then build the front-end pieces.

**4.3 Expansion playbook**
> Write a repeatable process for adding a new metro: data sourcing checklist, QA, and launch steps.

**4.4 Monetization options (analysis)**
> Lay out 3–4 sustainability models for a free directory (sponsorship, premium org listings, grants, etc.) with pros/cons and what each implies for the product. Give your recommendation but present the alternatives.

---

## Delegating well — quick tips
- **One task per conversation.** Paste the task prompt; let Claude read HANDOFF.md + the current file.
- **Always hand over the latest file** when iterating, or tell Claude to start from the version in project knowledge.
- **Keep the contracts stable:** if a task would change the data model or design tokens, ask Claude to flag it before doing it.
- **Make the product calls yourself**, then delegate the build — Claude will otherwise guess, and the guesses compound.
