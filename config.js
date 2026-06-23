/* Tutti — front-end configuration (Phase 3).
 *
 * The HTML loads this file if it's present. If it's absent (e.g. opening the raw
 * file with no server), Tutti falls back to the bundled dataset and an in-memory
 * Saved list — so the page always renders.
 *
 * supabaseAnonKey is a PUBLIC client key (safe to ship in the browser). Row-Level
 * Security in the database is what actually protects the data.
 *
 *   • Local dev: the values below are the Supabase CLI's standard local URL + anon
 *     key. Run `supabase start`; if your CLI prints a different anon key, paste it here.
 *   • Production: replace both values with your hosted project's API URL + anon key.
 *   • Set useApi:false to force the bundled/offline dataset (no backend calls).
 */
window.TUTTI_CONFIG = {
  supabaseUrl: "http://127.0.0.1:54321",
  supabaseAnonKey:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0",
  useApi: true,
};
