#!/usr/bin/env node
// Tutti — one-command data sync. data.json is the only hand-edited copy of the
// dataset; two generated copies must always match it byte-for-byte:
//
//   1. supabase/seed.sql                          (built by scripts/generate-seed.mjs)
//   2. the dataset embedded in tutti-orchestra-finder.html
//      inside <script type="application/json" id="bootstrap-data">
//
// Usage:
//   node scripts/sync-data.mjs           validate data.json, rewrite both copies
//   node scripts/sync-data.mjs --check   validate + compare only; exit 1 on any drift
//
// The script validates data.json against schema.json before touching anything,
// so an invalid dataset can never be propagated. It has no dependencies (this
// repo has no build step and no node_modules).

import { readFileSync, writeFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, join, relative } from "node:path";
import { buildSeed } from "./generate-seed.mjs";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const CHECK = process.argv.includes("--check");

const DATA_PATH = join(root, "data.json");
const SCHEMA_PATH = join(root, "schema.json");
const SEED_PATH = join(root, "supabase", "seed.sql");
const HTML_PATH = join(root, "tutti-orchestra-finder.html");

const BOOTSTRAP_OPEN = '<script type="application/json" id="bootstrap-data">';
const BOOTSTRAP_CLOSE = "</script>";

const rel = (p) => relative(root, p);

function fail(message) {
  console.error(`\n✗ ${message}`);
  process.exit(1);
}

// --- Minimal JSON Schema validator ------------------------------------------
// Covers exactly the draft 2020-12 subset schema.json uses: type, enum, const,
// required, properties, additionalProperties:false, items, minItems/maxItems,
// uniqueItems, minLength/maxLength, pattern, minimum/maximum, $ref (#/$defs/*),
// allOf, if/then, and the formats date / uri / email / date-time.
// auditSchema() below fails the run if schema.json ever grows past this subset,
// so validation can never silently weaken.

const FORMATS = {
  date: (s) => {
    if (!/^\d{4}-\d{2}-\d{2}$/.test(s)) return false;
    const d = new Date(`${s}T00:00:00Z`);
    return !Number.isNaN(d.getTime()) && d.toISOString().slice(0, 10) === s;
  },
  uri: (s) => {
    try {
      new URL(s);
      return true;
    } catch {
      return false;
    }
  },
  email: (s) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s),
  "date-time": (s) => !Number.isNaN(Date.parse(s)),
};

// Keywords the validator implements, plus pure annotations it may safely ignore.
const KNOWN_KEYWORDS = new Set([
  "type", "enum", "const", "required", "properties", "additionalProperties",
  "items", "minItems", "maxItems", "uniqueItems", "minLength", "maxLength",
  "pattern", "minimum", "maximum", "format", "$ref", "allOf", "if", "then",
  "$schema", "$id", "$defs", "title", "description", "default", "examples",
  "deprecated",
]);

// Refuse to run against a schema this validator can't fully enforce. A silently
// ignored keyword would mean "✓ valid" without the new rule being checked at all.
function auditSchema(node, at, problems) {
  if (typeof node !== "object" || node === null) return;
  for (const [key, value] of Object.entries(node)) {
    if (!KNOWN_KEYWORDS.has(key))
      problems.push(`${at}: keyword "${key}" is not supported by scripts/sync-data.mjs — extend the validator before using it`);
    if (key === "format" && !FORMATS[value])
      problems.push(`${at}: format "${value}" is not supported — extend the validator`);
    if (key === "additionalProperties" && value !== false)
      problems.push(`${at}: only additionalProperties:false is supported`);
    if (key === "items" && Array.isArray(value))
      problems.push(`${at}: tuple-form "items" is not supported`);
    if ((key === "enum" || key === "const")) {
      const entries = key === "enum" ? value : [value];
      if (!entries.every((e) => e === null || ["string", "number", "boolean"].includes(typeof e)))
        problems.push(`${at}: non-primitive ${key} entries are not supported`);
    }
    // Recurse only into positions that hold subschemas.
    if (key === "properties" || key === "$defs")
      for (const [name, sub] of Object.entries(value))
        auditSchema(sub, `${at}.${key}.${name}`, problems);
    else if (key === "items" && !Array.isArray(value))
      auditSchema(value, `${at}.items`, problems);
    else if (key === "if" || key === "then")
      auditSchema(value, `${at}.${key}`, problems);
    else if (key === "allOf")
      value.forEach((sub, i) => auditSchema(sub, `${at}.allOf[${i}]`, problems));
  }
}

const typeName = (v) =>
  v === null ? "null" : Array.isArray(v) ? "array" : typeof v;

const matchesType = (v, t) =>
  t === "integer"
    ? typeof v === "number" && Number.isInteger(v)
    : t === "number"
      ? typeof v === "number"
      : typeName(v) === t;

function resolveRef(ref, rootSchema) {
  if (!ref.startsWith("#/"))
    throw new Error(`unsupported $ref "${ref}" (only local #/ refs)`);
  let node = rootSchema;
  for (const part of ref.slice(2).split("/")) {
    node = node?.[part];
    if (node === undefined) throw new Error(`$ref "${ref}" does not resolve`);
  }
  return node;
}

function validate(value, schema, path, errors, rootSchema) {
  if (schema.$ref)
    validate(value, resolveRef(schema.$ref, rootSchema), path, errors, rootSchema);

  if (schema.type !== undefined) {
    const types = Array.isArray(schema.type) ? schema.type : [schema.type];
    if (!types.some((t) => matchesType(value, t))) {
      errors.push(`${path}: expected ${types.join(" or ")}, got ${typeName(value)}`);
      return; // structural mismatch — deeper keywords would only add noise
    }
  }

  // enum/const entries are primitives (auditSchema guarantees it), so === is exact.
  if (schema.enum !== undefined && !schema.enum.includes(value))
    errors.push(`${path}: "${value}" is not one of ${JSON.stringify(schema.enum)}`);
  if (schema.const !== undefined && schema.const !== value)
    errors.push(`${path}: must be ${JSON.stringify(schema.const)}`);

  for (const sub of schema.allOf ?? [])
    validate(value, sub, path, errors, rootSchema);

  if (schema.if) {
    const probe = [];
    validate(value, schema.if, path, probe, rootSchema);
    if (probe.length === 0 && schema.then)
      validate(value, schema.then, path, errors, rootSchema);
  }

  if (value !== null && typeof value === "object" && !Array.isArray(value)) {
    for (const key of schema.required ?? [])
      if (!(key in value)) errors.push(`${path}: missing required "${key}"`);
    for (const [key, sub] of Object.entries(schema.properties ?? {}))
      if (key in value)
        validate(value[key], sub, `${path}.${key}`, errors, rootSchema);
    if (schema.additionalProperties === false && schema.properties)
      for (const key of Object.keys(value))
        if (!(key in schema.properties))
          errors.push(`${path}: unknown field "${key}"`);
  }

  if (Array.isArray(value)) {
    if (schema.minItems !== undefined && value.length < schema.minItems)
      errors.push(`${path}: needs at least ${schema.minItems} item(s)`);
    if (schema.maxItems !== undefined && value.length > schema.maxItems)
      errors.push(`${path}: allows at most ${schema.maxItems} item(s)`);
    if (schema.uniqueItems && new Set(value).size !== value.length)
      errors.push(`${path}: has duplicate entries`);
    if (schema.items)
      value.forEach((item, i) =>
        validate(item, schema.items, `${path}[${i}]`, errors, rootSchema)
      );
  }

  if (typeof value === "string") {
    if (schema.minLength !== undefined && value.length < schema.minLength)
      errors.push(`${path}: must not be empty`);
    if (schema.maxLength !== undefined && value.length > schema.maxLength)
      errors.push(`${path}: longer than ${schema.maxLength} characters`);
    if (schema.pattern !== undefined && !new RegExp(schema.pattern).test(value))
      errors.push(`${path}: does not match pattern ${schema.pattern}`);
    if (schema.format && FORMATS[schema.format] && !FORMATS[schema.format](value))
      errors.push(`${path}: "${value}" is not a valid ${schema.format}`);
  }

  if (typeof value === "number") {
    if (schema.minimum !== undefined && value < schema.minimum)
      errors.push(`${path}: ${value} is below minimum ${schema.minimum}`);
    if (schema.maximum !== undefined && value > schema.maximum)
      errors.push(`${path}: ${value} is above maximum ${schema.maximum}`);
  }
}

// Rules the schema itself cannot express. Shape errors are already recorded by
// validate() at this point, so guard every access instead of assuming arrays.
function extraChecks(data) {
  const errors = [];
  const seen = new Set();
  const ageOk = (ages, where) => {
    if (Array.isArray(ages) && ages.length === 2 && ages[0] > ages[1])
      errors.push(`${where}: age range [${ages}] has min > max`);
  };
  const orgs = Array.isArray(data?.organizations) ? data.organizations : [];
  orgs.forEach((o, i) => {
    if (o === null || typeof o !== "object") return;
    const at = `organizations[${i}]`;
    if (seen.has(o.id)) errors.push(`${at}: duplicate org id "${o.id}"`);
    seen.add(o.id);
    ageOk(o.ages, `${at}.ages`);
    (Array.isArray(o.ensembles) ? o.ensembles : []).forEach((e, j) =>
      ageOk(e?.ages, `${at}.ensembles[${j}].ages`));
    (Array.isArray(o.auditions) ? o.auditions : []).forEach((a, j) =>
      ageOk(a?.ages, `${at}.auditions[${j}].ages`));
  });
  return errors;
}

// --- Embedded bootstrap ------------------------------------------------------

function rebuildHtml(html, rawData) {
  const start = html.indexOf(BOOTSTRAP_OPEN);
  if (start === -1)
    fail(`no ${BOOTSTRAP_OPEN} block found in ${rel(HTML_PATH)} — not touching the file`);
  if (html.indexOf(BOOTSTRAP_OPEN, start + BOOTSTRAP_OPEN.length) !== -1)
    fail(`more than one ${BOOTSTRAP_OPEN} block in ${rel(HTML_PATH)} — not touching the file`);
  const bodyStart = start + BOOTSTRAP_OPEN.length;
  const end = html.indexOf(BOOTSTRAP_CLOSE, bodyStart);
  if (end === -1)
    fail(`the bootstrap block in ${rel(HTML_PATH)} has no closing tag`);
  const body = "\n" + rawData + (rawData.endsWith("\n") ? "" : "\n");
  return html.slice(0, bodyStart) + body + html.slice(end);
}

// --- Main ---------------------------------------------------------------------

const rawData = readFileSync(DATA_PATH, "utf8");
let data;
try {
  data = JSON.parse(rawData);
} catch (e) {
  fail(`${rel(DATA_PATH)} is not valid JSON: ${e.message}`);
}

const schema = JSON.parse(readFileSync(SCHEMA_PATH, "utf8"));

const schemaProblems = [];
auditSchema(schema, "schema", schemaProblems);
if (schemaProblems.length) {
  console.error(`✗ ${rel(SCHEMA_PATH)} uses features this validator does not cover — refusing to give a false "valid":\n`);
  for (const p of schemaProblems) console.error(`  · ${p}`);
  process.exit(1);
}

const errors = [];
validate(data, schema, "dataset", errors, schema);
errors.push(...extraChecks(data));

// The dataset is embedded inside a <script> element; the browser would end that
// element at the first literal "</script" inside the data, breaking the page.
if (/<\/script/i.test(rawData))
  errors.push(
    `data.json contains the text "</script>" inside a value — that would break the web page when embedded. Remove or rephrase that text.`
  );

// The generated copies mirror data.json byte-for-byte, so data.json itself must
// stay in the standard 2-space format (a reformat would churn every copy).
if (rawData !== JSON.stringify(data, null, 2) + "\n")
  errors.push(
    `data.json is not in the standard 2-space format — re-save it with 2-space indentation (and a final newline) so diffs stay readable`
  );

if (errors.length) {
  console.error(`✗ ${rel(DATA_PATH)} failed validation — nothing was written:\n`);
  for (const e of errors) console.error(`  · ${e}`);
  process.exit(1);
}

const published = data.organizations.filter(
  (o) => o.listingStatus === "published"
).length;
console.log(
  `✓ ${rel(DATA_PATH)} is valid (${data.organizations.length} organizations, ${published} published)`
);

const currentHtml = readFileSync(HTML_PATH, "utf8");
const targets = [
  {
    path: SEED_PATH,
    current: readFileSync(SEED_PATH, "utf8"),
    want: buildSeed(data),
    label: "database seed",
  },
  {
    path: HTML_PATH,
    current: currentHtml,
    want: rebuildHtml(currentHtml, rawData),
    label: "embedded dataset",
  },
];

let drifted = 0;
for (const t of targets) {
  if (t.current === t.want) {
    console.log(`✓ ${rel(t.path)} (${t.label}) is in sync`);
  } else if (CHECK) {
    console.error(`✗ ${rel(t.path)} (${t.label}) is OUT OF SYNC with data.json`);
    drifted++;
  } else {
    writeFileSync(t.path, t.want);
    console.log(`✓ ${rel(t.path)} (${t.label}) updated`);
  }
}

if (drifted) {
  console.error(`\nFix: node scripts/sync-data.mjs   (then review the diff and commit)`);
  process.exit(1);
}
console.log(CHECK ? "\nEverything is in sync." : "\nDone.");
