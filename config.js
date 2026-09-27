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

// ---- Auth guard ----
// Call this at the top of any page that should require a logged-in admin.
// Redirects to login.html if there's no active session.
async function requireAuth() {
  const { data } = await sb.auth.getSession();
  if (!data.session) {
    window.location.href = "login.html";
    return null;
  }
  return data.session;
}

async function logout() {
  await sb.auth.signOut();
  window.location.href = "login.html";
}
