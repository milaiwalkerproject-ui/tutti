/* Tutti — front-end configuration (production).
 *
 * The HTML loads this file if it's present. If it's absent (e.g. opening the raw
 * file with no server), Tutti falls back to the bundled dataset and an in-memory
 * Saved list — so the page always renders.
 *
 * supabaseAnonKey is a PUBLIC client key (safe to ship in the browser). Row-Level
 * Security in the database is what actually protects the data.
 *
 *   • Production (current values): the hosted Supabase project. The deployed site
 *     serves this file as-is.
 *   • Local dev against the local stack: comment the production block and
 *     uncomment the LOCAL block below (then `npx supabase start`).
 *   • Set useApi:false to force the bundled/offline dataset (no backend calls).
 */
window.TUTTI_CONFIG = {
  supabaseUrl: "https://nylnqmpbijalgzkudhgo.supabase.co",
  supabaseAnonKey:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im55bG5xbXBiaWphbGd6a3VkaGdvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODMzMTQxNjAsImV4cCI6MjA5ODg5MDE2MH0.WrH7Tugj7EMLZ0cnrr6i1cIKNQFacn6bii9JsQ4c2XA",
  useApi: true,
  stadiaApiKey: "24746999-ed8d-4634-bd4f-170c079720b8", // public, for map tiles
  // appleSignIn: true,   // uncomment ONLY after Apple sign-in is configured in
  //                      // Supabase (Services ID + key + domain). Until then the
  //                      // "Continue with Apple" button stays hidden so nobody
  //                      // clicks a sign-in that can't work yet.
};

/* LOCAL dev block — swap in when working against `npx supabase start`:
window.TUTTI_CONFIG = {
  supabaseUrl: "http://127.0.0.1:54321",
  supabaseAnonKey:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0",
  useApi: true,
};
*/
