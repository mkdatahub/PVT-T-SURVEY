const DEFAULT_SALES = [
  { id: "d514d255-8b82-5710-971c-847c445bdc43", display_name: "คุณกิตติพงษ์", username: "kittipong" },
  { id: "6a445fea-5b89-5189-a55a-a58b0f22f5c3", display_name: "คุณจักรพันธ์", username: "jakkraphan" },
  { id: "955a7ad1-973f-50e4-8b12-346a51886fdf", display_name: "คุณฐาปนี", username: "thapanee" },
  { id: "7fea3301-3316-5e1c-836f-580d9df9bd24", display_name: "คุณพิชัย", username: "pichai" },
  { id: "e5e246ce-f117-51d4-8f08-a5fc69fd5ab2", display_name: "คุณวิรุฬห์", username: "wirun" },
  { id: "4efef0a9-4a63-541d-8d4e-7914d647bcf9", display_name: "คุณอรญา", username: "oraya" },
  { id: "c03a7c5e-ccc8-559d-9223-3379b540f53d", display_name: "บริษัท", username: "company" },
];

let SALES_LIST = [...DEFAULT_SALES];

document.addEventListener("DOMContentLoaded", async () => {
  PVT.requireConfigured();
  if (!PVT.db) return;

  // If already logged in, redirect right away
  const ctx = await PVT.getSessionProfile();
  if (ctx) {
    location.href = ctx.profile.role === "sales" ? "survey.html" : "admin.html";
    return;
  }

  setupTabs();
  await initSalesLogin();
  setupAdminLogin();
});

function setupTabs() {
  const tabs = document.querySelectorAll(".login-tabs .tab-btn");
  tabs.forEach(btn => {
    btn.addEventListener("click", () => {
      tabs.forEach(t => t.classList.remove("active"));
      btn.classList.add("active");
      const targetId = btn.dataset.target;
      document.querySelectorAll(".login-panel").forEach(p => {
        p.classList.toggle("active", p.id === targetId);
      });
    });
  });
}

async function initSalesLogin() {
  const select = document.getElementById("salesperson-select");
  const chipsContainer = document.getElementById("sales-chips");
  const customField = document.getElementById("custom-name-field");
  const customInput = document.getElementById("custom-name-input");
  const form = document.getElementById("sales-login-form");
  const rememberCheckbox = document.getElementById("remember-salesperson");

  // Try fetching dynamic list from database
  try {
    const { data, error } = await PVT.db
      .from("sales_people")
      .select("id,display_name")
      .eq("is_active", true)
      .order("display_name");
    if (!error && data && data.length) {
      SALES_LIST = data;
    }
  } catch (e) {
    console.warn("Using default sales list:", e);
  }

  // Populate select dropdown
  select.innerHTML = `<option value="">-- กรุณาเลือกชื่อของคุณ --</option>` +
    SALES_LIST.map(s => `<option value="${s.id}">${PVT.escapeHtml(s.display_name)}</option>`).join("") +
    `<option value="__custom__">+ พิมพ์ชื่ออื่น...</option>`;

  // Populate quick selection chips if element exists
  if (chipsContainer) {
    chipsContainer.innerHTML = SALES_LIST.map(s => `
      <button type="button" class="sales-chip" data-id="${s.id}" data-name="${PVT.escapeHtml(s.display_name)}">
        ${PVT.escapeHtml(s.display_name)}
      </button>
    `).join("");

    // Select chip handler
    chipsContainer.querySelectorAll(".sales-chip").forEach(chip => {
      chip.addEventListener("click", () => {
        chipsContainer.querySelectorAll(".sales-chip").forEach(c => c.classList.remove("active"));
        chip.classList.add("active");
        select.value = chip.dataset.id;
        customField.classList.add("hidden");
        customInput.required = false;
      });
    });
  }

  // Handle select change
  select.addEventListener("change", () => {
    const val = select.value;
    if (chipsContainer) {
      chipsContainer.querySelectorAll(".sales-chip").forEach(c => {
        c.classList.toggle("active", c.dataset.id === val);
      });
    }
    if (val === "__custom__") {
      customField.classList.remove("hidden");
      customInput.required = true;
      customInput.focus();
    } else {
      customField.classList.add("hidden");
      customInput.required = false;
    }
  });

  // Check remembered salesperson
  const savedId = localStorage.getItem("pvt_last_salesperson_id");
  if (savedId) {
    select.value = savedId;
    if (chipsContainer) {
      const matchingChip = chipsContainer.querySelector(`[data-id="${savedId}"]`);
      if (matchingChip) matchingChip.classList.add("active");
    }
  }

  // Handle sales login submission (No password needed!)
  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const btn = document.getElementById("sales-submit-btn");
    const val = select.value;
    if (!val) {
      PVT.toast("กรุณาเลือกชื่อของคุณ", "warning");
      select.focus();
      return;
    }

    let salespersonId = null;
    let displayName = "";

    if (val === "__custom__") {
      displayName = customInput.value.trim();
      if (!displayName) {
        PVT.toast("กรุณาพิมพ์ชื่อของท่าน", "warning");
        customInput.focus();
        return;
      }
      // Check if custom typed name matches any known salesperson
      const matched = SALES_LIST.find(s => 
        displayName.includes(s.display_name.replace("คุณ","").trim()) ||
        s.display_name.includes(displayName)
      );
      salespersonId = matched ? matched.id : "c03a7c5e-ccc8-559d-9223-3379b540f53d"; // default to company UUID
    } else {
      const found = SALES_LIST.find(s => s.id === val);
      if (!found) {
        PVT.toast("ไม่พบข้อมูลเซลล์ที่เลือก", "error");
        return;
      }
      salespersonId = found.id;
      displayName = found.display_name;
    }

    PVT.setBusy(btn, true, "กำลังเข้าสู่ระบบ...");

    try {
      // Remember selection on device if checked
      if (rememberCheckbox && rememberCheckbox.checked && val !== "__custom__") {
        localStorage.setItem("pvt_last_salesperson_id", salespersonId);
      } else {
        localStorage.removeItem("pvt_last_salesperson_id");
      }

      // Save sales session (Name-only, no password required)
      const salesProfile = {
        salesperson_id: salespersonId,
        display_name: displayName,
        username: displayName,
        role: "sales",
        is_active: true
      };
      PVT.setSalesSession(salesProfile);

      // Attempt background Supabase sign-in if default account exists
      if (PVT.db && PVT.db.auth) {
        try {
          const email = `${displayName.replace(/\s+/g, '').toLowerCase()}@pvt.local`;
          await PVT.db.auth.signInWithPassword({ email, password: "sales" });
        } catch (authErr) {
          // Silent fallback - passwordless local session takes charge
        }
      }

      PVT.toast(`ยินดีต้อนรับ ${displayName}`, "success");
      const next = PVT.params().get("next");
      setTimeout(() => {
        location.href = next || "survey.html";
      }, 250);
    } catch (err) {
      PVT.toast(err.message || "เกิดข้อผิดพลาดในการเข้าสู่ระบบ", "error");
    } finally {
      PVT.setBusy(btn, false);
    }
  });
}

function setupAdminLogin() {
  const form = document.getElementById("login-form");
  if (!form) return;
  form.addEventListener("submit", async e => {
    e.preventDefault();
    const btn = form.querySelector("button[type=submit]");
    PVT.setBusy(btn, true, "กำลังเข้าสู่ระบบ...");
    try {
      let username = document.getElementById("username").value.trim();
      const password = document.getElementById("password").value;
      const email = username.includes("@") ? username : `${username}@pvt.local`;
      
      let authenticated = false;

      // 1. Try Supabase Auth
      if (PVT.db && PVT.db.auth) {
        try {
          const { error } = await PVT.db.auth.signInWithPassword({ email, password });
          if (!error) {
            const ctx = await PVT.getSessionProfile();
            if (ctx && (ctx.profile.role === "admin" || ctx.profile.role === "management")) {
              authenticated = true;
            }
          }
        } catch (supabaseErr) {
          console.warn("Supabase auth check notice:", supabaseErr);
        }
      }

      // 2. Admin fallback if Supabase Auth user not created yet
      if (!authenticated) {
        const uLower = username.toLowerCase();
        const isAdminCred = (uLower === "admin" || uLower === "administrator") && 
          (password === "admin" || password === "admin1234" || password === "pvt2026" || password === "1234" || password === "password");
        const isMgmtCred = (uLower === "management" || uLower === "manager") &&
          (password === "management" || password === "pvt2026" || password === "1234");

        if (isAdminCred || isMgmtCred) {
          PVT.setAdminSession({
            auth_user_id: "00000000-0000-0000-0000-000000000001",
            username: username,
            display_name: isMgmtCred ? "ผู้บริหาร (Management)" : "ผู้ดูแลระบบ (Admin)",
            role: isMgmtCred ? "management" : "admin",
            is_active: true
          });
          authenticated = true;
        }
      }

      if (!authenticated) {
        throw new Error("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง (สำหรับเข้าทดสอบสามารถใช้ admin / admin)");
      }

      PVT.toast("เข้าสู่ระบบสำเร็จ", "success");
      const next = PVT.params().get("next");
      setTimeout(() => {
        location.href = next || "admin.html";
      }, 200);
    } catch (err) {
      PVT.toast(err.message || "เข้าสู่ระบบไม่สำเร็จ", "error");
    } finally {
      PVT.setBusy(btn, false);
    }
  });
}
