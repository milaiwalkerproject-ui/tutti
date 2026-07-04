-- GENERATED FILE — do not edit by hand.
-- Source: data.json   Regenerate: node scripts/generate-seed.mjs
-- Dataset version 2.0.0 · metro "Greater Los Angeles" · generated 2026-07-04

begin;

-- DESTRUCTIVE — local dev / first load only. Supabase runs this on `supabase db reset`.
-- The cascade also clears `public.saved` (it FKs organizations), so never run this
-- against a live database with real accounts. Production curation uses Studio (see CURATION.md).
truncate table public.organizations restart identity cascade;

-- yola — Youth Orchestra Los Angeles (YOLA)
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'yola', 'Youth Orchestra Los Angeles (YOLA)', 'youth', 33.9596, -118.3517, 'Inglewood', 'Greater Los Angeles',
  'https://www.laphil.com/learn/yola', NULL, 'The LA Phil''s free music program: instruments, instruction, and orchestras for young musicians aged 6–18 across five LA County sites, including the Beckmen YOLA Center in Inglewood.',
  '{"status":"unverified","source":"https://www.laphil.com/learn/yola/youth-orchestra-los-angeles"}'::jsonb, '{6,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"unverified","source":"https://www.laphil.com/learn/yola/youth-orchestra-los-angeles"}'::jsonb, '{"status":"verified","value":"Several hours per week, after school","source":"https://heartofla.org/yola/","asOf":"2026-06-22"}'::jsonb, '{"status":"unverified","source":"https://www.laphil.com/learn/yola/youth-orchestra-los-angeles"}'::jsonb, '{"status":"verified","value":"Free — instruments and instruction provided","source":"https://www.laphil.com/learn/yola","asOf":"2026-06-22"}'::jsonb,
  'Good fit if you want a free, high-support program and live near a YOLA site.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('yola', 0, 'Beginning Orchestra', 'Beginner', '{6,10}'::int[], 'First-instrument and early ensemble training; no experience needed.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('yola', 1, 'Intermediate Orchestra', 'Intermediate', '{9,13}'::int[], 'Full ensemble repertoire and sectionals.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('yola', 2, 'Advanced Orchestra', 'Advanced', '{13,18}'::int[], 'Flagship-level players; performances at the Hollywood Bowl and Walt Disney Concert Hall.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('yola', 0, 'Beginner', 'All — no experience required', '{"status":"unverified"}'::jsonb, 'rolling', '{6,10}'::int[], 'Start via the YOLA Interest Form; placement is by interview, not a formal audition. Space varies by site.', 'https://www.laphil.com/learn/yola');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('yola', 1, 'Advanced', 'Strings, winds, brass, percussion', '{"status":"unverified"}'::jsonb, 'upcoming', '{13,18}'::int[], 'Advanced placement is audition-based; check the site for the current window.', 'https://www.laphil.com/learn/yola');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('yola', 0, 'https://www.laphil.com/learn/yola', 'LA Phil — YOLA', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('yola', 1, 'https://en.wikipedia.org/wiki/Youth_Orchestra_Los_Angeles', 'Wikipedia — YOLA', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('yola', 2, 'https://www.laphil.com/learn/yola/youth-orchestra-los-angeles', 'LA Phil — YOLA program & how to join', '2026-07-04'::date);

-- colburn — Colburn Community School of Performing Arts — Youth Orchestras
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'colburn', 'Colburn Community School of Performing Arts — Youth Orchestras', 'youth', 34.0537, -118.2497, 'Downtown LA', 'Greater Los Angeles',
  'https://www.colburnschool.edu', 'https://colburnschool.edu/community-school/by-program/ensembles/', 'The Community School of Performing Arts at Colburn runs graded youth orchestras and a new advanced performance program feeding its renowned conservatory, in the Music Center district.',
  '{"status":"unverified","source":"https://colburnschool.edu/community-school/by-program/ensembles/"}'::jsonb, '{8,18}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"unverified","source":"https://colburnschool.edu/community-school/by-program/ensembles/"}'::jsonb, '{"status":"unverified","source":"https://colburnschool.edu/community-school/by-program/ensembles/"}'::jsonb, '{"status":"verified","value":true,"source":"https://colburnschool.edu/community-school/by-program/ensembles/","asOf":"2026-06-22"}'::jsonb, '{"status":"unverified","source":"https://colburnschool.edu/community-school/register/"}'::jsonb,
  'Good fit for a serious, conservatory-track student; scholarships help with cost.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('colburn', 0, 'Violin / Cello Ensembles', 'Beginner', '{6,12}'::int[], 'Entry-level ensembles building reading and ensemble fundamentals.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('colburn', 1, 'String Orchestra', 'Intermediate', '{11,16}'::int[], 'Intermediate/advanced strings; placement by audition.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('colburn', 2, 'Colburn Youth Philharmonic', 'Advanced', '{13,18}'::int[], 'Top symphonic ensemble (replacing the Colburn Youth Orchestra for 2026–27).');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('colburn', 3, 'Advanced Music Performance Program', 'Pre-professional', '{13,18}'::int[], 'Highly selective Sunday program: orchestra, chamber music, theory, college-audition prep.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('colburn', 0, 'Intermediate', 'Strings', '{"status":"unverified"}'::jsonb, 'rolling', '{11,16}'::int[], 'By application + video prescreen, then live audition (most recent round was held June 6–7, 2026). Check the site for the next window.', 'https://colburnschool.edu/community-school/by-program/ensembles/string-orchestra/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('colburn', 1, 'Pre-professional', 'Piano, strings, winds, brass, percussion', '{"status":"unverified"}'::jsonb, 'rolling', '{13,18}'::int[], 'Advanced Music Performance Program — selective audition; one day a week (Sundays).', 'https://colburnschool.edu/community-school/by-program/advanced_music_program/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('colburn', 0, 'https://www.colburnschool.edu', 'Colburn School', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('colburn', 1, 'https://colburnschool.edu/community-school/by-program/ensembles/', 'Community School ensembles', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('colburn', 2, 'https://colburnschool.edu/community-school/by-program/advanced_music_program/', 'Advanced Music Performance Program', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('colburn', 3, 'https://colburnschool.edu/community-school/register/', 'Community School — registration & tuition', '2026-07-03'::date);

-- ays — American Youth Symphony
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'ays', 'American Youth Symphony', 'youth', 34.0701, -118.4441, 'Westwood', 'Greater Los Angeles',
  'https://www.aysymphony.org', NULL, 'A tuition-free, audition-only pre-professional orchestra for advanced young players (15 and up, no upper age limit), known for film-score concerts and free performances at Royce Hall.',
  '{"status":"unverified"}'::jsonb, '{15,30}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"verified","value":"Free — tuition-free fellowship; selected players receive an annual stipend","source":"https://www.laphil.com/musicdb/artists/290/american-youth-symphony","asOf":"2026-06-22"}'::jsonb,
  'Good fit for advanced teens and young adults ready for professional-level repertoire.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('ays', 0, 'American Youth Symphony', 'Pre-professional', '{15,30}'::int[], 'Single advanced orchestra of ~100 musicians; conservatory-level repertoire.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('ays', 0, 'Pre-professional', 'All orchestral instruments', '{"status":"unverified"}'::jsonb, 'upcoming', '{15,30}'::int[], 'Competitive; roughly 35 seats open each year. Solo + orchestral excerpts. Check the site for current dates.', 'https://www.aysymphony.org');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ays', 0, 'https://www.aysymphony.org', 'American Youth Symphony', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ays', 1, 'https://www.laphil.com/musicdb/artists/290/american-youth-symphony', 'LA Phil — AYS', '2026-06-22'::date);

-- layo — Los Angeles Youth Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'layo', 'Los Angeles Youth Orchestra', 'youth', 34.1718, -118.5125, 'Encino', 'Greater Los Angeles',
  'https://losangelesyouthorchestra.org', 'https://losangelesyouthorchestra.org/audition-information/', 'A welcoming youth orchestra rehearsing Sunday afternoons in Encino, with an intermediate and an advanced ensemble and two concerts each semester.',
  '{"status":"verified","value":"2026–27 season","source":"https://losangelesyouthorchestra.org/audition-information/","asOf":"2026-06-22"}'::jsonb, '{8,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Sunday afternoons, 1:30–5:00 PM (Encino)","source":"https://losangelesyouthorchestra.org/audition-information/","asOf":"2026-06-22"}'::jsonb, '{"status":"verified","value":"Weekly rehearsals; two fall and two spring concerts","source":"https://losangelesyouthorchestra.org/audition-information/","asOf":"2026-06-22"}'::jsonb, '{"status":"verified","value":true,"source":"https://losangelesyouthorchestra.org/audition-information/","asOf":"2026-06-22"}'::jsonb, '{"status":"verified","value":"$750 per semester (or $1,400 paid in full for the year)","source":"https://losangelesyouthorchestra.org/audition-information/","asOf":"2026-06-22"}'::jsonb,
  'Good fit for an intermediate-to-advanced player (about two+ years of lessons) wanting a friendly Sunday orchestra in the Valley.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('layo', 0, 'Ruth Borun Concert Orchestra', 'Intermediate', '{8,18}'::int[], 'Intermediate ensemble.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('layo', 1, 'Symphony Orchestra', 'Advanced', '{8,18}'::int[], 'Advanced ensemble; higher expectations for tone, dynamics, and musicianship.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('layo', 0, 'Advanced', 'Strings, winds, brass, percussion', '{"status":"verified","value":"August 22 & 23, 2026 (First Presbyterian Church, Encino)","source":"https://losangelesyouthorchestra.org/audition-information/","asOf":"2026-06-22"}'::jsonb, 'upcoming', '{8,18}'::int[], 'For the Fall 2026 semester. Major & minor scales, LAYO-provided excerpts, and sight-reading. $100 audition fee is applied to tuition on acceptance.', 'https://losangelesyouthorchestra.org/audition-information/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('layo', 0, 'https://losangelesyouthorchestra.org/audition-information/', 'LAYO — Audition Information', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('layo', 1, 'https://losangelesyouthorchestra.org', 'LAYO', '2026-06-22'::date);

-- pyso — Pasadena Youth Symphony Orchestras
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'pyso', 'Pasadena Youth Symphony Orchestras', 'youth', 34.1478, -118.1445, 'Pasadena', 'Greater Los Angeles',
  'https://pasadenasymphony-pops.org/education/pyso/', 'https://pasadenasymphony-pops.org/education/pyso/auditions/', 'The Pasadena Symphony Association''s youth program: seven ensembles for grades 4–12, serving 400+ students from across Southern California, with weekly rehearsals and at least two concerts a year.',
  '{"status":"unverified","source":"https://pasadenasymphony-pops.org/education/pyso/auditions/"}'::jsonb, '{9,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Weekly throughout the season","source":"https://pasadenasymphony-pops.org/education/pyso/auditions/","asOf":"2026-06-22"}'::jsonb, '{"status":"verified","value":"Weekly; students perform in at least two concerts each year","source":"https://pasadenasymphony-pops.org/education/pyso/auditions/","asOf":"2026-06-22"}'::jsonb, '{"status":"verified","value":true,"source":"https://pasadenasymphony-pops.org/education/pyso/auditions/","asOf":"2026-06-22"}'::jsonb, '{"status":"unverified","source":"https://pasadenasymphony-pops.org/education/pyso/auditions/"}'::jsonb,
  'Good fit for San Gabriel Valley families wanting a structured, multi-tier path from beginner to youth symphony.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('pyso', 0, 'Beginning Strings', 'Beginner', '{9,12}'::int[], 'Entry ensemble — one of seven graded PYSO ensembles.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('pyso', 1, 'Intermediate Orchestra', 'Intermediate', '{11,15}'::int[], 'Strings, winds, and brass together.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('pyso', 2, 'Youth Symphony', 'Advanced', '{14,18}'::int[], 'Top ensemble in the seven-tier program.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('pyso', 0, 'Intermediate', 'Strings, winds, brass, percussion', '{"status":"unverified"}'::jsonb, 'upcoming', '{9,18}'::int[], '2026–27 applications open in early April; placement by audition across seven ensembles. Check the site for in-person dates.', 'https://pasadenasymphony-pops.org/education/pyso/auditions/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('pyso', 0, 'https://pasadenasymphony-pops.org/education/pyso/auditions/', 'PYSO — Auditions', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('pyso', 1, 'https://pasadenasymphony-pops.org/education/pyso/', 'PYSO', '2026-06-22'::date);

-- gyo — Glendale Youth Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'gyo', 'Glendale Youth Orchestra', 'youth', 34.1466, -118.2551, 'Glendale', 'Greater Los Angeles',
  'https://www.glendaleyouthorchestra.com', 'https://www.glendaleyouthorchestra.com/auditions', 'An advanced, audition-based youth orchestra founded in 1989, performing three concerts each season at the Alex Theatre, with a members'' concerto competition.',
  '{"status":"unverified","source":"https://www.glendaleyouthorchestra.com/auditions"}'::jsonb, '{12,23}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.glendaleyouthorchestra.com/auditions","asOf":"2026-06-22"}'::jsonb, '{"status":"verified","value":"$875 per year (includes 5 concert tickets per concert)","source":"https://www.glendaleyouthorchestra.com/auditions","asOf":"2026-06-22"}'::jsonb,
  'Good fit for an advanced Glendale-area player who wants symphonic repertoire and a concerto-competition opportunity.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('gyo', 0, 'Glendale Youth Orchestra', 'Advanced', '{12,23}'::int[], 'Single full orchestra; classical, film, and world music.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('gyo', 0, 'Advanced', 'All orchestral instruments', '{"status":"unverified"}'::jsonb, 'upcoming', '{12,23}'::int[], 'By appointment, typically late August before the season. Two prepared excerpts + two scales; merit-based. Check the site for the current date.', 'https://www.glendaleyouthorchestra.com/auditions');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('gyo', 0, 'https://www.glendaleyouthorchestra.com/auditions', 'GYO — Auditions', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('gyo', 1, 'https://www.glendaleyouthorchestra.com', 'Glendale Youth Orchestra', '2026-06-22'::date);

-- smyo — Santa Monica Youth Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'smyo', 'Santa Monica Youth Orchestra', 'youth', 34.0287, -118.479, 'Santa Monica', 'Greater Los Angeles',
  'https://soundslikela.org/programs/santa-monica-youth-orchestra/', NULL, 'A tuition-free, audition-free Sunday music program (part of Sounds Like LA) for ages 6–18, with three orchestra levels and a culturally diverse repertoire, rehearsing at Virginia Avenue Park.',
  '{"status":"unverified"}'::jsonb, '{6,18}'::int[], '{"Strings","Winds"}'::public.instrument[],
  '{"status":"verified","value":"Sunday afternoons, roughly 30 weeks Sept–June (Virginia Avenue Park)","source":"https://arts.ca.gov/grantee/santa-monica-youth-orchestra-2/","asOf":"2026-06-22"}'::jsonb, '{"status":"verified","value":"Weekly (Sundays); open to any student who can commit to rehearsals","source":"https://soundslikela.org/programs/santa-monica-youth-orchestra/","asOf":"2026-06-22"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"verified","value":"Free — tuition-free","source":"https://soundslikela.org/programs/santa-monica-youth-orchestra/","asOf":"2026-06-22"}'::jsonb,
  'Good fit for westside and coastal families wanting a free, welcoming first orchestra with no audition.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('smyo', 0, 'Prelude Orchestra', 'Beginner', '{6,11}'::int[], 'Beginning level.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('smyo', 1, 'Youth Orchestra', 'Intermediate', '{10,14}'::int[], 'Intermediate level.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('smyo', 2, 'Symphonic Orchestra', 'Advanced', '{12,18}'::int[], 'Most advanced of the three levels; opens for the Westside Chamber Orchestra.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('smyo', 0, 'Beginner', 'All — no audition', '{"status":"verified","value":"Open enrollment — no audition; register each season","source":"https://soundslikela.org/programs/santa-monica-youth-orchestra/","asOf":"2026-06-22"}'::jsonb, 'rolling', '{6,18}'::int[], 'Audition-free; students are placed by level. Registration opens each season.', 'https://soundslikela.org/programs/santa-monica-youth-orchestra/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('smyo', 0, 'https://soundslikela.org/programs/santa-monica-youth-orchestra/', 'Sounds Like LA — SMYO', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('smyo', 1, 'https://arts.ca.gov/grantee/santa-monica-youth-orchestra-2/', 'CA Arts Council — SMYO', '2026-06-22'::date);

-- laphil — Los Angeles Philharmonic
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'laphil', 'Los Angeles Philharmonic', 'professional', 34.0556, -118.2497, 'Downtown LA', 'Greater Los Angeles',
  'https://www.laphil.com', NULL, 'One of the world''s leading orchestras, resident at Walt Disney Concert Hall and the Hollywood Bowl.',
  '{"status":"unverified","source":"https://www.laphil.com/campaigns/202627-welcome"}'::jsonb, '{22,99}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"verified","value":"Full-time professional","source":"https://www.laphil.com","asOf":"2026-06-22"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'For professional musicians auditioning for posted vacancies; for families, a world-class concert destination.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('laphil', 0, 'Los Angeles Philharmonic', 'Professional', '{22,99}'::int[], 'Full professional symphony orchestra.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('laphil', 0, 'Professional', 'Posted vacancies only', '{"status":"unverified"}'::jsonb, 'rolling', '{22,99}'::int[], 'Union audition process; sealed-round excerpts. See the LA Phil site for current openings.', 'https://www.laphil.com');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('laphil', 0, 'https://www.laphil.com', 'Los Angeles Philharmonic', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('laphil', 1, 'https://www.laphil.com/campaigns/202627-welcome', 'LA Phil — 2026/27 season', '2026-07-04'::date);

-- laco — Los Angeles Chamber Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'laco', 'Los Angeles Chamber Orchestra', 'professional', 34.0556, -118.2468, 'Downtown LA', 'Greater Los Angeles',
  'https://www.laco.org', NULL, 'Founded in 1968, a preeminent professional chamber orchestra performing orchestral, chamber, and Baroque programs across greater Los Angeles, led by Music Director Jaime Martín.',
  '{"status":"verified","value":"2026/27 season","source":"https://www.laco.org/2627season/","asOf":"2026-06-22"}'::jsonb, '{22,99}'::int[], '{"Strings","Winds","Brass"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"verified","value":"Full-time professional","source":"https://www.laco.org","asOf":"2026-06-22"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'For professional players; for families, intimate, high-craft chamber concerts in DTLA and Beverly Hills.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('laco', 0, 'Los Angeles Chamber Orchestra', 'Professional', '{22,99}'::int[], 'Professional chamber-scale orchestra.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('laco', 0, '2026-09-26'::date, 'MOVEMENT(S)!', 'Walt Disney Concert Hall (DTLA) & Wallis Annenberg Center (Beverly Hills)', 'Kodály; Carlos Simon (world premiere); Gabriela Lena Frank; de Falla', '{"status":"unverified"}'::jsonb, 'https://www.laco.org/events/movements/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('laco', 1, '2026-11-19'::date, 'East Meets West', 'Orchestral Series', NULL, '{"status":"unverified"}'::jsonb, 'https://www.laco.org/2627season/subscribe/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('laco', 2, '2027-05-15'::date, 'Brahms, Beethoven, Ravaei (season finale)', 'Orchestral Series', 'Brahms Violin Concerto (James Ehnes); Beethoven Symphony No. 7; world premiere by Kian Ravaei', '{"status":"unverified"}'::jsonb, 'https://www.laco.org/laco-2627-pr/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('laco', 0, 'Professional', 'Posted vacancies only', '{"status":"unverified"}'::jsonb, 'rolling', '{22,99}'::int[], 'Excerpts + chamber round. See the LACO site for current openings.', 'https://www.laco.org');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('laco', 0, 'https://www.laco.org/2627season/', 'LACO — 2026/27 season', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('laco', 1, 'https://www.laco.org/events/movements/', 'LACO — MOVEMENT(S)!', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('laco', 2, 'https://www.laco.org/laco-2627-pr/', 'LACO — 2026/27 announcement', '2026-06-22'::date);

-- passym — Pasadena Symphony and POPS
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'passym', 'Pasadena Symphony and POPS', 'professional', 34.1452, -118.139, 'Pasadena', 'Greater Los Angeles',
  'https://pasadenasymphony-pops.org', NULL, 'The San Gabriel Valley''s professional orchestra: a classical season (Oct–May) at Ambassador Auditorium and a summer POPS series at the LA County Arboretum.',
  '{"status":"verified","value":"Classical season Oct–May at Ambassador Auditorium; POPS Jun–Sep at the LA County Arboretum","source":"https://pasadenasymphony-pops.org","asOf":"2026-06-22"}'::jsonb, '{22,99}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"verified","value":"Per-service professional","source":"https://pasadenasymphony-pops.org","asOf":"2026-06-22"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'For professional players seeking section/sub work; for families, a regional classical and POPS concert series.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('passym', 0, 'Pasadena Symphony', 'Professional', '{22,99}'::int[], 'Professional regional orchestra.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('passym', 0, 'Professional', 'Substitute & section list', '{"status":"unverified"}'::jsonb, 'rolling', '{22,99}'::int[], 'Resume + excerpts by posted vacancy.', 'https://pasadenasymphony-pops.org');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('passym', 0, 'https://pasadenasymphony-pops.org', 'Pasadena Symphony and POPS', '2026-06-22'::date);

-- lbso — Long Beach Symphony
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'lbso', 'Long Beach Symphony', 'professional', 33.7686, -118.1923, 'Long Beach', 'Greater Los Angeles',
  'https://longbeachsymphony.org', NULL, 'Long Beach''s professional orchestra since 1934, led by Music Director Eckart Preu, with a five-concert Classical Series at the Terrace Theater plus a POPS series and youth concerts.',
  '{"status":"verified","value":"2026–27 Classical Series — five concerts at the Terrace Theater","source":"https://longbeachsymphony.org/classical-2026-27/","asOf":"2026-06-22"}'::jsonb, '{22,99}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"verified","value":"Per-service professional","source":"https://longbeachsymphony.org","asOf":"2026-06-22"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'For professional players; for families, a relaxed Classical Series in Long Beach with free pre-concert talks.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('lbso', 0, 'Long Beach Symphony', 'Professional', '{22,99}'::int[], 'Professional orchestra.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('lbso', 0, '2026-10-10'::date, 'Faces of America at 250', 'Terrace Theater', 'Copland Fanfare for the Common Man; James P. Johnson Harlem Symphony; Gershwin Strike Up the Band', '{"status":"unverified"}'::jsonb, 'https://longbeachsymphony.org/classical-2026-27/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('lbso', 1, '2026-11-14'::date, 'Entangled in Passion', 'Terrace Theater', 'Ravel Boléro; R. Strauss Don Juan; Rachmaninoff Piano Concerto No. 2 (Michelle Cann)', '{"status":"unverified"}'::jsonb, 'https://longbeachsymphony.org/classical-2026-27/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('lbso', 2, '2027-03-06'::date, 'Heaven & Earth', 'Terrace Theater', 'Gabriela Lena Frank; Brahms Violin Concerto (Randall Goosby); Mozart Symphony No. 41 ''Jupiter''', '{"status":"unverified"}'::jsonb, 'https://longbeachsymphony.org/classical-2026-27/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('lbso', 0, 'Professional', 'Posted vacancies only', '{"status":"unverified"}'::jsonb, 'rolling', '{22,99}'::int[], 'Union audition; excerpts provided by posted vacancy.', 'https://longbeachsymphony.org');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('lbso', 0, 'https://longbeachsymphony.org/classical-2026-27/', 'Long Beach Symphony — 2026–27 Classical', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('lbso', 1, 'https://longbeachsymphony.org', 'Long Beach Symphony', '2026-06-22'::date);

-- culver — Culver City Symphony Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'culver', 'Culver City Symphony Orchestra', 'community', 34.0211, -118.3965, 'Culver City', 'Greater Los Angeles',
  'https://www.culvercitysymphony.org', NULL, 'Founded in 1964 (originally the Westchester String Symphony), an orchestra that pairs professional players with talented amateurs and students, presenting free concerts in Culver City and a summer series as the Marina del Rey Summer Symphony.',
  '{"status":"verified","value":"3–4 free concerts each season in Culver City; summers as the Marina del Rey Summer Symphony at Burton Chace Park","source":"https://www.culvercitysymphony.org","asOf":"2026-06-22"}'::jsonb, '{16,99}'::int[], '{"Strings","Winds","Brass"}'::public.instrument[],
  '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb,
  'Good fit for adult amateurs and advanced students who want to play alongside professionals, or for families wanting free local concerts.', NULL, '2026-06-22'::date,
  'published', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('culver', 0, 'Culver City Symphony Orchestra', 'Intermediate', '{16,99}'::int[], 'Mixed professional/amateur/student orchestra; becomes the Marina del Rey Summer Symphony in summer.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('culver', 0, 'Intermediate', 'Strings, winds, brass', '{"status":"unverified"}'::jsonb, 'rolling', '{16,99}'::int[], 'Includes professional, amateur, and student players; contact the orchestra to inquire about joining.', 'https://www.culvercitysymphony.org');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('culver', 0, 'https://www.culvercitysymphony.org', 'Culver City Symphony Orchestra', '2026-06-22'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('culver', 1, 'https://www.eventbrite.com/o/culver-city-symphony-orchestra-119912435181', 'CCSO — about (Eventbrite)', '2026-06-22'::date);

commit;
