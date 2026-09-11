window.PVT_SURVEY_CONFIG = {
  // ใส่ค่าจาก Supabase Project Settings > API
  SUPABASE_URL: "https://YOUR_PROJECT.supabase.co",
  SUPABASE_ANON_KEY: "YOUR_SUPABASE_ANON_KEY",

  // ปล่อยเป็น window.location.origin ได้เมื่อ deploy แล้ว
  PUBLIC_BASE_URL: window.location.origin
};
