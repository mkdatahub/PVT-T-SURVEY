let SALES_CTX=null, CUSTOMERS=[], CAMPAIGNS=[], PRODUCTS=[], INVITES=[], RESPONSES=[];
let SALES_QUESTIONS=[], SALES_OPTIONS=[], SALES_ANSWERS=[];
let STORE_SCOPE="all"; // "all", "responded", "pending"

function getProductIcon(code, size = 16) {
  return PVT.productIcon ? PVT.productIcon(code, { size }) : `<span class="pvt-icon pvt-icon-package"></span>`;
}

document.addEventListener("DOMContentLoaded", async()=>{
  PVT.requireConfigured();
  SALES_CTX=await PVT.requireAuth(["sales","admin","management"]);
  if(!SALES_CTX) return;

  const displayName = SALES_CTX?.profile?.display_name || "ฝ่ายขาย";
  const userSub = document.getElementById("dash-user-subtitle");
  if (userSub) userSub.textContent = `พนักงาน: ${displayName}`;

  await Promise.all([
    loadCampaigns(),
    loadProducts(),
    loadCustomers(),
    loadInvites(),
    loadResponses(),
    loadSurveyMetadata()
  ]);

  populateDashboardFilterOptions();
  bindSalesEvents();
  bindDashboardEvents();
  renderDashboard();
  renderCustomers();
  await renderSalesKpis();
});

async function loadCampaigns(){
  try{
    const {data,error}=await PVT.db.from("survey_campaigns").select("*").order("start_date",{ascending:false});
    if(!error && data && data.length) CAMPAIGNS=data;
  }catch(e){
    console.warn("Load campaigns notice:", e);
  }
  if(!CAMPAIGNS.length){
    CAMPAIGNS=[{
      id: "c0000000-0000-0000-0000-000000000001",
      name: "สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026",
      is_active: true
    }];
  }
  const sel=document.getElementById("campaign-filter");
  if (sel) {
    sel.innerHTML=`<option value="">ทุก Campaign</option>`+CAMPAIGNS.map(c=>`<option value="${c.id}">${PVT.escapeHtml(c.name)}${c.is_active?" • Active":""}</option>`).join("");
  }
}

async function loadProducts(){
  PRODUCTS=await PVT.loadProducts("dealer");
  if (!PRODUCTS.length) {
    PRODUCTS = [
      { id: "p0000000-0000-0000-0000-000000000001", code: "GREENHOUSE", name_th: "พลาสติกโรงเรือน (Green House)", name_en: "Greenhouse Film" },
      { id: "p0000000-0000-0000-0000-000000000002", code: "SHADE_NET", name_th: "แสลนกรองแสง (Shade Net)", name_en: "Shading Net" },
      { id: "p0000000-0000-0000-0000-000000000003", code: "POND_LINER", name_th: "ผ้าปูบ่อ (Pond Liner)", name_en: "Geomembrane" },
      { id: "p0000000-0000-0000-0000-000000000004", code: "MULCH_FILM", name_th: "ดำเงิน / พลาสติกคลุมดิน", name_en: "Mulch Film" },
      { id: "p0000000-0000-0000-0000-000000000005", code: "PE_PIPE", name_th: "ท่อ PE / HDPE / LDPE", name_en: "PE Pipes" },
      { id: "p0000000-0000-0000-0000-000000000006", code: "NURSERY_BAG", name_th: "ถุงเพาะชำ ตราต้นไม้", name_en: "Nursery Bags" },
      { id: "p0000000-0000-0000-0000-000000000007", code: "DRIP_TAPE", name_th: "เทปน้ำพุ่ง / เทปน้ำหยด", name_en: "Drip / Spray Tape" },
      { id: "p0000000-0000-0000-0000-000000000008", code: "GENERAL_BAG", name_th: "ถุงเอนกประสงค์ / ถุงขยะ", name_en: "General Bags" }
    ];
  }
}

async function loadCustomers(){
  let loaded = [];
  try {
    let query = PVT.db.from("customers").select("*");
    const {data,error}=await query;
    if(!error && data && data.length){
      loaded = data;
    }
  } catch(e) {
    console.warn("Database customer query notice:", e);
  }

  // Always merge with seed list for full coverage
  try {
    const seedList = await PVT.getSeedCustomers();
    if (seedList && seedList.length) {
      loaded = [...loaded, ...seedList];
    }
  } catch (seedErr) {
    console.warn("Could not load seed customers:", seedErr);
  }

  // Deduplicate first
  let allClean = PVT.dedupeCustomers(loaded);

  // Filter by sales profile if logged in as salesperson
  const myName = (SALES_CTX?.profile?.display_name || "").trim();
  const myId = SALES_CTX?.profile?.salesperson_id;

  if (SALES_CTX?.profile?.role === "sales" && myName && myName !== "บริษัท") {
    let filtered = [];
    if (myId && PVT.isUuid(myId)) {
      filtered = allClean.filter(r => r.salesperson_id === myId || r.sale_id === myId);
    }
    if (!filtered.length && myName) {
      filtered = allClean.filter(r => r.employee_name && (r.employee_name.includes(myName) || myName.includes(r.employee_name)));
    }
    CUSTOMERS = filtered.length ? filtered : allClean;
  } else {
    CUSTOMERS = allClean;
  }

  // Sort alphabetically
  CUSTOMERS.sort((a, b) => (a.client_name || "").localeCompare(b.client_name || "", "th"));

  const provinces=[...new Set(CUSTOMERS.map(c=>c.province_normalized||c.province_raw).filter(Boolean))].sort((a,b)=>a.localeCompare(b,"th"));
  const pSel = document.getElementById("province-filter");
  if (pSel) {
    pSel.innerHTML=`<option value="">ทุกจังหวัด/พื้นที่</option>`+provinces.map(p=>`<option>${PVT.escapeHtml(p)}</option>`).join("");
  }
}

async function loadInvites(){
  try {
    INVITES=await PVT.fetchAll(()=>PVT.db.from("survey_invites")
      .select("id,customer_id,campaign_id,product_id,status,created_at,completed_at,token")
      .order("created_at",{ascending:false}),{maxRows:10000});
  } catch(e) {
    console.warn("Load invites notice:", e);
    INVITES=[];
  }
}

async function loadResponses(){
  let loaded = [];
  try {
    // 1. Try response_overview view
    let query = PVT.db.from("response_overview").select("*");
    if (SALES_CTX?.profile?.role === "sales" && SALES_CTX.profile.salesperson_id && PVT.isUuid(SALES_CTX.profile.salesperson_id)) {
      query = query.eq("salesperson_id", SALES_CTX.profile.salesperson_id);
    }
    const { data, error } = await query.order("submitted_at", { ascending: false });
    if (!error && data) {
      loaded = data;
    }
  } catch (err) {
    console.warn("Error querying response_overview view:", err);
  }

  // 2. Direct query fallback
  if (!loaded.length) {
    try {
      let query = PVT.db.from("survey_responses")
        .select("id,campaign_id,customer_id,salesperson_id,product_id,respondent_type,source,respondent_name,nps_score,submitted_at");
      if (SALES_CTX?.profile?.role === "sales" && SALES_CTX.profile.salesperson_id && PVT.isUuid(SALES_CTX.profile.salesperson_id)) {
        query = query.eq("salesperson_id", SALES_CTX.profile.salesperson_id);
      }
      const { data, error } = await query.order("submitted_at", { ascending: false });
      if (!error && data && data.length) {
        loaded = data.map(r => {
          const cust = CUSTOMERS.find(c => c.id === r.customer_id);
          const prod = PRODUCTS.find(p => p.id === r.product_id);
          const camp = CAMPAIGNS.find(c => c.id === r.campaign_id);
          return {
            ...r,
            client_id: cust?.client_id || "-",
            client_name: cust?.client_name || r.respondent_name || "ร้านค้าตัวแทน",
            province: cust?.province_normalized || cust?.province_raw || "-",
            product_name: prod?.name_th || "ผลิตภัณฑ์ตราต้นไม้",
            product_code: prod?.code || "GENERAL",
            campaign_name: camp?.name || "สำรวจ 2026"
          };
        });
      }
    } catch (directErr) {
      console.warn("Direct survey_responses notice:", directErr);
    }
  }

  // 3. Merge offline / client-side storage
  try {
    const offlineList = JSON.parse(localStorage.getItem("pvt_offline_responses") || "[]");
    if (offlineList.length) {
      const myCustIds = new Set(CUSTOMERS.map(c => c.id));
      offlineList.forEach(off => {
        if (!myCustIds.size || myCustIds.has(off.customer_id)) {
          const cust = CUSTOMERS.find(c => c.id === off.customer_id);
          const prod = PRODUCTS.find(p => p.id === off.product_id);
          const camp = CAMPAIGNS.find(c => c.id === off.campaign_id);
          if (!loaded.some(r => r.id === off.id)) {
            loaded.unshift({
              id: off.id,
              submitted_at: off.created_at || off.submitted_at || new Date().toISOString(),
              source: off.source || "sales",
              respondent_type: off.respondent_type || "dealer",
              respondent_name: off.respondent_name || cust?.client_name || "ร้านค้า",
              nps_score: off.nps_score || null,
              customer_id: off.customer_id,
              client_id: cust?.client_id || "-",
              client_name: cust?.client_name || off.customer_name || "ร้านค้าตัวแทน",
              province: cust?.province_normalized || cust?.province_raw || "-",
              salesperson_id: off.salesperson_id || SALES_CTX?.profile?.salesperson_id,
              product_id: off.product_id,
              product_name: prod?.name_th || "ผลิตภัณฑ์ตราต้นไม้",
              product_code: prod?.code || "GENERAL",
              campaign_id: off.campaign_id,
              campaign_name: camp?.name || "สำรวจ 2026",
              is_offline: true
            });
          }
        }
      });
    }
  } catch (e) {}

  RESPONSES = loaded;
  window.RESPONSES = RESPONSES;
  window.CUSTOMERS = CUSTOMERS;
  window.PRODUCTS = PRODUCTS;
  window.CAMPAIGNS = CAMPAIGNS;
}

async function loadSurveyMetadata() {
  try {
    const [qRes, oRes, aRes] = await Promise.allSettled([
      PVT.db.from("survey_questions").select("id,product_id,respondent_type,question_no,question_type,prompt"),
      PVT.db.from("survey_question_options").select("id,question_id,option_text,is_other"),
      PVT.fetchAll(() => PVT.db.from("survey_answers").select("id,response_id,question_id,answer_json"), { maxRows: 50000 })
    ]);

    SALES_QUESTIONS = (qRes.status === "fulfilled" && qRes.value?.data) ? qRes.value.data : [];
    SALES_OPTIONS = (oRes.status === "fulfilled" && oRes.value?.data) ? oRes.value.data : [];
    SALES_ANSWERS = (aRes.status === "fulfilled" && Array.isArray(aRes.value)) ? aRes.value : [];
  } catch (e) {
    console.warn("Notice loading survey metadata in sales:", e);
  }

  // Merge embedded answers from RESPONSES / offline storage
  for (const r of RESPONSES) {
    if (Array.isArray(r.answers) && r.answers.length) {
      for (const ansItem of r.answers) {
        if (!SALES_ANSWERS.some(a => a.response_id === r.id && a.question_id === ansItem.question_id)) {
          SALES_ANSWERS.push({
            id: `ans-${r.id}-${ansItem.question_id}`,
            response_id: r.id,
            question_id: ansItem.question_id,
            answer_json: ansItem.answer
          });
        }
      }
    }
  }

  window.SALES_QUESTIONS = SALES_QUESTIONS;
  window.SALES_OPTIONS = SALES_OPTIONS;
  window.SALES_ANSWERS = SALES_ANSWERS;
}

function populateDashboardFilterOptions() {
  const campSel = document.getElementById("dash-filter-campaign");
  if (campSel) {
    campSel.innerHTML = `<option value="">ทุก Campaign</option>` +
      CAMPAIGNS.map(c => `<option value="${c.id}">${PVT.escapeHtml(c.name)}</option>`).join("");
  }

  const prodSel = document.getElementById("dash-filter-product");
  if (prodSel) {
    prodSel.innerHTML = `<option value="">ทุกผลิตภัณฑ์ (${PRODUCTS.length})</option>` +
      PRODUCTS.map(p => {
        return `<option value="${p.id}">${PVT.escapeHtml(p.name_th || p.name)}</option>`;
      }).join("");
  }

  const provSel = document.getElementById("dash-filter-province");
  if (provSel) {
    const provinces = [...new Set(CUSTOMERS.map(c => c.province_normalized || c.province_raw).filter(Boolean))].sort((a,b)=>a.localeCompare(b,"th"));
    provSel.innerHTML = `<option value="">ทุกจังหวัด (${provinces.length})</option>` +
      provinces.map(p => `<option value="${PVT.escapeHtml(p)}">${PVT.escapeHtml(p)}</option>`).join("");
  }
}

function bindDashboardEvents() {
  // Main View Switcher
  const viewNav = document.querySelector(".sales-view-nav");
  if (viewNav) {
    viewNav.querySelectorAll("button").forEach(btn => {
      btn.addEventListener("click", () => {
        viewNav.querySelectorAll("button").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
        const targetViewId = btn.dataset.view;
        document.querySelectorAll(".tab-panel").forEach(p => p.classList.remove("active"));
        const targetPanel = document.getElementById(targetViewId);
        if (targetPanel) targetPanel.classList.add("active");
      });
    });
  }

  // Dashboard Subtabs
  const subtabs = document.querySelector(".dash-subtabs");
  if (subtabs) {
    subtabs.querySelectorAll(".dash-subtab-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        subtabs.querySelectorAll(".dash-subtab-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
        const targetSubId = btn.dataset.subpanel;
        document.querySelectorAll(".dash-subpanel").forEach(p => p.classList.remove("active"));
        const targetSub = document.getElementById(targetSubId);
        if (targetSub) targetSub.classList.add("active");
      });
    });
  }

  // Filter events
  ["dash-filter-campaign", "dash-filter-product", "dash-filter-province"].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.addEventListener("change", renderDashboard);
  });

  const searchInput = document.getElementById("dash-filter-search");
  if (searchInput) searchInput.addEventListener("input", renderDashboard);

  const resetBtn = document.getElementById("dash-reset-filter");
  if (resetBtn) {
    resetBtn.addEventListener("click", () => {
      document.getElementById("dash-filter-campaign").value = "";
      document.getElementById("dash-filter-product").value = "";
      document.getElementById("dash-filter-province").value = "";
      document.getElementById("dash-filter-search").value = "";
      renderDashboard();
    });
  }

  // Store Scope buttons (all, responded, pending)
  document.querySelectorAll(".store-scope-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".store-scope-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      if (btn.id === "store-scope-all") STORE_SCOPE = "all";
      else if (btn.id === "store-scope-responded") STORE_SCOPE = "responded";
      else if (btn.id === "store-scope-pending") STORE_SCOPE = "pending";
      renderStoreSummary(getFilteredResponses());
    });
  });

  // Action buttons
  const focusIncompleteBtn = document.getElementById("btn-focus-incomplete");
  if (focusIncompleteBtn) {
    focusIncompleteBtn.addEventListener("click", focusIncompleteShops);
  }

  const shareAllIncompleteBtn = document.getElementById("btn-share-all-incomplete");
  if (shareAllIncompleteBtn) {
    shareAllIncompleteBtn.addEventListener("click", () => openShareModal());
  }

  const refreshBtn = document.getElementById("dash-refresh-btn");
  if (refreshBtn) {
    refreshBtn.addEventListener("click", async () => {
      PVT.setBusy(refreshBtn, true, "กำลังโหลด...");
      await Promise.all([loadCustomers(), loadInvites(), loadResponses()]);
      renderDashboard();
      renderCustomers();
      await renderSalesKpis();
      PVT.setBusy(refreshBtn, false);
      PVT.toast("รีเฟรชข้อมูลล่าสุดเรียบร้อย", "success");
    });
  }

  const copyBtn = document.getElementById("dash-copy-btn");
  if (copyBtn) {
    copyBtn.addEventListener("click", copyDashboardSummary);
  }

  const exportBtn = document.getElementById("dash-export-btn");
  if (exportBtn) {
    exportBtn.addEventListener("click", exportDashboardCSV);
  }
}

function getFilteredResponses() {
  const campId = document.getElementById("dash-filter-campaign")?.value || "";
  const prodId = document.getElementById("dash-filter-product")?.value || "";
  const prov = document.getElementById("dash-filter-province")?.value || "";
  const term = (document.getElementById("dash-filter-search")?.value || "").trim().toLowerCase();

  return RESPONSES.filter(r => {
    if (campId && r.campaign_id !== campId) return false;
    if (prodId && r.product_id !== prodId) return false;
    if (prov && (r.province || "") !== prov) return false;
    if (term) {
      const matchText = `${r.client_name || ""} ${r.client_id || ""} ${r.product_name || ""} ${r.respondent_name || ""}`.toLowerCase();
      if (!matchText.includes(term)) return false;
    }
    return true;
  });
}

function focusIncompleteShops() {
  // Ensure dashboard is visible
  document.querySelectorAll(".sales-view-nav button").forEach(b => b.classList.remove("active"));
  const dashNavBtn = document.getElementById("tab-btn-dash");
  if (dashNavBtn) dashNavBtn.classList.add("active");
  document.querySelectorAll(".tab-panel").forEach(p => p.classList.remove("active"));
  const dashPanel = document.getElementById("panel-dashboard");
  if (dashPanel) dashPanel.classList.add("active");

  // Activate store subtab
  const subtabs = document.querySelector(".dash-subtabs");
  if (subtabs) {
    subtabs.querySelectorAll(".dash-subtab-btn").forEach(b => b.classList.remove("active"));
    const storeSubBtn = document.getElementById("subtab-btn-stores");
    if (storeSubBtn) storeSubBtn.classList.add("active");
    document.querySelectorAll(".dash-subpanel").forEach(p => p.classList.remove("active"));
    const subpanel = document.getElementById("subpanel-stores");
    if (subpanel) subpanel.classList.add("active");
  }

  // Set store scope to pending
  STORE_SCOPE = "pending";
  document.querySelectorAll(".store-scope-btn").forEach(b => b.classList.remove("active"));
  const pendingBtn = document.getElementById("store-scope-pending");
  if (pendingBtn) pendingBtn.classList.add("active");

  renderStoreSummary(getFilteredResponses());

  // Smooth scroll to the store summary table
  document.getElementById("subpanel-stores")?.scrollIntoView({ behavior: "smooth", block: "start" });
  PVT.toast("แสดงเฉพาะร้านค้าที่ยังไม่ตอบแบบสอบถาม เพื่อจัดลำดับการเข้าเยี่ยมหรือติดต่อ", "info");
}

function renderDashboard() {
  const filtered = getFilteredResponses();

  // 1. Top KPI Calculations
  const totalResponses = filtered.length;
  const dealerResponses = filtered.filter(r => !r.respondent_type || r.respondent_type === "dealer").length;
  const farmerResponses = filtered.filter(r => r.respondent_type === "farmer").length;

  const respondedCustIds = new Set(filtered.map(r => r.customer_id).filter(Boolean));
  const totalAssignedStores = CUSTOMERS.length;
  const coveragePercent = totalAssignedStores > 0 ? ((respondedCustIds.size / totalAssignedStores) * 100).toFixed(1) : "0.0";

  const evaluatedProdIds = new Set(filtered.map(r => r.product_id).filter(Boolean));
  const totalProducts = PRODUCTS.length;

  // Average Score
  const scoredResponses = filtered.filter(r => typeof r.nps_score === "number" && r.nps_score > 0);
  const avgScore = scoredResponses.length > 0 
    ? (scoredResponses.reduce((sum, r) => sum + r.nps_score, 0) / scoredResponses.length).toFixed(2)
    : "-";

  // Update DOM KPIs
  document.getElementById("dash-kpi-total").textContent = totalResponses.toLocaleString();
  document.getElementById("dash-kpi-source-sub").textContent = `ร้านค้า ${dealerResponses.toLocaleString()} • เกษตรกร ${farmerResponses.toLocaleString()} ชุด`;

  document.getElementById("dash-kpi-stores").textContent = respondedCustIds.size.toLocaleString();
  document.getElementById("dash-kpi-stores-sub").textContent = `จากทั้งหมด ${totalAssignedStores.toLocaleString()} ร้าน (${coveragePercent}%)`;

  document.getElementById("dash-kpi-products").textContent = evaluatedProdIds.size.toLocaleString();
  document.getElementById("dash-kpi-products-sub").textContent = `จากทั้งหมด ${totalProducts} ชนิดสินค้า`;

  document.getElementById("dash-kpi-score").textContent = avgScore !== "-" ? `${avgScore} ⭐` : "รอข้อมูล";
  document.getElementById("dash-kpi-score-sub").textContent = scoredResponses.length > 0 ? `จากคำตอบ ${scoredResponses.length} ชุด (สเกล 1-5)` : "ยังไม่มีข้อมูลคะแนน";

  // Update the new Dashboard Progress Card
  const progressPercentEl = document.getElementById("dash-progress-percentage");
  const progressFillEl = document.getElementById("dash-progress-bar-fill");
  const progressCountEl = document.getElementById("dash-progress-count");
  const progressStatusEl = document.getElementById("dash-progress-status-text");

  if (progressPercentEl) progressPercentEl.textContent = `${coveragePercent}%`;
  if (progressFillEl) progressFillEl.style.width = `${coveragePercent}%`;
  if (progressCountEl) {
    progressCountEl.textContent = `กรอกสำเร็จ ${respondedCustIds.size.toLocaleString()} จากทั้งหมด ${totalAssignedStores.toLocaleString()} ร้านค้า`;
  }
  
  // 1.1 Incomplete Surveys Action Banner Calculation & Render
  const incompleteStores = CUSTOMERS.filter(c => !respondedCustIds.has(c.id));
  const incompleteCount = incompleteStores.length;

  if (progressStatusEl) {
    const isCompleted = respondedCustIds.size >= totalAssignedStores && totalAssignedStores > 0;
    if (isCompleted) {
      progressStatusEl.textContent = "✓ เสร็จสมบูรณ์ทุกร้านค้า";
      progressStatusEl.className = "pill success";
    } else {
      progressStatusEl.textContent = `เหลืออีก ${incompleteCount} ร้าน`;
      progressStatusEl.className = "pill warning";
    }
  }

  const countEl = document.getElementById("incomplete-shops-count");
  if (countEl) countEl.textContent = incompleteCount.toLocaleString();
  const textEl = document.getElementById("incomplete-shops-text");
  if (textEl) textEl.textContent = `${incompleteCount.toLocaleString()} ร้าน`;

  const fillEl = document.getElementById("incomplete-progress-fill");
  if (fillEl) fillEl.style.width = `${coveragePercent}%`;
  const labelEl = document.getElementById("incomplete-progress-label");
  if (labelEl) labelEl.textContent = `${coveragePercent}% ตอบแล้ว (${respondedCustIds.size.toLocaleString()} / ${totalAssignedStores.toLocaleString()} ร้าน)`;

  const chipsContainer = document.getElementById("incomplete-shops-chips");
  if (chipsContainer) {
    if (incompleteCount === 0) {
      chipsContainer.innerHTML = `<span class="pill success" style="font-weight:750">✓ ครบถ้วนทุกร้านค้าที่รับผิดชอบแล้ว ยอดเยี่ยมมาก!</span>`;
    } else {
      const topPending = incompleteStores.slice(0, 6);
      chipsContainer.innerHTML = topPending.map(c => {
        const prov = c.province_normalized || c.province_raw || "";
        return `<span class="incomplete-store-pill" data-quick-visit="${c.id}" title="คลิกเพื่อเข้าเยี่ยมและบันทึกแบบสอบถามร้าน ${PVT.escapeHtml(c.client_name)}">${PVT.escapeHtml(c.client_name)} ${prov ? `(${PVT.escapeHtml(prov)})` : ''} ➔</span>`;
      }).join("") + (incompleteStores.length > 6 ? `<span id="chip-see-all-pending" class="small muted" style="font-weight:750;cursor:pointer;text-decoration:underline;display:inline-flex;align-items:center;padding:4px 6px">+ ดูร้านที่ยังไม่ตอบทั้งหมด (${incompleteCount} ร้าน)</span>` : "");
      
      chipsContainer.querySelectorAll("[data-quick-visit]").forEach(chip => {
        chip.addEventListener("click", () => {
          const custId = chip.dataset.quickVisit;
          window.location.href = `survey.html?customer=${encodeURIComponent(custId)}`;
        });
      });

      const seeAllBtn = document.getElementById("chip-see-all-pending");
      if (seeAllBtn) {
        seeAllBtn.addEventListener("click", () => focusIncompleteShops());
      }
    }
  }

  // 2. Render Subsections
  renderStoreSummary(filtered);
  renderProductSummary(filtered);
  renderSurveyInsights(filtered);
  renderMatrixSummary(filtered);
  renderRecentResponses(filtered);
}

// --------------------------------------------------------------------------
// SUBPANEL 1: สรุปตามร้านค้า (Summarized by Store)
// --------------------------------------------------------------------------
function renderStoreSummary(filteredResponses) {
  const tbody = document.getElementById("tbody-summary-store");
  if (!tbody) return;

  const provFilter = document.getElementById("dash-filter-province")?.value || "";
  const term = (document.getElementById("dash-filter-search")?.value || "").trim().toLowerCase();

  // Aggregate responses per customer
  const storeMap = new Map();

  // Initialize with assigned customers
  CUSTOMERS.forEach(c => {
    const p = c.province_normalized || c.province_raw || "-";
    if (provFilter && p !== provFilter) return;
    if (term) {
      const match = `${c.client_id} ${c.client_name} ${p}`.toLowerCase();
      if (!match.includes(term)) return;
    }
    storeMap.set(c.id, {
      customer_id: c.id,
      client_id: c.client_id || "-",
      client_name: c.client_name,
      province: p,
      responses_count: 0,
      product_counts: {}, // { [product_id]: count }
      scores: [],
      latest_submitted_at: null,
      latest_respondent: null,
      sources: new Set()
    });
  });

  // Aggregate responses into storeMap
  filteredResponses.forEach(r => {
    let entry = storeMap.get(r.customer_id);
    if (!entry) {
      // If customer not in assigned list, create dynamic entry
      entry = {
        customer_id: r.customer_id,
        client_id: r.client_id || "-",
        client_name: r.client_name || "ร้านค้าตัวแทน",
        province: r.province || "-",
        responses_count: 0,
        product_counts: {},
        scores: [],
        latest_submitted_at: null,
        latest_respondent: null,
        sources: new Set()
      };
      storeMap.set(r.customer_id, entry);
    }

    entry.responses_count++;
    if (r.product_id) {
      entry.product_counts[r.product_id] = (entry.product_counts[r.product_id] || 0) + 1;
    }
    if (typeof r.nps_score === "number") entry.scores.push(r.nps_score);
    if (!entry.latest_submitted_at || new Date(r.submitted_at) > new Date(entry.latest_submitted_at)) {
      entry.latest_submitted_at = r.submitted_at;
      entry.latest_respondent = r.respondent_name || (r.respondent_type === "farmer" ? "เกษตรกร" : "ร้านค้า");
    }
    if (r.respondent_type) entry.sources.add(r.respondent_type);
  });

  let storeList = Array.from(storeMap.values());

  // Update scope counter buttons
  const respondedStores = storeList.filter(s => s.responses_count > 0);
  const pendingStores = storeList.filter(s => s.responses_count === 0);

  document.getElementById("count-scope-all").textContent = storeList.length.toLocaleString();
  document.getElementById("count-scope-responded").textContent = respondedStores.length.toLocaleString();
  document.getElementById("count-scope-pending").textContent = pendingStores.length.toLocaleString();

  // Filter according to active scope
  if (STORE_SCOPE === "responded") {
    storeList = respondedStores;
  } else if (STORE_SCOPE === "pending") {
    storeList = pendingStores;
  }

  // Sort: stores with most responses first, then by name
  storeList.sort((a, b) => {
    if (b.responses_count !== a.responses_count) return b.responses_count - a.responses_count;
    return a.client_name.localeCompare(b.client_name, "th");
  });

  if (!storeList.length) {
    tbody.innerHTML = `<tr><td colspan="7" class="empty">ไม่พบข้อมูลร้านค้าตามเงื่อนไขที่เลือก</td></tr>`;
    return;
  }

  tbody.innerHTML = storeList.slice(0, 250).map(s => {
    const hasResponses = s.responses_count > 0;
    const avg = s.scores.length > 0 ? (s.scores.reduce((sum, v) => sum + v, 0) / s.scores.length).toFixed(1) + " ⭐" : "-";

    // Products evaluated badges
    let prodChips = "";
    if (hasResponses) {
      prodChips = Object.entries(s.product_counts).map(([pid, count]) => {
        const prod = PRODUCTS.find(p => p.id === pid);
        const icon = getProductIcon(prod?.code, 14);
        const shortName = prod ? (prod.name_th || prod.name || "").split("(")[0].trim() : "สินค้า";
        return `<span class="badge-prod-chip clickable-badge" data-store-prod="${s.customer_id}" data-pid="${pid}" style="cursor:pointer;display:inline-flex;align-items:center;gap:4px" title="${PVT.escapeHtml(prod?.name_th||'')} (${count} ชุด) คลิกเพื่อดูคำตอบ">${icon} <span>${PVT.escapeHtml(shortName)}</span> <strong>(${count})</strong></span>`;
      }).join(" ");
    } else {
      prodChips = `<span class="small" style="color:#c2410c;font-weight:600;display:inline-flex;align-items:center;gap:4px">
        <svg class="pvt-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
        <span>ยังไม่เคยประเมินสินค้าใด</span>
      </span>`;
    }

    const countBadge = hasResponses 
      ? `<span class="pill success clickable-badge" data-view-store="${s.customer_id}" style="font-size:13px;padding:3px 10px;font-weight:800;cursor:pointer;display:inline-flex;align-items:center;gap:4px" title="คลิกเพื่อดูรายละเอียดคำตอบ"><span>${s.responses_count} ชุด</span> ${PVT.icon('eye', {size: 13})}</span>`
      : `<div style="display:inline-flex;flex-direction:column;align-items:center;gap:3px">
          <span class="pill warning" style="font-weight:800;font-size:11.5px;padding:3px 9px;display:inline-flex;align-items:center;gap:4px">
            <span style="width:7px;height:7px;border-radius:50%;background:#ea580c;display:inline-block"></span>
            <span>ยังไม่ตอบ</span>
          </span>
          <span class="small" style="color:#c2410c;font-weight:750;font-size:10.5px;display:inline-flex;align-items:center;gap:3px;"><svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="color:#c2410c;"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg> ต้องเข้าเยี่ยม/ติดต่อ</span>
        </div>`;

    const latestDate = s.latest_submitted_at ? PVT.formatDate(s.latest_submitted_at) : "<span class='muted small'>-</span>";
    const respMeta = s.latest_respondent ? `<div class="muted small">${PVT.escapeHtml(s.latest_respondent)}</div>` : "";

    return `
      <tr class="${hasResponses ? 'clickable-table-row' : 'store-row-pending'}" data-store-row="${s.customer_id}" title="${hasResponses ? 'คลิกแถวนี้เพื่อดูรายละเอียดผลสำรวจร้าน ' + PVT.escapeHtml(s.client_name) : 'ร้านนี้ยังไม่มีประวัติแบบสอบถาม คลิกปุ่มเพื่อเข้าเยี่ยมและบันทึก'}">
        <td>
          <div style="display:flex;align-items:center;gap:6px;flex-wrap:wrap">
            <strong style="color:#0f3b25;font-size:14px">${PVT.escapeHtml(s.client_name)}</strong>
            ${!hasResponses ? `<span class="pill danger" style="font-size:10px;padding:1px 6px;font-weight:750">รอเข้าเยี่ยม</span>` : ''}
          </div>
          <div class="muted small">รหัส: ${PVT.escapeHtml(s.client_id)}</div>
        </td>
        <td><span class="pill info" style="font-size:11px">${PVT.escapeHtml(s.province)}</span></td>
        <td style="text-align:center">${countBadge}</td>
        <td>${prodChips}</td>
        <td style="text-align:center;font-weight:750">${avg}</td>
        <td>
          <div>${latestDate}</div>
          ${respMeta}
        </td>
        <td style="text-align:right">
          <div class="actions" style="justify-content:flex-end;gap:5px">
            ${!hasResponses ? `
              <a class="btn btn-primary btn-sm" href="survey.html?customer=${s.customer_id}" onclick="event.stopPropagation()" style="background:#ea580c;border-color:#c2410c;display:inline-flex;align-items:center;gap:4px;font-weight:750" title="เข้าเยี่ยมร้านนี้และบันทึกแบบสอบถาม">
                ${PVT.icon('edit', {size: 13})} <span>เข้าเยี่ยม &amp; กรอก</span>
              </a>
            ` : `
              <button class="btn btn-primary btn-sm" data-view-store="${s.customer_id}" title="เปิดดูผลสำรวจ" style="display:inline-flex;align-items:center;gap:4px">${PVT.icon('eye', {size: 13})} <span>ดูคำตอบ</span></button>
              <a class="btn btn-secondary btn-sm" href="survey.html?customer=${s.customer_id}" onclick="event.stopPropagation()" style="display:inline-flex;align-items:center;gap:4px">${PVT.icon('edit', {size: 13})} <span>กรอกเพิ่ม</span></a>
            `}
          </div>
        </td>
      </tr>
    `;
  }).join("");

  // Bind clickable rows and view buttons
  tbody.querySelectorAll("[data-store-row]").forEach(tr => {
    tr.addEventListener("click", (e) => {
      if (e.target.closest("button") || e.target.closest("a") || e.target.closest(".badge-prod-chip")) return;
      const custId = tr.dataset.storeRow;
      PVT.openResponseModal({ customerId: custId });
    });
  });

  tbody.querySelectorAll("[data-view-store]").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.stopPropagation();
      PVT.openResponseModal({ customerId: btn.dataset.viewStore });
    });
  });

  tbody.querySelectorAll("[data-store-prod]").forEach(chip => {
    chip.addEventListener("click", (e) => {
      e.stopPropagation();
      PVT.openResponseModal({ customerId: chip.dataset.storeProd, productId: chip.dataset.pid });
    });
  });
}

// --------------------------------------------------------------------------
// SUBPANEL: สรุปผลลัพธ์เชิงลึกตามข้อคำถามแบบ Dynamic (Question Insights)
// --------------------------------------------------------------------------
function renderSurveyInsights(filteredResponses) {
  const container = document.getElementById("sales-dynamic-question-insights-container");
  if (!container) return;

  const selectedCampId = document.getElementById("dash-filter-campaign")?.value || document.getElementById("campaign-filter")?.value || "";
  const selectedCamp = CAMPAIGNS.find(c => c.id === selectedCampId);
  const campLabel = document.getElementById("sales-dynamic-insights-label");
  const badge = document.getElementById("sales-dynamic-insights-badge");

  // Determine Question Set for this view
  let questions = [];
  let isCustom = false;

  if (selectedCampId && typeof PVT.getCampaignQuestions === "function") {
    const customList = PVT.getCampaignQuestions(selectedCampId);
    if (customList && customList.length > 0) {
      questions = customList;
      isCustom = typeof PVT.hasCampaignCustomQuestions === "function" ? PVT.hasCampaignCustomQuestions(selectedCampId) : true;
    }
  }

  if (!questions.length && typeof PVT.getActiveCustomQuestions === "function") {
    const activeCustom = PVT.getActiveCustomQuestions();
    if (activeCustom && activeCustom.length > 0) {
      questions = activeCustom;
      isCustom = true;
    }
  }

  if (!questions.length && SALES_QUESTIONS && SALES_QUESTIONS.length > 0) {
    questions = [...SALES_QUESTIONS].map(q => {
      const opts = SALES_OPTIONS.filter(o => o.question_id === q.id);
      return { ...q, options: opts };
    });
  }

  if (!questions.length && typeof PVT.getStandardDefaultQuestions === "function") {
    questions = PVT.getStandardDefaultQuestions();
  }

  questions.sort((a, b) => (a.sort_order || a.question_no || 0) - (b.sort_order || b.question_no || 0));

  if (campLabel) {
    if (selectedCamp) {
      campLabel.textContent = `กำลังแสดงผลสรุปคำตอบของ Campaign: ${selectedCamp.name} (${questions.length} ข้อคำถาม)`;
    } else {
      campLabel.textContent = `ประมวลผลคำตอบแบบ Dynamic จากชุดคำถามทั้งหมด (${questions.length} ข้อคำถาม)`;
    }
  }

  if (badge) {
    if (isCustom) {
      badge.textContent = `✨ ชุดคำถามเฉพาะ Campaign (${questions.length} ข้อ)`;
      badge.className = "pill info";
    } else {
      badge.textContent = `📋 ชุดคำถามมาตรฐาน (${questions.length} ข้อ)`;
      badge.className = "pill success";
    }
  }

  const respIds = new Set(filteredResponses.map(r => r.id));
  const relevantAnswers = SALES_ANSWERS.filter(a => respIds.has(a.response_id));
  const totalRespCount = filteredResponses.length;

  if (!questions.length || !totalRespCount) {
    container.innerHTML = `
      <div class="card" style="grid-column:1/-1;text-align:center;padding:32px 20px">
        <div class="muted small" style="font-size:14px">ยังไม่มีข้อมูลคำตอบในตัวกรองปัจจุบัน หรือยังไม่มีการบันทึกแบบสอบถามในแคมเปญที่เลือก</div>
      </div>
    `;
    return;
  }

  const oMap = Object.fromEntries(SALES_OPTIONS.map(o => [o.id, o]));

  const cardsHtml = questions.map((q, qIndex) => {
    const qNo = q.question_no || (qIndex + 1);
    const qType = (q.question_type || "checkbox").toLowerCase();
    const promptText = q.prompt || `ข้อคำถามที่ ${qNo}`;
    const hintText = q.analysis_hint || "";
    const options = Array.isArray(q.options) ? q.options : (SALES_OPTIONS.filter(o => o.question_id === q.id));

    const qAnswers = relevantAnswers.filter(a => {
      if (a.question_id === q.id) return true;
      if (a.question_id && (a.question_id === `std_q${qNo}_dealer` || a.question_id === `std_q${qNo}_farmer` || a.question_id === `q${qNo}`)) return true;
      const dbQ = SALES_QUESTIONS.find(x => x.id === a.question_id);
      if (dbQ && (dbQ.question_no === qNo || dbQ.sort_order === qNo)) return true;
      return false;
    });

    const answeredCount = qAnswers.length;

    let typeLabel = "เลือกตอบ";
    if (qType.includes("rating") || qType.includes("matrix") || qNo === 2) typeLabel = "ให้คะแนน 1–5 ดาว";
    else if (qType.includes("scale") || qType.includes("nps")) typeLabel = "สเกลความพึงพอใจ";
    else if (qType.includes("text") || qType.includes("feedback")) typeLabel = "ข้อความตอบอิสระ";
    else if (qType.includes("radio") || qType.includes("single")) typeLabel = "เลือก 1 ข้อ";
    else if (q.max_selections) typeLabel = `เลือกไม่เกิน ${q.max_selections} ข้อ`;
    else typeLabel = "เลือกได้หลายข้อ";

    let bodyHtml = "";

    // 1. RATING / MATRIX TYPE (e.g. Q2 factors)
    if (qType.includes("rating") || qType.includes("matrix") || qNo === 2) {
      const factorMap = {};
      options.forEach(opt => {
        factorMap[opt.option_text || opt.id] = { label: opt.option_text || opt.id, scores: [] };
      });

      for (const a of qAnswers) {
        const ratings = a.answer_json?.ratings || {};
        for (const [key, score] of Object.entries(ratings)) {
          const optObj = options.find(o => o.id === key || o.option_key === key);
          const label = optObj?.option_text || oMap[key]?.option_text || key;
          if (!factorMap[label]) factorMap[label] = { label, scores: [] };
          const num = Number(score);
          if (Number.isFinite(num)) factorMap[label].scores.push(num);
        }
      }

      const factorList = Object.values(factorMap)
        .filter(f => f.scores.length > 0)
        .map(f => {
          const avg = f.scores.reduce((a, b) => a + b, 0) / f.scores.length;
          return { ...f, avg, count: f.scores.length };
        })
        .sort((a, b) => b.avg - a.avg);

      if (!factorList.length) {
        bodyHtml = `<div class="empty" style="padding:12px 0">ยังไม่มีข้อมูลคะแนน</div>`;
      } else {
        bodyHtml = `
          <div class="dynamic-opt-list">
            ${factorList.map(f => {
              const fillPct = Math.round((f.avg / 5) * 100);
              return `
                <div class="dynamic-opt-row">
                  <div class="dynamic-opt-header">
                    <span class="dynamic-opt-label">${PVT.escapeHtml(f.label)}</span>
                    <div class="dynamic-opt-val">
                      <span class="pill info" style="font-weight:800;font-size:11.5px">${f.avg.toFixed(2)} / 5 ⭐</span>
                      <span class="small muted">${f.count} คำตอบ</span>
                    </div>
                  </div>
                  <div class="dist-bar" style="height:6px;background:#e2ece5;border-radius:4px">
                    <div class="dist-bar-fill" style="width:${fillPct}%;background:${f.avg >= 4 ? '#166534' : f.avg >= 3 ? '#0284c7' : '#ea580c'}"></div>
                  </div>
                </div>
              `;
            }).join("")}
          </div>
        `;
      }
    }
    // 2. TEXT / FEEDBACK TYPE
    else if (qType.includes("text") || qType.includes("feedback")) {
      const comments = [];
      for (const a of qAnswers) {
        const ans = a.answer_json || {};
        const txt = ans.text || ans.comment || (typeof ans === "string" ? ans : "");
        if (txt && typeof txt === "string" && txt.trim()) {
          const resp = filteredResponses.find(r => r.id === a.response_id);
          comments.push({
            text: txt.trim(),
            client_name: resp?.client_name || "ร้านค้า",
            date: resp?.submitted_at ? PVT.formatDateTime(resp.submitted_at) : ""
          });
        }
      }

      if (!comments.length) {
        bodyHtml = `<div class="empty" style="padding:12px 0">ยังไม่มีข้อความความคิดเห็น</div>`;
      } else {
        bodyHtml = `
          <div class="dynamic-comment-stream">
            ${comments.map(c => `
              <div class="dynamic-comment-card">
                <div style="line-height:1.5">"${PVT.escapeHtml(c.text)}"</div>
                <div class="dynamic-comment-meta">
                  <span style="font-weight:700;color:#166534;display:inline-flex;align-items:center;gap:4px;"><svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="color:#166534;"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg> ${PVT.escapeHtml(c.client_name)}</span>
                  <span>${c.date}</span>
                </div>
              </div>
            `).join("")}
          </div>
        `;
      }
    }
    // 3. CHECKBOX / RADIO / CHOICE / SCALE TYPE
    else {
      const counts = {};
      const otherTexts = [];

      options.forEach(opt => {
        counts[opt.option_text || opt.id] = 0;
      });

      for (const a of qAnswers) {
        const ans = a.answer_json || {};
        const ids = Array.isArray(ans.selected) ? ans.selected : (ans.selected ? [ans.selected] : []);
        for (const id of ids) {
          const optObj = options.find(o => o.id === id || o.option_key === id);
          const label = optObj?.option_text || oMap[id]?.option_text || id;
          counts[label] = (counts[label] || 0) + 1;
        }
        if (ans.other && typeof ans.other === "string" && ans.other.trim()) {
          otherTexts.push(ans.other.trim());
        }
      }

      const sortedOpts = Object.entries(counts)
        .map(([label, count]) => ({ label, count }))
        .sort((a, b) => b.count - a.count);

      const maxCount = sortedOpts.length ? Math.max(...sortedOpts.map(x => x.count), 1) : 1;

      if (!sortedOpts.some(x => x.count > 0)) {
        bodyHtml = `<div class="empty" style="padding:12px 0">ยังไม่มีข้อมูลคำตอบในข้อนี้</div>`;
      } else {
        bodyHtml = `
          <div class="dynamic-opt-list">
            ${sortedOpts.filter(x => x.count > 0 || sortedOpts.length <= 6).map(item => {
              const pct = answeredCount > 0 ? Math.round((item.count / answeredCount) * 100) : 0;
              const barWidth = Math.round((item.count / maxCount) * 100);
              return `
                <div class="dynamic-opt-row">
                  <div class="dynamic-opt-header">
                    <span class="dynamic-opt-label">${PVT.escapeHtml(item.label)}</span>
                    <div class="dynamic-opt-val">
                      <span class="pill ${item.count > 0 ? 'success' : ''}" style="font-weight:750;font-size:11.5px">${item.count} ครั้ง (${pct}%)</span>
                    </div>
                  </div>
                  <div class="dist-bar" style="height:5px;background:#e5eee8;border-radius:4px">
                    <div class="dist-bar-fill" style="width:${barWidth}%;background:#1b804e"></div>
                  </div>
                </div>
              `;
            }).join("")}
          </div>
        `;

        if (otherTexts.length > 0) {
          bodyHtml += `
            <div style="margin-top:10px;padding-top:8px;border-top:1px dashed #dbe8e0">
              <div class="small muted" style="font-weight:700;margin-bottom:4px">💬 ข้อความอื่นๆ ที่ระบุเพิ่มเติม (${otherTexts.length} รายการ):</div>
              <div style="display:flex;flex-wrap:wrap;gap:5px">
                ${[...new Set(otherTexts)].slice(0, 8).map(t => `<span class="pill warning" style="font-size:11.5px;max-width:100%;white-space:normal;text-align:left">"${PVT.escapeHtml(t)}"</span>`).join("")}
              </div>
            </div>
          `;
        }
      }
    }

    return `
      <div class="dynamic-q-card">
        <div class="dynamic-q-header">
          <div class="dynamic-q-badges">
            <span class="dynamic-q-no-badge">ข้อ ${qNo}</span>
            <span class="pill" style="font-size:11px;background:#f0f7f3;color:#11422b;border:1px solid #c9e0d2">${typeLabel}</span>
            <span class="small muted" style="margin-left:auto;font-size:11px">${answeredCount.toLocaleString()} คำตอบ</span>
          </div>
          <h4 class="dynamic-q-prompt">${PVT.escapeHtml(promptText)}</h4>
          ${hintText ? `<div class="dynamic-q-hint">${PVT.escapeHtml(hintText)}</div>` : ''}
        </div>
        <div style="flex:1">
          ${bodyHtml}
        </div>
      </div>
    `;
  }).join("");

  container.innerHTML = cardsHtml;
}

// --------------------------------------------------------------------------
// SUBPANEL 2: สรุปตามผลิตภัณฑ์ (Summarized by Product)
// --------------------------------------------------------------------------
function renderProductSummary(filteredResponses) {
  const cardsGrid = document.getElementById("product-cards-stat-grid");
  const tbody = document.getElementById("tbody-summary-product");
  if (!cardsGrid || !tbody) return;

  const totalFilteredResponses = filteredResponses.length;

  // Aggregate by product
  const prodStats = PRODUCTS.map(p => {
    const pResponses = filteredResponses.filter(r => r.product_id === p.id);
    const storeIds = new Set(pResponses.map(r => r.customer_id).filter(Boolean));
    const dealerCount = pResponses.filter(r => !r.respondent_type || r.respondent_type === "dealer").length;
    const farmerCount = pResponses.filter(r => r.respondent_type === "farmer").length;
    const scored = pResponses.filter(r => typeof r.nps_score === "number");
    const avg = scored.length > 0 ? (scored.reduce((acc, r) => acc + r.nps_score, 0) / scored.length).toFixed(1) : "-";
    const sharePct = totalFilteredResponses > 0 ? Math.round((pResponses.length / totalFilteredResponses) * 100) : 0;

    // Get list of store names
    const storeNames = [...new Set(pResponses.map(r => r.client_name).filter(Boolean))];

    return {
      product: p,
      icon: getProductIcon(p.code, 24),
      responses_count: pResponses.length,
      stores_count: storeIds.size,
      dealer_count: dealerCount,
      farmer_count: farmerCount,
      avg_score: avg,
      share_pct: sharePct,
      stores: storeNames
    };
  });

  // Sort: highest response count first
  prodStats.sort((a, b) => b.responses_count - a.responses_count);

  // 1. Render Product Cards Grid
  cardsGrid.innerHTML = prodStats.map(stat => {
    return `
      <div class="prod-card-stat">
        <div style="display:flex;align-items:center;gap:10px;margin-bottom:10px">
          <div style="color:var(--brand)">${stat.icon}</div>
          <div style="flex:1;min-width:0">
            <h3 style="margin:0;font-size:14px;font-weight:800;color:#13402c;white-space:nowrap;overflow:hidden;text-overflow:ellipsis" title="${PVT.escapeHtml(stat.product.name_th)}">
              ${PVT.escapeHtml(stat.product.name_th)}
            </h3>
            <span class="muted small">${PVT.escapeHtml(stat.product.code)}</span>
          </div>
        </div>

        <div style="display:flex;justify-content:space-between;align-items:flex-end;margin-bottom:8px">
          <div>
            <div style="font-size:24px;font-weight:850;color:var(--brand);line-height:1">${stat.responses_count}</div>
            <div class="muted small" style="margin-top:2px">แบบสอบถาม</div>
          </div>
          <div style="text-align:right">
            <span class="pill info" style="font-size:11px;display:inline-flex;align-items:center;gap:4px">${PVT.icon('store', {size: 13})} <span>${stat.stores_count} ร้าน</span></span>
          </div>
        </div>

        <div class="dist-bar" style="height:6px;margin-bottom:6px">
          <div class="dist-bar-fill" style="width:${stat.share_pct}%"></div>
        </div>

        <div style="display:flex;justify-content:space-between;font-size:11px;color:var(--muted)">
          <span>สัดส่วน: <b>${stat.share_pct}%</b></span>
          <span style="display:inline-flex;align-items:center;gap:3px">คะแนน: <b>${stat.avg_score !== "-" ? stat.avg_score + " " + PVT.icon('star', {size: 11}) : "-"}</b></span>
        </div>
      </div>
    `;
  }).join("");

  // 2. Render Product Table
  tbody.innerHTML = prodStats.map(stat => {
    const storesDisplay = stat.stores.length > 0
      ? `<span class="muted small" title="${PVT.escapeHtml(stat.stores.join(', '))}">${stat.stores.slice(0, 2).map(s=>PVT.escapeHtml(s)).join(", ")}${stat.stores.length > 2 ? ` + อีก ${stat.stores.length - 2} ร้าน` : ""}</span>`
      : `<span class="muted small">-</span>`;

    return `
      <tr>
        <td>
          <div style="display:flex;align-items:center;gap:8px">
            <span style="display:flex;align-items:center;color:var(--brand)">${getProductIcon(stat.product.code, 20)}</span>
            <div>
              <strong style="color:#0f3d27;font-size:14px">${PVT.escapeHtml(stat.product.name_th)}</strong>
              <div class="muted small">${PVT.escapeHtml(stat.product.name_en || stat.product.code)}</div>
            </div>
          </div>
        </td>
        <td style="text-align:center">
          <span class="pill success" style="font-weight:800;font-size:13px">${stat.responses_count} ชุด</span>
        </td>
        <td style="text-align:center;font-weight:700">
          ${stat.stores_count} ร้าน
        </td>
        <td>
          <div class="dist-bar-wrap">
            <div class="dist-bar"><div class="dist-bar-fill" style="width:${stat.share_pct}%"></div></div>
            <span style="font-size:12px;font-weight:750;min-width:32px">${stat.share_pct}%</span>
          </div>
        </td>
        <td style="text-align:center;font-weight:800;color:#0b4c2d">
          ${stat.avg_score !== "-" ? stat.avg_score + " " + PVT.icon('star', {size: 12}) : "-"}
        </td>
        <td>
          <div class="small">
            <span class="pill success" style="font-size:10.5px;padding:2px 6px;display:inline-flex;align-items:center;gap:3px;"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="color:inherit;"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg> ร้านค้า ${stat.dealer_count}</span>
            <span class="pill warning" style="font-size:10.5px;padding:2px 6px;margin-left:3px;display:inline-flex;align-items:center;gap:3px;"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="color:inherit;"><path d="M12 22V12"/><path d="M12 12C12 7.58172 8.41828 4 4 4"/><path d="M12 15C12 10.5817 15.5817 7 20 7"/></svg> เกษตรกร ${stat.farmer_count}</span>
          </div>
        </td>
        <td style="text-align:right">
          ${storesDisplay}
        </td>
      </tr>
    `;
  }).join("");
}

// --------------------------------------------------------------------------
// SUBPANEL 3: ตารางความครอบคลุม (Store × Product Matrix)
// --------------------------------------------------------------------------
function renderMatrixSummary(filteredResponses) {
  const thead = document.getElementById("thead-matrix");
  const tbody = document.getElementById("tbody-matrix");
  const tfoot = document.getElementById("tfoot-matrix");
  if (!thead || !tbody || !tfoot) return;

  const provFilter = document.getElementById("dash-filter-province")?.value || "";
  const term = (document.getElementById("dash-filter-search")?.value || "").trim().toLowerCase();

  // Header row with product columns
  thead.innerHTML = `
    <tr>
      <th class="sticky-col">ชื่อร้านค้าตัวแทน</th>
      ${PRODUCTS.map(p => {
        const icon = getProductIcon(p.code, 18);
        const shortName = (p.name_th || p.name).split("(")[0].trim();
        return `<th title="${PVT.escapeHtml(p.name_th)}"><div style="display:flex;flex-direction:column;align-items:center;gap:3px;color:var(--brand)">${icon}<span style="font-size:10.5px;color:var(--text);font-weight:600">${PVT.escapeHtml(shortName)}</span></div></th>`;
      }).join("")}
      <th style="background:#edf6f1;font-weight:800;color:var(--brand)">รวม</th>
    </tr>
  `;

  // Aggregate responses count per (customer_id, product_id)
  const matrixCounts = new Map(); // key = `${customer_id}:${product_id}` -> count
  const storeResponseTotals = new Map(); // customer_id -> total
  const productTotals = {}; // product_id -> total

  PRODUCTS.forEach(p => { productTotals[p.id] = 0; });

  filteredResponses.forEach(r => {
    if (r.customer_id && r.product_id) {
      const key = `${r.customer_id}:${r.product_id}`;
      matrixCounts.set(key, (matrixCounts.get(key) || 0) + 1);
      storeResponseTotals.set(r.customer_id, (storeResponseTotals.get(r.customer_id) || 0) + 1);
      productTotals[r.product_id] = (productTotals[r.product_id] || 0) + 1;
    }
  });

  // Filter customers for matrix
  let matrixCustomers = CUSTOMERS.filter(c => {
    const p = c.province_normalized || c.province_raw || "";
    if (provFilter && p !== provFilter) return false;
    if (term) {
      const match = `${c.client_id} ${c.client_name} ${p}`.toLowerCase();
      if (!match.includes(term)) return false;
    }
    return true;
  });

  // Sort: stores with responses first
  matrixCustomers.sort((a, b) => {
    const countA = storeResponseTotals.get(a.id) || 0;
    const countB = storeResponseTotals.get(b.id) || 0;
    if (countB !== countA) return countB - countA;
    return a.client_name.localeCompare(b.client_name, "th");
  });

  if (!matrixCustomers.length) {
    tbody.innerHTML = `<tr><td colspan="${PRODUCTS.length + 2}" class="empty">ไม่พบข้อมูลตามตัวกรอง</td></tr>`;
    tfoot.innerHTML = "";
    return;
  }

  tbody.innerHTML = matrixCustomers.slice(0, 150).map(c => {
    const totalForStore = storeResponseTotals.get(c.id) || 0;

    const cells = PRODUCTS.map(p => {
      const cnt = matrixCounts.get(`${c.id}:${p.id}`) || 0;
      if (cnt > 0) {
        return `<td><span class="matrix-cell-active clickable-badge" data-matrix-cust="${c.id}" data-matrix-prod="${p.id}" style="cursor:pointer;display:inline-flex;align-items:center;justify-content:center;gap:3px" title="${PVT.escapeHtml(c.client_name)} — ${PVT.escapeHtml(p.name_th)} (${cnt} ชุด) คลิกเพื่อดูคำตอบ">${PVT.icon('check', {size: 11})} <span>${cnt}</span></span></td>`;
      }
      return `<td><span class="matrix-cell-empty">-</span></td>`;
    }).join("");

    return `
      <tr class="${totalForStore > 0 ? 'clickable-table-row' : ''}" data-matrix-row="${c.id}">
        <td class="sticky-col">
          <div style="font-size:13px;color:#103b27;font-weight:700">${PVT.escapeHtml(c.client_name)}</div>
          <div class="muted small" style="font-size:10.5px">${PVT.escapeHtml(c.client_id)} • ${PVT.escapeHtml(c.province_normalized || c.province_raw || "")}</div>
        </td>
        ${cells}
        <td style="font-weight:800;color:var(--brand);background:#f6fbf8">${totalForStore > 0 ? `<span class="clickable-badge" style="cursor:pointer" title="คลิกดูคำตอบทั้งหมดของร้านนี้">${totalForStore}</span>` : "-"}</td>
      </tr>
    `;
  }).join("");

  // Bind matrix cell click
  tbody.querySelectorAll("[data-matrix-cust]").forEach(badge => {
    badge.addEventListener("click", (e) => {
      e.stopPropagation();
      PVT.openResponseModal({
        customerId: badge.dataset.matrixCust,
        productId: badge.dataset.matrixProd
      });
    });
  });

  tbody.querySelectorAll("[data-matrix-row]").forEach(tr => {
    tr.addEventListener("click", (e) => {
      if (e.target.closest(".matrix-cell-active")) return;
      const custId = tr.dataset.matrixRow;
      PVT.openResponseModal({ customerId: custId });
    });
  });

  // Total footer row
  const overallTotal = Object.values(productTotals).reduce((a, b) => a + b, 0);
  tfoot.innerHTML = `
    <tr>
      <td class="sticky-col">รวมทุกร้านค้า</td>
      ${PRODUCTS.map(p => {
        const pTotal = productTotals[p.id] || 0;
        return `<td><span style="font-weight:800;color:var(--brand)">${pTotal > 0 ? pTotal : "-"}</span></td>`;
      }).join("")}
      <td style="color:var(--brand);font-size:14px">${overallTotal}</td>
    </tr>
  `;
}

// --------------------------------------------------------------------------
// SUBPANEL 4: ประวัติการตอบล่าสุด (Recent Responses Log)
// --------------------------------------------------------------------------
function renderRecentResponses(filteredResponses) {
  const tbody = document.getElementById("tbody-recent");
  const countPill = document.getElementById("recent-count-pill");
  if (!tbody) return;

  countPill.textContent = `${filteredResponses.length.toLocaleString()} รายการ`;

  if (!filteredResponses.length) {
    tbody.innerHTML = `<tr><td colspan="7" class="empty">ยังไม่มีประวัติแบบสอบถาม</td></tr>`;
    return;
  }

  // Sort by date desc
  const sorted = [...filteredResponses].sort((a, b) => new Date(b.submitted_at) - new Date(a.submitted_at));

  tbody.innerHTML = sorted.slice(0, 100).map(r => {
    const prod = PRODUCTS.find(p => p.id === r.product_id);
    const icon = getProductIcon(prod?.code, 16);
    const prodName = prod ? (prod.name_th || prod.name) : (r.product_name || "ผลิตภัณฑ์");

    const respPill = r.respondent_type === "farmer"
      ? `<span class="pill warning" style="font-size:11px;display:inline-flex;align-items:center;gap:3px;"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="color:inherit;"><path d="M12 22V12"/><path d="M12 12C12 7.58172 8.41828 4 4 4"/><path d="M12 15C12 10.5817 15.5817 7 20 7"/></svg> เกษตรกร</span>`
      : `<span class="pill success" style="font-size:11px;display:inline-flex;align-items:center;gap:3px;"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="color:inherit;"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg> ร้านค้า</span>`;

    const scorePill = typeof r.nps_score === "number"
      ? `<span class="pill ${r.nps_score >= 4 ? 'success' : r.nps_score <= 2 ? 'danger' : 'warning'}" style="font-weight:800;display:inline-flex;align-items:center;gap:3px"><span>${r.nps_score} / 5</span> ${PVT.icon('star', {size: 11})}</span>`
      : `<span class="muted small">-</span>`;

    return `
      <tr class="clickable-table-row" data-response-row="${r.id}" title="คลิกเพื่อดูรายละเอียดคำตอบฉบับเต็ม">
        <td class="small">${PVT.formatDateTime(r.submitted_at)}</td>
        <td>
          <strong style="color:#0f3f29">${PVT.escapeHtml(r.client_name || "ร้านค้า")}</strong>
          <div class="muted small">รหัส: ${PVT.escapeHtml(r.client_id || "-")}</div>
        </td>
        <td><span class="pill" style="font-size:11px">${PVT.escapeHtml(r.province || "-")}</span></td>
        <td>
          <div style="display:flex;align-items:center;gap:6px">
            <span style="color:var(--brand);display:flex;align-items:center">${icon}</span>
            <span style="font-weight:600;font-size:13px">${PVT.escapeHtml(prodName)}</span>
          </div>
        </td>
        <td>
          <div style="font-weight:600">${PVT.escapeHtml(r.respondent_name || (r.respondent_type === 'farmer' ? 'เกษตรกร' : 'ร้านค้า'))}</div>
        </td>
        <td>${respPill}</td>
        <td style="text-align:center">${scorePill}</td>
        <td style="text-align:right">
          <button class="btn btn-primary btn-sm" data-view-recent="${r.id}" title="ดูรายละเอียดคำตอบ" style="display:inline-flex;align-items:center;gap:4px">
            ${PVT.icon('eye', {size: 13})} <span>ดูคำตอบ</span>
          </button>
        </td>
      </tr>
    `;
  }).join("");

  tbody.querySelectorAll("[data-response-row]").forEach(tr => {
    tr.addEventListener("click", (e) => {
      if (e.target.closest("button") || e.target.closest("a")) return;
      PVT.openResponseModal({ responseId: tr.dataset.responseRow });
    });
  });

  tbody.querySelectorAll("[data-view-recent]").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.stopPropagation();
      PVT.openResponseModal({ responseId: btn.dataset.viewRecent });
    });
  });
}

// --------------------------------------------------------------------------
// Actions: Export CSV & Copy Summary Report
// --------------------------------------------------------------------------
function copyDashboardSummary() {
  const filtered = getFilteredResponses();
  const displayName = SALES_CTX?.profile?.display_name || "ฝ่ายขาย";
  const now = new Date().toLocaleDateString("th-TH", { dateStyle: "long" });

  const total = filtered.length;
  const storeCount = new Set(filtered.map(r => r.customer_id).filter(Boolean)).size;

  // Product breakdown
  const prodLines = PRODUCTS.map(p => {
    const c = filtered.filter(r => r.product_id === p.id).length;
    return `• ${p.name_th}: ${c} ชุด`;
  }).join("\n");

  const text = `รายงานสรุปผลสำรวจความพึงพอใจตราต้นไม้
ผู้รายงาน: ${displayName}
ณ วันที่: ${now}
----------------------------------------
- จำนวนแบบสอบถามที่เก็บได้: ${total} ชุด
- จำนวนร้านค้าที่ได้รับการประเมิน: ${storeCount} ร้าน (จากทั้งหมด ${CUSTOMERS.length} ร้าน)
- สรุปแยกตามผลิตภัณฑ์:
${prodLines}
----------------------------------------
ระบบสำรวจความพึงพอใจตราต้นไม้ (P.V.T. & T Plas)`;

  navigator.clipboard.writeText(text).then(() => {
    PVT.toast("คัดลอกรายงานสรุปผลลงคลิปบอร์ดแล้ว พร้อมส่งต่อใน LINE", "success");
  }).catch(() => {
    PVT.toast("ไม่สามารถคัดลอกได้ กรุณาลองใหม่", "error");
  });
}

function exportDashboardCSV() {
  const filtered = getFilteredResponses();
  if (!filtered.length) return PVT.toast("ไม่มีข้อมูลแบบสอบถามสำหรับส่งออก", "warning");

  const rows = filtered.map(r => ({
    "วันเวลาที่บันทึก": PVT.formatDateTime(r.submitted_at),
    "กลุ่มผู้ตอบ": r.respondent_type === "farmer" ? "เกษตรกร" : "ร้านค้า",
    "รหัสลูกค้า": r.client_id || "",
    "ชื่อร้านค้า": r.client_name || "",
    "จังหวัด": r.province || "",
    "ผลิตภัณฑ์": r.product_name || "",
    "ผู้ให้ข้อมูล": r.respondent_name || (r.respondent_type === "farmer" ? "เกษตรกร" : "ร้านค้า"),
    "ผู้บันทึก": "เซลล์ (พนักงานขาย)",
    "คะแนนความพึงพอใจ": r.nps_score ?? ""
  }));

  const filename = `pvt_survey_responses_${new Date().toISOString().split("T")[0]}.csv`;
  PVT.downloadCSV(filename, rows);
  PVT.toast("ส่งออกไฟล์ CSV สำเร็จ", "success");
}

// --------------------------------------------------------------------------
// Existing Store Directory & Invites
// --------------------------------------------------------------------------
async function renderSalesKpis(){
  const provinceCount=new Set(CUSTOMERS.map(c=>c.province_normalized||c.province_raw).filter(Boolean)).size;
  const {count:responseCount}=await PVT.db.from("survey_responses").select("id",{count:"exact",head:true});
  const respondedStoreIds = new Set(RESPONSES.map(r => r.customer_id).filter(Boolean));
  const pendingStoresCount = CUSTOMERS.filter(c => !respondedStoreIds.has(c.id)).length;
  
  const custEl = document.getElementById("kpi-customers");
  if (custEl) custEl.textContent=CUSTOMERS.length.toLocaleString();
  const provEl = document.getElementById("kpi-provinces");
  if (provEl) provEl.textContent=provinceCount.toLocaleString();
  const respEl = document.getElementById("kpi-responses");
  if (respEl) respEl.textContent=(responseCount || RESPONSES.length || 0).toLocaleString();
  const pendEl = document.getElementById("kpi-pending");
  if (pendEl) pendEl.textContent=pendingStoresCount.toLocaleString();
}

let SHARE_MODAL_MODE = "general"; // "general" or "store"

function getSalespersonIdentity(){
  const spId = SALES_CTX?.profile?.salesperson_id || SALES_CTX?.profile?.auth_user_id || SALES_CTX?.profile?.id || "c03a7c5e-ccc8-559d-9223-3379b540f53d";
  const spName = SALES_CTX?.profile?.display_name || "ฝ่ายขายตราต้นไม้";
  return { spId, spName };
}

function generateSalesShareLink(customerId = null, productId = null){
  const base = PVT.getPublicBaseUrl ? PVT.getPublicBaseUrl() : window.location.origin;
  const { spId, spName } = getSalespersonIdentity();
  let url = `${base}/public-survey.html?sp=${encodeURIComponent(spId)}&sp_name=${encodeURIComponent(spName)}`;
  if (customerId) {
    url += `&store=${encodeURIComponent(customerId)}`;
  }
  if (productId) {
    url += `&product=${encodeURIComponent(productId)}`;
  }
  return url;
}

function openShareModal(preselectedCustomerId = null){
  const { spName } = getSalespersonIdentity();
  const salesNameEl = document.getElementById("share-modal-sales-name");
  if (salesNameEl) salesNameEl.textContent = spName;

  // Populate store dropdown
  const storeSel = document.getElementById("share-modal-store-select");
  if (storeSel) {
    storeSel.innerHTML = CUSTOMERS.map(c => 
      `<option value="${c.id}" ${preselectedCustomerId === c.id ? "selected" : ""}>${PVT.escapeHtml(c.client_name)} (${PVT.escapeHtml(c.province_normalized || c.province_raw || "-")})</option>`
    ).join("");
  }

  // Populate product dropdown
  const prodSel = document.getElementById("share-modal-product-select");
  if (prodSel && PRODUCTS.length) {
    prodSel.innerHTML = `<option value="">-- ให้ร้านค้าเลือกเอง --</option>` + 
      PRODUCTS.map(p => `<option value="${p.id}">${PVT.escapeHtml(p.name_th || p.name)}</option>`).join("");
  }

  if (preselectedCustomerId) {
    setShareModalMode("store");
    if (storeSel) storeSel.value = preselectedCustomerId;
  } else {
    setShareModalMode("general");
  }

  updateShareModalContent();
  document.getElementById("share-link-backdrop").classList.remove("hidden");
}

function closeShareModal(){
  document.getElementById("share-link-backdrop").classList.add("hidden");
}

function setShareModalMode(mode){
  SHARE_MODAL_MODE = mode;
  const genBtn = document.getElementById("share-mode-general-btn");
  const storeBtn = document.getElementById("share-mode-store-btn");
  const storeRow = document.getElementById("share-store-select-row");

  if (mode === "general") {
    if (genBtn) genBtn.className = "btn btn-primary btn-sm";
    if (storeBtn) storeBtn.className = "btn btn-outline btn-sm";
    if (storeRow) storeRow.classList.add("hidden");
  } else {
    if (genBtn) genBtn.className = "btn btn-outline btn-sm";
    if (storeBtn) storeBtn.className = "btn btn-primary btn-sm";
    if (storeRow) storeRow.classList.remove("hidden");
  }
  updateShareModalContent();
}

function updateShareModalContent(){
  const storeId = SHARE_MODAL_MODE === "store" ? document.getElementById("share-modal-store-select")?.value : null;
  const prodId = document.getElementById("share-modal-product-select")?.value || null;
  const link = generateSalesShareLink(storeId, prodId);

  const input = document.getElementById("share-modal-link-input");
  if (input) input.value = link;

  const testLink = document.getElementById("share-modal-test-link");
  if (testLink) testLink.href = link;

  // Update QR Code
  const qrContainer = document.getElementById("share-modal-qrcode");
  if (qrContainer && typeof QRCode !== "undefined") {
    qrContainer.innerHTML = "";
    new QRCode(qrContainer, {
      text: link,
      width: 170,
      height: 170,
      correctLevel: QRCode.CorrectLevel.M
    });
  }

  // Update LINE Share URL and text
  const { spName } = getSalespersonIdentity();
  let storeText = "";
  if (storeId) {
    const cust = CUSTOMERS.find(c => c.id === storeId);
    if (cust) storeText = ` สำหรับร้าน ${cust.client_name}`;
  }
  const lineText = `สวัสดีครับ/ค่ะ ขอความกรุณาประเมินแบบสอบถามความพึงพอใจและคุณค่าผลิตภัณฑ์ตราต้นไม้ (P.V.T. & T Plas)${storeText} (ใช้เวลาเพียง 2 นาที ไม่ต้องล็อกอิน) ได้ที่ลิงก์นี้ครับ:\n${link}\n\nผู้แทนขายที่ดูแล: ${spName}`;
  
  const lineBtn = document.getElementById("share-modal-line-btn");
  if (lineBtn) {
    lineBtn.href = `https://line.me/R/msg/text/?${encodeURIComponent(lineText)}`;
  }
}

function bindSalesEvents(){
  ["province-filter","campaign-filter","store-status-filter"].forEach(id=> {
    const el = document.getElementById(id);
    if (el) el.addEventListener("change", renderCustomers);
  });
  const searchCust = document.getElementById("search-customer");
  if (searchCust) searchCust.addEventListener("input", renderCustomers);

  const closeInv = document.getElementById("close-invite-modal");
  if (closeInv) closeInv.addEventListener("click", closeInviteModal);

  const invBackdrop = document.getElementById("invite-backdrop");
  if (invBackdrop) {
    invBackdrop.addEventListener("click", e => { if (e.target.id === "invite-backdrop") closeInviteModal(); });
  }

  const createInvBtn = document.getElementById("create-invite-btn");
  if (createInvBtn) createInvBtn.addEventListener("click", createInvite);

  const copyLinkBtn = document.getElementById("copy-link-btn");
  if (copyLinkBtn) {
    copyLinkBtn.addEventListener("click", async () => {
      const input = document.getElementById("public-link");
      if (input && input.value) {
        await navigator.clipboard.writeText(input.value);
        PVT.toast("คัดลอกลิงก์แล้ว");
      }
    });
  }
}

function renderCustomers(){
  const province=document.getElementById("province-filter")?.value || "";
  const campaign=document.getElementById("campaign-filter")?.value || "";
  const statusFilter=document.getElementById("store-status-filter")?.value || "";
  const term=(document.getElementById("search-customer")?.value || "").trim().toLowerCase();

  // Pre-calculate responses per customer
  const respsByCust = new Map();
  RESPONSES.forEach(r => {
    if (r.customer_id) {
      if (!respsByCust.has(r.customer_id)) respsByCust.set(r.customer_id, []);
      respsByCust.get(r.customer_id).push(r);
    }
  });
  
  let rows=CUSTOMERS.filter(c=>{
    const p=c.province_normalized||c.province_raw||"";
    const text=`${c.client_id} ${c.client_name} ${p}`.toLowerCase();
    const hasResp = respsByCust.has(c.id);

    if (province && p !== province) return false;
    if (term && !text.includes(term)) return false;
    if (statusFilter === "pending" && hasResp) return false;
    if (statusFilter === "completed" && !hasResp) return false;
    return true;
  });

  const countPill = document.getElementById("customer-count");
  if (countPill) countPill.textContent=`${rows.length.toLocaleString()} ร้าน`;

  const el=document.getElementById("customer-list");
  if (!el) return;

  if(!rows.length){el.innerHTML=`<div class="empty">ไม่พบร้านค้าตามตัวกรอง</div>`;return;}
  el.innerHTML=rows.slice(0,300).map(c=>{
    const p=c.province_normalized||c.province_raw||"-";
    const storeResps = respsByCust.get(c.id) || [];
    const hasResp = storeResps.length > 0;

    let statusHtml = "";
    if (hasResp) {
      statusHtml = `<span class="pill success" style="font-weight:750;display:inline-flex;align-items:center;gap:4px">
        <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
        <span>สำรวจแล้ว (${storeResps.length} ชุด)</span>
      </span>`;
    } else {
      statusHtml = `<span class="pill warning" style="font-weight:800;background:#fff7ed;color:#c2410c;border:1px solid #fed7aa;display:inline-flex;align-items:center;gap:4px">
        <span style="width:7px;height:7px;border-radius:50%;background:#ea580c;display:inline-block"></span>
        <span>ยังไม่ตอบ (รอเข้าเยี่ยม)</span>
      </span>`;
    }

    return `<article class="customer-row ${hasResp ? 'completed-survey' : 'pending-visit'}">
      <div class="customer-main">
        <div style="display:flex;align-items:center;gap:8px;flex-wrap:wrap">
          <strong style="font-size:15px;color:#0f3f29">${PVT.escapeHtml(c.client_name)}</strong>
          ${!hasResp ? `<span class="pill danger" style="font-size:10.5px;padding:2px 7px;font-weight:750">ต้องเข้าเยี่ยม</span>` : ''}
        </div>
        <div class="customer-meta" style="margin-top:4px">
          <span>รหัส: ${PVT.escapeHtml(c.client_id)}</span>
          <span>•</span>
          <span>${PVT.escapeHtml(p)}</span>
          <span>•</span>
          <span>${statusHtml}</span>
        </div>
      </div>
      <div class="actions" style="display:flex;align-items:center;gap:6px;flex-wrap:wrap">
        ${!hasResp ? `
          <a class="btn btn-primary btn-sm" href="survey.html?customer=${c.id}" style="background:#ea580c;border-color:#c2410c;display:inline-flex;align-items:center;gap:4px;font-weight:750" title="เข้าเยี่ยมร้านนี้และบันทึกแบบสอบถาม">
            ${PVT.icon('edit', {size: 13})} <span>เข้าเยี่ยม &amp; กรอก</span>
          </a>
        ` : `
          <button class="btn btn-primary btn-sm" data-view-store="${c.id}" style="display:inline-flex;align-items:center;gap:4px">
            ${PVT.icon('eye', {size: 13})} <span>ดูคำตอบ</span>
          </button>
          <a class="btn btn-secondary btn-sm" href="survey.html?customer=${c.id}" style="display:inline-flex;align-items:center;gap:4px">
            ${PVT.icon('edit', {size: 13})} <span>กรอกเพิ่ม</span>
          </a>
        `}
      </div>
    </article>`;
  }).join("")+(rows.length>300?`<div class="notice">แสดง 300 รายการแรก กรุณาใช้ช่องค้นหาเพื่อเจาะจงร้าน</div>`:"");

  el.querySelectorAll("[data-view-store]").forEach(btn=>btn.addEventListener("click",()=>PVT.openResponseModal({ customerId: btn.dataset.viewStore })));
}

function statusPill(s){
  const map={created:["สร้างแล้ว","warning"],opened:["เปิดแล้ว","info"],completed:["ตอบแล้ว","success"],expired:["หมดอายุ","danger"],cancelled:["ยกเลิก","danger"]};
  const [t,c]=map[s]||[s,""];return `<span class="pill ${c}">${t}</span>`;
}

function openInviteModal(customerId){
  const c=CUSTOMERS.find(x=>x.id===customerId); if(!c)return;
  document.getElementById("invite-customer-id").value=c.id;
  document.getElementById("invite-customer-name").textContent=c.client_name;
  const active=CAMPAIGNS.filter(x=>x.is_active);
  const campaigns=active.length?active:CAMPAIGNS;
  document.getElementById("invite-campaign").innerHTML=campaigns.map(x=>`<option value="${x.id}">${PVT.escapeHtml(x.name)}</option>`).join("");
  document.getElementById("invite-product").innerHTML=`<option value="">ให้ร้านเลือกสินค้าเอง</option>`+PRODUCTS.map(p=>`<option value="${p.id}">${PVT.escapeHtml(p.name_th)}</option>`).join("");
  document.getElementById("invite-result").classList.add("hidden");
  document.getElementById("invite-backdrop").classList.remove("hidden");
}

function closeInviteModal(){
  document.getElementById("invite-backdrop").classList.add("hidden");
}

async function createInvite(){
  const btn=document.getElementById("create-invite-btn");
  const customerId=document.getElementById("invite-customer-id").value;
  const campaignId=document.getElementById("invite-campaign").value;
  const productId=document.getElementById("invite-product").value||null;
  if(!campaignId)return PVT.toast("กรุณาเลือกหรือสร้าง Campaign ก่อน","error");
  PVT.setBusy(btn,true,"กำลังสร้าง...");
  try{
    let token = null;

    // Ensure customer and campaign exist in DB
    const c = CUSTOMERS.find(x=>x.id===customerId);
    if (c && PVT.isUuid(c.id)) {
      try {
        await PVT.db.from("customers").upsert({
          id: c.id,
          client_id: c.client_id || "N/A",
          client_name: c.client_name,
          province_raw: c.province_raw || "",
          province_normalized: c.province_normalized || "",
          salesperson_id: c.salesperson_id || SALES_CTX?.profile?.salesperson_id || "c03a7c5e-ccc8-559d-9223-3379b540f53d",
          is_active: true
        }, { onConflict: "id", ignoreDuplicates: true });
      } catch (upsertCustErr) {
        console.warn("Customer upsert notice:", upsertCustErr);
      }
    }

    if (campaignId) {
      try {
        const campObj = CAMPAIGNS.find(x => x.id === campaignId);
        await PVT.db.from("survey_campaigns").upsert({
          id: campaignId,
          name: campObj ? campObj.name : "สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026",
          start_date: new Date().toISOString().split("T")[0],
          is_active: true
        }, { onConflict: "id", ignoreDuplicates: true });
      } catch (upsertCampErr) {
        console.warn("Campaign upsert notice:", upsertCampErr);
      }
    }

    if (PVT.isUuid(customerId) && PVT.isUuid(campaignId)) {
      const {data,error}=await PVT.db.rpc("create_survey_invite",{
        p_customer_id:customerId,p_campaign_id:campaignId,p_product_id:productId,p_expires_at:null
      });
      if(!error && data?.token){
        token = data.token;
      }
    }

    if (!token) {
      token = Array.from(crypto.getRandomValues(new Uint8Array(20))).map(b=>b.toString(16).padStart(2,'0')).join('');
      try {
        await PVT.db.from("survey_invites").insert({
          token,
          customer_id: PVT.isUuid(customerId) ? customerId : null,
          campaign_id: campaignId,
          product_id: productId,
          salesperson_id: c?.salesperson_id || SALES_CTX?.profile?.salesperson_id || "c03a7c5e-ccc8-559d-9223-3379b540f53d",
          status: 'created'
        });
      } catch (insertErr) {
        console.warn("Direct invite insert notice:", insertErr);
      }
    }

    const base = PVT.getPublicBaseUrl ? PVT.getPublicBaseUrl() : (PVT_SURVEY_CONFIG.PUBLIC_BASE_URL||location.origin).replace(/\/$/,"");
    const link = `${base}/public-survey.html?token=${encodeURIComponent(token)}`;
    document.getElementById("public-link").value=link;
    const openBtn = document.getElementById("open-link-btn");
    if (openBtn) openBtn.href = link;
    const qr=document.getElementById("qrcode"); qr.innerHTML="";
    new QRCode(qr,{text:link,width:190,height:190,correctLevel:QRCode.CorrectLevel.M});
    document.getElementById("invite-result").classList.remove("hidden");
    await loadInvites(); renderCustomers(); await renderSalesKpis();
  }catch(err){PVT.toast(err.message||"สร้างลิงก์ไม่สำเร็จ","error");}
  finally{PVT.setBusy(btn,false);}
}
