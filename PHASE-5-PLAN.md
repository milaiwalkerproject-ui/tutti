# Tutti — Phase 5: trust, sharing, and Auditioner

*Decided with Milai Walker in a grill-me session on 2026-10-10, the day Auditioner
(`milaiwalkerproject-ui/auditioner`) joined as Tutti's sister project. This file is the
decision record for Phase 5; `CLAUDE.md` carries the standing rules it adds.*

---

## Why Phase 5 exists — what the live site was doing on 2026-10-10

Tutti has been live at tutti-orchestra.com since July with 36 curated Southern California
orgs. Nothing had changed on `main` since 2026-07-06, and every listing was last checked
on 2026-06-22 or 2026-07-06. Found in review:

- **Stale present-tense claims.** 16 of the 19 auditions badged "Open now" had deadlines
  that passed between July 18 and October 5. The badge came from a hand-set `status` that
  nothing ever expired.
- **"Upcoming concerts" opened with 13 concerts that had already happened.**
- **No feedback channel** — `reportEmail` was never set, so report links stayed hidden.
- **A form that promised more than it did.** "List your organization" logged the entry
  to the browser console while telling the sender they were "in the review queue"
  (and Phase 3 had decided: curated only, no public submission form).
- **Phone bugs:** board cards ran past the right edge (330px minimum column in a ~260px
  space); after "View list" the map/list switch vanished with the map; the map's zoom
  buttons floated over the orchestra panel; the honesty notice covered the switch and
  the panel's buttons, and its "How we check" button was squeezed into a 22px square.
- **No way to share one orchestra**, and no link preview.
- **Drift:** HANDOFF.md still described the June prototype; the Claude.ai project held
  June copies of 11 files (including American Youth Symphony, closed since 2024) next to
  the GitHub sync, plus a sync to a branch that no longer exists.

---

## Decision log

| # | Decision |
|---|---|
| P5-1 | **Tutti is families first.** Youth and student auditions are Tutti's job. Professional auditions move to Auditioner's open-auditions feed once it launches; until then they stay on Tutti under the same date rules. Pro orchestras stay on the map (concerts, side-by-sides). |
| P5-2 | **Dates decide "Open now".** Two optional audition fields, `opensOn` / `closesOn`, restate dates from a verified window; the badge is computed from them (SCHEMA.md has the table). Allowed only on verified windows (schema, sync script and a DB CHECK); `opensOn ≤ closesOn`. Nothing renamed or removed. Closed rounds stay on the board, grouped last. "Rolling" reads "Year-round" and only while the window was confirmed within a year. |
| P5-3 | **Two seasonal sweeps** — late February and early June — set up as scheduled tasks in the Claude.ai project. Claude researches with citations and drafts; Milai approves. Replaces the weekly re-check in LAUNCH-CHECKLIST Step 9, which wasn't happening. |
| P5-4 | **"Prepare in Auditioner" links only where they help:** once Auditioner is installable (public TestFlight or App Store), only on auditions for ages 13+, and only when Auditioner has that orchestra's list. No "coming soon" before then. |
| P5-5 | **Share links now:** every orchestra has `tutti-orchestra.com/o/<id>` (Cloudflare rewrite), a Share button, and a site-wide link preview. Per-orchestra pages that Google can read come later (5.6). |
| P5-6 | **Report inbox:** `reports@tutti-orchestra.com`, forwarded to Milai's Gmail by Cloudflare Email Routing. Also receives orchestra suggestions. |
| P5-7 | **Project knowledge = GitHub `main` only.** The 11 June copies were deleted from the Claude.ai project on 2026-10-10 (all live on in git); Milai removes the dead `claude/zen-allen-874p3c` sync. |
| P5-8 | *(Claude's call within existing decisions, flagged)* The console-only "List your organization" form is replaced by **"Suggest an orchestra"** — an email to the report inbox, shown only when the inbox is configured. Enforces Phase 3's "curated only, no public submission form". |

---

## Tutti × Auditioner — who does what

| | Tutti (web) | Auditioner (iPhone/iPad) |
|---|---|---|
| For | Parents choosing an orchestra for their child | Players preparing to win a seat |
| Scope | Southern California | Worldwide (its own storefront rules) |
| Auditions | Youth and student placement auditions | Professional and student orchestra auditions, with repertoire lists |
| Ages | Any (YOLA starts at 6) | 13+ (its terms) |
| Shared | The honesty contract: `verified` = value + source + asOf, otherwise "Check their site / the official list" | ← same shape (Auditioner D3) |

**Data flow (Auditioner U2, unchanged):** Auditioner's crawler may propose Tutti audition
updates only as `provenanceType: "scraped"`, `listingStatus: "in_review"` drafts for Milai
to approve — never straight to parents. Tutti's orgs join its crawl registry.

**Links (Auditioner U1, refined by P5-4):** Tutti → Auditioner as above. Auditioner →
Tutti ("Find an orchestra near you") should appear only for players whose region is
Southern California; elsewhere it would lead to an empty map.

**To record in Auditioner's PLAN.md** (its own rule: decisions change only with Milai's
say-so, in its repo): P5-1 (professional auditions hand over to Auditioner's feed), P5-4
(13+, installable, has the list), and the Southern-California-only Tutti link.

---

## Built on `phase5/trust-and-sharing`

| Area | Change |
|---|---|
| Data contract | `schema.json` + `SCHEMA.md` (`opensOn`, `closesOn`); `scripts/sync-data.mjs` rejects dates on unverified windows and out-of-order dates; `scripts/generate-seed.mjs` writes them; migration `20261010120000_audition_dates.sql` (columns, two CHECKs, read view re-created with the same columns). |
| Live-DB refresh | `scripts/audition-updates-sql.mjs` — in-place UPDATEs for every audition from `data.json`, no truncate, Saved lists untouched. Used after every sweep (CURATION.md). |
| Data (needs Milai's OK — see table below) | 20 auditions get `closesOn` / `opensOn` restated from their own verified windows; no new facts; dataset 3.2.0. |
| App | Date-driven badges everywhere (board, filters, Explore toggle, panel, compare); closed rounds grouped last; past concerts hidden (board, panel, price range, compare count); honest empty states; Share button + `/o/<id>` + `#o=<id>` fallback; Open Graph/description tags, `og-image.png`, `favicon.svg`; "Suggest an orchestra"; reduced-motion map jumps; closed panel and hidden compare tray kept off the Tab path; phone fixes listed above. |
| Docs | HANDOFF.md refreshed; CLAUDE.md (dates rule, Auditioner, `phase5/` branches); CURATION.md (cadence, date rules, live refresh); LAUNCH-CHECKLIST.md (Step 7 click path, Step 10 rollout); DELEGATION-PLAN.md pointer. |

**Checked (2026-10-10):** schema + sync check pass; all 8 migrations and the seed applied to
a real Postgres engine (PGlite) with the API view equal to `data.json` field-for-field;
dates on an unverified window and out-of-order dates rejected by the database; a draft org
stays invisible to the public role; the production path (live-shaped DB → new migration →
update script) ends equal to `data.json` with Saved rows intact; headless-browser run at
1280px and 390px with "today" frozen on Oct 10, Jul 15 and Jun 20 — 0 "Open now" in
October, 19 closed, 8 year-round; "Open now · until Jul 30", "Apply by Jul 18", "Opens
Jul 6" on the right days; share link copies `/o/<id>`; `/o/sdys` opens that orchestra;
cards fit a 390px phone; no script errors.

### The 20 restated dates (Milai approves by merging)

Rule: `closesOn` = last day a family can still get in (hard deadline; soft deadline or
late registration → the last stated chance; no deadline → last audition day). `opensOn`
only when the page states a start date. Same source and as-of date as the window.

| Audition | Window (verified) | Added |
|---|---|---|
| LAYO · Advanced | Aug 22 & 23, 2026 | closes 2026-08-23 |
| SCVYO · Advanced, Intermediate | live auditions Jul 25 (returning), Aug 15 (new) | closes 2026-08-15 |
| SCVYO · Beginner | register by Aug 15 | closes 2026-08-15 |
| Pacific Symphony · 3 rounds | deadlines Sep 4, Sep 7, Oct 5 | closes 2026-09-04 / 09-07 / 10-05 |
| PSYE · Intermediate, Advanced | 2026–27 applications closed May 1 | closes 2026-05-01 |
| SCYSO · Beginner | videos accepted from May 25 (no close stated) | opens 2026-05-25 |
| CYOSC · Beginner | prescreening video due Aug 16 | closes 2026-08-16 |
| San Diego Symphony · 2 rounds | applications due Aug 28, Oct 2 | closes 2026-08-28 / 10-02 |
| SDYS · Intermediate | register Jul 6–30 | opens 2026-07-06, closes 2026-07-30 |
| SDYS · Beginner | registration open through Jul 31 | closes 2026-07-31 |
| SD Civic Youth Orchestra | last audition Jul 18 | closes 2026-07-18 |
| Mainly Mozart YO · Intermediate | Jul 1–31, deadline Jul 31 | opens 2026-07-01, closes 2026-07-31 |
| LOYO · Beginner | late registration through Sep 11 | closes 2026-09-11 |
| LOYO · Advanced | standard registration closes Aug 3 | closes 2026-08-03 |
| BYSO · Advanced | due Sep 4 ($10 late fee after); auditions Sep 12 | closes 2026-09-12 |

Not dated (no exact date on the page): CYMO Beginner, CSUN ×2, PSYE's "early March"
opening, Riverside Arts Academy, every unverified window.

---

## Next tasks

| # | Task | Who | When |
|---|---|---|---|
| 5.1 | **Roll out Phase 5** — LAUNCH-CHECKLIST Step 7, then Step 10 | Milai (Claude on call) | Now |
| 5.2 | Optional **catch-up sweep** for winter/spring 2027 rounds already posted | Claude researches, Milai approves | Any time before Feb |
| 5.3 | Seasonal sweeps — scheduled tasks (late Feb, early June) | Scheduled | Set up 2026-10-10 |
| 5.4 | "Prepare in Auditioner" links per P5-4 | Claude Code | When Auditioner is installable |
| 5.5 | Professional auditions hand over to Auditioner's feed (hide pro auditions on Tutti, keep pro orgs + concerts, link out) | Claude Code + Milai's OK | When Auditioner's feed (its M4) is live |
| 5.6 | **Be found on Google:** generate one static page per orchestra at `/o/<id>` (own title, description, preview) from `data.json` by the sync script, same honesty rendering | Claude Code | Next growth step |
| 5.7 | "Confirmed by the organization" badge (PHASE-4-PLAN fast-follow) — the report inbox makes it possible | Plan → build | After 5.1 |
| 5.8 | Apple sign-in (LAUNCH-CHECKLIST Step 6) | Milai's accounts | Open |
| 5.9 | Record P5-1 / P5-4 in Auditioner's PLAN.md | Auditioner session | Next Auditioner session |
