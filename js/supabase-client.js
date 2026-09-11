window.PVT = window.PVT || {};
(() => {
  const cfg = window.PVT_SURVEY_CONFIG || {};
  if (!window.supabase || !cfg.SUPABASE_URL || !cfg.SUPABASE_ANON_KEY) {
    console.warn("Supabase client not initialized.");
    return;
  }

  // Pre-check and clean stale/expired auth tokens that cause 401 Unauthorized
  try {
    const isSalesLocal = !!localStorage.getItem("pvt_sales_session");
    for (let i = localStorage.length - 1; i >= 0; i--) {
      const key = localStorage.key(i);
      if (key && key.startsWith("sb-") && key.endsWith("-auth-token")) {
        try {
          const raw = localStorage.getItem(key);
          const item = JSON.parse(raw);
          const isExpired = item?.expires_at && (item.expires_at < Math.floor(Date.now() / 1000));
          if (isExpired || isSalesLocal) {
            console.info("Cleared stale Supabase auth token from storage to prevent 401 errors:", key);
            localStorage.removeItem(key);
          }
        } catch (e) {
          localStorage.removeItem(key);
        }
      }
    }
  } catch (e) {}

  PVT.db = window.supabase.createClient(cfg.SUPABASE_URL, cfg.SUPABASE_ANON_KEY, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true }
  });
})();
