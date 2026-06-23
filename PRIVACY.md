# Tutti — Privacy Note

_Plain-language summary of what an account stores. This is the source for the in-app
"What sign-in stores" note (Saved view → privacy link). Keep them in sync._

You can use all of Tutti — search, the map, ensembles, concerts, auditions — **without an
account**. Signing in is optional and does exactly one thing: it keeps your **Saved** list so
the organizations you star follow you across reloads and devices.

## What we store when you sign in
- A basic account identifier from Google or Apple — an ID and the email on that account.
- The list of organizations you've saved (just their IDs).

That's all. Sign-in is handled by Supabase Auth; Tutti never sees or stores your password.

## What we don't store
- No passwords, no payment details, no information about your child.
- No browsing history, no location tracking.
- We never sell or share your information.

## You're in control
- Sign out anytime. Removing a save deletes that entry from your account.
- Each person can only ever read or change **their own** saved list — enforced by the database
  (Row-Level Security), not just the app.

## Tutti's role
Tutti is a discovery-and-comparison layer. It never collects applications or routes payments —
the **Apply** button always hands you off to the organization's own website.

---

### Where this is enforced
- `saved` rows are keyed to your account id (`auth.uid()`), and RLS policies allow a user to
  read/insert/delete **only** their own rows (see `supabase/migrations/…_saved.sql`).
- Signed-out visitors get an in-memory Saved list that simply resets on reload — no row is
  written anywhere.

### Pre-launch follow-ups
- Link this note from the footer/ribbon as well as the Saved view before a public launch.
- Confirm the Google OAuth consent screen and Apple Services ID describe the same minimal scope
  (email + basic profile) and nothing more.
