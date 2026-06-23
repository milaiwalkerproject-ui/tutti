#!/usr/bin/env node
// Tutti — generate supabase/seed.sql from the curated data.json.
//
// The curated dataset (data.json) stays the human-editable source of truth. This script
// translates it into SQL the Supabase CLI loads on `supabase db reset`. Re-run it whenever
// data.json changes:  node scripts/generate-seed.mjs
//
// The generated seed is idempotent: it truncates the listing tables first, so reapplying it
// (or running `supabase db reset`) reproduces exactly the dataset in data.json.

import { readFileSync, writeFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const data = JSON.parse(readFileSync(join(root, "data.json"), "utf8"));

// --- SQL literal helpers ---------------------------------------------------
const q = (s) => `'${String(s).replace(/'/g, "''")}'`;               // text literal
const txt = (v) => (v == null ? "NULL" : q(v));                       // nullable text
const dateLit = (v) => (v == null ? "NULL" : `${q(v)}::date`);        // nullable date
const jsonb = (v) =>                                                  // nullable jsonb
  v == null || v === undefined ? "NULL" : `${q(JSON.stringify(v))}::jsonb`;
const intArr = (a) => `'{${a.join(",")}}'::int[]`;                    // [6,18] -> '{6,18}'::int[]
const enumArr = (a, type) =>                                          // ['Strings'] -> '{Strings}'::type[]
  a == null ? "NULL" : `'{${a.map((x) => `"${x}"`).join(",")}}'::${type}[]`;

const lines = [];
const w = (s = "") => lines.push(s);

w("-- GENERATED FILE — do not edit by hand.");
w("-- Source: data.json   Regenerate: node scripts/generate-seed.mjs");
w(`-- Dataset version ${data.version} · metro ${JSON.stringify(data.metro)} · generated ${data.generatedAt}`);
w("");
w("begin;");
w("");
w("-- DESTRUCTIVE — local dev / first load only. Supabase runs this on `supabase db reset`.");
w("-- The cascade also clears `public.saved` (it FKs organizations), so never run this");
w("-- against a live database with real accounts. Production curation uses Studio (see CURATION.md).");
w("truncate table public.organizations restart identity cascade;");
w("");

for (const o of data.organizations) {
  w(`-- ${o.id} — ${o.name}`);
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

const out = join(root, "supabase", "seed.sql");
writeFileSync(out, lines.join("\n"));
console.log(
  `Wrote ${out}\n  ${data.organizations.length} organizations` +
    ` (${data.organizations.filter((o) => o.listingStatus === "published").length} published)`
);
