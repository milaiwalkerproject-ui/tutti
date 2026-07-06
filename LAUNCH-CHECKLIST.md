# LAUNCH-CHECKLIST.md — putting Tutti on the internet

*Written 2026-07-06 (Phase 4 launch-prep track). This is the click-by-click
path from "works on Milai's Mac" to "live on a real domain." Steps marked
**⚑ you** need your hands and accounts — nobody else can (or should) do them.
Steps marked **🤖 Claude Code** are run in a repo session after you hand over
the values it asks for. Do the steps in order; each one says what success
looks like. The companion web page (artifact) mirrors this file for
follow-along; this file is the canonical copy.*

**Two standing safety notes, repeated from the field notes:**
- Secrets (Google/Apple keys) never go in git or chat. They are typed only
  into the Supabase dashboard. The `supabaseAnonKey` and Stadia key are
  **public by design** — those are safe to paste to Claude Code and to commit.
- When testing in Safari, always hard-refresh with **Cmd+Shift+R** — it
  caches the single file aggressively.

---

## Step 0 — Code pre-flight (🤖 done, awaiting your merges)

Two parked fixes you approved, now prepared on branches:

- [ ] `phase4/verified-asof` merged — the database and schema now require the
      "as of" date on every verified fact (closing the one gap found in
      Task 0). Existing data already complies.
- [ ] `phase4/doctype` merged — the missing `<!DOCTYPE html>` line, verified
      against the layout on desktop and phone widths.

*Success looks like: both branches merged; `node scripts/sync-data.mjs
--check` still says "Everything is in sync."*

---

## Step 1 — ⚑ Choose and buy the domain — ✅ DONE 2026-07-06

**The domain is `tutti-orchestra.com`** (bought by Milai 2026-07-06). Every
later step below uses it verbatim. One thing to confirm in the registrar when
convenient: auto-renew is on.

> Apple sign-in (Step 6) is legally tied to this domain — that's why it
> waited until now. If the domain was bought outside Cloudflare, Step 3 will
> also offer to move its DNS to Cloudflare when the site is added — say yes,
> it makes HTTPS and the custom domain automatic.

---

## Step 2 — ⚑ Create the hosted Supabase project

> **Progress 2026-07-06:** the project exists and is healthy. Project ref
> `nylnqmpbijalgzkudhgo` · URL `https://nylnqmpbijalgzkudhgo.supabase.co` ·
> anon key with Claude Code (found inside the key itself — it carries the
> project ref). Remaining: the link/push commands below and the one-time seed.

1. Go to **supabase.com** → Sign in (GitHub login is easiest) → **New
   project**.
2. Organization: your personal one. Name: `tutti`. Database password:
   let it generate one and store it in your password manager (you'll rarely
   need it). Region: **West US (North California)** — closest to your
   parents. Plan: **Free**.
3. Wait ~2 minutes for provisioning.
4. Collect three values from **Project Settings → API**:
   - **Project URL** (looks like `https://abcdefgh.supabase.co`)
   - **anon public key** (long text starting `eyJ…` — public by design)
   - **Project ref** (the `abcdefgh` part of the URL)
5. Hand all three to Claude Code.

*Success looks like: the project dashboard is green/"Healthy" and you've
pasted the three values into a Claude Code session.*

**Then 🤖 Claude Code (with you watching):**

```bash
npx supabase link --project-ref nylnqmpbijalgzkudhgo
npx supabase db push        # applies all migrations to the hosted database
```

Loading the 11 listings: Claude Code hands you the contents of
`supabase/seed.sql`; you paste it into the dashboard's **SQL Editor → New
query → Run**. (One-time initial load. After launch, listing changes happen
in Studio per `CURATION.md` — never by re-running the seed, which wipes
saved lists.)

*Success looks like: dashboard → Table Editor → `organizations` shows 11
rows, metro "Southern California". And this returns only published listings:*

```bash
curl 'https://nylnqmpbijalgzkudhgo.supabase.co/rest/v1/org_listings?select=id,name' \
  -H "apikey: <anon-key>"
```

---

## Step 3 — ⚑ Put the site on Cloudflare Pages

(Netlify works equally well; instructions assume Cloudflare per the plan.)

1. **dash.cloudflare.com** → **Workers & Pages** → **Create** → **Pages** →
   **Connect to Git**.
2. Authorize your GitHub account, pick the **tutti** repository.
3. Build settings: framework preset **None**, build command **empty**,
   output directory **/** (root). (No build step — that's by design.)
4. Deploy. You get a temporary `*.pages.dev` URL — open it: the map should
   render with all 11 pins (it's using the embedded dataset until config
   points at the hosted database).
5. **Custom domains** tab → add your domain from Step 1 → Cloudflare sets
   DNS + HTTPS automatically.

*Success looks like: `https://tutti-orchestra.com` shows Tutti with the map and
pins, padlock in the address bar.*

**Then 🤖 Claude Code:** updates `config.js` with the production Supabase
URL + anon key (public values, committed to git; the deploy picks them up
automatically on push to main).

*Success looks like: reload the site — listings now come from the hosted
database (Claude Code verifies via the network tab / a draft-row test).*

---

## Step 4 — ⚑ Google sign-in on the real domain

1. **console.cloud.google.com** → select the existing Tutti OAuth project
   (created in Phase 3) → **APIs & Services → Credentials** → click your
   OAuth 2.0 Client ID.
2. Under **Authorized redirect URIs** click **+ Add URI** and enter exactly:
   `https://nylnqmpbijalgzkudhgo.supabase.co/auth/v1/callback`
3. Under **Authorized JavaScript origins** add: `https://tutti-orchestra.com`
4. Save. Copy the **Client ID** and **Client secret** (from this same page).
5. Supabase dashboard → **Authentication → Providers → Google** → toggle on
   → paste Client ID + secret → Save. (Secrets live here, never in git.)
6. Supabase dashboard → **Authentication → URL Configuration**:
   - **Site URL**: `https://tutti-orchestra.com`
   - **Redirect URLs**: add `https://tutti-orchestra.com` (and your `*.pages.dev`
     URL if you want sign-in on preview deploys).

*Success looks like: on the live site, "Continue with Google" round-trips —
you end up signed in, and a heart you tap shows up again after a reload and
on your phone.*

---

## Step 5 — ⚑ Stadia Maps key (nicer tiles)

1. **stadiamaps.com** → Sign up (free tier) → create a **Property** for your
   domain.
2. In the property's **Authentication** settings, add your domain as an
   allowed origin, and create an **API key**. The key is public (it's
   origin-locked, like the anon key).
3. Hand the key to Claude Code → it adds `stadiaApiKey` to `config.js`.

*Success looks like: the map switches to the quieter "Alidade Smooth" look;
pins unchanged. Remove-the-key still renders the old tiles (that fallback
was Task 4.1's guarantee).*

---

## Step 6 — ⚑ Apple sign-in (needs Steps 1–4 done)

You already have the Apple Developer membership. ~20 minutes of
portal-clicking:

1. **developer.apple.com → Account → Certificates, Identifiers & Profiles →
   Identifiers**.
2. **+** → **App IDs** → type App → description `Tutti` → Bundle ID
   `com.tutti-orchestra.web` (explicit) → check **Sign in with Apple** → Register.
3. **+** → **Services IDs** → description `Tutti Web` → identifier
   `com.tutti-orchestra.web.signin` → Register → open it → check **Sign in with
   Apple** → **Configure**:
   - Primary App ID: the one from #2.
   - Domains: `tutti-orchestra.com` and `nylnqmpbijalgzkudhgo.supabase.co`
   - Return URLs: `https://nylnqmpbijalgzkudhgo.supabase.co/auth/v1/callback`
4. **Keys** → **+** → name `Tutti Sign in with Apple` → check **Sign in with
   Apple** → Configure → pick the App ID → Register → **Download the .p8
   file** (one chance!) and note the **Key ID**; your **Team ID** is at the
   top right of the account page.
5. Supabase dashboard → **Authentication → Providers → Apple** → toggle on →
   enter Services ID (`com.tutti-orchestra.web.signin`), Team ID, Key ID, and the
   contents of the .p8 file → Save.
6. Tell Claude Code "Apple is configured" → it flips `appleSignIn: true` in
   `config.js`, and the "Continue with Apple" button reappears.

*Success looks like: "Continue with Apple" round-trips on the live site,
including on an iPhone.*

---

## Step 7 — ⚑ Report-a-problem inbox

1. Create (or choose) the dedicated address — your decision: **one inbox for
   the whole region**.
2. Hand the address to Claude Code → it adds `reportEmail` to `config.js`.

*Success looks like: every listing shows "Something off? Report a problem",
and "How Tutti works" shows the email link. Send yourself a test report —
it arrives with the org's name in the subject line.*

---

## Step 8 — Pre-launch QA (🤖 with your hands on a phone)

All of these must pass on the **live domain** against the **hosted**
database:

- [ ] **Honesty gates:** a `draft` row added in Studio is invisible on the
      site and via the API; an `unverified` fact with a value is rejected by
      the database; a `verified` fact without source or "as of" date is
      rejected; a non-Southern-California metro is rejected. (Claude Code
      scripts these; the draft row is deleted after.)
- [ ] **Sync guard:** `node scripts/sync-data.mjs --check` — everything in
      sync on main.
- [ ] **Auth round-trip** (Google + Apple) on the real domain; a saved heart
      survives reload and appears on a second device.
- [ ] **Phones:** iPhone Safari (Cmd+Shift+R equivalent: long-press reload)
      and an Android if available — map, detail panel, boards, sign-in.
- [ ] **Keyboard only:** tab through — focus always visible, modals
      trap/restore focus, Esc closes.
- [ ] **Reduced motion:** with "Reduce Motion" on (System Settings →
      Accessibility → Display), no fly-animations.
- [ ] **Lighthouse** (Chrome DevTools → Lighthouse → Mobile): performance
      and accessibility both green (90+).
- [ ] **"Details last checked"** shows on every listing; deep-link pointers
      open the right org pages.

---

## Step 9 — Launch & the first week

- [ ] Announce however feels right (there is no analytics on the site — by
      design, nothing to configure).
- [ ] **Weekly audition re-check** (your Claude.ai project, every week for
      now): re-confirm each org's audition window; update `asOf` on
      confirmed values; flip anything unconfirmable back to `unverified`.
- [ ] Watch the report inbox; every report gets a listing re-check.
- [ ] Twice-a-year full refresh for everything else (tuition, seasons,
      rehearsal details).
- [ ] When the Southern California sweep produces newly verified orgs,
      they enter via `CURATION.md` (Studio for singles, `data.json` +
      sync for batches) — the scope guard now expects exactly
      `Southern California`.

---

## If something goes wrong

- Map renders but no listings → config.js values (URL/anon key) or the seed
  didn't load; Claude Code checks the browser network tab first.
- Google sign-in loops or errors → the redirect URI in Google Console must
  be **exactly** `https://nylnqmpbijalgzkudhgo.supabase.co/auth/v1/callback`, and
  the Site URL in Supabase must be your domain.
- Apple button missing → `appleSignIn: true` not set; Apple errors →
  Services ID domains/return URL must list both your domain and the
  Supabase callback.
- Stale page in Safari → Cmd+Shift+R before debugging anything else.
- Local dev still works the whole time: `npx supabase start` + the local
  config values (local `npx supabase db reset` wipes only *local* test
  sign-ins/saves — expected, not a bug; production data is untouched).
