#!/usr/bin/env node
// Tutti — seed-building logic: data.json (parsed) -> supabase/seed.sql text.
//
// This is a library used by scripts/sync-data.mjs, which validates data.json first
// and keeps every generated copy in sync. It is NOT meant to be run directly —
// running it directly prints a pointer to the right command and writes nothing,
// so the old pre-Phase-4 habit can't produce an unvalidated or drifted seed.
//
// The generated seed is idempotent: it truncates the listing tables first, so reapplying it
// (or running `npx supabase db reset`) reproduces exactly the dataset in data.json.

import { realpathSync } from "node:fs";
import { pathToFileURL } from "node:url";

// --- SQL literal helpers ---------------------------------------------------
const q = (s) => `'${String(s).replace(/'/g, "''")}'`;               // text literal
const txt = (v) => (v == null ? "NULL" : q(v));                       // nullable text
const dateLit = (v) => (v == null ? "NULL" : `${q(v)}::date`);        // nullable date
const jsonb = (v) =>                                                  // nullable jsonb
  v == null || v === undefined ? "NULL" : `${q(JSON.stringify(v))}::jsonb`;
const intArr = (a) => `'{${a.join(",")}}'::int[]`;                    // [6,18] -> '{6,18}'::int[]
const enumArr = (a, type) =>                                          // ['Strings'] -> '{Strings}'::type[]
  a == null ? "NULL" : `'{${a.map((x) => `"${x}"`).join(",")}}'::${type}[]`;
const cmt = (s) => String(s).replace(/[\r\n]+/g, " ");                // text placed in a `--` comment
                                                                      // (a newline would end the comment
                                                                      //  and leak raw text into the SQL)

export function buildSeed(data) {
  const lines = [];
  const w = (s = "") => lines.push(s);

  w("-- GENERATED FILE — do not edit by hand.");
  w("-- Source: data.json   Regenerate: node scripts/sync-data.mjs");
  w(cmt(`-- Dataset version ${data.version} · metro ${JSON.stringify(data.metro)} · generated ${data.generatedAt}`));
  w("");
  w("begin;");
  w("");
  w("-- DESTRUCTIVE — local dev / first load only. Supabase runs this on `supabase db reset`.");
  w("-- The cascade also clears `public.saved` (it FKs organizations), so never run this");
  w("-- against a live database with real accounts. Production curation uses Studio (see CURATION.md).");
  w("truncate table public.organizations restart identity cascade;");
  w("");

  for (const o of data.organizations) {
    w(cmt(`-- ${o.id} — ${o.name}`));
    w("insert into public.organizations (");
    w("  id, name, type, lat, lng, area, metro, website, apply_url, blurb,");
    w("  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,");
    w("  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by");
    w(") values (");
    w(`  ${q(o.id)}, ${q(o.name)}, ${q(o.type)}, ${o.lat}, ${o.lng}, ${q(o.area)}, ${q(o.metro)},`);
    w(`  ${q(o.website)}, ${txt(o.applyUrl)}, ${q(o.blurb)},`);
    w(`  ${jsonb(o.season)}, ${intArr(o.ages)}, ${enumArr(o.instruments, "public.instrument")},`);
    w(`  ${jsonb(o.rehearsal)}, ${jsonb(o.commitment)}, ${jsonb(o.financialAid)}, ${jsonb(o.tuition)},`);
    w(`  ${txt(o.goodFit)}, ${jsonb(o.reviews)}, ${dateLit(o.lastVerified)},`);
    w(`  ${q(o.listingStatus)}, ${q(o.provenanceType)}, ${jsonb(o.submittedBy ?? null)}`);
    w(");");

    (o.ensembles || []).forEach((e, i) => {
      w(
        `insert into public.ensembles (org_id, position, name, level, ages, "desc") values (` +
          `${q(o.id)}, ${i}, ${q(e.name)}, ${q(e.level)}, ${intArr(e.ages)}, ${txt(e.desc)});`
      );
    });

    (o.performances || []).forEach((p, i) => {
      w(
        `insert into public.performances (org_id, position, date, title, venue, program, "from", source) values (` +
          `${q(o.id)}, ${i}, ${dateLit(p.date)}, ${q(p.title)}, ${txt(p.venue)}, ${txt(p.program)}, ${jsonb(p.from)}, ${txt(p.source)});`
      );
    });

    (o.auditions || []).forEach((a, i) => {
      w(
        `insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values (` +
          `${q(o.id)}, ${i}, ${q(a.level)}, ${q(a.instruments)}, ${jsonb(a.window)}, ${q(a.status)}, ${intArr(a.ages)}, ${txt(a.note)}, ${txt(a.source)});`
      );
    });

    (o.sources || []).forEach((s, i) => {
      w(
        `insert into public.org_sources (org_id, position, url, label, retrieved_at) values (` +
          `${q(o.id)}, ${i}, ${q(s.url)}, ${txt(s.label)}, ${dateLit(s.retrievedAt)});`
      );
    });

    w("");
  }

  w("commit;");
  w("");

  return lines.join("\n");
}

// Direct runs get a pointer instead of a silent bypass of validation.
// (realpathSync so a symlinked invocation is still recognized as a direct run.)
let isMain = false;
try {
  isMain =
    !!process.argv[1] &&
    import.meta.url === pathToFileURL(realpathSync(process.argv[1])).href;
} catch {
  /* argv[1] unreadable — being imported; leave isMain false */
}

if (isMain) {
  console.error("generate-seed.mjs is a library now and writes nothing on its own.");
  console.error("Run instead:  node scripts/sync-data.mjs");
  console.error("  (validates data.json, then regenerates the seed AND the dataset embedded in the HTML)");
  process.exit(1);
}
