-- First admin bootstrap
-- 1) In Supabase Dashboard > Authentication > Users, create the first user.
--    Recommended email format: admin@pvt.local
-- 2) Copy that user's UUID and replace YOUR_AUTH_USER_UUID below.
-- 3) Run this statement once.

insert into public.profiles(auth_user_id,username,display_name,role,salesperson_id)
values (
  'YOUR_AUTH_USER_UUID'::uuid,
  'admin',
  'Administrator',
  'admin',
  null
)
on conflict(auth_user_id) do update
set username=excluded.username, display_name=excluded.display_name, role='admin', is_active=true;
