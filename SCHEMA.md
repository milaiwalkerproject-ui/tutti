# Tutti — Data Schema (Phase 2.1)

The finalized data contract for real Tutti listings. `schema.json` is the machine-checkable version (JSON Schema, Draft 2020-12); this file is the plain-English explainer.

**Decisions this schema encodes** (locked in Phase 2 planning):
- **Scope:** Greater Los Angeles only. The `metro` field is an enum with one allowed value, so anything outside LA fails validation — scope creep can't sneak in through the data.
- **Sourcing:** manual curation now (we draft + cite, you approve), with `provenanceType` and `listingStatus` reserved so self-serve submissions and scrape-then-review plug in later without a schema change.
- **Honesty fallback:** unconfirmed facts render as **"Check their site"** rather than a guessed value.

---

## The one big change from the prototype: verifiable fields

In the prototype every fact was a plain value, with only two states — a value, or `null` (hide). Real data needs a **third state**: *we know this field applies, but we couldn't confirm it.* So the facts a parent acts on are now small objects with a `status`:

| status | meaning | what the UI shows |
|---|---|---|
| `verified` | found and cited | the value (requires `value` + `source`) |
| `unverified` | applies, but unconfirmed | **"Check their site"** (links to the field's own `source` page when curation recorded one, else the org's website) |
| `not_applicable` | the question doesn't apply | hide the row |

Example — a confirmed tuition vs. an unconfirmed one vs. a pro orchestra:

```json
"tuition": { "status": "verified", "value": "$650 / semester", "source": "https://…", "asOf": "2026-06-22" }
"tuition": { "status": "unverified" }
"tuition": { "status": "not_applicable" }   // professional org — no tuition
```

The schema enforces this: a `verified` field **must** carry a `source`, and an `unverified` field **must not** carry a value (so nobody can smuggle a guess in). This is what lets us drop the blanket "sample data" ribbon for confirmed fields while staying truthful about the gaps.

An `unverified` field may also carry a `source` — not a confirmation, just a **pointer**: the page where a parent can check that fact directly. The UI uses it as the "Check their site" link target instead of the homepage. A pointer must be a page we actually consulted (add it to the org's `sources` audit trail too); never guess a URL. `asOf` stays reserved for confirmed values.

**Which fields are verifiable** (the volatile, parent-facing ones):
`season`, `tuition`, `rehearsal`, `commitment`, `financialAid`, each performance's price (`from`), and each audition's `window`. Everything else is either stable identity (name, location, website, type) or editorial (`blurb`, `goodFit`) and stays a plain value.

> `not_applicable` for `tuition` and `financialAid` is meant **only for professional orgs.** Youth/community/collegiate should use `verified` or `unverified`. (Documented rule — the validator doesn't force it, so it's part of the curation checklist.)

---

## Ratings: absent, not invented

The prototype had fake star ratings. We have **no real aggregated reviews yet**, so the seed dataset leaves `reviews` as `null`. Don't invent ratings, and don't let orgs self-report them. When a real source exists later, it slots into:

```json
"reviews": { "rating": 4.6, "count": 110, "source": "Aggregated parent reviews" }
```

This has two knock-on effects for the **2.3 HTML rebuild** (flagging now so they don't surprise us):
1. The star line on cards/detail must **hide gracefully** when `reviews` is null.
2. The **"Highest rated" sort** has nothing to sort by — either drop that option for now or push unrated orgs to the bottom.

---

## Field reference

**Dataset wrapper**

| field | type | req | notes |
|---|---|---|---|
| `version` | string | ✓ | e.g. `"2.0.0"` |
| `metro` | enum | ✓ | only `"Greater Los Angeles"` |
| `generatedAt` | date | ✓ | when the file was assembled |
| `organizations` | array | ✓ | the listings |

**Organization**

| field | type | req | notes |
|---|---|---|---|
| `id` | slug | ✓ | lowercase/digits/hyphens, unique |
| `name` | string | ✓ | |
| `type` | enum | ✓ | youth / professional / community / collegiate → drives pin & badge color |
| `lat`, `lng` | number | ✓ | for the map pin |
| `area` | string | ✓ | neighborhood label |
| `metro` | enum | ✓ | `"Greater Los Angeles"` |
| `website` | uri | ✓ | the authoritative source we route to |
| `applyUrl` | uri/null | | "Apply" target; falls back to `website` |
| `blurb` | string | ✓ | editorial description |
| `ages` | [min,max] | ✓ | overall org range |
| `ensembles` | array | ✓ | **at least one** |
| `season` | verifiable | | label like "2026–27 Season" |
| `instruments` | enum[] | | Strings/Winds/Brass/Percussion/Harp |
| `rehearsal`, `commitment` | verifiable | | |
| `financialAid` | verifiable bool | | `not_applicable` for pros |
| `tuition` | verifiable | | `not_applicable` for pros |
| `goodFit` | string/null | | editorial "Good fit if…" |
| `reviews` | object/null | | **null until a real source exists** |
| `performances` | array | | see below |
| `auditions` | array | | see below |
| `sources` | array | | pages consulted — the audit trail |
| `lastVerified` | date/null | | |
| `listingStatus` | enum | ✓ | draft / in_review / **published**; only published reaches parents |
| `provenanceType` | enum | ✓ | curated / self_submitted / scraped |
| `submittedBy` | object/null | | populated only for self-serve (Phase 3) |

**Ensemble:** `name`✓, `level`✓ (the 5 levels), `ages`✓, `desc`.
**Performance:** `date`✓, `title`✓, `from`✓ (verifiable number; `value:0` = free), `venue`, `program`, `source`.
**Audition:** `level`✓, `instruments`✓, `window`✓ (verifiable — the most volatile field in the dataset), `status`✓ (open/upcoming/rolling), `ages`✓, `note`, `source`.

---

## Rules the validator does **not** enforce (curation checklist)

- `id` is unique across the dataset.
- In every `ages` / `[min,max]` pair, `min <= max`.
- `not_applicable` tuition/aid only on professional orgs.
- `reviews` stays null unless a genuine aggregated source exists.
- Every `verified` value's `source` is a real, public page (the validator checks a source *exists*, not that it's truthful — that's the human approval step).

---

## What's intentionally **not** here

- **Presets / quick locations** (`PRESETS[]`) are app configuration, not org data — they stay in the app, out of this schema.
- **Accounts, saved state, submissions storage** — those are backend concerns (Phase 3). The `listingStatus` / `provenanceType` / `submittedBy` fields are just the data-shaped hooks so that work fits later.

---

## How this feeds the rest of Phase 2

- **2.2 (seed dataset):** I research each LA org, fill `verified` fields with sources, mark the rest `unverified`, and hand you a `data.json` + a list of the `unverified` fields for your approval. Pros (LA Phil, LACO, Pasadena Symphony) will be mostly verified; youth/community orgs will lean on `unverified` for tuition and audition windows — expected, not a failure.
- **2.3 (externalize):** the HTML fetches `data.json` (as `json.organizations`), and the render code learns three new behaviors: show "Check their site" for `unverified`, hide `not_applicable`, and handle null `reviews`.
