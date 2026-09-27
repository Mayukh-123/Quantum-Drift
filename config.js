// ---- Supabase connection ----
// Reusing the same project as before — replace if you spin up a fresh one.
const SUPABASE_URL = "https://rirlyngwsrwcefaydkam.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_UBkVk0EnjhmsO0Zf87DSiw_1gRzY8Z0";

const sb = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// ---- Shared helpers ----

function statusClass(status) {
  return "badge-" + status.toLowerCase().replace(/[^a-z]/g, "");
}

function formatDateTime(ts) {
  return new Date(ts).toLocaleString("en-IN");
}
