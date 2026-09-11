window.PVT = window.PVT || {};

PVT.getSalesSession = () => {
  try {
    const raw = localStorage.getItem("pvt_sales_session");
    if (!raw) return null;
    const data = JSON.parse(raw);
    return data && data.role === "sales" ? data : null;
  } catch (e) {
    return null;
  }
};

PVT.setSalesSession = (salesProfile) => {
  try {
    localStorage.setItem("pvt_sales_session", JSON.stringify(salesProfile));
  } catch (e) {
    console.error("Failed to save sales session", e);
  }
};

PVT.clearSalesSession = () => {
  try {
    localStorage.removeItem("pvt_sales_session");
  } catch (e) {}
};

PVT.getAdminSession = () => {
  try {
    const raw = localStorage.getItem("pvt_admin_session");
    if (!raw) return null;
    const data = JSON.parse(raw);
    return data && (data.role === "admin" || data.role === "management") ? data : null;
  } catch (e) {
    return null;
  }
};

PVT.setAdminSession = (adminProfile) => {
  try {
    localStorage.setItem("pvt_admin_session", JSON.stringify(adminProfile));
  } catch (e) {
    console.error("Failed to save admin session", e);
  }
};

PVT.clearAdminSession = () => {
  try {
    localStorage.removeItem("pvt_admin_session");
  } catch (e) {}
};

PVT.getSessionProfile = async () => {
  // 1. Check Supabase authenticated session
  if (PVT.db && PVT.db.auth) {
    try {
      const { data: { session }, error } = await PVT.db.auth.getSession();
      if (!error && session) {
        const { data: profile, error: pErr } = await PVT.db
          .from("profiles")
          .select("auth_user_id,username,display_name,role,salesperson_id,is_active")
          .eq("auth_user_id", session.user.id)
          .maybeSingle();
        if (!pErr && profile && profile.is_active) {
          return { session, profile };
        }
      }
    } catch (err) {
      console.warn("Supabase session check error:", err);
    }
  }

  // 2. Check Admin local session
  const admin = PVT.getAdminSession();
  if (admin && admin.is_active !== false) {
    return {
      session: null,
      profile: {
        auth_user_id: admin.auth_user_id || "admin-local-user",
        username: admin.username || "admin",
        display_name: admin.display_name || "ผู้ดูแลระบบ (Admin)",
        role: admin.role || "admin",
        salesperson_id: null,
        is_active: true
      }
    };
  }

  // 3. Check Sales passwordless session
  const sales = PVT.getSalesSession();
  if (sales && sales.is_active !== false) {
    return {
      session: null,
      profile: {
        auth_user_id: sales.salesperson_id || "sales-local-user",
        username: sales.username || sales.display_name,
        display_name: sales.display_name,
        role: "sales",
        salesperson_id: sales.salesperson_id,
        is_active: true
      }
    };
  }

  return null;
};

PVT.requireAuth = async (roles=[]) => {
  if (!PVT.db) return null;
  const ctx = await PVT.getSessionProfile();
  if (!ctx) {
    const isOnlyAdmin = roles.length && roles.every(r => r === "admin" || r === "management");
    const targetLogin = isOnlyAdmin ? "admin-login.html" : "index.html";
    location.href = `${targetLogin}?next=${encodeURIComponent(location.pathname.split("/").pop()+location.search)}`;
    return null;
  }
  if (roles.length && !roles.includes(ctx.profile.role)) {
    location.href = ctx.profile.role === "sales" ? "survey.html" : "admin.html";
    return null;
  }
  const userName=document.getElementById("current-user");
  if (userName) userName.textContent=ctx.profile.display_name;
  return ctx;
};

PVT.logout = async (redirectTarget) => {
  const currentCtx = await PVT.getSessionProfile();
  const isAdmin = currentCtx?.profile?.role === "admin" || currentCtx?.profile?.role === "management" || location.pathname.includes("admin.html");
  
  PVT.clearSalesSession();
  PVT.clearAdminSession();
  if (PVT.db && PVT.db.auth) {
    try {
      await PVT.db.auth.signOut();
    } catch (e) {}
  }
  
  if (redirectTarget) {
    location.href = redirectTarget;
  } else if (isAdmin) {
    location.href = "admin-login.html";
  } else {
    location.href = "index.html";
  }
};

document.addEventListener("click",e=>{
  const btn=e.target.closest("[data-action='logout']");
  if(btn) PVT.logout();
});
