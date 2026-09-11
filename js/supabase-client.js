window.PVT = window.PVT || {};
(() => {
  const cfg = window.PVT_SURVEY_CONFIG || {};
  if (!window.supabase || !cfg.SUPABASE_URL || !cfg.SUPABASE_ANON_KEY) {
    console.warn("Supabase client not initialized.");
    return;
  }
  PVT.db = window.supabase.createClient(cfg.SUPABASE_URL, cfg.SUPABASE_ANON_KEY, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true }
  });
})();
