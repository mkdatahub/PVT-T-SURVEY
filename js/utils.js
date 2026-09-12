window.PVT = window.PVT || {};

PVT.escapeHtml = (value="") => String(value ?? "")
  .replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;")
  .replaceAll('"',"&quot;").replaceAll("'","&#039;");

PVT.qs = (sel, root=document) => root.querySelector(sel);
PVT.qsa = (sel, root=document) => [...root.querySelectorAll(sel)];

PVT.params = () => new URLSearchParams(location.search);

PVT.toast = (message, type="success") => {
  let el = document.getElementById("app-toast");
  if (!el) {
    el = document.createElement("div");
    el.id = "app-toast";
    Object.assign(el.style,{
      position:"fixed",right:"16px",bottom:"16px",zIndex:99,maxWidth:"min(420px,calc(100vw - 32px))"
    });
    document.body.appendChild(el);
  }
  el.innerHTML = `<div class="notice ${type === "error" ? "error" : type === "success" ? "success" : ""}" style="box-shadow:0 12px 35px rgba(0,0,0,.16)">${PVT.escapeHtml(message)}</div>`;
  clearTimeout(PVT._toastTimer);
  PVT._toastTimer=setTimeout(()=>el.innerHTML="",3500);
};

PVT.setBusy = (button, busy, label="กำลังทำรายการ...") => {
  if (!button) return;
  if (busy) {
    button.dataset.originalText = button.innerHTML;
    button.disabled = true;
    button.innerHTML = label;
  } else {
    button.disabled = false;
    if (button.dataset.originalText) button.innerHTML = button.dataset.originalText;
  }
};

PVT.formatDateTime = (iso) => {
  if (!iso) return "-";
  try { return new Intl.DateTimeFormat("th-TH",{dateStyle:"medium",timeStyle:"short"}).format(new Date(iso)); }
  catch { return iso; }
};

PVT.formatDate = (iso) => {
  if (!iso) return "-";
  try { return new Intl.DateTimeFormat("th-TH",{dateStyle:"medium"}).format(new Date(iso)); }
  catch { return iso; }
};

PVT.downloadCSV = (filename, rows) => {
  if (!rows?.length) return PVT.toast("ไม่มีข้อมูลสำหรับ Export","error");
  const headers = Object.keys(rows[0]);
  const csv = [
    headers.join(","),
    ...rows.map(row=>headers.map(h=>{
      const v = row[h] ?? "";
      return `"${String(v).replaceAll('"','""')}"`;
    }).join(","))
  ].join("\n");
  const blob = new Blob(["\ufeff"+csv], {type:"text/csv;charset=utf-8"});
  const a=document.createElement("a");
  a.href=URL.createObjectURL(blob); a.download=filename; a.click();
  setTimeout(()=>URL.revokeObjectURL(a.href),1000);
};


PVT.fetchAll = async (makeQuery, {pageSize=1000,maxRows=50000}={}) => {
  const all=[];
  for(let from=0; from<maxRows; from+=pageSize){
    const {data,error}=await makeQuery().range(from,from+pageSize-1);
    if(error) throw error;
    all.push(...(data||[]));
    if(!data || data.length<pageSize) break;
  }
  return all;
};

PVT.requireConfigured = () => {
  const c=window.PVT_SURVEY_CONFIG || {};
  const ok=c.SUPABASE_URL && !c.SUPABASE_URL.includes("YOUR_PROJECT")
    && c.SUPABASE_ANON_KEY && !c.SUPABASE_ANON_KEY.includes("YOUR_SUPABASE");
  if (!ok) {
    const box=document.createElement("div");
    box.className="notice error";
    box.style.margin="12px";
    box.innerHTML="<strong>ยังไม่ได้ตั้งค่า Supabase</strong><br>แก้ไฟล์ <code>js/config.js</code> แล้วใส่ SUPABASE_URL และ SUPABASE_ANON_KEY ก่อนใช้งานจริง";
    document.body.prepend(box);
  }
  return ok;
};

PVT.getPublicBaseUrl = () => {
  const custom = window.PVT_SURVEY_CONFIG?.PUBLIC_BASE_URL;
  if (custom && typeof custom === "string" && custom.trim() && !custom.includes("YOUR_") && custom !== "window.location.origin") {
    return custom.trim().replace(/\/$/, "");
  }
  return window.location.origin.replace(/\/$/, "");
};

PVT.isUuid = (val) => {
  if (!val || typeof val !== "string") return false;
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(val.trim());
};

PVT.toValidUuid = (val) => {
  if (!val || typeof val !== "string") return "00000000-0000-4000-8000-000000000001";
  const trimmed = val.trim();
  if (PVT.isUuid(trimmed)) return trimmed;

  const stdMap = {
    "std_q1_dealer": "00000000-0000-4000-8000-000000000101",
    "std_q2_dealer": "00000000-0000-4000-8000-000000000102",
    "std_q3_dealer": "00000000-0000-4000-8000-000000000103",
    "std_q4_dealer": "00000000-0000-4000-8000-000000000104",
    "std_q5_dealer": "00000000-0000-4000-8000-000000000105",
    "std_q1_farmer": "00000000-0000-4000-8000-000000000201",
    "std_q2_farmer": "00000000-0000-4000-8000-000000000202",
    "std_q3_farmer": "00000000-0000-4000-8000-000000000203",
    "std_q4_farmer": "00000000-0000-4000-8000-000000000204",
    "std_q5_farmer": "00000000-0000-4000-8000-000000000205"
  };
  if (stdMap[trimmed]) return stdMap[trimmed];

  let hash = 0;
  for (let i = 0; i < trimmed.length; i++) {
    hash = ((hash << 5) - hash) + trimmed.charCodeAt(i);
    hash |= 0;
  }
  const hex = Math.abs(hash).toString(16).padStart(12, "0").slice(0, 12);
  return `00000000-0000-4000-8000-${hex}`;
};

PVT.ensureQuestionsExistInDb = async (questions, productId = null, respondentType = "dealer") => {
  if (!PVT.db || !questions || !Array.isArray(questions) || !questions.length) return;
  try {
    const rows = questions.map((q, idx) => {
      const validId = PVT.toValidUuid(q.id);
      let qType = (q.question_type || "checkbox").toLowerCase();
      if (!["checkbox", "rating_grid", "single_choice", "scale", "text"].includes(qType)) {
        qType = "checkbox";
      }
      return {
        id: validId,
        product_id: PVT.isUuid(productId) ? productId : (PVT.isUuid(q.product_id) ? q.product_id : "22903454-9bc7-5025-a316-8050c7704a17"),
        respondent_type: (respondentType === "farmer" || respondentType === "dealer") ? respondentType : "dealer",
        question_no: q.question_no || (idx + 1),
        question_type: qType,
        prompt: q.prompt || `คำถามที่ ${idx + 1}`,
        required: q.required !== false,
        sort_order: q.sort_order || (idx + 1)
      };
    });
    await PVT.db.from("survey_questions").upsert(rows, { onConflict: "id", ignoreDuplicates: true });
  } catch (e) {
    console.warn("Notice ensuring survey questions in DB:", e);
  }
};

PVT.normalizeCustomer = (c) => {
  if (!c) return null;
  const client_name = (c.client_name || c.shop_name || "").trim();
  const client_id = (c.client_id || c.shop_code || "").trim();
  const province = (c.province_normalized || c.province_raw || c.province || "").trim();
  const salesperson_id = c.salesperson_id || c.sale_id || null;
  return {
    ...c,
    client_name: client_name || "ร้านค้า",
    shop_name: client_name || "ร้านค้า",
    client_id: client_id || "-",
    shop_code: client_id || "-",
    province_raw: province || "-",
    province_normalized: province || "-",
    salesperson_id: salesperson_id,
    sale_id: salesperson_id
  };
};

PVT.dedupeCustomers = (list) => {
  if (!Array.isArray(list)) return [];
  const keyToItem = new Map();
  const resultList = [];
  const normStr = (s) => (s || "").replace(/[\u00a0\s]+/g, "").toLowerCase().trim();

  list.forEach(item => {
    if (!item) return;
    const norm = PVT.normalizeCustomer(item);
    if (!norm) return;

    const code = normStr(norm.client_id || norm.shop_code).toUpperCase();
    const cleanName = normStr(norm.client_name || norm.shop_name).replace(/\/[a-z0-9ก-ฮ]+/g, "");
    const prov = normStr(norm.province_normalized || norm.province_raw || norm.province);

    const keys = [];
    if (code && code !== "-" && code !== "N/A") {
      keys.push(`CODE:${code}`);
    }
    if (cleanName) {
      keys.push(`NAME:${cleanName}|PROV:${prov}`);
    }
    if (norm.id && PVT.isUuid(norm.id)) {
      keys.push(`UUID:${norm.id.toLowerCase()}`);
    }

    let existing = null;
    for (const k of keys) {
      if (keyToItem.has(k)) {
        existing = keyToItem.get(k);
        break;
      }
    }

    if (existing) {
      // Merge properties safely
      if (!PVT.isUuid(existing.id) && PVT.isUuid(norm.id)) {
        existing.id = norm.id;
      }
      if (!existing.salesperson_id && norm.salesperson_id) {
        existing.salesperson_id = norm.salesperson_id;
        existing.sale_id = norm.salesperson_id;
      }
      if ((!existing.client_id || existing.client_id === "-") && norm.client_id && norm.client_id !== "-") {
        existing.client_id = norm.client_id;
        existing.shop_code = norm.client_id;
      }
      if (norm.client_name && norm.client_name !== "ร้านค้า" && norm.client_name.length > (existing.client_name || "").length) {
        existing.client_name = norm.client_name;
        existing.shop_name = norm.client_name;
      }
      if ((!existing.province_normalized || existing.province_normalized === "-") && norm.province_normalized) {
        existing.province_raw = norm.province_normalized;
        existing.province_normalized = norm.province_normalized;
      }
      keys.forEach(k => keyToItem.set(k, existing));
    } else {
      const newObj = { ...norm };
      resultList.push(newObj);
      keys.forEach(k => keyToItem.set(k, newObj));
    }
  });

  return resultList;
};

PVT._seedCustomersCache = null;
PVT.getSeedCustomers = async () => {
  if (PVT._seedCustomersCache && PVT._seedCustomersCache.length) {
    return PVT._seedCustomersCache;
  }
  try {
    const res = await fetch("data/customers_seed.json");
    if (res.ok) {
      const raw = await res.json();
      PVT._seedCustomersCache = PVT.dedupeCustomers(raw);
      return PVT._seedCustomersCache;
    }
  } catch (e) {
    console.warn("Could not fetch data/customers_seed.json:", e);
  }
  return [];
};

PVT.resolveCustomer = async (identifier) => {
  if (!identifier) return null;
  const str = String(identifier).trim();

  // 0. Check session storage and memory objects first for instant resolution
  try {
    const saved = sessionStorage.getItem("pvt_active_customer");
    if (saved) {
      const parsed = JSON.parse(saved);
      if (parsed && (parsed.id === str || parsed.client_id === str || parsed.client_name === str)) {
        return parsed;
      }
    }
  } catch (e) {}

  if (typeof window !== "undefined") {
    if (window.CUSTOMER && (window.CUSTOMER.id === str || window.CUSTOMER.client_id === str || window.CUSTOMER.client_name === str)) {
      return window.CUSTOMER;
    }
    if (Array.isArray(window.MY_CUSTOMERS)) {
      const found = window.MY_CUSTOMERS.find(c => c.id === str || c.client_id === str || c.client_name === str);
      if (found) return found;
    }
    if (Array.isArray(window.A_CUSTOMERS)) {
      const found = window.A_CUSTOMERS.find(c => c.id === str || c.client_id === str || c.client_name === str);
      if (found) return found;
    }
  }

  // 1. Try DB lookup if valid UUID
  if (PVT.isUuid(str) && PVT.db) {
    try {
      const { data, error } = await PVT.db.from("customers").select("*").eq("id", str).maybeSingle();
      if (!error && data) return data;
    } catch (err) {
      console.warn("DB customer query notice:", err);
    }
  }

  // 2. Lookup in seed list
  const seedList = await PVT.getSeedCustomers();
  if (seedList && seedList.length) {
    // Exact UUID match
    let found = seedList.find(c => c.id.toLowerCase() === str.toLowerCase());
    if (found) return found;

    // "cust-seed-X" or row number match
    const cleanNum = str.replace(/^cust-seed-/i, "");
    if (/^\d+$/.test(cleanNum)) {
      const num = parseInt(cleanNum, 10);
      found = seedList.find(c => c.source_row === num);
      if (found) return found;
    }

    // Client ID match (e.g. "ก031")
    found = seedList.find(c => c.client_id === str);
    if (found) return found;

    // Client name match
    found = seedList.find(c => c.client_name === str);
    if (found) return found;
  }

  return null;
};

PVT.DEFAULT_SALES = [
  { id: "d514d255-8b82-5710-971c-847c445bdc43", display_name: "คุณกิตติพงษ์", username: "kittipong" },
  { id: "6a445fea-5b89-5189-a55a-a58b0f22f5c3", display_name: "คุณจักรพันธ์", username: "jakkraphan" },
  { id: "955a7ad1-973f-50e4-8b12-346a51886fdf", display_name: "คุณฐาปนี", username: "thapanee" },
  { id: "7fea3301-3316-5e1c-836f-580d9df9bd24", display_name: "คุณพิชัย", username: "pichai" },
  { id: "e5e246ce-f117-51d4-8f08-a5fc69fd5ab2", display_name: "คุณวิรุฬห์", username: "wirun" },
  { id: "4efef0a9-4a63-541d-8d4e-7914d647bcf9", display_name: "คุณอรญา", username: "oraya" },
  { id: "c03a7c5e-ccc8-559d-9223-3379b540f53d", display_name: "บริษัท (ส่วนกลาง)", username: "company" },
];

PVT.getOfflineResponses = () => {
  try {
    const list = JSON.parse(localStorage.getItem("pvt_offline_responses") || "[]");
    return Array.isArray(list) ? list : [];
  } catch (e) {
    return [];
  }
};

PVT.saveOfflineResponse = (record) => {
  if (!record) return;
  try {
    const list = PVT.getOfflineResponses();
    const idx = list.findIndex(r => r.id === record.id);
    if (idx >= 0) {
      list[idx] = { ...list[idx], ...record };
    } else {
      list.unshift(record);
    }
    localStorage.setItem("pvt_offline_responses", JSON.stringify(list));
  } catch (e) {
    console.warn("Could not save offline response to localStorage:", e);
  }
};
