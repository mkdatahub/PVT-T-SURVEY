import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) throw new Error("Missing Authorization header");

    const admin = createClient(supabaseUrl, serviceRoleKey, {
      auth: { autoRefreshToken: false, persistSession: false },
    });

    const token = authHeader.replace("Bearer ", "");
    const { data: userData, error: userErr } = await admin.auth.getUser(token);
    if (userErr || !userData.user) throw new Error("Invalid user session");

    const { data: caller, error: callerErr } = await admin
      .from("profiles")
      .select("role,is_active")
      .eq("auth_user_id", userData.user.id)
      .single();
    if (callerErr || !caller?.is_active || caller.role !== "admin") {
      throw new Error("Admin permission required");
    }

    const body = await req.json();
    const username = String(body.username || "").trim().toLowerCase();
    const displayName = String(body.display_name || "").trim();
    const password = String(body.password || "");
    const role = String(body.role || "sales");
    const salespersonId = body.salesperson_id || null;

    if (!/^[a-z0-9._-]{3,40}$/i.test(username)) {
      throw new Error("Username ต้องมี 3–40 ตัว และใช้ a-z 0-9 . _ -");
    }
    if (!displayName) throw new Error("กรุณาระบุชื่อแสดงผล");
    if (password.length < 8) throw new Error("Password ต้องอย่างน้อย 8 ตัว");
    if (!["admin", "management", "sales"].includes(role)) throw new Error("Invalid role");
    if (role === "sales" && !salespersonId) throw new Error("Role sales ต้องผูกกับ salesperson");

    const email = `${username}@pvt.local`;
    const { data: created, error: createErr } = await admin.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
      user_metadata: { username, display_name: displayName, role },
    });
    if (createErr) throw createErr;

    const { error: profileErr } = await admin.from("profiles").insert({
      auth_user_id: created.user.id,
      username,
      display_name: displayName,
      role,
      salesperson_id: salespersonId,
      is_active: true,
    });
    if (profileErr) {
      await admin.auth.admin.deleteUser(created.user.id);
      throw profileErr;
    }

    return new Response(JSON.stringify({ ok: true, user_id: created.user.id, username }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message || "Unknown error" }), {
      status: 400,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
