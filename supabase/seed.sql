-- GENERATED FILE — do not edit by hand.
-- Source: data.json   Regenerate: node scripts/sync-data.mjs
-- Dataset version 3.1.0 · metro "Southern California" · generated 2026-07-06

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

-- icyola — Inner City Youth Orchestra of Los Angeles
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'icyola', 'Inner City Youth Orchestra of Los Angeles', 'youth', 33.9789, -118.372, 'South Los Angeles', 'Greater Los Angeles',
  'https://icyola.org/', 'https://icyola.org/join-our-orchestra/', 'Tuition-free, no-audition orchestra of roughly 125 young musicians rooted in South Los Angeles, widely described as the largest majority-Black youth orchestra in the country. Players rehearse weekly alongside professional mentor-artists and close each season on the Walt Disney Concert Hall stage.',
  '{"status":"verified","value":"2025–26 concert season (theme: ''I, Too, Sing America''; season finale July 12, 2026)","source":"https://icyola.org/2025-26-season/","asOf":"2026-07-06"}'::jsonb, '{10,25}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"unverified"}'::jsonb, '{"status":"verified","value":"Weekly rehearsals; 12–15 concerts annually","source":"https://icyola.org/our-orchestra/","asOf":"2026-07-06"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"verified","value":"Free — no tuition, no auditions, no competition for seats","source":"https://icyola.org/join-our-orchestra/","asOf":"2026-07-06"}'::jsonb,
  'Good fit if you want a tuition-free, no-audition orchestra where beginners and advanced players grow side by side with professional mentors.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('icyola', 0, 'Inner City Youth Orchestra of Los Angeles', 'Intermediate', '{10,25}'::int[], 'Single mixed-level orchestra of approximately 125 members; advanced players mentor newer ones and professional mentor-artists rehearse and perform alongside students.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('icyola', 0, '2026-07-12'::date, '18th Annual Season Finale Concert', 'Walt Disney Concert Hall', NULL, '{"status":"unverified"}'::jsonb, 'https://icyola.org/2025-26-season/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('icyola', 0, 'Beginner', 'All orchestral instruments — all skill levels welcome', '{"status":"verified","value":"Open enrollment — no audition; join any time via the interest form","source":"https://icyola.org/join-our-orchestra/","asOf":"2026-07-06"}'::jsonb, 'rolling', '{10,25}'::int[], 'No auditions — families submit an interest form and staff follow up; instruments can be provided if needed.', 'https://icyola.org/join-our-orchestra/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('icyola', 0, 'https://icyola.org/', 'ICYOLA home', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('icyola', 1, 'https://icyola.org/join-our-orchestra/', 'Join Our Orchestra', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('icyola', 2, 'https://icyola.org/our-orchestra/', 'Our Orchestra', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('icyola', 3, 'https://icyola.org/2025-26-season/', '2025–26 Concert Season', '2026-07-06'::date);

-- cymo — Claremont Young Musicians Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'cymo', 'Claremont Young Musicians Orchestra', 'youth', 34.111, -117.719, 'Claremont', 'Greater Los Angeles',
  'https://www.cymo.org/', 'https://www.cymo.org/audition.html', 'Auditioned youth orchestra program founded in 1989, with three Sunday-rehearsal ensembles running from beginning strings through a full symphony that has performed at Walt Disney Concert Hall and toured Europe. A Los Angeles Philharmonic member appears as soloist with the orchestra each January.',
  '{"status":"verified","value":"2026–27 season","source":"https://www.cymo.org/audition.html","asOf":"2026-07-06"}'::jsonb, '{8,20}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Sundays at Claremont High School, September through May: Overture Strings 2:00–3:00 PM, Intermezzo Orchestra 3:30–5:30 PM, CYMO 6:30–9:15 PM","source":"https://www.cymo.org/orchestra-bio.html","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Weekly Sunday rehearsals, September through May","source":"https://www.cymo.org/orchestra-bio.html","asOf":"2026-07-06"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb,
  'Good fit if your player wants a classic auditioned youth-symphony ladder in the east San Gabriel Valley with serious repertoire and LA Phil connections.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('cymo', 0, 'Claremont Young Musicians Overture String Orchestra', 'Beginner', '{8,13}'::int[], 'Beginning orchestral experience for string players in grades 3–8, preparing them for the Intermezzo Orchestra (about 35 members).');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('cymo', 1, 'Claremont Young Musicians Intermezzo Orchestra', 'Intermediate', '{9,18}'::int[], '75-member preparatory orchestra for intermediate players, ages 9–18, feeding into CYMO.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('cymo', 2, 'Claremont Young Musicians Orchestra (CYMO)', 'Advanced', '{12,20}'::int[], 'Flagship symphony of musicians ages 12–20 performing major symphonic works at Bridges Hall of Music, Pomona College.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('cymo', 0, 'Advanced', 'All orchestral instruments (CYMO)', '{"status":"unverified"}'::jsonb, 'upcoming', '{12,20}'::int[], '2026–27 audition dates and excerpts to be available in July 2026; join the audition list via the application form.', 'https://www.cymo.org/audition.html');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('cymo', 1, 'Intermediate', 'All orchestral instruments (Intermezzo Orchestra)', '{"status":"unverified"}'::jsonb, 'upcoming', '{9,18}'::int[], '2026–27 audition dates and excerpts to be available in July 2026; join the audition list via the application form.', 'https://www.cymo.org/audition.html');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('cymo', 2, 'Beginner', 'Strings (Overture String Orchestra)', '{"status":"verified","value":"September, two weeks after the CYMO and Intermezzo auditions","source":"https://www.cymo.org/orchestra-bio.html","asOf":"2026-07-06"}'::jsonb, 'upcoming', '{8,13}'::int[], NULL, 'https://www.cymo.org/orchestra-bio.html');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('cymo', 0, 'https://www.cymo.org/', 'CYMO home', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('cymo', 1, 'https://www.cymo.org/audition.html', 'Audition information, 2026–27 season', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('cymo', 2, 'https://www.cymo.org/orchestra-bio.html', 'Orchestra bio (ensembles, ages, rehearsals)', '2026-07-06'::date);

-- scvyo — Santa Clarita Valley Youth Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'scvyo', 'Santa Clarita Valley Youth Orchestra', 'youth', 34.3995, -118.587, 'Santa Clarita', 'Greater Los Angeles',
  'https://www.scvyo.org/', 'https://www.scvyo.org/enroll-in-scvyo', 'Santa Clarita''s youth orchestra for nearly 40 years, with a beginner-to-advanced ensemble ladder and unusually adventurous programming that pairs classical repertoire with dancers, animators and cross-cultural works. Students can also join honors chamber music, a conducting program and travel opportunities.',
  '{"status":"verified","value":"Fall 2026 (semester-based; new members register by August 15, 2026)","source":"https://www.scvyo.org/enroll-in-scvyo","asOf":"2026-07-06"}'::jsonb, '{8,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Symphony Orchestra: Sundays 1:00–2:30 PM, Rancho Pico Jr. High School band room","source":"https://www.scvyo.org/orchestra","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Semester-based enrollment; all students except continuing Prelude members re-audition each fall","source":"https://www.scvyo.org/enroll-in-scvyo","asOf":"2026-07-06"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"verified","value":"$420 per-semester ensemble fee (Symphony Orchestra, Spring 2026) plus $13 online processing fee; 10% sibling discount; payment plans available","source":"https://www.scvyo.org/payments/symphony-orchestra","asOf":"2026-07-06"}'::jsonb,
  'Good fit if you want a friendly, community-minded orchestra in the Santa Clarita Valley that welcomes players from their first year through advanced repertoire.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('scvyo', 0, 'Prelude Ensemble', 'Beginner', '{8,13}'::int[], 'Entry-level ensemble for musicians with about one year of experience on any string, wind or brass instrument (including piano and percussion); continuing students do not re-audition.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('scvyo', 1, 'Symphony Orchestra', 'Intermediate', '{10,16}'::int[], 'Mixed-level intermediate orchestra (typically 3+ years of experience) that prepares musicians for Novae Sinfonia.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('scvyo', 2, 'Novae Sinfonia', 'Advanced', '{13,18}'::int[], 'Most advanced orchestral ensemble; typical members have at least five years of experience.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('scvyo', 3, 'Honors Chamber Music', 'Advanced', '{13,18}'::int[], 'Advanced chamber program; members must be concurrently enrolled in Novae Sinfonia.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('scvyo', 0, 'Advanced', 'Strings, winds, brass, percussion, piano (Novae Sinfonia)', '{"status":"verified","value":"Live auditions July 25, 2026 (returning students) and August 15, 2026 (new students) at Rancho Pico Jr. High School; digital video auditions accepted in advance","source":"https://www.scvyo.org/enroll-in-scvyo","asOf":"2026-07-06"}'::jsonb, 'open', '{13,18}'::int[], 'Scales, a solo piece and short orchestral excerpts; all new and returning students re-audition each fall.', 'https://www.scvyo.org/enroll-in-scvyo');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('scvyo', 1, 'Intermediate', 'Strings, winds, brass, percussion, piano (Symphony Orchestra)', '{"status":"verified","value":"Live auditions July 25, 2026 (returning students) and August 15, 2026 (new students) at Rancho Pico Jr. High School; digital video auditions accepted in advance","source":"https://www.scvyo.org/enroll-in-scvyo","asOf":"2026-07-06"}'::jsonb, 'open', '{10,16}'::int[], 'Scales, a solo piece and short orchestral excerpts (excerpts updated 6/16/26).', 'https://www.scvyo.org/orchestra');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('scvyo', 2, 'Beginner', 'Strings, winds, brass, piano, percussion (Prelude Ensemble)', '{"status":"verified","value":"New students register for Fall 2026 by August 15, 2026","source":"https://www.scvyo.org/enroll-in-scvyo","asOf":"2026-07-06"}'::jsonb, 'open', '{8,13}'::int[], 'New students demonstrate one year of experience, music reading and a one-octave scale; continuing Prelude students are exempt from re-auditioning.', 'https://www.scvyo.org/enroll-in-scvyo');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('scvyo', 0, 'https://www.scvyo.org/', 'SCVYO home', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('scvyo', 1, 'https://www.scvyo.org/enroll-in-scvyo', 'Enroll in SCVYO (auditions)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('scvyo', 2, 'https://www.scvyo.org/orchestra', 'Symphony Orchestra program page', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('scvyo', 3, 'https://www.scvyo.org/payments/symphony-orchestra', 'Symphony Orchestra fees', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('scvyo', 4, 'https://www.scvyo.org/about-scvyo', 'About SCVYO', '2026-07-06'::date);

-- csun-yo — CSUN Youth Orchestras
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'csun-yo', 'CSUN Youth Orchestras', 'youth', 34.24, -118.529, 'Northridge', 'Greater Los Angeles',
  'https://www.csun.edu/csun-youth-orchestras', 'https://www.csun.edu/csun-youth-orchestras/application-audition', 'Multi-orchestra program for school-age musicians in residence at Cal State Northridge since the mid-1970s, serving the San Fernando Valley with three ensembles from intermediate strings up to the Youth Philharmonic. The program traces its roots to the Valley Young People''s Orchestra founded in 1970.',
  '{"status":"verified","value":"2025–2026 (first rehearsals September 13–14, 2025)","source":"https://www.csun.edu/csun-youth-orchestras","asOf":"2026-07-06"}'::jsonb, '{7,17}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb,
  'Good fit if you want a university-hosted youth orchestra ladder in the San Fernando Valley with a competitive top ensemble.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('csun-yo', 0, 'Camerata Strings', 'Intermediate', '{9,14}'::int[], 'Intermediate string orchestra teaching the skills needed for successful orchestral playing.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('csun-yo', 1, 'Symphony', 'Intermediate', '{11,17}'::int[], 'Intermediate orchestra of 70–90 members playing standard works and arrangements; players expected to have roughly four or more years of experience.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('csun-yo', 2, 'Philharmonic', 'Advanced', '{13,17}'::int[], 'Top-level orchestra of 80–100 students playing standard literature, mainly late-romantic and 20th-century; auditions are highly competitive.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('csun-yo', 0, 'Advanced', 'All orchestral instruments (Philharmonic)', '{"status":"verified","value":"Late spring each year","source":"https://www.csun.edu/csun-youth-orchestras/about/ensembles-conductors","asOf":"2026-07-06"}'::jsonb, 'upcoming', '{13,17}'::int[], 'Site''s posted registration details are from the 2025–26 cycle (video auditions were due before September 6, 2025); confirm current-year dates with the program.', 'https://www.csun.edu/csun-youth-orchestras/about/ensembles-conductors');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('csun-yo', 1, 'Intermediate', 'All orchestral instruments (Symphony)', '{"status":"verified","value":"Summer through early September each year","source":"https://www.csun.edu/csun-youth-orchestras/about/ensembles-conductors","asOf":"2026-07-06"}'::jsonb, 'upcoming', '{11,17}'::int[], 'Annual recurring window per the ensembles page; 2026–27 specific dates not yet posted as of 2026-07-06 — the site''s audition page still shows the 2025–26 cycle. Returning members re-register without re-auditioning.', 'https://www.csun.edu/csun-youth-orchestras/about/ensembles-conductors');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('csun-yo', 0, 'https://www.csun.edu/csun-youth-orchestras', 'CSUN Youth Orchestras home (2025–26 audition info)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('csun-yo', 1, 'https://www.csun.edu/csun-youth-orchestras/about', 'About / history', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('csun-yo', 2, 'https://www.csun.edu/csun-youth-orchestras/about/ensembles-conductors', 'Ensembles & conductors', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('csun-yo', 3, 'https://www.csun.edu/csun-youth-orchestras/application-audition', 'Application & audition', '2026-07-06'::date);

-- claremont-so — Claremont Symphony Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'claremont-so', 'Claremont Symphony Orchestra', 'community', 34.0975, -117.714, 'Claremont', 'Greater Los Angeles',
  'https://www.claremontso.org/', 'https://www.claremontso.org/auditions.html', 'All-volunteer community symphony entering its 74th season, performing free concerts at Bridges Hall of Music on the Pomona College campus. The orchestra''s association also sponsors the Claremont Youth Symphony Orchestra.',
  '{"status":"verified","value":"2026–2027 (74th season); dates and programming to be posted","source":"https://www.claremontso.org/","asOf":"2026-07-06"}'::jsonb, '{18,99}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Monday evenings 7:30–10:00 PM at Bryant Rehearsal Hall, Thatcher Music Building, Pomona College","source":"https://www.claremontso.org/auditions.html","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Volunteer membership; attendance at weekly rehearsals expected","source":"https://www.claremontso.org/auditions.html","asOf":"2026-07-06"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb,
  'Good fit if you''re an adult amateur player near the east San Gabriel Valley looking for a welcoming volunteer symphony — or a family wanting free classical concerts.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('claremont-so', 0, 'Claremont Symphony Orchestra', 'Intermediate', '{18,99}'::int[], 'All-volunteer community symphony led by Music Director Robert Sage; membership by audition.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('claremont-so', 0, 'Intermediate', 'All instruments', '{"status":"verified","value":"Year-round, on an ongoing basis","source":"https://www.claremontso.org/auditions.html","asOf":"2026-07-06"}'::jsonb, 'rolling', '{18,99}'::int[], 'String players contact the concertmaster; all other instruments contact the orchestra''s audition coordinator. Confirm you can attend Monday rehearsals before requesting an audition.', 'https://www.claremontso.org/auditions.html');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('claremont-so', 0, 'https://www.claremontso.org/', 'CSO home (74th season announcement)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('claremont-so', 1, 'https://www.claremontso.org/auditions.html', 'Auditions & rehearsal schedule', '2026-07-06'::date);

-- mslm-yo — Musique Sur La Mer Youth Orchestras
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'mslm-yo', 'Musique Sur La Mer Youth Orchestras', 'youth', 33.7607, -118.1889, 'Long Beach', 'Greater Los Angeles',
  'https://www.mslmorchestra.com/', 'https://www.mslmorchestra.com/audition/', 'Long Beach youth orchestra family founded in 2000 by Marcy Sudock, running from beginner strings and a youth mariachi ensemble up to a touring youth symphony that has played the Sydney Opera House and Vienna''s Musikverein. Rehearsals happen at the group''s own waterfront studio at Shoreline Village.',
  '{"status":"verified","value":"Concert season runs late August through May, with four major concerts per season","source":"https://www.mslmorchestra.com/audition/","asOf":"2026-07-06"}'::jsonb, '{7,18}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"verified","value":"At the Musique Sur La Mer studio, 423 Shoreline Village Drive, Suite CD, Long Beach","source":"https://www.mslmorchestra.com/audition/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Four major concerts per season (late August–May) plus community performances; school music program participation (where available) and private lessons required for youth members","source":"https://www.mslmorchestra.com/audition/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.mslmorchestra.com/audition/","asOf":"2026-07-06"}'::jsonb, '{"status":"unverified"}'::jsonb,
  'Good fit if your Long Beach-area player wants a smaller, studio-based program with big travel ambitions, from first orchestra experience to international touring.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mslm-yo', 0, 'La Petite Musique Training Orchestra', 'Beginner', '{7,15}'::int[], 'Entry ensemble for string players (grades 3–8) with about two years of lessons; no audition — seating assessments happen in the first two weeks of class.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mslm-yo', 1, 'Shoreline Strings', 'Intermediate', '{10,14}'::int[], 'Auditioned ensemble for strings, piano and percussion, grades 5–9, requiring developed vibrato and two-octave scales.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mslm-yo', 2, 'Musique Sur La Mer Youth Symphony Orchestra', 'Advanced', '{12,18}'::int[], 'Advanced full orchestra (strings including harp, woodwinds, brass, piano and percussion) for ages 12–18, grades 7–12; performs locally and on international tours.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mslm-yo', 3, 'Musique Sur La Mer Youth Honors Chamber Orchestra', 'Advanced', '{12,17}'::int[], 'Invitation-only chamber orchestra for advanced strings, woodwinds and piano concurrently enrolled in the Youth Symphony.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mslm-yo', 4, 'Long Beach Offshore Winds Ensemble', 'Advanced', '{11,17}'::int[], 'Auditioned wind ensemble for advanced woodwinds, brass and percussion (grades 6–12 per the program page) performing symphonic band, jazz and chamber music; concurrent Youth Symphony membership required.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mslm-yo', 5, 'Long Beach Youth Mariachis — Musica de la Playa', 'Intermediate', '{7,18}'::int[], 'Open-enrollment mariachi ensemble for elementary through high school musicians with two years of lessons; no audition required.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('mslm-yo', 0, 'Advanced', 'Strings, woodwinds, brass, percussion, piano, harp (Youth Symphony Orchestra and Honors Chamber Orchestra)', '{"status":"unverified"}'::jsonb, 'rolling', '{12,18}'::int[], 'Auditions are by scheduled appointment at the MSLM studio; the posted FAQ dates are from a prior season, so contact the office for the current schedule.', 'https://www.mslmorchestra.com/audition/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('mslm-yo', 1, 'Beginner', 'Strings (La Petite Musique Training Orchestra)', '{"status":"verified","value":"No audition — seating assessments during the first two weeks of class","source":"https://www.mslmorchestra.com/youth-community/","asOf":"2026-07-06"}'::jsonb, 'rolling', '{7,15}'::int[], 'No audition required; individual seating placement assessments take place during the first two weeks of class.', 'https://www.mslmorchestra.com/youth-community/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('mslm-yo', 0, 'https://www.mslmorchestra.com/youth-community/', 'Youth Programs (ensembles, financial aid and 2025–26 registration packet)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('mslm-yo', 1, 'https://www.mslmorchestra.com/audition/', 'Audition, eligibility and FAQ (scholarships, season, rehearsal location)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('mslm-yo', 2, 'https://www.mslmorchestra.com/events/', 'Events calendar (Costa Rica concert tour, June 21–29, 2026)', '2026-07-06'::date);

-- pacsym — Pacific Symphony
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'pacsym', 'Pacific Symphony', 'professional', 33.6889, -117.8859, 'Costa Mesa', 'Orange County',
  'https://www.pacificsymphony.org/', 'https://www.pacificsymphony.org/orchestra-auditions', 'Orange County''s resident professional orchestra performs classical, pops, family, and summer series at the Renée and Henry Segerstrom Concert Hall in Costa Mesa and Great Park Live in Irvine, with Artistic and Music Director Designate Alexander Shelley taking the podium.',
  '{"status":"verified","value":"2026–27 season (concerts listed September 2026 through June 2027)","source":"https://www.pacificsymphony.org/get-tickets","asOf":"2026-07-06"}'::jsonb, '{18,99}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'Good fit if you want to hear a professional orchestra close to home — or show your teen where serious training can lead.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('pacsym', 0, 'Pacific Symphony', 'Professional', '{18,99}'::int[], 'The professional orchestra, performing classical, pops, family, and summer outdoor series across Orange County.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('pacsym', 0, '2026-08-15'::date, 'Symphony in the Cities: Irvine', NULL, NULL, '{"status":"verified","value":0,"source":"https://www.pacificsymphony.org/get-tickets","asOf":"2026-07-06"}'::jsonb, 'https://www.pacificsymphony.org/get-tickets');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('pacsym', 1, '2026-09-24'::date, 'Violin Virtuoso Joshua Bell & Alexander Shelley', 'Renée and Henry Segerstrom Concert Hall', NULL, '{"status":"unverified"}'::jsonb, 'https://www.pacificsymphony.org/get-tickets');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('pacsym', 2, '2026-10-01'::date, 'Shelley Conducts Mahler 2: Resurrection', 'Renée and Henry Segerstrom Concert Hall', NULL, '{"status":"unverified"}'::jsonb, 'https://www.pacificsymphony.org/get-tickets');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('pacsym', 0, 'Professional', 'Section Violin (3 positions)', '{"status":"verified","value":"Application deadline September 4, 2026; live auditions September 25–26, 2026","source":"https://www.pacificsymphony.org/orchestra-auditions","asOf":"2026-07-06"}'::jsonb, 'open', '{18,99}'::int[], 'Online application plus $100 refundable deposit check mailed to the Irvine office.', 'https://www.pacificsymphony.org/orchestra-auditions');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('pacsym', 1, 'Professional', 'Principal Clarinet', '{"status":"verified","value":"Application deadline September 7, 2026; live auditions September 28–29, 2026","source":"https://www.pacificsymphony.org/orchestra-auditions","asOf":"2026-07-06"}'::jsonb, 'open', '{18,99}'::int[], NULL, 'https://www.pacificsymphony.org/orchestra-auditions');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('pacsym', 2, 'Professional', 'Principal Harp', '{"status":"verified","value":"Application deadline October 5, 2026; live auditions October 19–20, 2026","source":"https://www.pacificsymphony.org/orchestra-auditions","asOf":"2026-07-06"}'::jsonb, 'open', '{18,99}'::int[], 'Excerpt list marked ''coming soon'' on the auditions page.', 'https://www.pacificsymphony.org/orchestra-auditions');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('pacsym', 0, 'https://www.pacificsymphony.org/get-tickets', 'Concert calendar (2026–27 listings)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('pacsym', 1, 'https://www.pacificsymphony.org/orchestra-auditions', 'Orchestra auditions', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('pacsym', 2, 'https://www.pacificsymphony.org/psye', 'PSYE page (leadership, venues, org context)', '2026-07-06'::date);

-- psye — Pacific Symphony Youth Ensembles
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'psye', 'Pacific Symphony Youth Ensembles', 'youth', 33.6405, -117.8443, 'Irvine (UC Irvine)', 'Orange County',
  'https://www.pacificsymphony.org/psye', 'https://www.pacificsymphony.org/auditions', 'Pacific Symphony''s pre-professional training program for musicians in grades 6–12, with four ensembles that rehearse weekly at UC Irvine, receive coaching from Pacific Symphony musicians, and perform free concerts at the Renée and Henry Segerstrom Concert Hall.',
  '{"status":"verified","value":"2026–27","source":"https://www.pacificsymphony.org/auditions","asOf":"2026-07-06"}'::jsonb, '{10,18}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"verified","value":"Weekly, September through May, at UC Irvine: Youth Wind Ensemble & Youth Orchestra Sundays 1–4 PM; Youth Concert Band & Santiago Strings Sundays 5–7 PM","source":"https://www.pacificsymphony.org/psye-general-program-information","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Members must actively participate in their school music program and study with a private teacher for the duration of the season; all members re-audition each year","source":"https://www.pacificsymphony.org/auditions","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.pacificsymphony.org/psye-general-program-information","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"$1,250 per season (Santiago Strings, Youth Concert Band); $1,500 per season (Youth Orchestra, Youth Wind Ensemble)","source":"https://www.pacificsymphony.org/psye-general-program-information","asOf":"2026-07-06"}'::jsonb,
  'Good fit if your grade 6–12 musician wants conservatory-style training, coaching from professional players, and the chance to perform in a world-class hall.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('psye', 0, 'Pacific Symphony Santiago Strings', 'Intermediate', '{10,15}'::int[], 'String orchestra for grades 6–9 (age 10+), led by Dr. Johanna Gamboa-Kroesen; violin, viola, cello, and double bass.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('psye', 1, 'Pacific Symphony Youth Concert Band', 'Intermediate', '{10,15}'::int[], 'Concert band for woodwind, brass, and percussion players in grades 6–9 (age 10+), led by Angela Woo.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('psye', 2, 'Pacific Symphony Youth Wind Ensemble', 'Advanced', '{13,18}'::int[], 'Wind symphony for woodwind, brass, and percussion players in grades 9–12 (age 13+), led by Dr. Gregory X. Whitmore.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('psye', 3, 'Pacific Symphony Youth Orchestra', 'Pre-professional', '{13,18}'::int[], 'Full symphony orchestra of 100+ string, wind, and percussion players in grades 9–12 (age 13+), led by Pacific Symphony Assistant Conductor Pola Benke.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('psye', 0, 'Intermediate', 'Strings (Santiago Strings); winds, brass, percussion (Youth Concert Band)', '{"status":"verified","value":"Held each spring for the following season; application generally available early March through early May (2026–27 applications closed May 1, 2026)","source":"https://www.pacificsymphony.org/psye-frequently-asked-questions","asOf":"2026-07-06"}'::jsonb, 'upcoming', '{10,15}'::int[], 'Video audition via Acceptd; $45 non-refundable fee (fee waivers available through Acceptd).', 'https://www.pacificsymphony.org/auditions');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('psye', 1, 'Advanced', 'Strings, winds, brass, percussion, harp, piano (Youth Orchestra); winds, brass, percussion, harp, piano (Youth Wind Ensemble)', '{"status":"verified","value":"Held each spring for the following season; application generally available early March through early May (2026–27 applications closed May 1, 2026)","source":"https://www.pacificsymphony.org/psye-frequently-asked-questions","asOf":"2026-07-06"}'::jsonb, 'upcoming', '{13,18}'::int[], 'All members re-audition annually; grade and age eligibility measured as of September 1 of the season year.', 'https://www.pacificsymphony.org/auditions');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('psye', 0, 'https://www.pacificsymphony.org/psye', 'PSYE overview and ensemble structure', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('psye', 1, 'https://www.pacificsymphony.org/auditions', 'PSYE auditions and eligibility', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('psye', 2, 'https://www.pacificsymphony.org/psye-general-program-information', 'PSYE general info (rehearsals, tuition, aid)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('psye', 3, 'https://www.pacificsymphony.org/psye-frequently-asked-questions', 'PSYE audition FAQs', '2026-07-06'::date);

-- ocys — Orange County Youth Symphony and String Ensemble
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'ocys', 'Orange County Youth Symphony and String Ensemble', 'youth', 33.6875, -117.791, 'Irvine', 'Orange County',
  'https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony', 'https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information', 'Founded in 1970 and run by the Philharmonic Society of Orange County, the county''s official youth orchestra pairs an advanced full symphony (OCYS) with an intermediate string ensemble (OCYSE), rehearsing Sunday afternoons at Irvine Valley College and performing in halls like the Segerstrom Concert Hall and Soka Performing Arts Center.',
  '{"status":"verified","value":"2026–27 season runs late August 2026 through mid-May 2027","source":"https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information","asOf":"2026-07-06"}'::jsonb, '{11,19}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"verified","value":"Sunday afternoons, 1:00–3:30 PM, Irvine Valley College Music & Dance Building","source":"https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Active participation in your school music program is expected (verified with teachers each semester); three major concerts per season, with OCYS adding winter community concerts and a fall retreat","source":"https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"2026–27: OCYS $1,500; OCYSE $1,300","source":"https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information","asOf":"2026-07-06"}'::jsonb,
  'Good fit if your advanced high schooler wants a full-orchestra challenge with retreats and a concerto competition, or your middle schooler is ready for a step up in strings.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('ocys', 0, 'Orange County Youth Symphony (OCYS)', 'Advanced', '{14,19}'::int[], 'Full orchestra for advanced woodwind, brass, string, and percussion musicians in grades 9–13, led by Music Director Johannes Müller Stosch.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('ocys', 1, 'Orange County Youth String Ensemble (OCYSE)', 'Intermediate', '{11,15}'::int[], 'String ensemble for intermediate string players in grades 6–9, led by Conductor Lucy Lu, with sectionals and a chamber group program.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('ocys', 0, 'Advanced', 'OCYS: violin, viola, cello, double bass, flute/piccolo, oboe/English horn, clarinet/bass clarinet, bassoon, French horn, trumpet, trombone, bass trombone, euphonium and tuba, percussion; harp and piano as needed', '{"status":"unverified"}'::jsonb, 'upcoming', '{14,19}'::int[], '2026–27 season auditions (opened March 1, 2026) closed May 13, 2026 with no extensions; $40 fee and video audition; next cycle not yet announced.', 'https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('ocys', 1, 'Intermediate', 'OCYSE: strings only (violin, viola, cello, double bass)', '{"status":"unverified"}'::jsonb, 'upcoming', '{11,15}'::int[], '2026–27 auditions closed May 13, 2026; in-person OCYSE callbacks planned for late August 2026 per the official page; next cycle not yet announced.', 'https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ocys', 0, 'https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony', 'OCYS/E program home (Philharmonic Society)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ocys', 1, 'https://www.philharmonicsociety.org/education-community/orange-county-youth-symphony/audition-information', 'OCYS/E audition information, tuition, schedule FAQ', '2026-07-06'::date);

-- scyso — South Coast Youth Symphony Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'scyso', 'South Coast Youth Symphony Orchestra', 'youth', 33.5985, -117.66, 'Mission Viejo', 'Orange County',
  'https://www.scysomusic.org/', 'https://www.scysomusic.org/registration-audition', 'A registration-based youth orchestra founded in 2001 that welcomes players of all abilities, with a choice of weekly rehearsal sites in Mission Viejo, Garden Grove, and Ontario, monthly combined workshops, and a history of international touring — including a Carnegie Hall invitational tour planned for summer 2027.',
  '{"status":"verified","value":"2026–2027 season","source":"https://www.scysomusic.org/","asOf":"2026-07-06"}'::jsonb, '{8,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Weekly by location: Ontario Mondays 5–7 PM; Garden Grove Tuesdays 7–9 PM; Mission Viejo Wednesdays 7–9 PM; plus Saturday combined workshops at La Paz Intermediate School, Mission Viejo","source":"https://www.scysomusic.org/season-schedule-fall","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Previous training on your instrument and enrollment in your school instrumental music program (if available) are required; registration includes a season obligation and commitment form","source":"https://www.scysomusic.org/registration-audition","asOf":"2026-07-06"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb,
  'Good fit if you want a welcoming orchestra that takes all ability levels and lets you pick the rehearsal night and location that suits your family.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('scyso', 0, 'South Coast Youth Symphony Orchestra', 'Intermediate', '{8,18}'::int[], 'One orchestra program open to musicians of all abilities, rehearsing at three sites (Mission Viejo, Garden Grove, Ontario) that combine monthly for workshops and perform together.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('scyso', 0, '2026-12-13'::date, 'Season Opening Concert', NULL, NULL, '{"status":"unverified"}'::jsonb, 'https://www.scysomusic.org/season-schedule-fall');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('scyso', 0, 'Beginner', 'Strings, woodwinds, brass, percussion', '{"status":"verified","value":"Registration for the 2026–27 season is open; registration and seating-placement audition videos accepted beginning May 25, 2026","source":"https://www.scysomusic.org/registration-audition","asOf":"2026-07-06"}'::jsonb, 'open', '{8,18}'::int[], 'Open to all abilities — the video audition is for seating placement only, and you can register before receiving audition results. Late/mid-season joining by phone or email.', 'https://www.scysomusic.org/registration-audition');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('scyso', 0, 'https://www.scysomusic.org/', 'SCYSO home (2026–2027 season, about)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('scyso', 1, 'https://www.scysomusic.org/registration-audition', 'Registration & audition', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('scyso', 2, 'https://www.scysomusic.org/season-schedule-fall', 'Fall 2026 schedule (rehearsal sites/times, opening concert)', '2026-07-06'::date);

-- cyosc — Community Youth Orchestra of Southern California
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'cyosc', 'Community Youth Orchestra of Southern California', 'youth', 33.6846, -117.8265, 'Irvine/Tustin', 'Orange County',
  'https://www.cyosc.org/', 'https://www.cyosc.org/apply.html', 'A nonprofit founded in 1990 that serves students of all ages and ability levels — preschool through college — placing them by audition into one of four ensembles, with Friday evening rehearsals in the Irvine/Tustin area, three concerts a season, and economical tuition.',
  '{"status":"verified","value":"2026–2027 season; rehearsals begin September 11, 2026","source":"https://www.cyosc.org/apply.html","asOf":"2026-07-06"}'::jsonb, '{4,22}'::int[], '{"Strings","Winds","Brass","Harp"}'::public.instrument[],
  '{"status":"verified","value":"Once a week on Friday evenings, one to two hours depending on ensemble; 2026–27 rehearsal space not yet confirmed but will be in the Irvine/Tustin area","source":"https://www.cyosc.org/faqs.html","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Signed attendance and behavior contract; students who miss more than 5 rehearsals during the season cannot play concerts and risk removal from their ensemble","source":"https://www.cyosc.org/apply.html","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.cyosc.org/faqs.html","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"2026–27: $875 per student ($850 if paying by check/Zelle); 10% sibling discount; 20% discount for qualifying viola and brass students","source":"https://www.cyosc.org/faqs.html","asOf":"2026-07-06"}'::jsonb,
  'Good fit if you want an affordable, community-minded orchestra home for a beginner through advanced player of almost any age.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('cyosc', 0, 'Sinfonietta', 'Beginner', '{5,11}'::int[], 'Entry ensemble; students are placed by teachers based on age group and playing level.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('cyosc', 1, 'Philharmonia', 'Intermediate', '{8,14}'::int[], 'Intermediate ensemble (described as the String Ensemble in program text).');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('cyosc', 2, 'Symphony Orchestra', 'Advanced', '{12,18}'::int[], 'The organization''s top full-orchestra ensemble.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('cyosc', 3, 'Solisti', 'Advanced', '{12,22}'::int[], 'The newest ensemble in the four-ensemble lineup.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('cyosc', 0, 'Beginner', 'Orchestral strings, winds, and brass per the audition guide; harp listed among accepted instruments', '{"status":"verified","value":"2026–27 sign-ups open now; prescreening video due by August 16, 2026; in-person auditions August 25–28, 2026; results emailed the first week of September","source":"https://www.cyosc.org/apply.html","asOf":"2026-07-06"}'::jsonb, 'open', '{4,22}'::int[], 'All ability levels accepted; the audition assigns students to the ensemble matching their age and level. $40 audition fee; all students including returners re-audition. Late joiners sometimes accommodated mid-season.', 'https://www.cyosc.org/apply.html');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('cyosc', 0, 'https://www.cyosc.org/', 'CYOSC home (2026–27 sign-ups, summer camp, audition dates)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('cyosc', 1, 'https://www.cyosc.org/programs.html', 'Programs (four ensembles)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('cyosc', 2, 'https://www.cyosc.org/apply.html', 'Apply / audition steps (2026–27)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('cyosc', 3, 'https://www.cyosc.org/faqs.html', 'FAQs (rehearsals, tuition, financial aid)', '2026-07-06'::date);

-- sdsym — San Diego Symphony
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'sdsym', 'San Diego Symphony', 'professional', 32.7178, -117.1583, 'Downtown San Diego', 'San Diego County',
  'https://www.sandiegosymphony.org/', 'https://www.sandiegosymphony.org/about/san-diego-symphony-orchestra/auditions-san-diego-symphony/', 'San Diego''s professional orchestra under music director Rafael Payare, performing downtown at the Jacobs Music Center and outdoors at The Rady Shell at Jacobs Park.',
  '{"status":"verified","value":"2026–27 season at Jacobs Music Center, plus a summer season at The Rady Shell at Jacobs Park","source":"https://www.sandiegosymphony.org/","asOf":"2026-07-06"}'::jsonb, '{18,99}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"verified","value":"Full-time professional: 42-week contract (37 playing weeks plus 5 vacation weeks) for the 2026–27 season","source":"https://www.sandiegosymphony.org/about/san-diego-symphony-orchestra/auditions-san-diego-symphony/","asOf":"2026-07-06"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'Good fit if you want to take the family to hear professionals live — this is a professional orchestra, not an enrollment program for kids.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdsym', 0, 'San Diego Symphony Orchestra', 'Professional', '{18,99}'::int[], 'Full-time professional symphony orchestra performing at the Jacobs Music Center and The Rady Shell at Jacobs Park.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('sdsym', 0, '2026-07-12'::date, 'Beethoven by the Bay', 'The Rady Shell at Jacobs Park', NULL, '{"status":"unverified"}'::jsonb, 'https://www.sandiegosymphony.org/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('sdsym', 1, '2026-07-17'::date, 'Distant Worlds: music from FINAL FANTASY', 'The Rady Shell at Jacobs Park', NULL, '{"status":"unverified"}'::jsonb, 'https://www.sandiegosymphony.org/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('sdsym', 2, '2026-07-31'::date, 'The Music of John Williams', 'The Rady Shell at Jacobs Park', NULL, '{"status":"unverified"}'::jsonb, 'https://www.sandiegosymphony.org/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('sdsym', 0, 'Professional', 'Second Horn', '{"status":"verified","value":"Applications due August 28, 2026; auditions October 5–6, 2026","source":"https://www.sandiegosymphony.org/about/san-diego-symphony-orchestra/auditions-san-diego-symphony/","asOf":"2026-07-06"}'::jsonb, 'open', '{18,99}'::int[], 'Employment intended to begin no later than January 2027; refundable audition deposit required.', 'https://www.sandiegosymphony.org/about/san-diego-symphony-orchestra/auditions-san-diego-symphony/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('sdsym', 1, 'Professional', 'Section Violin', '{"status":"verified","value":"Applications due October 2, 2026; auditions November 7–9, 2026","source":"https://www.sandiegosymphony.org/about/san-diego-symphony-orchestra/auditions-san-diego-symphony/","asOf":"2026-07-06"}'::jsonb, 'open', '{18,99}'::int[], 'Full repertoire list to be posted; all candidates with completed applications receive an audition time.', 'https://www.sandiegosymphony.org/about/san-diego-symphony-orchestra/auditions-san-diego-symphony/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sdsym', 0, 'https://www.sandiegosymphony.org/', 'San Diego Symphony home (2026–27 season nav + July 2026 concert listings)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sdsym', 1, 'https://www.sandiegosymphony.org/about/san-diego-symphony-orchestra/auditions-san-diego-symphony/', 'Auditions — San Diego Symphony Orchestra (vacancies, CBA terms)', '2026-07-06'::date);

-- sdys — San Diego Youth Symphony and Conservatory
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'sdys', 'San Diego Youth Symphony and Conservatory', 'youth', 32.7316, -117.1476, 'Balboa Park, San Diego', 'San Diego County',
  'https://www.keynote-music.org/sdys/', 'https://www.keynote-music.org/sdys/how-to-join/', 'Founded in 1945 and based in Balboa Park, SDYS runs 13+ orchestras and wind ensembles with a clear ladder from first-time beginners to an advanced Symphony Orchestra, and tuition assistance for families who need it.',
  '{"status":"verified","value":"2026–27 season; new-student registration re-opens July 6 and ends July 30, 2026, with auditions closing July 31, 2026","source":"https://www.keynote-music.org/sdys/how-to-join/","asOf":"2026-07-06"}'::jsonb, '{7,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Weekly weekend rehearsals by ensemble — Saturdays or Sundays at Balboa Park or Liberty Station (e.g. Symphony Orchestra: Sundays 3:30–6:30 PM)","source":"https://www.keynote-music.org/sdys/who-we-are/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Full-season commitment: all students, including marching band students, join in the fall — no mid-year entry","source":"https://www.keynote-music.org/sdys/how-to-join/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.keynote-music.org/sdys/how-to-join/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"$900–$1,450 per season depending on ensemble (Beginning ensembles $900; Symphony Orchestra $1,450)","source":"https://www.keynote-music.org/sdys/who-we-are/","asOf":"2026-07-06"}'::jsonb,
  'Good fit if you want a large, structured program where any level from age 7 to 18 can find a seat and move up year by year.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdys', 0, 'Beginning Strings / Winds / Brass / Percussion', 'Beginner', '{7,11}'::int[], 'No-experience-required entry ensembles at Liberty Station; no audition needed.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdys', 1, 'Debut Strings & Debut Winds', 'Beginner', '{7,13}'::int[], 'First performing ensembles for students with a little experience, rehearsing in Balboa Park.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdys', 2, 'Overture Strings & Overture Winds', 'Intermediate', '{8,15}'::int[], 'Late-beginner ensembles building technical and collaborative skills.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdys', 3, 'Symphonic Strings', 'Intermediate', '{8,15}'::int[], 'Early-intermediate string orchestra.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdys', 4, 'Concert Strings, Concert Winds & Philharmonia', 'Intermediate', '{10,18}'::int[], 'Early-to-late-intermediate orchestras and winds for grades 5–12.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdys', 5, 'Sinfonia & Wind Symphony', 'Advanced', '{12,18}'::int[], 'Late-intermediate full orchestra and wind symphony for grades 7–12.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdys', 6, 'Symphony Orchestra', 'Pre-professional', '{14,18}'::int[], 'Flagship advanced orchestra (grades 9–12) playing professional-level repertoire under Artistic Director Sameer Patel.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('sdys', 0, 'Intermediate', 'Select instruments: viola, double bass, bass clarinet, bassoon, saxophones, horn, trumpet, trombone, bass trombone, euphonium, tuba, percussion', '{"status":"verified","value":"Register July 6–30, 2026 ($50 non-refundable fee); video auditions due July 31, 2026","source":"https://www.keynote-music.org/sdys/how-to-join/","asOf":"2026-07-06"}'::jsonb, 'open', '{7,18}'::int[], 'One audition places students across all ensembles; percussion auditions in person Thursday, August 13; results emailed around the first two weeks of August.', 'https://www.keynote-music.org/sdys/how-to-join/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('sdys', 1, 'Beginner', 'Beginning Strings, Woodwinds, Brass, Percussion', '{"status":"verified","value":"Registration open through July 31, 2026","source":"https://www.keynote-music.org/sdys/how-to-join/","asOf":"2026-07-06"}'::jsonb, 'open', '{7,11}'::int[], 'No audition required for beginning ensembles — register and pay the registration fee.', 'https://www.keynote-music.org/sdys/how-to-join/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sdys', 0, 'https://www.keynote-music.org/sdys/how-to-join/', 'How To Join (2026–27 registration/audition deadlines, tuition assistance, FAQ)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sdys', 1, 'https://www.keynote-music.org/sdys/who-we-are/', 'Who We Are (13+ ensembles with ages, tuition, rehearsal times)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sdys', 2, 'https://sdys.org/', 'Legacy SDYS site (founded 1945, 6th oldest US youth symphony; page content stale)', '2026-07-06'::date);

-- sdcyo — San Diego Civic Youth Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'sdcyo', 'San Diego Civic Youth Orchestra', 'youth', 33.132, -117.086, 'Escondido (North County)', 'San Diego County',
  'https://www.civicyouthorchestra.org/', 'https://www.civicyouthorchestra.org/audition-information', 'Seven graded Saturday-morning ensembles in Escondido, from a first-time Prelude Orchestra up to a full Symphony Orchestra that performs at the California Center for the Arts, Escondido.',
  '{"status":"verified","value":"2026–27 performance season; tuition and registration due July 31, 2026","source":"https://www.civicyouthorchestra.org/tuition-and-registration","asOf":"2026-07-06"}'::jsonb, '{5,22}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Saturdays 9:00 AM–noon (Prelude 9–11 AM) at Classical Academy High School — PLC, 130 Woodward Avenue, Escondido","source":"https://www.civicyouthorchestra.org/tuition-and-registration","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Weekly Saturday rehearsals with roughly 3–4 performances per season; summer workshop required for Prelude–Wind ensembles and Labor Day retreat required for Symphonic and Symphony members","source":"https://www.civicyouthorchestra.org/our-ensembles","asOf":"2026-07-06"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"verified","value":"$725–$975 per season by ensemble (Prelude $725; Symphony Orchestra $975); $85 registration fee included; due July 31, 2026","source":"https://www.civicyouthorchestra.org/tuition-and-registration","asOf":"2026-07-06"}'::jsonb,
  'Good fit for North County families who want affordable Saturday-morning training with room to grow into a full symphony.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdcyo', 0, 'Prelude Orchestra', 'Beginner', '{7,11}'::int[], 'First ensemble experience for string players with about a year of playing; weekly 2-hour rehearsals and three performances per season.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdcyo', 1, 'Intermezzo Orchestra', 'Beginner', '{8,13}'::int[], 'String orchestra reinforcing fundamentals for players with 2+ years of experience.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdcyo', 2, 'Intermediate Orchestra', 'Intermediate', '{10,15}'::int[], 'String orchestra for players with 3+ years of experience exploring transcriptions of larger works.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdcyo', 3, 'Chamber Orchestra', 'Advanced', '{11,17}'::int[], 'Advanced students drawn from the Intermediate Orchestra tackling higher-level string repertoire.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdcyo', 4, 'Wind Ensemble', 'Intermediate', '{11,18}'::int[], 'Woodwind, brass and percussion ensemble, primarily middle and high school students.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdcyo', 5, 'Symphonic Orchestra', 'Advanced', '{13,18}'::int[], 'Full orchestra, primarily high school students; performs at least four times per season; Labor Day retreat required.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sdcyo', 6, 'Symphony Orchestra', 'Advanced', '{14,22}'::int[], 'Flagship full symphony playing original literature (Beethoven, Brahms, Shostakovich); advanced high schoolers plus some college students; performs at the California Center for the Arts, Escondido.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('sdcyo', 0, 'Intermediate', 'All orchestral instruments — placement across all seven ensembles', '{"status":"verified","value":"July 18, 2026 is the last audition for the 2026–27 season","source":"https://www.civicyouthorchestra.org/","asOf":"2026-07-06"}'::jsonb, 'open', '{5,22}'::int[], 'Open to new students and current students moving up; placement determined by audition in spring and summer.', 'https://www.civicyouthorchestra.org/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sdcyo', 0, 'https://www.civicyouthorchestra.org/', 'CYO home (ages 5–22, July 18 audition, Escondido rehearsal location)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sdcyo', 1, 'https://www.civicyouthorchestra.org/tuition-and-registration', '2026–27 Tuition & Registration (tuition table, deadlines)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sdcyo', 2, 'https://www.civicyouthorchestra.org/our-ensembles', 'Our Ensembles (7 graded ensembles, requirements)', '2026-07-06'::date);

-- mmyo — Mainly Mozart Youth Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'mmyo', 'Mainly Mozart Youth Orchestra', 'youth', 32.9808, -117.2617, 'Solana Beach', 'San Diego County',
  'https://www.mmyo.org/', 'https://www.mmyo.org/summer-auditions', 'Mainly Mozart''s youth program rehearses Saturdays in Solana Beach, with ensembles from entry-level strings to an advanced full orchestra and the chance to work alongside the festival''s professional All-Star players.',
  '{"status":"verified","value":"Season typically runs September through May; 2026/27 summer auditions open July 1–31, 2026","source":"https://www.mmyo.org/faq","asOf":"2026-07-06"}'::jsonb, '{5,18}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"verified","value":"Saturdays at Calvary Lutheran Church, Solana Beach; times by ensemble (Suzuki Stars 8:30–9:15 AM through Advanced Orchestra 9:30 AM–12:30 PM)","source":"https://www.mmyo.org/faq","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Weekly Saturday rehearsals, at least two concerts per season; max 4 excused / 2 unexcused absences per semester; private lessons required above the Suzuki Stars level","source":"https://www.mmyo.org/faq","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.mmyo.org/faq","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"$725–$900 per student per season, depending on ensemble placement","source":"https://www.mmyo.org/faq","asOf":"2026-07-06"}'::jsonb,
  'Good fit for coastal North County families — one Saturday location, a beginner-friendly entry point, and professional musicians in the room.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mmyo', 0, 'Amadeus Strings (Suzuki Stars / Mozart Comets)', 'Beginner', '{5,10}'::int[], 'Entry-level strings for students with little or no prior experience; no audition to start.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mmyo', 1, 'Prelude Strings', 'Beginner', '{7,12}'::int[], 'Early string orchestra (violin, viola, cello, double bass).');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mmyo', 2, 'Intermediate Strings', 'Intermediate', '{9,14}'::int[], 'String orchestra for developing players.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mmyo', 3, 'Concert Band', 'Intermediate', '{10,16}'::int[], 'Full wind, brass and percussion band; winds/brass/percussion in Intermediate Orchestra also play here.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mmyo', 4, 'Intermediate Orchestra', 'Intermediate', '{10,16}'::int[], 'Full orchestra including winds, brass, percussion, harp and strings.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('mmyo', 5, 'Advanced Orchestra', 'Advanced', '{13,18}'::int[], 'Top full orchestra, rehearsing Saturday mornings; performs alongside Mainly Mozart events.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('mmyo', 0, 'Intermediate', 'Openings by ensemble: Prelude Strings (all strings), Intermediate Strings (viola, bass), Concert Band (all instruments), Intermediate Orchestra (viola, bass, winds, brass, percussion), Advanced Orchestra (bass, horn, trombone, percussion)', '{"status":"verified","value":"Summer auditions for the 2026/27 season open July 1–31, 2026 (deadline Friday, July 31, 2026)","source":"https://www.mmyo.org/summer-auditions","asOf":"2026-07-06"}'::jsonb, 'open', '{7,18}'::int[], 'All placement auditions by online video submission.', 'https://www.mmyo.org/summer-auditions');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('mmyo', 1, 'Beginner', 'Beginner violin (entry-level Amadeus Strings)', '{"status":"unverified"}'::jsonb, 'open', '{5,10}'::int[], '2026/27 beginner enrollment is live on the site; no audition required for the entry-level ensemble.', 'https://www.mmyo.org/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('mmyo', 0, 'https://www.mmyo.org/', 'MMYO home (2026/27 auditions open July 1–31; ensembles and openings)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('mmyo', 1, 'https://www.mmyo.org/faq', 'FAQ (tuition, financial aid, rehearsal times, season, expectations)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('mmyo', 2, 'https://www.mmyo.org/who-we-are', 'Who We Are (history since 1995, ensembles and instruments incl. harp)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('mmyo', 3, 'https://www.mmyo.org/summer-auditions', '2026/2027 Summer Auditions (deadline July 31, 2026; per-instrument requirements)', '2026-07-06'::date);

-- ecys — East County Youth Symphony
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'ecys', 'East County Youth Symphony', 'youth', 32.726, -117.01, 'Spring Valley / El Cajon (East County)', 'San Diego County',
  'https://ecysymphony.com/', 'https://www.ecysymphony.com/auditions.php', 'A tuition-free East County program where young beginners start in the Pre-Orchestra Division and advanced players join a stipend-supported pre-professional orchestra, with two big concerts a year at the Joan B. Kroc Theatre.',
  '{"status":"verified","value":"Spring term January–May and fall term August–December (Pre-Orchestra Division)","source":"https://www.ecysymphony.com/podiv.php","asOf":"2026-07-06"}'::jsonb, '{6,28}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Advanced Division: Fridays 6:00–8:50 PM at 7997 Paradise Valley Road, San Diego; Pre-Orchestra Division: Saturdays, one hour between 8:00 AM–12:30 PM at 2300 Bancroft Drive (Spring Valley)","source":"https://www.ecysymphony.com/auditions.php","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"All students perform twice a year at the Joan B. Kroc Theatre, plus weekly rehearsals","source":"https://www.ecysymphony.com/events.php","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.ecysymphony.com/adivi.php","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Free — tuition-free participation is the organization''s mission","source":"https://ecysymphony.com/","asOf":"2026-07-06"}'::jsonb,
  'Good fit if cost is a barrier — everything is tuition-free, from a child''s first ensemble classes to the advanced orchestra.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('ecys', 0, 'Pre-Orchestra Division', 'Beginner', '{6,14}'::int[], 'Tuition-free six-year training program: first-year classes (ages 6–10, open to all beginners) cover violin, small ensemble, piano and theory; continuing classes (ages 8–14) by audition.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('ecys', 1, 'Advanced Orchestra', 'Pre-professional', '{16,28}'::int[], 'Pre-professional orchestra for advanced players, many pursuing college music degrees; by audition or invitation; each player receives a $100–$500 stipend per semester.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('ecys', 0, '2026-11-18'::date, 'Fall 2026 Showcase — world premiere of Vonn Vanier''s ''Symphonic Suite''', 'Joan B. Kroc Theater, 6611 University Ave, San Diego', 'Pre-Orchestra Division Fall 2026 Showcase; Advanced Orchestra world premiere of Vonn Vanier''s Symphonic Suite, dedicated to the 250th anniversary of the USA', '{"status":"unverified"}'::jsonb, 'https://www.ecysymphony.com/events.php');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('ecys', 0, 'Beginner', 'Pre-Orchestra Division (strings focus); beginners are interviewed in groups — no instrument playing required', '{"status":"verified","value":"Applications accepted year-round; term deadlines September 10 (fall) and February 10 (spring)","source":"https://www.ecysymphony.com/podiv.php","asOf":"2026-07-06"}'::jsonb, 'rolling', '{6,14}'::int[], 'Age determined as of September 1 (fall term) or February 1 (spring term); in-person in Spring Valley or online via Zoom/Skype.', 'https://www.ecysymphony.com/auditions.php');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('ecys', 1, 'Pre-professional', 'All orchestral instruments (Advanced Orchestra)', '{"status":"verified","value":"New students accepted all year round","source":"https://www.ecysymphony.com/auditions.php","asOf":"2026-07-06"}'::jsonb, 'rolling', '{16,28}'::int[], 'By audition or invitation; 10 minutes of contrasting repertoire plus possible sight-reading; results usually same day (up to 3 weeks for competitive seats).', 'https://www.ecysymphony.com/auditions.php');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ecys', 0, 'https://ecysymphony.com/', 'ECYS home (tuition-free mission, founded 2007)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ecys', 1, 'https://www.ecysymphony.com/events.php', 'Events (May 13 and November 18, 2026 concerts at Kroc Theater; venues)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ecys', 2, 'https://www.ecysymphony.com/auditions.php', 'Auditions (year-round intake, locations, rehearsal schedule)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ecys', 3, 'https://www.ecysymphony.com/podiv.php', 'Pre-Orchestra Division (ages 6–10 / 8–14, term calendar)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('ecys', 4, 'https://www.ecysymphony.com/adivi.php', 'Advanced Division (ages 16–28, stipends, Friday rehearsals)', '2026-07-06'::date);

-- newwest — New West Symphony
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'newwest', 'New West Symphony', 'professional', 34.1772, -118.8235, 'Thousand Oaks', 'Ventura County',
  'https://newwestsymphony.org/', 'https://newwestsymphony.org/about/careers-auditions/', 'Ventura County''s professional orchestra, led by artistic and music director Michael Christie, performing its Masterpiece Series in Thousand Oaks (BAPAC) and Camarillo (RCPAC). Its education wing runs student concerts, a traveling Music Van, and the tuition-free Laby Harmony Project in Ventura.',
  '{"status":"verified","value":"2026 Masterpiece Series (calendar-year 2026 season celebrating the U.S. semiquincentennial)","source":"https://newwestsymphony.org/","asOf":"2026-07-06"}'::jsonb, '{18,99}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'Good fit if you want to hear a professional orchestra close to home, with family and student ticket pricing available.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('newwest', 0, 'New West Symphony', 'Professional', '{18,99}'::int[], 'Professional symphony orchestra performing in Thousand Oaks and Camarillo, with tenured members drawn from LA''s film-recording scene.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('newwest', 0, '2026-10-03'::date, 'Beethoven & Copland', 'Thousand Oaks (BAPAC)', 'Francesco Lecce-Chong conducts; with Pacific Festival Ballet and Los Robles Children''s Choir. Repeats Sun Oct 4 at 3 PM in Camarillo (RCPAC).', '{"status":"unverified"}'::jsonb, 'https://newwestsymphony.org/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('newwest', 1, '2026-11-07'::date, 'Symphony Goes to Cirque', 'Thousand Oaks (BAPAC)', 'Michael Christie conducts; with Troupe Vertigo. Repeats Sun Nov 8 at 3 PM in Camarillo (RCPAC).', '{"status":"unverified"}'::jsonb, 'https://newwestsymphony.org/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('newwest', 2, '2026-12-05'::date, 'Too Hot To Handel', 'Thousand Oaks (BAPAC)', 'Michael Christie conducts; New West Symphony Chorus; Alfreda Burke, soprano; Rodrick Dixon, tenor. Repeats Sun Dec 6 at 3 PM in Camarillo (RCPAC).', '{"status":"unverified"}'::jsonb, 'https://newwestsymphony.org/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('newwest', 0, 'https://newwestsymphony.org/', 'Home / 2026 Masterpiece Series concerts', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('newwest', 1, 'https://newwestsymphony.org/about/careers-auditions/', 'Careers & Auditions', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('newwest', 2, 'https://newwestsymphony.org/orchestra-positions/', 'Orchestra Positions (last posting: Section Cello, Oct 2024)', '2026-07-06'::date);

-- loyo — Lyceum Oaks Youth Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'loyo', 'Lyceum Oaks Youth Orchestra', 'youth', 34.19, -118.93, 'Newbury Park (Thousand Oaks)', 'Ventura County',
  'https://loyo.lyceumoaks.org/', 'https://loyo.lyceumoaks.org/auditions/', 'Formerly the Conejo Valley Youth Orchestra, LOYO is a six-ensemble youth orchestra program entering its 66th season, rehearsing Mondays in Newbury Park with satellite campuses in Simi Valley and Ventura. Students climb a clear ladder from beginning strings and band to an advanced Symphony Orchestra and the invitation-only Virtuosi chamber orchestra.',
  '{"status":"verified","value":"2026–27 season (LOYO''s 66th); season begins September 11, 2026","source":"https://loyo.lyceumoaks.org/","asOf":"2026-07-06"}'::jsonb, '{6,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Mondays at Godspeak Church, 320 Via Las Brisas, Newbury Park; ensemble blocks between 3:45 and 9:00 PM (Youth Strings 3:45–4:30, Preparatory 4:45–6:15, Symphony 6:30–8:15, Virtuosi 8:15–9:00)","source":"https://loyo.lyceumoaks.org/schedule/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Two-semester season of weekly Monday rehearsals (Sept 14, 2026 – Jun 4, 2027); Gala concerts and their dress rehearsals are mandatory","source":"https://loyo.lyceumoaks.org/schedule/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://loyo.lyceumoaks.org/schedule/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"$1,000 per season or $700 per single semester (payment plans available; $20 discount for single September payment)","source":"https://loyo.lyceumoaks.org/schedule/","asOf":"2026-07-06"}'::jsonb,
  'Good fit if you want a structured, multi-level orchestra ladder in the Conejo Valley with clear advancement from first ensemble to pre-college level.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('loyo', 0, 'Youth Strings', 'Beginner', '{6,12}'::int[], 'Junior string orchestra of 40–80 musicians where most string players begin (about 1–4 years of experience).');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('loyo', 1, 'Youth Band', 'Beginner', '{8,13}'::int[], 'Junior wind, brass, and percussion ensemble of 20–50 musicians for players in their first years.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('loyo', 2, 'Flore Ensemble', 'Intermediate', '{8,13}'::int[], 'Invitation-only string ensemble of 12–24 players bridging Youth Strings and Preparatory Orchestra.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('loyo', 3, 'Preparatory Orchestra', 'Intermediate', '{10,15}'::int[], 'Full symphonic orchestra of 60–80 intermediate string, wind, and brass players.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('loyo', 4, 'Symphony Orchestra', 'Advanced', '{12,18}'::int[], 'Flagship full symphony of 70–90 advanced players tackling major repertoire from Brahms to Mussorgsky.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('loyo', 5, 'Virtuosi Ensemble', 'Pre-professional', '{13,18}'::int[], 'Invitation-only chamber orchestra of Symphony principals; performs mostly conductorless with its own Dialogues concert series and concert stipends.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('loyo', 0, '2026-12-04'::date, 'Dialogues Messiah', 'Padre Serra, Camarillo', 'Handel''s Messiah with the Virtuosi Ensemble and partner choirs', '{"status":"unverified"}'::jsonb, 'https://loyo.lyceumoaks.org/schedule/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('loyo', 1, '2026-12-12'::date, 'Winter Gala', 'Seaver Hall, Pepperdine University', 'All six LOYO ensembles (4:00 PM younger ensembles; 7:30 PM Virtuosi and Symphony Orchestra)', '{"status":"unverified"}'::jsonb, 'https://loyo.lyceumoaks.org/schedule/');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('loyo', 2, '2027-06-06'::date, 'Spring Gala', 'Kavli Theatre, Thousand Oaks', 'All orchestras, 4:00 PM', '{"status":"unverified"}'::jsonb, 'https://loyo.lyceumoaks.org/schedule/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('loyo', 0, 'Beginner', 'Strings, winds, brass, percussion, saxophone (Youth Strings / Youth Band)', '{"status":"verified","value":"Registration open now; live auditions July 31 and August 1, 7, 8; standard registration closes August 3; make-up/sit-in auditions and late registration through September 11 (2026–27 season)","source":"https://loyo.lyceumoaks.org/auditions/","asOf":"2026-07-06"}'::jsonb, 'open', '{6,13}'::int[], 'Entry-level musicians may request a sit-in audition instead of a live audition. Registration fee $20–$60 rises with later registration.', 'https://loyo.lyceumoaks.org/auditions/');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('loyo', 1, 'Advanced', 'Strings, winds, brass, percussion (Preparatory Orchestra, Symphony Orchestra, Virtuosi placement)', '{"status":"verified","value":"Registration open now; live auditions July 31 and August 1, 7, 8; standard registration closes August 3; make-up auditions September 11 (2026–27 season)","source":"https://loyo.lyceumoaks.org/auditions/","asOf":"2026-07-06"}'::jsonb, 'open', '{10,18}'::int[], 'All applicants, new and returning, play an in-person audition: scale, solo excerpt, and orchestral excerpt. Placement is merit-based with no age or grade requirements.', 'https://loyo.lyceumoaks.org/auditions/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('loyo', 0, 'https://loyo.lyceumoaks.org/', 'Home (66th season; 2026–27 registration open; campuses)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('loyo', 1, 'https://loyo.lyceumoaks.org/auditions/', 'Auditions and registration', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('loyo', 2, 'https://loyo.lyceumoaks.org/schedule/', 'Schedule and tuition (2026–27 calendar, concerts, scholarships)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('loyo', 3, 'https://loyo.lyceumoaks.org/orchestras/', 'Orchestras and levels', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('loyo', 4, 'https://www.cvyo.org', 'cvyo.org (redirects to loyo.lyceumoaks.org, confirming rename)', '2026-07-06'::date);

-- baksym — Bakersfield Symphony Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'baksym', 'Bakersfield Symphony Orchestra', 'professional', 35.3722, -119.0203, 'Downtown Bakersfield', 'Kern County',
  'https://www.bsonow.org/', 'https://www.bsonow.org/auditions', 'Kern County''s professional orchestra, enriching Bakersfield since 1932 and performing its season at the Dignity Health Theater downtown. Education programs like Young People''s Concerts and BSO NEXT serve students across the county.',
  '{"status":"verified","value":"2026/27 season — ''A Season in Motion'' (season tickets on sale now)","source":"https://www.bsonow.org/","asOf":"2026-07-06"}'::jsonb, '{18,99}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'Good fit if you want live symphonic music in downtown Bakersfield, from the classics to holiday and mariachi nights.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('baksym', 0, 'Bakersfield Symphony Orchestra', 'Professional', '{18,99}'::int[], 'Professional symphony performing at the Dignity Health Theater; auditions are held blind behind a screen.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('baksym', 0, '2026-10-03'::date, 'Rhythm & Fire', 'Dignity Health Theater, Bakersfield', 'Bartók, Dvořák, and Ligeti; Jackson Snead performs Sarasate''s Zigeunerweisen', '{"status":"unverified"}'::jsonb, 'https://www.bsonow.org/calendar');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('baksym', 1, '2026-11-07'::date, 'Music in Color', 'Dignity Health Theater, Bakersfield', 'Sibelius; Anastasiya Poff in ''The River''; Mussorgsky''s Pictures at an Exhibition', '{"status":"unverified"}'::jsonb, 'https://www.bsonow.org/calendar');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('baksym', 2, '2026-12-04'::date, 'Home for the Holidays', 'Dignity Health Theater, Bakersfield', 'Holiday favorites and carols with Bakersfield College Combined Choirs and Bakersfield Master Chorale', '{"status":"unverified"}'::jsonb, 'https://www.bsonow.org/calendar');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('baksym', 0, 'https://www.bsonow.org/', 'Home (2026/27 season announcement)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('baksym', 1, 'https://www.bsonow.org/calendar', 'Calendar (dated 2026–27 concerts)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('baksym', 2, 'https://www.bsonow.org/auditions', 'Auditions (blind audition policy; no current postings)', '2026-07-06'::date);

-- byso — Bakersfield Youth Symphony Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'byso', 'Bakersfield Youth Symphony Orchestra', 'youth', 35.3489, -119.104, 'Bakersfield (CSUB campus)', 'Kern County',
  'https://www.bysorocks.org/', 'https://www.bysorocks.org/audition', 'An audition-only youth orchestra affiliated with the Bakersfield Symphony, open to students from 7th grade through age 19. Members rehearse Sunday evenings at CSU Bakersfield under music director Dr. Leo Sakomoto and perform three concerts a year.',
  '{"status":"verified","value":"2026–27 season (calendar published; auditions September 12, 2026)","source":"https://www.bysorocks.org/audition","asOf":"2026-07-06"}'::jsonb, '{12,19}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"verified","value":"Sundays 5:30–8:00 PM at CSU Bakersfield (except three-day weekends)","source":"https://www.bysorocks.org/audition","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Attendance at all rehearsals and concerts is mandatory for members","source":"https://www.bysorocks.org/audition","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.bysorocks.org/audition","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"$275 per year ($25 application fee applies toward tuition; financial aid available based on need)","source":"https://www.bysorocks.org/audition","asOf":"2026-07-06"}'::jsonb,
  'Good fit if your middle or high schooler is ready for a step up from school ensembles and can commit to Sunday evening rehearsals.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('byso', 0, 'Bakersfield Youth Symphony Orchestra', 'Advanced', '{12,19}'::int[], 'Single audition-only ensemble of highly motivated students performing high-level orchestral repertoire, from 7th grade through first-year undergraduates.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('byso', 0, 'Advanced', 'Strings, woodwinds, brass, percussion, harp', '{"status":"verified","value":"Applications due September 4, 2026 ($10 late fee after); auditions September 12, 2026 at the CSUB Music Building, 9001 Stockdale Hwy","source":"https://www.bysorocks.org/audition","asOf":"2026-07-06"}'::jsonb, 'open', '{12,19}'::int[], '$25 non-refundable application fee. Assigned scales, excerpts, and sight-reading per instrument; students must be enrolled and in good standing in their school instrumental ensemble where available.', 'https://www.bysorocks.org/audition');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('byso', 0, 'https://www.bysorocks.org/', 'Home (affiliation, director, membership range)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('byso', 1, 'https://www.bysorocks.org/audition', 'Audition requirements, tuition, 2026–27 dates', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('byso', 2, 'https://www.bsonow.org/', 'Bakersfield Symphony home (BYSO affiliation; June 2026 BYSO season-finale mention)', '2026-07-06'::date);

-- sbsyo — San Bernardino Symphony Youth Orchestras
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'sbsyo', 'San Bernardino Symphony Youth Orchestras', 'youth', 34.081, -117.316, 'San Bernardino', 'Inland Empire',
  'https://www.sanbernardinosymphony.org/symphony-youth-orchestras', 'https://www.sanbernardinosymphony.org/symphony-youth-orchestras', 'The San Bernardino Symphony''s youth program fields two full orchestras — the Symphony Youth Orchestra for high schoolers and the Overture Orchestra for middle schoolers — with Sunday rehearsals, fall and spring concerts, and chances to share the stage with the professional symphony.',
  '{"status":"verified","value":"2025–2026 season (fall and spring semesters; full calendar posted)","source":"https://www.sanbernardinosymphony.org/symphony-youth-orchestras","asOf":"2026-07-06"}'::jsonb, '{11,18}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"verified","value":"SBSYO: Sundays 2:00–5:00 PM at San Bernardino Valley College (North Hall 164); SBSOO: Sundays 3:00–4:30 PM at Wilmer Amina Carter High School","source":"https://www.sanbernardinosymphony.org/symphony-youth-orchestras","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Weekly Sunday rehearsals September–May with fall and spring concerts; attendance policy per program handbook","source":"https://www.sanbernardinosymphony.org/symphony-youth-orchestras","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.sanbernardinosymphony.org/symphony-youth-orchestras","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"2025–26: SBSYO $200/semester ($400/year, or $350 if paid in full by Sept 7); SBSOO $100/semester ($200/year, or $175 in full); prorated for mid-year joins","source":"https://www.sanbernardinosymphony.org/symphony-youth-orchestras","asOf":"2026-07-06"}'::jsonb,
  'Good fit if your middle or high schooler wants a full-orchestra experience on a modest budget, with a path onto the professional symphony''s stage.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sbsyo', 0, 'San Bernardino Symphony Youth Orchestra (SBSYO)', 'Advanced', '{14,18}'::int[], 'Full orchestra for ages 14–18 (grades 9–12); rehearses Sundays at San Bernardino Valley College and performs at the SBVC Auditorium and with the San Bernardino Symphony.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sbsyo', 1, 'San Bernardino Symphony Overture Orchestra (SBSOO)', 'Intermediate', '{11,14}'::int[], 'Full orchestra for ages 11–14 (grades 6–9); rehearses Sundays at Wilmer Amina Carter High School. 9th graders are placed in SBSOO or SBSYO by audition.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('sbsyo', 0, '2026-12-13'::date, 'Youth Orchestras Winter Concert', NULL, NULL, '{"status":"verified","value":10,"source":"https://www.sanbernardinosymphony.org/symphony-youth-orchestras","asOf":"2026-07-06"}'::jsonb, 'https://www.sanbernardinosymphony.org/symphony-youth-orchestras');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('sbsyo', 0, 'Advanced', 'Strings, woodwinds, brass, percussion, harp, keyboard (SBSYO)', '{"status":"unverified"}'::jsonb, 'rolling', '{14,18}'::int[], '2025–26 auditions were held Aug 24–Sep 5, 2025; 2026–27 dates not yet announced as of 2026-07-06. Registration and video-audition forms stay posted online, and mid-year joins are possible with prorated tuition.', 'https://www.sanbernardinosymphony.org/symphony-youth-orchestras');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('sbsyo', 1, 'Intermediate', 'Strings, woodwinds, brass, percussion, harp, keyboard (SBSOO)', '{"status":"unverified"}'::jsonb, 'rolling', '{11,14}'::int[], '2025–26 auditions were held Aug 24–Sep 5, 2025; 2026–27 dates not yet announced as of 2026-07-06. Registration and video-audition forms stay posted online.', 'https://www.sanbernardinosymphony.org/symphony-youth-orchestras');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sbsyo', 0, 'https://www.sanbernardinosymphony.org/symphony-youth-orchestras', 'SBSYO/SBSOO program page — mission, tuition, calendar, rehearsals, auditions, financial aid', '2026-07-06'::date);

-- riverside-arts — Riverside Arts Academy
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'riverside-arts', 'Riverside Arts Academy', 'youth', 33.9737, -117.3281, 'Riverside', 'Inland Empire',
  'https://www.riversideartsacademy.com', 'https://www.riversideartsacademy.com/overview', 'Riverside''s nonprofit music academy runs a full ladder of ensembles — from no-audition beginner strings through the auditioned Riverside Youth Orchestra, which rehearses Sunday evenings at UC Riverside — and full or partial need-based scholarships are available.',
  '{"status":"verified","value":"2026–27 season; registration open","source":"https://www.riversideartsacademy.com/overview","asOf":"2026-07-06"}'::jsonb, '{7,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Riverside Youth Orchestra: Sundays 6:00–9:00 PM at UC Riverside; Overture Orchestra and beginner strings: Saturday mornings at the Arlanza Community Center, Riverside","source":"https://www.riversideartsacademy.com/overview","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Rehearsal attendance mandatory; up to 2 absences per semester (excluding dress rehearsals and concerts) under the RYO policy","source":"https://www.riversideartsacademy.com/ryo","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":true,"source":"https://www.riversideartsacademy.com/overview","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Riverside Youth Orchestra: $1,200 per school year (3 units) before financial aid, payable in one sum or monthly; beginner strings classes are 1.5 units","source":"https://www.riversideartsacademy.com/ryo","asOf":"2026-07-06"}'::jsonb,
  'Good fit if you want one program that can carry a child from first beginner-strings lessons to an auditioned full youth orchestra without leaving Riverside.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('riverside-arts', 0, 'Riverside Youth Orchestra', 'Advanced', '{11,18}'::int[], 'Flagship auditioned full orchestra for grades 6–12 with 2+ years of experience; Sundays 6:00–9:00 PM at UC Riverside, with instrument-specific sectionals; repertoire spans the classical canon to film and video game music.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('riverside-arts', 1, 'Overture Orchestra', 'Intermediate', '{11,18}'::int[], 'New auditioned intermediate full orchestra (strings, winds, brass, percussion) for grades 6–12; Saturdays 9:00 AM–12:00 PM at Arlanza Community Center.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('riverside-arts', 2, 'Strings II', 'Beginner', '{8,14}'::int[], 'Auditioned string orchestra (violin, viola, cello, bass) for grades 3–8; Saturday mornings at Arlanza Community Center.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('riverside-arts', 3, 'Strings I', 'Beginner', '{7,11}'::int[], 'No-audition entry strings class for grades 2–6; Saturday mornings at Arlanza Community Center.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('riverside-arts', 0, 'Advanced', 'Strings, winds, brass, percussion (2+ years experience for RYO)', '{"status":"verified","value":"Registration for the 2026–27 season is open; RYO placement is by audition with posted excerpts and scales","source":"https://www.riversideartsacademy.com/overview","asOf":"2026-07-06"}'::jsonb, 'open', '{11,18}'::int[], 'Overture Orchestra and Strings II also require auditions; Strings I is no-audition. Students not placed in RYO are recommended to another RAA class.', 'https://www.riversideartsacademy.com/ryo');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('riverside-arts', 0, 'https://www.riversideartsacademy.com/overview', '2026–27 season program overview and registration', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('riverside-arts', 1, 'https://www.riversideartsacademy.com/ryo', 'Riverside Youth Orchestra page — tuition, schedule, audition materials, attendance policy', '2026-07-06'::date);

-- tvys — Temecula Valley Youth Symphony
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'tvys', 'Temecula Valley Youth Symphony', 'youth', 33.5539, -117.2139, 'Temecula / Murrieta', 'Inland Empire',
  'https://temeculavalleysymphony.org/youth-symphony/', 'https://temeculavalleysymphony.org/youth-symphony/apply/', 'The Temecula Valley Symphony''s youth division for student musicians in southwest Riverside County, with tiered ensembles from beginning strings to a full symphonic orchestra, weekly Monday-night rehearsals, and coaching from professional musicians.',
  '{"status":"verified","value":"Fall and spring semesters plus a summer session","source":"https://temeculavalleysymphony.org/youth-symphony/","asOf":"2026-07-06"}'::jsonb, '{8,18}'::int[], '{"Strings","Winds","Brass","Percussion"}'::public.instrument[],
  '{"status":"verified","value":"Weekly Monday night rehearsals","source":"https://temeculavalleysymphony.org/youth-symphony/","asOf":"2026-07-06"}'::jsonb, '{"status":"verified","value":"Weekly rehearsals; 3–4 concerts per season plus community recital and chamber opportunities","source":"https://temeculavalleysymphony.org/youth-symphony/","asOf":"2026-07-06"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"unverified"}'::jsonb,
  'Good fit if you want a youth orchestra close to home in the Temecula–Murrieta area rather than driving to Riverside or San Diego.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('tvys', 0, 'Symphonic Orchestra', 'Advanced', '{12,18}'::int[], 'Top full-orchestra tier of the youth program.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('tvys', 1, 'Concert Orchestra', 'Intermediate', '{10,16}'::int[], 'Intermediate orchestra between beginning strings and the symphonic orchestra.');
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('tvys', 2, 'Debut Strings', 'Beginner', '{8,13}'::int[], 'Entry-level string ensemble.');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('tvys', 0, 'Intermediate', 'Strings, winds, brass, percussion — all ensemble levels', '{"status":"verified","value":"Rolling — audition any time during the school year before a scheduled rehearsal; video auditions accepted","source":"https://temeculavalleysymphony.org/youth-symphony/apply/","asOf":"2026-07-06"}'::jsonb, 'rolling', '{8,18}'::int[], 'All students re-audition at the start of each season (repertoire piece plus a scale; snare/mallet skills for percussion). The apply page still shows the 2025–26 cycle (spring session ended May 18, 2026) — confirm 2026–27 dates with the manager before relying on them.', 'https://temeculavalleysymphony.org/youth-symphony/apply/');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('tvys', 0, 'https://temeculavalleysymphony.org/youth-symphony/', 'Youth Symphony program page (read via rendered browser — site requires JavaScript)', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('tvys', 1, 'https://temeculavalleysymphony.org/youth-symphony/apply/', 'Apply & Audition (read via rendered browser; page shows 2025–26 cycle)', '2026-07-06'::date);

-- redsym — Redlands Symphony
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'redsym', 'Redlands Symphony', 'professional', 34.064, -117.165, 'Redlands (University of Redlands)', 'Inland Empire',
  'https://www.redlandssymphony.com', 'https://www.redlandssymphony.com/careers', 'A professional orchestra that has entertained the Inland Empire since 1950, performing its series at Memorial Chapel on the University of Redlands campus; 2026–27 is its 75th anniversary season under Music Director & Conductor Deanna Tham.',
  '{"status":"verified","value":"2026–2027 season — 75th Anniversary Season","source":"https://www.redlandssymphony.com/26-27-season","asOf":"2026-07-06"}'::jsonb, '{18,99}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"verified","value":"Professional orchestra; musicians are represented by AFM Local 47 and must be members in good standing to perform","source":"https://www.redlandssymphony.com/careers","asOf":"2026-07-06"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'Good fit for families who want professional concerts in an intimate campus hall close to home; not a student ensemble.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('redsym', 0, 'Redlands Symphony Orchestra', 'Professional', '{18,99}'::int[], 'Professional symphony orchestra performing its subscription series at Memorial Chapel, University of Redlands.');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('redsym', 0, '2026-09-12'::date, 'Shostakovich''s Fifth', 'Memorial Chapel, University of Redlands', 'Deanna Tham conducts — Derrick Skye ''Prisms, Cycles, Leaps''; Melanie Bonis ''Trois femmes de légende''; Shostakovich Symphony No. 5', '{"status":"unverified"}'::jsonb, 'https://www.redlandssymphony.com/26-27-season');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('redsym', 1, '2026-10-03'::date, 'Pulcinella Suite', 'Memorial Chapel, University of Redlands', 'Oswald Huỳnh ''Then, as if Breathing, the sea swelled beneath us''; Ibert Concertino da camera (Madelyn Olsen, alto saxophone); Stravinsky Pulcinella Suite', '{"status":"unverified"}'::jsonb, 'https://www.redlandssymphony.com/26-27-season');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('redsym', 2, '2026-11-21'::date, 'Gulda Cello Concerto', 'Memorial Chapel, University of Redlands', 'Gabrielli Fanfare; R. Strauss Suite in B-flat; Gulda Concerto for Cello and Wind Orchestra (Nathan Chan, cello)', '{"status":"unverified"}'::jsonb, 'https://www.redlandssymphony.com/26-27-season');
insert into public.auditions (org_id, position, level, instruments, "window", status, ages, note, source) values ('redsym', 0, 'Professional', 'All orchestral instruments — substitute list', '{"status":"verified","value":"No auditions currently scheduled; résumés accepted by email for the substitute list","source":"https://www.redlandssymphony.com/careers","asOf":"2026-07-06"}'::jsonb, 'rolling', '{18,99}'::int[], 'Musicians must be AFM Local 47 members in good standing to perform.', 'https://www.redlandssymphony.com/careers');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('redsym', 0, 'https://www.redlandssymphony.com/26-27-season', '2026–27 season page — concerts, venue, music director', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('redsym', 1, 'https://www.redlandssymphony.com/careers', 'Careers and Auditions — audition status, AFM Local 47, substitute list', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('redsym', 2, 'https://www.redlandssymphony.com/25-26-season', '2025–26 season page (footer: ''Entertaining and Inspiring the IE since 1950'')', '2026-07-06'::date);

-- sbso — San Bernardino Symphony Orchestra
insert into public.organizations (
  id, name, type, lat, lng, area, metro, website, apply_url, blurb,
  season, ages, instruments, rehearsal, commitment, financial_aid, tuition,
  good_fit, reviews, last_verified, listing_status, provenance_type, submitted_by
) values (
  'sbso', 'San Bernardino Symphony Orchestra', 'professional', 34.106, -117.294, 'Downtown San Bernardino', 'Inland Empire',
  'https://www.sanbernardinosymphony.org', NULL, 'The Inland Empire''s professional symphony, led by Music Director Anthony Parnther, presenting a year-round series of orchestral, holiday, and jazz programming — and running its own two-tier youth orchestra program.',
  '{"status":"unverified"}'::jsonb, '{18,99}'::int[], '{"Strings","Winds","Brass","Percussion","Harp"}'::public.instrument[],
  '{"status":"not_applicable"}'::jsonb, '{"status":"unverified"}'::jsonb, '{"status":"not_applicable"}'::jsonb, '{"status":"not_applicable"}'::jsonb,
  'Good fit if you want big-stage professional concerts in the heart of the Inland Empire — and a symphony family your young musician can grow into.', NULL, '2026-07-06'::date,
  'in_review', 'curated', NULL
);
insert into public.ensembles (org_id, position, name, level, ages, "desc") values ('sbso', 0, 'San Bernardino Symphony Orchestra', 'Professional', '{18,99}'::int[], 'Professional orchestra led by Music Director Anthony Parnther; its education wing fields the SBSYO and SBSOO youth orchestras (listed separately).');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('sbso', 0, '2026-09-05'::date, 'This is Jazz', NULL, 'The Josh Nelson Jazz Ensemble — works by Mulgrew Miller, Michel Petrucciani, Mike Wofford, Kenny Kirkland, George Cables, and Josh Nelson', '{"status":"unverified"}'::jsonb, 'https://www.sanbernardinosymphony.org/september-5-concert');
insert into public.performances (org_id, position, date, title, venue, program, "from", source) values ('sbso', 1, '2026-12-12'::date, 'A Christmas Festival', NULL, NULL, '{"status":"unverified"}'::jsonb, 'https://www.sanbernardinosymphony.org/september-5-concert');
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sbso', 0, 'https://www.sanbernardinosymphony.org/september-5-concert', 'Sep 5, 2026 ''This is Jazz'' concert page + 2026 concert listings in site navigation', '2026-07-06'::date);
insert into public.org_sources (org_id, position, url, label, retrieved_at) values ('sbso', 1, 'https://www.sanbernardinosymphony.org/symphony-youth-orchestras', 'Org contact info, music director reference, education program', '2026-07-06'::date);

commit;
