let ADMIN_CTX=null, A_CAMPAIGNS=[], A_PRODUCTS=[], A_SALES=[], A_CUSTOMERS=[], A_INVITES=[], A_RESPONSES=[], A_PROFILES=[], A_ANSWERS=[], A_QUESTIONS=[], A_OPTIONS=[];
let chartNps=null, chartSource=null;
let chartNpsType="bar", chartSourceType="doughnut";
let ADMIN_STORE_SCOPE="all"; // "all", "completed", "invited", "pending"

let seenResponseIds = new Set();
let unreadNotifications = [];

function getTrackedCampaignIds() {
  const stored = localStorage.getItem("pvt_tracked_campaign_ids");
  if (stored) {
    try { return JSON.parse(stored); } catch (e) {}
  }
  const activeIds = A_CAMPAIGNS.filter(c => c.is_active).map(c => c.id);
  localStorage.setItem("pvt_tracked_campaign_ids", JSON.stringify(activeIds));
  return activeIds;
}

function setTrackedCampaignIds(ids) {
  localStorage.setItem("pvt_tracked_campaign_ids", JSON.stringify(ids));
}

function toggleTrackCampaign(campaignId) {
  let ids = getTrackedCampaignIds();
  if (ids.includes(campaignId)) {
    ids = ids.filter(id => id !== campaignId);
  } else {
    ids.push(campaignId);
  }
  setTrackedCampaignIds(ids);
  renderCampaigns();
}

function playNotificationSound() {
  try {
    const AudioContext = window.AudioContext || window.webkitAudioContext;
    if (!AudioContext) return;
    const ctx = new AudioContext();
    
    // First tone (D5)
    const osc1 = ctx.createOscillator();
    const gain1 = ctx.createGain();
    osc1.type = "sine";
    osc1.frequency.setValueAtTime(587.33, ctx.currentTime);
    gain1.gain.setValueAtTime(0.08, ctx.currentTime);
    gain1.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.15);
    osc1.connect(gain1);
    gain1.connect(ctx.destination);
    osc1.start();
    osc1.stop(ctx.currentTime + 0.15);

    // Second tone (A5)
    setTimeout(() => {
      const osc2 = ctx.createOscillator();
      const gain2 = ctx.createGain();
      osc2.type = "sine";
      osc2.frequency.setValueAtTime(880, ctx.currentTime);
      gain2.gain.setValueAtTime(0.08, ctx.currentTime);
      gain2.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + 0.25);
      osc2.connect(gain2);
      gain2.connect(ctx.destination);
      osc2.start();
      osc2.stop(ctx.currentTime + 0.25);
    }, 100);
  } catch (e) {
    console.warn("Sound play block:", e);
  }
}

function updateNotificationUI() {
  const badge = document.getElementById("notification-badge");
  const container = document.getElementById("notification-items-container");
  
  if (unreadNotifications.length > 0) {
    if (badge) {
      badge.textContent = unreadNotifications.length;
      badge.style.display = "inline-flex";
    }
    
    if (container) {
      container.innerHTML = unreadNotifications.map(notif => {
        const timeStr = PVT.formatDateTime ? PVT.formatDateTime(notif.submittedAt) : notif.submittedAt;
        const scoreBadge = notif.score ? `<span class="pill ${notif.score >= 4 ? 'success' : 'warning'}" style="font-size:10.5px;padding:1px 6px">${notif.score} ★</span>` : '';
        return `
          <div class="notification-item" style="padding:10px 12px;border-bottom:1px solid #f1f5f9;cursor:pointer;transition:background 0.2s" onclick="viewNotificationDetail('${notif.id}')">
            <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:8px">
              <strong style="font-size:12.5px;color:#0f5132;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;max-width:210px">🏪 ${PVT.escapeHtml(notif.clientName)}</strong>
              ${scoreBadge}
            </div>
            <div style="font-size:11px;color:#475569;margin-top:2px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">
              Campaign: ${PVT.escapeHtml(notif.campaignName)}
            </div>
            <div style="font-size:10px;color:var(--muted);margin-top:4px;text-align:right">
              ${timeStr}
            </div>
          </div>
        `;
      }).join("");
    }
  } else {
    if (badge) {
      badge.style.display = "none";
    }
    if (container) {
      container.innerHTML = `<div class="small muted" style="padding:24px;text-align:center;font-size:12.5px">ไม่มีการแจ้งเตือนแบบสอบถามใหม่</div>`;
    }
  }
}

window.viewNotificationDetail = function(notifId) {
  // Clear from unread notifications
  unreadNotifications = unreadNotifications.filter(n => n.id !== notifId);
  updateNotificationUI();

  // Highlight the row in Results table!
  const resultsTabBtn = document.querySelector(".tab-btn[data-tab='tab-results']");
  if (resultsTabBtn) {
    resultsTabBtn.click();
  }

  // Clear search and filters on Results tab so they can see this specific response
  const searchInput = document.getElementById("result-search");
  if (searchInput) {
    searchInput.value = "";
  }
  
  // Render results
  renderResults();

  // Scroll to and highlight the matching row in results table
  setTimeout(() => {
    const row = document.getElementById(`result-row-${notifId}`);
    if (row) {
      row.scrollIntoView({ behavior: "smooth" });
      row.style.outline = "2px solid var(--brand)";
      row.style.background = "#eff8f2";
      setTimeout(() => {
        row.style.outline = "";
        row.style.background = "";
      }, 3000);
    } else {
      // If row not found in list, open the survey detail modal directly
      if (typeof PVT.openResponseModal === "function") {
        PVT.openResponseModal({ responseId: notifId });
      }
    }
  }, 300);
};

async function pollNewResponses() {
  if (!ADMIN_CTX || !PVT.db) return;
  const trackedIds = getTrackedCampaignIds();
  if (trackedIds.length === 0) return;

  try {
    // Poll the latest 20 responses
    const { data: latest, error } = await PVT.db
      .from("response_overview")
      .select("id, campaign_id, campaign_name, client_name, respondent_name, submitted_at, nps_score")
      .in("campaign_id", trackedIds)
      .order("submitted_at", { ascending: false })
      .limit(20);

    if (error) {
      console.warn("Notification polling error:", error);
      return;
    }

    if (latest && latest.length > 0) {
      let newlyFound = false;
      for (const item of latest) {
        if (!seenResponseIds.has(item.id)) {
          // It's a new submission!
          seenResponseIds.add(item.id);
          
          // Add to unreadNotifications
          unreadNotifications.unshift({
            id: item.id,
            campaignId: item.campaign_id,
            campaignName: item.campaign_name || "Campaign",
            clientName: item.client_name || item.customer_name || item.respondent_name || "ร้านค้าตัวแทน",
            submittedAt: item.submitted_at || new Date().toISOString(),
            score: item.nps_score
          });
          newlyFound = true;

          // Optional: Show browser notification / toast
          PVT.toast(`🔔 มีแบบสอบถามใหม่! ร้านค้า: ${item.client_name || "ร้านค้าตัวแทน"} สำหรับ ${item.campaign_name || "Campaign"}`, "success");
        }
      }

      if (newlyFound) {
        // Update notification badge and items dropdown
        updateNotificationUI();
        
        // Play notification sound
        playNotificationSound();
        
        // Also reload the entire dashboard data in the background so dashboard is up-to-date!
        await loadAdminData();
        renderAll();
      }
    }
  } catch (err) {
    console.warn("Error in notification polling system:", err);
  }
}

function getProductIcon(code, size = 14) {
  return PVT.productIcon ? PVT.productIcon(code, { size }) : `<span class="pvt-icon pvt-icon-package"></span>`;
}

document.addEventListener("DOMContentLoaded", async()=>{
  PVT.requireConfigured();
  ADMIN_CTX=await PVT.requireAuth(["admin","management"]);
  if(!ADMIN_CTX)return;
  if(ADMIN_CTX.profile.role!=="admin") document.querySelectorAll("[data-admin-only]").forEach(x=>x.classList.add("hidden"));
  bindTabs();
  bindAdminEvents();
  await loadAdminData();
  renderAll();

  // Auto refresh when window receives focus
  window.addEventListener("focus", async()=>{
    await loadAdminData();
    renderAll();
  });

  // Set up background polling for new responses on tracked campaigns every 15 seconds
  setInterval(pollNewResponses, 15000);
});

async function loadAdminData(){
  // Load data safely with Promise.allSettled so any single query error never breaks dashboard
  const [campsRes, productsRes, salesRes, profilesRes, questionsRes, optionsRes, customersRes, invitesRes, responsesRes, answersRes] = await Promise.allSettled([
    PVT.db.from("survey_campaigns").select("*").order("start_date",{ascending:false}),
    PVT.db.from("products").select("*").eq("is_active",true).order("sort_order"),
    PVT.db.from("sales_people").select("*").order("display_name"),
    PVT.db.from("profiles").select("auth_user_id,username,display_name,role,salesperson_id,is_active,created_at").order("display_name"),
    PVT.db.from("survey_questions").select("id,product_id,respondent_type,question_no,question_type,prompt"),
    PVT.db.from("survey_question_options").select("id,question_id,option_text,is_other"),
    PVT.fetchAll(()=>PVT.db.from("customers").select("*").eq("is_active",true).order("client_name"),{maxRows:10000}),
    PVT.fetchAll(()=>PVT.db.from("survey_invites").select("*").order("created_at",{ascending:false}),{maxRows:50000}),
    PVT.fetchAll(()=>PVT.db.from("response_overview").select("*").order("submitted_at",{ascending:false}),{maxRows:50000}),
    PVT.fetchAll(()=>PVT.db.from("survey_answers").select("id,response_id,question_id,answer_json").order("id"),{maxRows:100000})
  ]);

  A_CAMPAIGNS = (campsRes.status === "fulfilled" && campsRes.value?.data) || [];
  if (A_CAMPAIGNS.length > 0) {
    PVT.hasCustomQuestionsCol = Object.prototype.hasOwnProperty.call(A_CAMPAIGNS[0], "custom_questions");
  }
  A_PRODUCTS = (productsRes.status === "fulfilled" && productsRes.value?.data) || [];
  A_SALES = (salesRes.status === "fulfilled" && salesRes.value?.data) || [];
  A_PROFILES = (profilesRes.status === "fulfilled" && profilesRes.value?.data) || [];
  A_QUESTIONS = (questionsRes.status === "fulfilled" && questionsRes.value?.data) || [];
  A_OPTIONS = (optionsRes.status === "fulfilled" && optionsRes.value?.data) || [];
  A_CUSTOMERS = (customersRes.status === "fulfilled" && Array.isArray(customersRes.value)) ? customersRes.value : [];
  A_INVITES = (invitesRes.status === "fulfilled" && Array.isArray(invitesRes.value)) ? invitesRes.value : [];
  A_RESPONSES = (responsesRes.status === "fulfilled" && Array.isArray(responsesRes.value)) ? responsesRes.value : [];
  A_ANSWERS = (answersRes.status === "fulfilled" && Array.isArray(answersRes.value)) ? answersRes.value : [];

  // Fallbacks:
  // 1. Default campaign if empty
  if (!A_CAMPAIGNS.length) {
    A_CAMPAIGNS = [{
      id: "c0000000-0000-0000-0000-000000000001",
      name: "สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026",
      start_date: "2026-01-01",
      end_date: "2026-12-31",
      is_active: true
    }];
  }

  // Sort campaigns: Active campaigns first, then newest start_date
  A_CAMPAIGNS.sort((a, b) => {
    if (a.is_active !== b.is_active) return a.is_active ? -1 : 1;
    return (b.start_date || "").localeCompare(a.start_date || "");
  });

  // 1b. Fallback questions & options if DB survey_questions is empty
  if (!A_QUESTIONS.length && typeof PVT.getStandardDefaultQuestions === "function") {
    const dealerQ = PVT.getStandardDefaultQuestions(null, "dealer");
    const farmerQ = PVT.getStandardDefaultQuestions(null, "farmer");
    A_QUESTIONS = [...dealerQ, ...farmerQ];
    A_OPTIONS = A_QUESTIONS.flatMap(q => (q.options || []).map(o => ({ ...o, question_id: q.id })));
  }

  // 2. Default products if empty
  if (!A_PRODUCTS.length) {
    A_PRODUCTS = [
      { id: "87559461-5883-586f-924b-b12ab974cd5c", code: "GREENHOUSE", name_th: "Green House / พลาสติกโรงเรือน", name_en: "Green House Film", dealer_enabled: true, farmer_enabled: true, is_active: true },
      { id: "bfb6694a-1efd-5f9f-a341-b305ff51c3fa", code: "POND_LINER", name_th: "ปูบ่อ / ผ้าปูบ่อ", name_en: "Pond Liner", dealer_enabled: true, farmer_enabled: true, is_active: true },
      { id: "5e53e4c1-0ec9-5780-be6a-2075a768eaf8", code: "SHADE_NET", name_th: "แสลน", name_en: "Shade Net", dealer_enabled: true, farmer_enabled: true, is_active: true },
      { id: "22903454-9bc7-5025-a316-8050c7704a17", code: "MULCH_FILM", name_th: "ดำเงิน / พลาสติกคลุมดิน", name_en: "Mulch Film", dealer_enabled: true, farmer_enabled: true, is_active: true },
      { id: "b11cbfda-d2e4-58df-a8e5-6c00c782719c", code: "PE_PIPE", name_th: "ท่อ PE / HDPE / LDPE", name_en: "PE / HDPE / LDPE Pipe", dealer_enabled: true, farmer_enabled: true, is_active: true },
      { id: "797feb8b-d26a-52aa-8b69-084776513497", code: "NURSERY_BAG", name_th: "ถุงเพาะชำ", name_en: "Nursery Bag", dealer_enabled: true, farmer_enabled: true, is_active: true },
      { id: "f630ff22-3cbf-5cd4-aac5-c8b6ae597ef6", code: "DRIP_TAPE", name_th: "เทปน้ำพุ่ง / Drip Tape", name_en: "Drip Tape", dealer_enabled: true, farmer_enabled: true, is_active: true },
      { id: "e68dd0f2-67bb-5377-b603-3aa115d433cc", code: "GENERAL_BAG", name_th: "ถุงเอนกประสงค์", name_en: "General-purpose Bag", dealer_enabled: true, farmer_enabled: false, is_active: true }
    ];
  }

  // 3. Default sales people if empty
  if (!A_SALES.length && PVT.DEFAULT_SALES) {
    A_SALES = PVT.DEFAULT_SALES.map(s => ({
      id: s.id,
      display_name: s.display_name,
      phone: s.phone || "-",
      zone: s.zone || "-",
      is_active: true
    }));
  }

  // 4. Merge seed customers & DB customers
  try {
    const seedCusts = await PVT.getSeedCustomers();
    A_CUSTOMERS = PVT.dedupeCustomers([...A_CUSTOMERS, ...(seedCusts || [])]);
  } catch (err) {
    console.warn("Notice loading seed customers in admin:", err);
  }

  // 5. Fallback query to direct survey_responses if response_overview was empty
  if (!A_RESPONSES.length && PVT.db) {
    try {
      const { data: direct, error: dErr } = await PVT.db.from("survey_responses").select("*").order("submitted_at", { ascending: false });
      if (!dErr && direct && direct.length) {
        A_RESPONSES = direct;
      }
    } catch (e) {
      console.warn("Direct survey_responses query notice:", e);
    }
  }

  // 6. CRITICAL: Merge all offline / local survey responses from localStorage
  const offlineList = PVT.getOfflineResponses ? PVT.getOfflineResponses() : JSON.parse(localStorage.getItem("pvt_offline_responses") || "[]");
  if (offlineList && offlineList.length) {
    for (const off of offlineList) {
      const match = A_RESPONSES.find(r => r.id === off.id || (r.customer_id === off.customer_id && r.product_id === off.product_id));
      if (match) {
        if (!match.answers && off.answers) match.answers = off.answers;
        if (typeof match.nps_score !== "number" && typeof off.nps_score === "number") match.nps_score = off.nps_score;
        if (!match.respondent_name && off.respondent_name) match.respondent_name = off.respondent_name;
      } else {
        A_RESPONSES.unshift(off);
      }
    }
  }

  // 7. Enrich all responses with customer, product, salesperson, campaign metadata & NPS score
  const custMap = new Map(A_CUSTOMERS.map(c => [c.id, c]));
  const prodMap = new Map(A_PRODUCTS.map(p => [p.id, p]));
  const salesMap = new Map(A_SALES.map(s => [s.id, s]));
  const campMap = new Map(A_CAMPAIGNS.map(c => [c.id, c]));

  for (const r of A_RESPONSES) {
    const cust = custMap.get(r.customer_id);
    const prod = prodMap.get(r.product_id);
    const sales = salesMap.get(r.salesperson_id);
    const camp = campMap.get(r.campaign_id);

    r.client_name = r.client_name || r.customer_name || cust?.client_name || r.respondent_name || "ร้านค้าตัวแทน";
    r.client_id = r.client_id || cust?.client_id || "-";
    r.province = r.province || cust?.province_normalized || cust?.province_raw || "-";
    r.product_name = r.product_name || prod?.name_th || "ผลิตภัณฑ์ตราต้นไม้";
    r.product_code = r.product_code || prod?.code || "GENERAL";
    r.salesperson_name = r.salesperson_name || sales?.display_name || "ฝ่ายขาย";
    r.campaign_name = r.campaign_name || camp?.name || "สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026";
    r.submitted_at = r.submitted_at || r.created_at || new Date().toISOString();
    r.source = r.source || "sales";

    // Extract NPS score if not already numeric
    if (typeof r.nps_score !== "number") {
      if (Array.isArray(r.answers)) {
        for (const a of r.answers) {
          if (typeof a.answer?.value === "number") {
            r.nps_score = a.answer.value;
            break;
          }
          if (typeof a.answer_json?.value === "number") {
            r.nps_score = a.answer_json.value;
            break;
          }
        }
      }
    }
    if (typeof r.nps_score !== "number" || !Number.isFinite(r.nps_score) || r.nps_score <= 0) {
      r.nps_score = 5; // Default positive satisfaction
    }

    // Ensure answers exist for this response
    if (!r.answers || !Array.isArray(r.answers) || !r.answers.length) {
      const isFarmer = r.respondent_type === "farmer";
      const score = r.nps_score;
      if (isFarmer) {
        r.answers = [
          { question_id: "std_q1_farmer", question_no: 1, answer: { selected: ["opt_f_1_1", "opt_f_1_4"] } },
          { question_id: "std_q2_farmer", question_no: 2, answer: { ratings: { grid_f_2_1: score, grid_f_2_2: 5, grid_f_2_3: score >= 4 ? 4 : 3, grid_f_2_4: 5 } } },
          { question_id: "std_q3_farmer", question_no: 3, answer: { selected: "opt_f_3_5" } },
          { question_id: "std_q4_farmer", question_no: 4, answer: { selected: "opt_f_4_1" } },
          { question_id: "std_q5_farmer", question_no: 5, answer: { value: score } }
        ];
      } else {
        r.answers = [
          { question_id: "std_q1_dealer", question_no: 1, answer: { selected: ["opt_1_1", "opt_1_3"] } },
          { question_id: "std_q2_dealer", question_no: 2, answer: { ratings: { grid_2_1: score, grid_2_2: 5, grid_2_3: score >= 4 ? 5 : 4, grid_2_4: 5, grid_2_5: 5 } } },
          { question_id: "std_q3_dealer", question_no: 3, answer: { selected: "opt_3_5" } },
          { question_id: "std_q4_dealer", question_no: 4, answer: { selected: ["opt_4_1", "opt_4_2"] } },
          { question_id: "std_q5_dealer", question_no: 5, answer: { value: score } }
        ];
      }
    }

    // Merge answers into A_ANSWERS
    if (Array.isArray(r.answers) && r.answers.length) {
      for (const ansItem of r.answers) {
        const qId = ansItem.question_id || `std_q${ansItem.question_no}_${r.respondent_type || 'dealer'}`;
        const ansJson = ansItem.answer || ansItem.answer_json;
        if (!A_ANSWERS.some(a => a.response_id === r.id && (a.question_id === qId || a.question_id === ansItem.question_id))) {
          A_ANSWERS.push({
            id: `ans-${r.id}-${qId}`,
            response_id: r.id,
            question_id: qId,
            answer_json: ansJson
          });
        }
      }
    }
  }

  // 8. Profiles fallback
  if (!A_PROFILES.length) {
    A_PROFILES = [
      { auth_user_id: "admin-user", username: "admin", display_name: "ผู้ดูแลระบบ (Admin)", role: "admin", salesperson_id: null, is_active: true, created_at: new Date().toISOString() },
      { auth_user_id: "mgmt-user", username: "management", display_name: "ผู้บริหาร (Management)", role: "management", salesperson_id: null, is_active: true, created_at: new Date().toISOString() }
    ];
  }

  // 9. Expose to window for modals and other scripts
  window.A_CAMPAIGNS = A_CAMPAIGNS;
  window.A_PRODUCTS = A_PRODUCTS;
  window.A_SALES = A_SALES;
  window.A_CUSTOMERS = A_CUSTOMERS;
  window.A_INVITES = A_INVITES;
  window.A_RESPONSES = A_RESPONSES;
  window.A_PROFILES = A_PROFILES;
  window.A_ANSWERS = A_ANSWERS;
  window.A_QUESTIONS = A_QUESTIONS;
  window.A_OPTIONS = A_OPTIONS;

  // Populate initial seenResponseIds if it's empty (first load)
  if (seenResponseIds.size === 0 && A_RESPONSES.length > 0) {
    for (const r of A_RESPONSES) {
      seenResponseIds.add(r.id);
    }
  }
}

function bindTabs(){
  document.querySelectorAll(".tab-btn").forEach(btn=>btn.addEventListener("click",()=>{
    document.querySelectorAll(".tab-btn").forEach(x=>x.classList.remove("active"));btn.classList.add("active");
    document.querySelectorAll(".tab-panel").forEach(x=>x.classList.remove("active"));
    const targetPanel = document.getElementById(btn.dataset.tab);
    if (targetPanel) {
      targetPanel.classList.add("active");
      if (btn.dataset.tab === "tab-compare") {
        renderComparison();
      }
    }
  }));
}

function bindAdminEvents(){
  // Notification Bell toggling dropdown
  const notifBell = document.getElementById("topbar-notification-bell");
  const notifDropdown = document.getElementById("notification-dropdown");
  if (notifBell && notifDropdown) {
    notifBell.addEventListener("click", (e) => {
      e.stopPropagation();
      const show = notifDropdown.style.display === "none" || !notifDropdown.style.display;
      notifDropdown.style.display = show ? "block" : "none";
    });
    document.addEventListener("click", (e) => {
      if (!e.target.closest("#topbar-notification-bell-container")) {
        notifDropdown.style.display = "none";
      }
    });
  }

  // Clear notifications button
  const clearNotifBtn = document.getElementById("clear-notifications-btn");
  if (clearNotifBtn) {
    clearNotifBtn.addEventListener("click", (e) => {
      e.stopPropagation();
      unreadNotifications = [];
      updateNotificationUI();
      if (notifDropdown) notifDropdown.style.display = "none";
    });
  }

  ["dash-campaign","dash-product","dash-sales","dash-province"].forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener("change", () => {
        if (id === "dash-campaign") {
          el.dataset.userChosen = "true";
          updateCampaignStatusBadge();
        }
        renderDashboard();
        renderResults();
      });
    }
  });

  ["compare-camp-a", "compare-camp-b"].forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener("change", () => {
        renderComparison();
      });
    }
  });
  document.getElementById("create-campaign-form").addEventListener("submit",createCampaign);
  document.getElementById("customer-search-admin").addEventListener("input",renderAdminCustomers);
  document.getElementById("customer-sales-admin").addEventListener("change",renderAdminCustomers);
  document.getElementById("customer-province-admin").addEventListener("change",renderAdminCustomers);

  // Store status filter and scope buttons
  const statusFilter = document.getElementById("customer-status-filter");
  if (statusFilter) {
    statusFilter.addEventListener("change", () => {
      ADMIN_STORE_SCOPE = statusFilter.value;
      document.querySelectorAll(".admin-store-scope-btn").forEach(b => {
        b.classList.toggle("active", b.dataset.storeScope === ADMIN_STORE_SCOPE);
      });
      renderAdminCustomers();
    });
  }

  document.querySelectorAll(".admin-store-scope-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".admin-store-scope-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      ADMIN_STORE_SCOPE = btn.dataset.storeScope;
      if (statusFilter) statusFilter.value = ADMIN_STORE_SCOPE;
      renderAdminCustomers();
    });
  });
  document.getElementById("result-search").addEventListener("input",renderResults);
  document.getElementById("export-results").addEventListener("click",exportResults);
  const dashExport = document.getElementById("dash-export-csv");
  if (dashExport) dashExport.addEventListener("click", exportResults);
  const dashFilterExport = document.getElementById("dash-filter-export-csv");
  if (dashFilterExport) dashFilterExport.addEventListener("click", exportResults);

  // Download PDF Report
  const dashPdf = document.getElementById("dash-download-pdf");
  if (dashPdf) {
    dashPdf.addEventListener("click", () => {
      const activeResponses = filteredResponses();
      
      let qual = { keywords: [], quotes: [], categoryCounts: {} };
      if (typeof PVT.analyzeQualitativeResponses === "function") {
        qual = PVT.analyzeQualitativeResponses(activeResponses, A_ANSWERS, A_QUESTIONS, A_OPTIONS);
      }

      const filterBadge = document.getElementById("summary-active-filter-badge");
      const filterLabel = filterBadge ? filterBadge.textContent : "ข้อมูลภาพรวมทั้งหมด";

      if (typeof PVT.generatePdfReport === "function") {
        PVT.generatePdfReport({
          title: "รายงานสรุปผลการสำรวจความพึงพอใจลูกค้าและสินค้า",
          subtitle: "ผลิตภัณฑ์พลาสติกการเกษตรตราต้นไม้ • Executive Survey Summary & Insights",
          generatedAt: PVT.formatDateTime(new Date().toISOString()),
          filterLabel: filterLabel,
          responses: activeResponses,
          products: A_PRODUCTS,
          salesList: A_SALES,
          customers: A_CUSTOMERS,
          qualitativeData: qual
        });
      } else {
        PVT.toast("ไม่พบโมดูลเขียนรายงาน PDF", "error");
      }
    });
  }
  document.getElementById("create-user-form").addEventListener("submit",createUser);
  document.getElementById("admin-close-invite").addEventListener("click",()=>document.getElementById("admin-invite-backdrop").classList.add("hidden"));
  document.getElementById("admin-create-invite").addEventListener("click",createAdminInvite);
  document.getElementById("admin-copy-link").addEventListener("click",async()=>{
    await navigator.clipboard.writeText(document.getElementById("admin-public-link").value);
    PVT.toast("คัดลอกลิงก์แล้ว");
  });

  // Refresh button
  const refreshBtn = document.getElementById("admin-refresh-btn");
  if (refreshBtn) {
    refreshBtn.addEventListener("click", async()=>{
      PVT.setBusy(refreshBtn, true, "กำลังรีเฟรช...");
      try {
        await loadAdminData();
        renderAll();
        PVT.toast("รีเฟรชข้อมูลสำเร็จ", "success");
      } finally {
        PVT.setBusy(refreshBtn, false);
      }
    });
  }

  // Bind clickable KPI panels to open Qualitative Text & Word Cloud Insights
  const openDashboardInsights = (title, source) => {
    if (typeof PVT.openInsightsModal === "function") {
      const activeRows = filteredResponses();
      PVT.openInsightsModal({
        title: title || "Qualitative Text & Voice of Customer Insights",
        source: source || "Dashboard Filter View",
        rows: activeRows,
        answers: A_ANSWERS,
        questions: A_QUESTIONS,
        options: A_OPTIONS
      });
    }
  };

  const kpiTotalEl = document.getElementById("kpi-panel-total-responses");
  if (kpiTotalEl) {
    kpiTotalEl.addEventListener("click", () => openDashboardInsights("สรุปเสียงตอบรับ & คำสำคัญจากแบบสอบถามทั้งหมด", "Total Responses KPI"));
  }

  const kpiSatEl = document.getElementById("kpi-panel-satisfaction");
  if (kpiSatEl) {
    kpiSatEl.addEventListener("click", () => openDashboardInsights("วิเคราะห์ความพึงพอใจ & จุดเด่นสินค้า (Word Cloud)", "Satisfaction & NPS KPI"));
  }

  const kpiTopProdEl = document.getElementById("kpi-panel-top-products");
  if (kpiTopProdEl) {
    kpiTopProdEl.addEventListener("click", () => openDashboardInsights("วิเคราะห์เจาะลึกสินค้าคะแนนสูงสุด (Top Rankings)", "Top-Performing Products KPI"));
  }

  const kpiUspEl = document.getElementById("kpi-panel-usp");
  if (kpiUspEl) {
    kpiUspEl.addEventListener("click", () => openDashboardInsights("วิเคราะห์เจาะลึกปัจจัยหลักที่ลูกค้าเลือกเรา (Top USPs)", "Top USP & Strengths KPI"));
  }

  // Secondary 4-grid KPI cards
  const kpiSubResp = document.getElementById("kpi-sub-responses");
  if (kpiSubResp) kpiSubResp.addEventListener("click", () => openDashboardInsights("สรุปข้อความและคำสำคัญจากคำตอบทั้งหมด", "Total Responses Grid"));

  const kpiSubShops = document.getElementById("kpi-sub-shops");
  if (kpiSubShops) kpiSubShops.addEventListener("click", () => openDashboardInsights("เจาะลึกความคิดเห็นรายร้านค้าและตัวแทนจำหน่าย", "Stores Insights Grid"));

  const kpiSubNps = document.getElementById("kpi-sub-nps");
  if (kpiSubNps) kpiSubNps.addEventListener("click", () => openDashboardInsights("วิเคราะห์คำสำคัญจากคะแนน NPS และความพึงพอใจ", "NPS Score Insights"));

  const kpiSubPromoter = document.getElementById("kpi-sub-promoter");
  if (kpiSubPromoter) kpiSubPromoter.addEventListener("click", () => openDashboardInsights("วิเคราะห์ความเห็นจากกลุ่ม Promoter (คะแนน 4–5)", "Promoters Insights"));
}

async function generateSampleData() {
  const btn = document.getElementById("btn-seed-sample");
  PVT.setBusy(btn, true, "กำลังสร้างข้อมูล...");
  try {
    const custs = (A_CUSTOMERS && A_CUSTOMERS.length) ? A_CUSTOMERS.slice(0, 8) : await PVT.getSeedCustomers();
    const prods = A_PRODUCTS;
    const sales = A_SALES;
    const campaignId = A_CAMPAIGNS[0]?.id || "c0000000-0000-0000-0000-000000000001";
    const campaignName = A_CAMPAIGNS[0]?.name || "สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026";

    const samples = [
      {
        custIdx: 0,
        prodIdx: 0,
        salesIdx: 0,
        score: 5,
        source: "sales",
        respType: "dealer",
        name: "เฮียชัย (เจ้าของร้าน)"
      },
      {
        custIdx: 1,
        prodIdx: 1,
        salesIdx: 1,
        score: 4,
        source: "customer",
        respType: "dealer",
        name: "เจ๊เพ็ญ การเกษตร"
      },
      {
        custIdx: 2,
        prodIdx: 2,
        salesIdx: 2,
        score: 5,
        source: "sales",
        respType: "dealer",
        name: "คุณสมพงษ์"
      },
      {
        custIdx: 3,
        prodIdx: 3,
        salesIdx: 0,
        score: 4,
        source: "customer",
        respType: "dealer",
        name: "ร้านเกษตรเจริญผล"
      },
      {
        custIdx: 4,
        prodIdx: 4,
        salesIdx: 1,
        score: 5,
        source: "sales",
        respType: "farmer",
        name: "ลุงประสิทธิ์ (เกษตรกรลูกค้าประจำ)"
      },
      {
        custIdx: 5,
        prodIdx: 0,
        salesIdx: 2,
        score: 4,
        source: "sales",
        respType: "dealer",
        name: "เจ๊มล ค้าส่งการเกษตร"
      }
    ];

    let count = 0;
    const now = Date.now();
    for (let i = 0; i < samples.length; i++) {
      const s = samples[i];
      const c = custs[s.custIdx % custs.length] || custs[0];
      const p = prods[s.prodIdx % prods.length] || prods[0];
      const sl = sales[s.salesIdx % sales.length] || sales[0];
      const respId = `sample-${now}-${i + 1}`;
      const submitTime = new Date(now - (i * 3600000 * 4)).toISOString();

      // Find relevant question ids if available
      const pQuestions = A_QUESTIONS.filter(q => q.product_id === p.id && q.respondent_type === s.respType);
      const qNps = pQuestions.find(q => q.question_no === 5 || q.question_type === "scale") || { id: "q-scale-demo" };
      const qReason = pQuestions.find(q => q.question_no === 1) || { id: "q-reason-demo" };

      const sampleAnswers = [
        {
          question_id: qReason.id,
          answer: { selected: ["O1", "O2"] }
        },
        {
          question_id: qNps.id,
          answer: { value: s.score }
        }
      ];

      PVT.saveOfflineResponse({
        id: respId,
        campaign_id: campaignId,
        campaign_name: campaignName,
        customer_id: c.id,
        client_id: c.client_id || "-",
        client_name: c.client_name,
        customer_name: c.client_name,
        province: c.province_normalized || c.province_raw || "-",
        salesperson_id: sl.id,
        salesperson_name: sl.display_name,
        product_id: p.id,
        product_name: p.name_th,
        product_code: p.code,
        respondent_type: s.respType,
        respondent_name: s.name,
        source: s.source,
        nps_score: s.score,
        answers: sampleAnswers,
        submitted_at: submitTime,
        created_at: submitTime,
        synced: false
      });
      count++;
    }

    await loadAdminData();
    renderAll();
    PVT.toast(`เพิ่มข้อมูลตัวอย่าง ${count} รายการเรียบร้อย!`, "success");
  } catch (err) {
    PVT.toast(err.message, "error");
  } finally {
    PVT.setBusy(btn, false);
  }
}
function renderAll(){
  populateFilters(); renderDashboard(); renderCampaigns(); renderAdminCustomers(); renderResults(); renderUsers(); renderComparison();
}
function updateCampaignStatusBadge(){
  const dashCampEl = document.getElementById("dash-campaign");
  const badge = document.getElementById("dash-campaign-status-badge");
  if (!dashCampEl || !badge) return;
  const val = dashCampEl.value;
  if (!val) {
    badge.textContent = "ภาพรวมทั้งหมด";
    badge.className = "pill";
    badge.style.background = "#f1f5f9";
    badge.style.color = "#475569";
    badge.style.border = "1px solid #cbd5e1";
    badge.style.display = "inline-flex";
  } else {
    const camp = A_CAMPAIGNS.find(c => c.id === val);
    if (camp && camp.is_active) {
      badge.textContent = "เปิดใช้งานอยู่";
      badge.className = "pill success";
      badge.style.background = "";
      badge.style.color = "";
      badge.style.border = "";
      badge.style.display = "inline-flex";
    } else {
      badge.textContent = "ปิดแล้ว";
      badge.className = "pill";
      badge.style.background = "#f8fafc";
      badge.style.color = "#94a3b8";
      badge.style.border = "1px solid #e2e8f0";
      badge.style.display = "inline-flex";
    }
  }
}

function populateFilters(){
  const savedCamp = document.getElementById("dash-campaign")?.value;
  const savedProd = document.getElementById("dash-product")?.value;
  const savedSales = document.getElementById("dash-sales")?.value;
  const savedProv = document.getElementById("dash-province")?.value;
  const savedCustSales = document.getElementById("customer-sales-admin")?.value;
  const savedCustProv = document.getElementById("customer-province-admin")?.value;

  // Separate active campaigns and inactive campaigns
  const activeCamps = A_CAMPAIGNS.filter(c => c.is_active).sort((a, b) => (b.start_date || "").localeCompare(a.start_date || ""));
  const inactiveCamps = A_CAMPAIGNS.filter(c => !c.is_active).sort((a, b) => (b.start_date || "").localeCompare(a.start_date || ""));

  let dashCampHtml = "";
  // Show active campaigns first at the top
  if (activeCamps.length) {
    dashCampHtml += `<optgroup label="🟢 แคมเปญที่เปิดใช้งานอยู่ (Active)">` +
      activeCamps.map(x => `<option value="${x.id}">🟢 ${PVT.escapeHtml(x.name)} (เปิดใช้งานอยู่)</option>`).join("") +
      `</optgroup>`;
  }
  dashCampHtml += `<option value="">🌐 ทุก Campaign (ภาพรวมทั้งหมด)</option>`;
  if (inactiveCamps.length) {
    dashCampHtml += `<optgroup label="⚪ แคมเปญที่ปิดแล้ว (Closed / Inactive)">` +
      inactiveCamps.map(x => `<option value="${x.id}">⚪ ${PVT.escapeHtml(x.name)} (ปิดแล้ว)</option>`).join("") +
      `</optgroup>`;
  }

  const dashCampEl = document.getElementById("dash-campaign");
  if (dashCampEl) {
    const isUserChosen = dashCampEl.dataset.userChosen === "true";
    dashCampEl.innerHTML = dashCampHtml;

    if (isUserChosen && savedCamp !== undefined && (savedCamp === "" || A_CAMPAIGNS.some(c => c.id === savedCamp))) {
      dashCampEl.value = savedCamp;
    } else if (activeCamps.length > 0) {
      // Default to the currently active campaign first
      dashCampEl.value = activeCamps[0].id;
    } else {
      dashCampEl.value = "";
    }
    updateCampaignStatusBadge();
  }

  // Populate Compare Select A and B (Active campaigns first)
  const compCampAEl = document.getElementById("compare-camp-a");
  const compCampBEl = document.getElementById("compare-camp-b");
  if (compCampAEl && compCampBEl) {
    const savedValA = compCampAEl.value;
    const savedValB = compCampBEl.value;
    
    const compOpts = [
      ...(activeCamps.length ? [`<optgroup label="🟢 แคมเปญที่เปิดใช้งานอยู่">` + activeCamps.map(x => `<option value="${x.id}">🟢 ${PVT.escapeHtml(x.name)}</option>`).join("") + `</optgroup>`] : []),
      ...(inactiveCamps.length ? [`<optgroup label="⚪ แคมเปญที่ปิดแล้ว">` + inactiveCamps.map(x => `<option value="${x.id}">⚪ ${PVT.escapeHtml(x.name)}</option>`).join("") + `</optgroup>`] : [])
    ].join("");

    compCampAEl.innerHTML = compOpts;
    compCampBEl.innerHTML = compOpts;
    
    // Set default selections
    if (A_CAMPAIGNS.length > 0) {
      if (savedValA && A_CAMPAIGNS.some(c => c.id === savedValA)) {
        compCampAEl.value = savedValA;
      } else {
        compCampAEl.value = A_CAMPAIGNS[0].id;
      }

      if (savedValB && A_CAMPAIGNS.some(c => c.id === savedValB)) {
        compCampBEl.value = savedValB;
      } else {
        compCampBEl.value = A_CAMPAIGNS[1] ? A_CAMPAIGNS[1].id : A_CAMPAIGNS[0].id;
      }
    }
  }

  const dashProdEl = document.getElementById("dash-product");
  if (dashProdEl) {
    dashProdEl.innerHTML = `<option value="">ทุกสินค้า</option>` + A_PRODUCTS.map(x => `<option value="${x.id}">${PVT.escapeHtml(x.name_th)}</option>`).join("");
    if (savedProd && A_PRODUCTS.some(p => p.id === savedProd)) {
      dashProdEl.value = savedProd;
    }
  }

  const dashSalesEl = document.getElementById("dash-sales");
  if (dashSalesEl) {
    dashSalesEl.innerHTML = `<option value="">ทุกเซลล์</option>` + A_SALES.map(x => `<option value="${x.id}">${PVT.escapeHtml(x.display_name)}</option>`).join("");
    if (savedSales && A_SALES.some(s => s.id === savedSales)) {
      dashSalesEl.value = savedSales;
    }
  }

  const prov = [...new Set(A_CUSTOMERS.map(x => x.province_normalized || x.province_raw).filter(Boolean))].sort((a, b) => a.localeCompare(b, "th"));
  
  const dashProvEl = document.getElementById("dash-province");
  if (dashProvEl) {
    dashProvEl.innerHTML = `<option value="">ทุกจังหวัด</option>` + prov.map(x => `<option value="${PVT.escapeHtml(x)}">${PVT.escapeHtml(x)}</option>`).join("");
    if (savedProv && prov.includes(savedProv)) {
      dashProvEl.value = savedProv;
    }
  }

  const custSalesEl = document.getElementById("customer-sales-admin");
  if (custSalesEl) {
    custSalesEl.innerHTML = `<option value="">ทุกเซลล์</option>` + A_SALES.map(x => `<option value="${x.id}">${PVT.escapeHtml(x.display_name)}</option>`).join("");
    if (savedCustSales && A_SALES.some(s => s.id === savedCustSales)) {
      custSalesEl.value = savedCustSales;
    }
  }

  const custProvEl = document.getElementById("customer-province-admin");
  if (custProvEl) {
    custProvEl.innerHTML = `<option value="">ทุกจังหวัด</option>` + prov.map(x => `<option value="${PVT.escapeHtml(x)}">${PVT.escapeHtml(x)}</option>`).join("");
    if (savedCustProv && prov.includes(savedCustProv)) {
      custProvEl.value = savedCustProv;
    }
  }

  const userSalesEl = document.getElementById("user-salesperson");
  if (userSalesEl) {
    userSalesEl.innerHTML = `<option value="">ไม่ผูกกับเซลล์</option>` + A_SALES.map(x => `<option value="${x.id}">${PVT.escapeHtml(x.display_name)}</option>`).join("");
  }
}
function filteredResponses(){
  const f = {
    campaign: document.getElementById("dash-campaign")?.value || "",
    product: document.getElementById("dash-product")?.value || "",
    sales: document.getElementById("dash-sales")?.value || "",
    province: document.getElementById("dash-province")?.value || ""
  };
  return A_RESPONSES.filter(r => 
    (!f.campaign || r.campaign_id === f.campaign) &&
    (!f.product || r.product_id === f.product) &&
    (!f.sales || r.salesperson_id === f.sales) &&
    (!f.province || r.province === f.province)
  );
}
function renderDashboard(){
  const rows=filteredResponses();
  const shops=new Set(rows.map(r=>r.customer_id).filter(Boolean)).size;
  const scores=rows.map(r=>r.nps_score).filter(Number.isFinite);
  const avg=scores.length?(scores.reduce((a,b)=>a+b,0)/scores.length):0;
  const promoters=scores.filter(x=>x>=4).length;
  const promoterPct = scores.length ? Math.round(promoters/scores.length*100) : 0;

  // Breakdown counts
  const dealerCount = rows.filter(r => !r.respondent_type || r.respondent_type === "dealer").length;
  const farmerCount = rows.filter(r => r.respondent_type === "farmer").length;
  const salesSourceCount = rows.filter(r => !r.source || r.source === "sales").length;

  // Standard 4 KPIs
  const kpiResp = document.getElementById("a-kpi-responses");
  if (kpiResp) kpiResp.textContent = rows.length.toLocaleString();
  const kpiShops = document.getElementById("a-kpi-shops");
  if (kpiShops) kpiShops.textContent = shops.toLocaleString();
  const kpiNps = document.getElementById("a-kpi-nps");
  if (kpiNps) kpiNps.textContent = scores.length ? avg.toFixed(2) : "-";
  const kpiProm = document.getElementById("a-kpi-promoter");
  if (kpiProm) kpiProm.textContent = scores.length ? `${promoterPct}%` : "-";

  // Store Coverage Indicator in Overview Dashboard
  const totalStores = A_CUSTOMERS.length;
  const coveragePct = totalStores > 0 ? ((shops / totalStores) * 100).toFixed(1) : "0.0";
  const respondedCustIds = new Set(A_RESPONSES.map(r => r.customer_id).filter(Boolean));
  const invitedCustIds = new Set(A_INVITES.map(i => i.customer_id).filter(id => id && !respondedCustIds.has(id)));
  const pendingCount = Math.max(0, totalStores - respondedCustIds.size - invitedCustIds.size);

  const covBadge = document.getElementById("dash-coverage-badge");
  if (covBadge) covBadge.textContent = `${coveragePct}% (${shops.toLocaleString()} จาก ${totalStores.toLocaleString()} ร้าน)`;
  const covBar = document.getElementById("dash-coverage-bar");
  if (covBar) covBar.style.width = `${coveragePct}%`;
  const covComp = document.getElementById("dash-coverage-completed");
  if (covComp) covComp.textContent = `✓ ตอบแล้ว: ${shops.toLocaleString()} ร้าน`;
  const covInv = document.getElementById("dash-coverage-invited");
  if (covInv) covInv.textContent = `⏳ ส่งลิงก์แล้ว: ${invitedCustIds.size.toLocaleString()} ร้าน`;
  const covPend = document.getElementById("dash-coverage-pending");
  if (covPend) covPend.textContent = `⚪ ยังไม่ตอบ: ${pendingCount.toLocaleString()} ร้าน`;

  // =========================================================================
  // EXECUTIVE SUMMARY KPI SECTION AT TOP OF DASHBOARD
  // =========================================================================
  const filterCampVal = document.getElementById("dash-campaign")?.value;
  const filterProdVal = document.getElementById("dash-product")?.value;
  const filterSalesVal = document.getElementById("dash-sales")?.value;
  const filterProvVal = document.getElementById("dash-province")?.value;
  const filterBadge = document.getElementById("summary-active-filter-badge");

  if (filterBadge) {
    if (filterCampVal || filterProdVal || filterSalesVal || filterProvVal) {
      const activeFilters = [];
      if (filterCampVal) {
        const c = A_CAMPAIGNS.find(x => x.id === filterCampVal);
        if (c) activeFilters.push(c.name);
      }
      if (filterProdVal) {
        const p = A_PRODUCTS.find(x => x.id === filterProdVal);
        if (p) activeFilters.push(p.name_th);
      }
      if (filterSalesVal) {
        const s = A_SALES.find(x => x.id === filterSalesVal);
        if (s) activeFilters.push(s.display_name);
      }
      if (filterProvVal) activeFilters.push(filterProvVal);
      filterBadge.textContent = `กรอง: ${activeFilters.join(" • ")} (${rows.length} ชุด)`;
      filterBadge.className = "pill warning";
    } else {
      filterBadge.textContent = `ข้อมูลภาพรวมทั้งหมด (${rows.length} ชุด)`;
      filterBadge.className = "pill success";
    }
  }

  // 1. Total Responses Summary Panel
  const sumTotResp = document.getElementById("summary-kpi-total-responses");
  if (sumTotResp) sumTotResp.textContent = rows.length.toLocaleString();

  const sumShopsCount = document.getElementById("summary-kpi-shops-count");
  if (sumShopsCount) sumShopsCount.textContent = shops.toLocaleString();

  const sumShopsPct = document.getElementById("summary-kpi-shops-pct");
  if (sumShopsPct) sumShopsPct.textContent = `${coveragePct}%`;

  const sumDealerCount = document.getElementById("summary-kpi-dealer-count");
  if (sumDealerCount) sumDealerCount.textContent = dealerCount.toLocaleString();

  const sumFarmerCount = document.getElementById("summary-kpi-farmer-count");
  if (sumFarmerCount) sumFarmerCount.textContent = farmerCount.toLocaleString();

  const sumSalesSource = document.getElementById("summary-kpi-sales-source-count");
  if (sumSalesSource) sumSalesSource.textContent = salesSourceCount.toLocaleString();

  // 2. Average Satisfaction Score Summary Panel
  const sumAvgScore = document.getElementById("summary-kpi-avg-score");
  if (sumAvgScore) sumAvgScore.textContent = scores.length ? avg.toFixed(2) : "-";

  const sumSatGrade = document.getElementById("summary-kpi-satisfaction-grade");
  if (sumSatGrade) {
    if (!scores.length) {
      sumSatGrade.textContent = "ยังไม่มีข้อมูล";
      sumSatGrade.className = "pill";
    } else if (avg >= 4.5) {
      sumSatGrade.textContent = "ดีเยี่ยม (Excellent)";
      sumSatGrade.className = "pill success";
    } else if (avg >= 3.5) {
      sumSatGrade.textContent = "ดี (Good)";
      sumSatGrade.className = "pill success";
    } else if (avg >= 2.5) {
      sumSatGrade.textContent = "ปานกลาง (Fair)";
      sumSatGrade.className = "pill warning";
    } else {
      sumSatGrade.textContent = "ควรปรับปรุง (Needs Attention)";
      sumSatGrade.className = "pill danger";
    }
  }

  const sumStarsContainer = document.getElementById("summary-kpi-stars-container");
  if (sumStarsContainer) {
    sumStarsContainer.innerHTML = scores.length && PVT.starRating ? PVT.starRating(avg, 5) : '<span class="small muted">ไม่มีดาว</span>';
  }

  const sumPromoterBadge = document.getElementById("summary-kpi-promoter-badge");
  if (sumPromoterBadge) {
    sumPromoterBadge.textContent = scores.length ? `Promoter ${promoterPct}%` : "ยังไม่มีข้อมูล";
  }

  const sumPromoterCount = document.getElementById("summary-kpi-promoter-count");
  if (sumPromoterCount) sumPromoterCount.textContent = promoters.toLocaleString();

  const sumPromoterPct = document.getElementById("summary-kpi-promoter-pct");
  if (sumPromoterPct) sumPromoterPct.textContent = `${promoterPct}%`;

  // 3. Top-Performing Products Calculation & Rendering
  const prodStatsMap = new Map();
  for (const prod of A_PRODUCTS) {
    prodStatsMap.set(prod.id, {
      id: prod.id,
      name: prod.name_th,
      code: prod.code,
      scores: [],
      responseCount: 0
    });
  }

  for (const r of rows) {
    let pEntry = prodStatsMap.get(r.product_id);
    if (!pEntry) {
      const found = A_PRODUCTS.find(p => p.code === r.product_code || p.name_th === r.product_name);
      if (found) {
        pEntry = prodStatsMap.get(found.id);
      } else {
        pEntry = {
          id: r.product_id || r.product_code || r.product_name,
          name: r.product_name || "ผลิตภัณฑ์",
          code: r.product_code || "GENERAL",
          scores: [],
          responseCount: 0
        };
        prodStatsMap.set(pEntry.id, pEntry);
      }
    }
    pEntry.responseCount++;
    if (typeof r.nps_score === "number" && Number.isFinite(r.nps_score)) {
      pEntry.scores.push(r.nps_score);
    }
  }

  const evaluatedProds = Array.from(prodStatsMap.values())
    .filter(p => p.scores.length > 0 || p.responseCount > 0)
    .map(p => {
      const avgScore = p.scores.length ? (p.scores.reduce((a, b) => a + b, 0) / p.scores.length) : 0;
      return { ...p, avgScore };
    })
    .sort((a, b) => {
      if (b.avgScore !== a.avgScore) return b.avgScore - a.avgScore;
      return b.responseCount - a.responseCount;
    });

  const topProds = evaluatedProds.slice(0, 3);
  const topContainer = document.getElementById("summary-top-products-container");
  if (topContainer) {
    if (!topProds.length) {
      topContainer.innerHTML = `<div class="small muted" style="padding:12px 0;text-align:center">ยังไม่มีข้อมูลการประเมินสินค้า</div>`;
    } else {
      topContainer.innerHTML = topProds.map((p, idx) => {
        const rank = idx + 1;
        const rankClass = rank === 1 ? "rank-1" : (rank === 2 ? "rank-2" : (rank === 3 ? "rank-3" : "rank-other"));
        const rankBadge = rank === 1 ? "🥇" : (rank === 2 ? "🥈" : (rank === 3 ? "🥉" : `#${rank}`));
        const iconHtml = PVT.productIcon ? PVT.productIcon(p.code, { size: 15 }) : "";
        const scoreFormatted = p.avgScore > 0 ? `${p.avgScore.toFixed(2)} ★` : "-";

        return `<div class="summary-top-product-item">
          <div class="summary-top-product-left">
            <span class="summary-rank-badge ${rankClass}" title="อันดับที่ ${rank}">${rankBadge}</span>
            <div class="summary-prod-name-box">
              <span class="summary-prod-name" title="${PVT.escapeHtml(p.name)}">
                ${iconHtml} <span style="margin-left:3px">${PVT.escapeHtml(p.name)}</span>
              </span>
            </div>
          </div>
          <div class="summary-top-product-right">
            <span class="summary-prod-score-pill">${scoreFormatted}</span>
            <span class="small muted" style="font-size:11px;min-width:38px;text-align:right">${p.responseCount} ชุด</span>
          </div>
        </div>`;
      }).join("");
    }
  }

  const prodEvalCount = document.getElementById("summary-product-eval-count");
  if (prodEvalCount) {
    prodEvalCount.textContent = `ประเมินแล้ว ${evaluatedProds.length} จาก ${A_PRODUCTS.length} ชนิดสินค้า`;
  }

  // 4. USP (Unique Selling Proposition) Summary Calculation & Rendering
  const uspContainer = document.getElementById("summary-usp-container");
  const uspEvalCount = document.getElementById("summary-usp-eval-count");
  if (uspContainer) {
    const responseIds = new Set(rows.map(r => r.id));
    const relevantAnswers = A_ANSWERS.filter(a => responseIds.has(a.response_id));
    
    // Find all questions with question_no = 1
    const uspQuestionIds = new Set(A_QUESTIONS.filter(q => q.question_no === 1).map(q => q.id));
    const uspAnswers = relevantAnswers.filter(a => uspQuestionIds.has(a.question_id));
    const uniqueUspRespondents = new Set(uspAnswers.map(a => a.response_id)).size;

    const oMap = Object.fromEntries(A_OPTIONS.map(o => [o.id, o]));
    const counts = {};
    
    for (const a of uspAnswers) {
      const ans = a.answer_json || {};
      const ids = Array.isArray(ans.selected) ? ans.selected : (ans.selected ? [ans.selected] : []);
      for (const id of ids) {
        const optObj = oMap[id];
        const label = optObj?.option_text || id;
        counts[label] = (counts[label] || 0) + 1;
      }
    }

    const sortedUsp = Object.entries(counts)
      .map(([label, count]) => ({ label, count }))
      .sort((a, b) => b.count - a.count);

    if (uspEvalCount) {
      uspEvalCount.textContent = `ผู้ตอบคำถาม USP: ${uniqueUspRespondents.toLocaleString()} คน`;
    }

    if (!sortedUsp.length) {
      uspContainer.innerHTML = `<div class="small muted" style="padding:16px 0;text-align:center">ยังไม่มีข้อมูลปัจจัย USP ในตัวกรองนี้</div>`;
    } else {
      const topUsp = sortedUsp.slice(0, 3);
      uspContainer.innerHTML = topUsp.map((item, idx) => {
        const fillPct = uniqueUspRespondents > 0 ? Math.round((item.count / uniqueUspRespondents) * 100) : 0;
        const colors = ['#1e3a8a', '#0284c7', '#f59e0b'];
        const color = colors[idx] || '#64748b';
        return `
          <div style="display:flex;flex-direction:column;gap:3px;margin-bottom:2px">
            <div style="display:flex;justify-content:space-between;align-items:center;font-size:12px;gap:8px">
              <span style="font-weight:normal;color:#1e293b;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:180px" title="${PVT.escapeHtml(item.label)}">
                ${idx + 1}. ${PVT.escapeHtml(item.label)}
              </span>
              <span style="font-weight:800;color:${color};flex-shrink:0">${fillPct}% (${item.count} คน)</span>
            </div>
            <div style="height:5px;background:#e2ece5;border-radius:3px;overflow:hidden">
              <div style="width:${fillPct}%;background:${color};height:100%;border-radius:3px"></div>
            </div>
          </div>
        `;
      }).join("");
    }
  }

  const byProduct={};
  for(const r of rows){
    if(!r.nps_score)continue;
    (byProduct[r.product_name] ||= []).push(r.nps_score);
  }
  const labels=Object.keys(byProduct);
  const values=labels.map(k=>byProduct[k].reduce((a,b)=>a+b,0)/byProduct[k].length);
  if(chartNps) chartNps.destroy();

  const vividPalette = [
    "#3b82f6", // Electric Blue
    "#ff007f", // Vivid Pink/Magenta
    "#10b981", // Emerald Green
    "#fbbf24", // Sunny Gold
    "#8b5cf6", // Purple
    "#06b6d4", // Cyan
    "#f97316", // Orange
    "#ec4899", // Hot Pink
    "#14b8a6", // Teal
    "#a855f7"  // Violet
  ];

  chartNps=new Chart(document.getElementById("chart-nps"), {
    type: chartNpsType,
    data: {
      labels,
      datasets: [{
        label: "NPS Score เฉลี่ย (1–5)",
        data: values,
        backgroundColor: chartNpsType === "bar" 
          ? vividPalette.slice(0, labels.length)
          : vividPalette.slice(0, labels.length)
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: chartNpsType === "bar" ? { y: { beginAtZero: true, max: 5 } } : undefined,
      plugins: {
        legend: {
          display: chartNpsType !== "bar",
          position: "bottom",
          labels: { font: { family: "Kanit", size: 12 } }
        }
      }
    }
  });

  if(chartSource) chartSource.destroy();
  chartSource = new Chart(document.getElementById("chart-source"), {
    type: chartSourceType,
    data: {
      labels: ["ร้านค้า (Dealer)", "เกษตรกร (Farmer)"],
      datasets: [{
        label: "จำนวนผู้ให้ข้อมูล",
        data: [dealerCount, farmerCount],
        backgroundColor: ["#3b82f6", "#ff007f"],
        borderWidth: chartSourceType === "bar" ? 0 : 2,
        borderColor: "#ffffff"
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: chartSourceType === "bar" ? { y: { beginAtZero: true } } : undefined,
      plugins: {
        legend: {
          display: chartSourceType !== "bar",
          position: "bottom",
          labels: {
            font: { family: "Kanit", size: 12 },
            padding: 12
          }
        },
        tooltip: {
          callbacks: {
            label: function(ctx) {
              const val = ctx.raw || 0;
              const total = dealerCount + farmerCount;
              const pct = total > 0 ? ((val / total) * 100).toFixed(1) : "0.0";
              return ` ${ctx.label}: ${val} ชุด (${pct}%)`;
            }
          }
        }
      }
    }
  });

  updateChartToggleButtons();
  renderQuestionInsights(rows);
}

function updateChartToggleButtons() {
  const npsBar = document.getElementById("toggle-nps-bar");
  const npsPie = document.getElementById("toggle-nps-pie");
  if (npsBar && npsPie) {
    if (chartNpsType === "bar") {
      npsBar.style.background = "var(--brand)";
      npsBar.style.color = "#fff";
      npsPie.style.background = "transparent";
      npsPie.style.color = "var(--muted)";
    } else {
      npsBar.style.background = "transparent";
      npsBar.style.color = "var(--muted)";
      npsPie.style.background = "var(--brand)";
      npsPie.style.color = "#fff";
    }
  }

  const srcDoughnut = document.getElementById("toggle-source-doughnut");
  const srcBar = document.getElementById("toggle-source-bar");
  if (srcDoughnut && srcBar) {
    if (chartSourceType === "doughnut") {
      srcDoughnut.style.background = "var(--brand)";
      srcDoughnut.style.color = "#fff";
      srcBar.style.background = "transparent";
      srcBar.style.color = "var(--muted)";
    } else {
      srcDoughnut.style.background = "transparent";
      srcDoughnut.style.color = "var(--muted)";
      srcBar.style.background = "var(--brand)";
      srcBar.style.color = "#fff";
    }
  }
}

window.setChartType = function(chartId, type) {
  if (chartId === "nps") {
    chartNpsType = type;
  } else if (chartId === "source") {
    chartSourceType = type;
  }
  renderDashboard();
};
function renderQuestionInsights(rows){
  const container = document.getElementById("dynamic-question-insights-container");
  if (!container) return;

  const selectedCampId = document.getElementById("dash-campaign")?.value || "";
  const selectedCamp = A_CAMPAIGNS.find(c => c.id === selectedCampId);
  const campLabel = document.getElementById("dynamic-insights-campaign-label");
  const badge = document.getElementById("dynamic-insights-badge");

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

  // If still no questions, fallback to global active custom or A_QUESTIONS or standard default
  if (!questions.length && typeof PVT.getActiveCustomQuestions === "function") {
    const activeCustom = PVT.getActiveCustomQuestions();
    if (activeCustom && activeCustom.length > 0) {
      questions = activeCustom;
      isCustom = true;
    }
  }

  if (!questions.length && A_QUESTIONS && A_QUESTIONS.length > 0) {
    questions = [...A_QUESTIONS].map(q => {
      const opts = A_OPTIONS.filter(o => o.question_id === q.id);
      return { ...q, options: opts };
    });
  }

  if (!questions.length && typeof PVT.getStandardDefaultQuestions === "function") {
    questions = PVT.getStandardDefaultQuestions();
  }

  // Sort questions by sort_order / question_no
  questions.sort((a, b) => (a.sort_order || a.question_no || 0) - (b.sort_order || b.question_no || 0));

  // Update header badges
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

  const responseIds = new Set(rows.map(r => r.id));
  const relevantAnswers = A_ANSWERS.filter(a => responseIds.has(a.response_id));
  const totalRespCount = rows.length;

  if (!questions.length || !totalRespCount) {
    container.innerHTML = `
      <div class="card" style="grid-column:1/-1;text-align:center;padding:32px 20px">
        <div class="muted small" style="font-size:14px">ยังไม่มีข้อมูลคำตอบในตัวกรองนี้ หรือยังไม่มีการบันทึกแบบสอบถามในแคมเปญที่เลือก</div>
      </div>
    `;
    return;
  }

  // Global Option Map for lookup
  const oMap = Object.fromEntries(A_OPTIONS.map(o => [o.id, o]));

  // Render cards for each question
  const cardsHtml = questions.map((q, qIndex) => {
    const qNo = q.question_no || (qIndex + 1);
    const qType = (q.question_type || "checkbox").toLowerCase();
    const promptText = q.prompt || `ข้อคำถามที่ ${qNo}`;
    const hintText = q.analysis_hint || "";
    const options = Array.isArray(q.options) ? q.options : (A_OPTIONS.filter(o => o.question_id === q.id));

    // Find all answers for this question
    const qAnswers = relevantAnswers.filter(a => {
      if (a.question_id === q.id) return true;
      if (a.question_id && (a.question_id === `std_q${qNo}_dealer` || a.question_id === `std_q${qNo}_farmer` || a.question_id === `q${qNo}`)) return true;
      if (a.question_id && (a.question_id === PVT.toValidUuid(`std_q${qNo}_dealer`) || a.question_id === PVT.toValidUuid(`std_q${qNo}_farmer`))) return true;
      const dbQ = A_QUESTIONS.find(x => x.id === a.question_id);
      if (dbQ && (dbQ.question_no === qNo || dbQ.sort_order === qNo)) return true;
      return false;
    });

    const answeredCount = qAnswers.length;

    // Type Badge Text
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
      
      // Initialize with defined options if available
      options.forEach(opt => {
        factorMap[opt.option_text || opt.id] = { label: opt.option_text || opt.id, scores: [] };
      });

      for (const a of qAnswers) {
        const ans = a.answer_json || a.answer || {};
        const ratings = ans.ratings || {};
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
              const stars = typeof PVT.starRating === "function" ? PVT.starRating(f.avg, 5) : "";
              const fillPct = Math.round((f.avg / 5) * 100);
              return `
                <div class="dynamic-opt-row">
                  <div class="dynamic-opt-header">
                    <span class="dynamic-opt-label">${PVT.escapeHtml(f.label)}</span>
                    <div class="dynamic-opt-val">
                      <span class="pill info" style="font-weight:800;font-size:11.5px">${f.avg.toFixed(2)} / 5</span>
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
        const ans = a.answer_json || a.answer || {};
        const txt = ans.text || ans.comment || (typeof ans === "string" ? ans : "");
        if (txt && typeof txt === "string" && txt.trim()) {
          // Find matching response for store name & date
          const resp = rows.find(r => r.id === a.response_id);
          comments.push({
            text: txt.trim(),
            client_name: resp?.client_name || resp?.customer_name || "ร้านค้า",
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
                  <span style="font-weight:700;color:#166534">🏪 ${PVT.escapeHtml(c.client_name)}</span>
                  <span>${c.date}</span>
                </div>
              </div>
            `).join("")}
          </div>
        `;
      }
    }
    // 3. CHECKBOX / RADIO / CHOICE / SCALE TYPE (Standard option counts)
    else {
      const counts = {};
      const otherTexts = [];

      // Initialize with defined options so 0-count options are also known
      options.forEach(opt => {
        counts[opt.option_text || opt.id] = 0;
      });

      for (const a of qAnswers) {
        const ans = a.answer_json || a.answer || {};
        const ids = Array.isArray(ans.selected) ? ans.selected : (ans.selected ? [ans.selected] : []);
        for (const id of ids) {
          const optObj = options.find(o => o.id === id || o.option_key === id);
          const label = optObj?.option_text || oMap[id]?.option_text || id;
          counts[label] = (counts[label] || 0) + 1;
        }
        if (typeof ans.value === "number") {
          const label = `${ans.value} คะแนน`;
          counts[label] = (counts[label] || 0) + 1;
        }
        if (ans.other && typeof ans.other === "string" && ans.other.trim()) {
          otherTexts.push(ans.other.trim());
        }
      }

      // Convert to sorted array
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
function renderInsightList(id,rows,suffix){
  const el=document.getElementById(id);
  if (!el) return;
  el.innerHTML=rows.length?rows.map(([k,v])=>`<div class="customer-row" style="grid-template-columns:1fr auto"><strong>${PVT.escapeHtml(k)}</strong><span class="pill">${v} ${suffix}</span></div>`).join(""):`<div class="empty">ยังไม่มีข้อมูล</div>`;
}
function renderCampaigns(){
  const tbody=document.getElementById("campaign-table");
  tbody.innerHTML=A_CAMPAIGNS.map(c=>{
    const hasCustom = typeof PVT.hasCampaignCustomQuestions === "function" && PVT.hasCampaignCustomQuestions(c.id);
    const customCount = hasCustom ? (PVT.getCampaignQuestions(c.id) || []).length : 0;
    const qBadge = hasCustom 
      ? `<span class="pill success" style="font-weight:750;font-size:11.5px;display:inline-flex;align-items:center;gap:4px"><svg class="pvt-icon" width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg><span>คำถามเฉพาะ (${customCount} ข้อ)</span></span>`
      : `<span class="pill" style="font-size:11.5px;background:#f1f5f9;color:#475569">คำถามมาตรฐาน</span>`;

    const trackedIds = getTrackedCampaignIds();
    const isTracked = trackedIds.includes(c.id);
    const trackingBtn = `
      <button class="btn btn-sm ${isTracked ? 'btn-primary' : 'btn-outline'}" 
              data-toggle-track="${c.id}" 
              style="display:inline-flex;align-items:center;gap:4px;padding:4px 8px;font-size:11px;font-weight:750" 
              title="${isTracked ? 'เลิกติดตาม Campaign นี้' : 'ติดตาม Campaign นี้เพื่อรับแจ้งเตือนเมื่อตอบแบบสอบถามใหม่'}">
        <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="${isTracked ? 'currentColor' : 'none'}" stroke="currentColor" stroke-width="2">
          <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/>
        </svg>
        <span>${isTracked ? 'กำลังติดตาม' : 'ติดตาม'}</span>
      </button>
    `;

    return `<tr>
      <td style="text-align:center">${trackingBtn}</td>
      <td><b>${PVT.escapeHtml(c.name)}</b></td>
      <td>${PVT.formatDate(c.start_date)} – ${PVT.formatDate(c.end_date)}</td>
      <td>${c.is_active?'<span class="pill success">Active</span>':'<span class="pill">Inactive</span>'}</td>
      <td>${qBadge}</td>
      <td style="text-align:right">
        <div style="display:inline-flex;align-items:center;gap:6px">
          <button class="btn btn-sm btn-primary" data-manage-questions="${c.id}" style="display:inline-flex;align-items:center;gap:4px;font-weight:750" title="ปรับแต่งโจทย์คำถาม เพิ่มข้อใหม่ หรือเพิ่มตัวเลือกเฉพาะ Campaign นี้">
            <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
            <span>จัดการคำถาม</span>
          </button>
          ${ADMIN_CTX.profile.role==="admin"?`
            <button class="btn btn-sm btn-outline" data-toggle-campaign="${c.id}" data-value="${!c.is_active}">${c.is_active?"ปิด":"เปิด"}</button>
            <button class="btn btn-sm btn-danger" data-delete-campaign="${c.id}" style="display:inline-flex;align-items:center;gap:4px;font-weight:750" title="ลบ Campaign นี้">
              <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/><line x1="10" y1="11" x2="10" y2="17"/><line x1="14" y1="11" x2="14" y2="17"/></svg>
              <span>ลบ</span>
            </button>
          `:""}
        </div>
      </td>
    </tr>`;
  }).join("");

  tbody.querySelectorAll("[data-manage-questions]").forEach(btn=>btn.addEventListener("click",()=>{
    if (typeof PVT.openCampaignQuestionModal === "function") {
      PVT.openCampaignQuestionModal(btn.dataset.manageQuestions);
    }
  }));
  tbody.querySelectorAll("[data-toggle-campaign]").forEach(btn=>btn.addEventListener("click",()=>toggleCampaign(btn.dataset.toggleCampaign,btn.dataset.value==="true")));
  tbody.querySelectorAll("[data-delete-campaign]").forEach(btn=>btn.addEventListener("click",()=>deleteCampaign(btn.dataset.deleteCampaign)));
  tbody.querySelectorAll("[data-toggle-track]").forEach(btn => {
    btn.addEventListener("click", () => {
      toggleTrackCampaign(btn.dataset.toggleTrack);
    });
  });
}
async function createCampaign(e){
  e.preventDefault(); if(ADMIN_CTX?.profile?.role!=="admin")return;
  const btn=e.submitter;PVT.setBusy(btn,true,"กำลังสร้าง...");
  try{
    const name = document.getElementById("campaign-name-input").value.trim();
    if (!name) throw new Error("กรุณาระบุชื่อ Campaign");

    const startDate = document.getElementById("campaign-start").value || null;
    const endDate = document.getElementById("campaign-end").value || null;
    const isActive = document.getElementById("campaign-active").checked;

    // Only set created_by if logged in via real Supabase Auth session user
    const realAuthUserId = ADMIN_CTX?.session?.user?.id || null;

    const payload = {
      name: name,
      start_date: startDate,
      end_date: endDate,
      is_active: isActive
    };

    if (realAuthUserId) {
      payload.created_by = realAuthUserId;
    }

    let data = null;
    let error = null;

    if (PVT.db) {
      const res = await PVT.db.from("survey_campaigns").insert(payload).select();
      data = res.data;
      error = res.error;

      // If foreign key constraint on created_by occurs, retry without created_by
      if (error && (error.code === "23503" || (error.message && error.message.includes("foreign key")))) {
        console.warn("Retrying survey_campaigns insert without created_by...");
        delete payload.created_by;
        const retryRes = await PVT.db.from("survey_campaigns").insert(payload).select();
        data = retryRes.data;
        error = retryRes.error;
      }
    }

    if (error) throw error;

    e.target.reset();await loadAdminData();renderAll();
    const createdId = data && data[0]?.id;
    PVT.toast("สร้าง Campaign แล้ว! กดปุ่ม 'จัดการคำถาม' เพื่อปรับแต่งคำถามได้ทันที", "success");
    if (createdId && typeof PVT.openCampaignQuestionModal === "function") {
      setTimeout(() => {
        if (confirm(`สร้าง Campaign สำเร็จ! ต้องการตั้งค่าหรือปรับแต่งคำถามเฉพาะสำหรับ Campaign นี้ตอนนี้เลยหรือไม่?`)) {
          PVT.openCampaignQuestionModal(createdId);
        }
      }, 300);
    }
  }catch(err){
    console.error("Error creating campaign:", err);
    PVT.toast(err.message || "เกิดข้อผิดพลาดในการสร้าง Campaign","error");
  }finally{
    PVT.setBusy(btn,false);
  }
}
async function toggleCampaign(id,value){
  const {error}=await PVT.db.from("survey_campaigns").update({is_active:value}).eq("id",id);
  if(error)return PVT.toast(error.message,"error");await loadAdminData();renderAll();
}
async function deleteCampaign(id){
  if(ADMIN_CTX.profile.role!=="admin")return;
  if(!confirm("⚠️ คุณแน่ใจหรือไม่ที่จะลบ Campaign นี้?\n\nคำเตือน: การลบ Campaign จะลบข้อมูลการตั้งค่าคำถามเฉพาะ และข้อมูลผลตอบรับ (Responses/Answers) ทั้งหมดของ Campaign นี้โดยถาวรและไม่สามารถเรียกคืนได้!")) return;
  
  try {
    // 1. Delete associated responses first because of ON DELETE RESTRICT on campaign_id in survey_responses
    const { error: respError } = await PVT.db.from("survey_responses").delete().eq("campaign_id", id);
    if (respError) {
      return PVT.toast("ไม่สามารถลบข้อมูลผลตอบรับของ Campaign ได้: " + respError.message, "error");
    }
    
    // 2. Delete the campaign itself (associated invites will delete automatically because of ON DELETE CASCADE)
    const { error } = await PVT.db.from("survey_campaigns").delete().eq("id", id);
    if (error) {
      return PVT.toast("ไม่สามารถลบ Campaign ได้: " + error.message, "error");
    }
    
    PVT.toast("ลบ Campaign สำเร็จแล้ว", "success");
    await loadAdminData();
    renderAll();
  } catch (err) {
    PVT.toast("เกิดข้อผิดพลาดในการลบ: " + err.message, "error");
  }
}
function renderAdminCustomers(){
  const term=document.getElementById("customer-search-admin").value.trim().toLowerCase();
  const sales=document.getElementById("customer-sales-admin").value;
  const prov=document.getElementById("customer-province-admin").value;
  const salesMap=Object.fromEntries(A_SALES.map(s=>[s.id,s.display_name]));

  // Map customer responses
  const responsesByCustomer = new Map();
  for (const r of A_RESPONSES) {
    if (r.customer_id) {
      if (!responsesByCustomer.has(r.customer_id)) responsesByCustomer.set(r.customer_id, []);
      responsesByCustomer.get(r.customer_id).push(r);
    }
  }

  // Map customer invites
  const invitesByCustomer = new Map();
  for (const inv of A_INVITES) {
    if (inv.customer_id && !invitesByCustomer.has(inv.customer_id)) {
      invitesByCustomer.set(inv.customer_id, inv);
    }
  }

  // Calculate Overall Progress Metrics across ALL stores in database
  const totalStores = A_CUSTOMERS.length;
  const completedStores = A_CUSTOMERS.filter(c => responsesByCustomer.has(c.id));
  const invitedStores = A_CUSTOMERS.filter(c => !responsesByCustomer.has(c.id) && invitesByCustomer.has(c.id));
  const pendingStores = A_CUSTOMERS.filter(c => !responsesByCustomer.has(c.id) && !invitesByCustomer.has(c.id));

  const completedCount = completedStores.length;
  const invitedCount = invitedStores.length;
  const pendingCount = pendingStores.length;

  const completedPct = totalStores > 0 ? ((completedCount / totalStores) * 100).toFixed(1) : "0.0";
  const invitedPct = totalStores > 0 ? ((invitedCount / totalStores) * 100).toFixed(1) : "0.0";
  const pendingPct = totalStores > 0 ? ((pendingCount / totalStores) * 100).toFixed(1) : "0.0";

  // Update Visual Progress Bar and Metric Cards
  const fillComp = document.getElementById("bar-fill-completed");
  if (fillComp) fillComp.style.width = `${completedPct}%`;
  const fillInv = document.getElementById("bar-fill-invited");
  if (fillInv) fillInv.style.width = `${invitedPct}%`;

  const pctPill = document.getElementById("store-progress-percentage-pill");
  if (pctPill) pctPill.textContent = `${completedPct}% ตอบแล้ว (${completedCount.toLocaleString()} / ${totalStores.toLocaleString()} ร้าน)`;

  const elTot = document.getElementById("metric-total-stores");
  if (elTot) elTot.textContent = totalStores.toLocaleString();
  const elComp = document.getElementById("metric-completed-stores");
  if (elComp) elComp.textContent = completedCount.toLocaleString();
  const elCompPct = document.getElementById("metric-completed-pct");
  if (elCompPct) elCompPct.textContent = `${completedPct}% ของร้านทั้งหมด`;

  const elInv = document.getElementById("metric-invited-stores");
  if (elInv) elInv.textContent = invitedCount.toLocaleString();
  const elInvPct = document.getElementById("metric-invited-pct");
  if (elInvPct) elInvPct.textContent = `${invitedPct}% มี Token/QR แล้ว`;

  const elPend = document.getElementById("metric-pending-stores");
  if (elPend) elPend.textContent = pendingCount.toLocaleString();
  const elPendPct = document.getElementById("metric-pending-pct");
  if (elPendPct) elPendPct.textContent = `${pendingPct}% ยังไม่เริ่มสำรวจ`;

  // Update Scope Filter Counts
  const scAll = document.getElementById("scope-count-all");
  if (scAll) scAll.textContent = totalStores.toLocaleString();
  const scComp = document.getElementById("scope-count-completed");
  if (scComp) scComp.textContent = completedCount.toLocaleString();
  const scInv = document.getElementById("scope-count-invited");
  if (scInv) scInv.textContent = invitedCount.toLocaleString();
  const scPend = document.getElementById("scope-count-pending");
  if (scPend) scPend.textContent = pendingCount.toLocaleString();

  // Filter rows based on search, sales, province, and scope
  const rows = A_CUSTOMERS.filter(c => {
    const p = c.province_normalized || c.province_raw || "";
    const text = `${c.client_id} ${c.client_name} ${p}`.toLowerCase();
    const hasResp = responsesByCustomer.has(c.id);
    const hasInv = invitesByCustomer.has(c.id);

    if (term && !text.includes(term)) return false;
    if (sales && c.salesperson_id !== sales) return false;
    if (prov && p !== prov) return false;

    if (ADMIN_STORE_SCOPE === "completed" && !hasResp) return false;
    if (ADMIN_STORE_SCOPE === "invited" && (hasResp || !hasInv)) return false;
    if (ADMIN_STORE_SCOPE === "pending" && (hasResp || hasInv)) return false;

    return true;
  });

  const countBadge = document.getElementById("admin-customer-count");
  if (countBadge) countBadge.textContent = `${rows.length.toLocaleString()} ร้าน (จาก ${totalStores.toLocaleString()})`;

  if (!rows.length) {
    document.getElementById("admin-customer-table").innerHTML = `<tr><td colspan="7" class="empty">ไม่พบข้อมูลร้านค้าตามเงื่อนไขที่เลือก</td></tr>`;
    return;
  }

  document.getElementById("admin-customer-table").innerHTML = rows.slice(0, 500).map(c => {
    const storeResps = responsesByCustomer.get(c.id) || [];
    const hasResp = storeResps.length > 0;
    const inv = invitesByCustomer.get(c.id);
    const hasInv = !hasResp && !!inv;

    // Status Badge
    let statusBadge = "";
    if (hasResp) {
      statusBadge = `<span class="pill success" style="font-weight:800;display:inline-flex;align-items:center;gap:4px;font-size:12px">
        <svg class="pvt-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
        <span>ตอบแล้ว</span>
      </span>`;
    } else if (hasInv) {
      const invLabel = inv.status === "opened" ? "เปิดลิงก์แล้ว" : "ส่งลิงก์แล้ว";
      statusBadge = `<span class="pill warning" style="font-weight:750;display:inline-flex;align-items:center;gap:4px;font-size:12px">
        <svg class="pvt-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        <span>${invLabel}</span>
      </span>`;
    } else {
      statusBadge = `<span class="pill" style="font-size:12px;color:var(--muted);background:#f1f5f3;display:inline-flex;align-items:center;gap:4px">
        <span style="width:7px;height:7px;border-radius:50%;background:#94a3b8;display:inline-block"></span>
        <span>ยังไม่ตอบ</span>
      </span>`;
    }

    // Answers / Evaluated details
    let detailsHtml = "";
    if (hasResp) {
      // Products evaluated chips
      const prodMap = {};
      storeResps.forEach(r => {
        if (r.product_id) prodMap[r.product_id] = (prodMap[r.product_id] || 0) + 1;
      });
      const prodChips = Object.entries(prodMap).map(([pid, count]) => {
        const prod = A_PRODUCTS.find(p => p.id === pid);
        const icon = getProductIcon(prod?.code, 12);
        const name = prod ? (prod.name_th || prod.name || "").split("(")[0].trim() : "สินค้า";
        return `<span class="badge-prod-chip" style="font-size:11px;padding:2px 6px">${icon} ${PVT.escapeHtml(name)}${count > 1 ? ` (${count})` : ""}</span>`;
      }).join(" ");

      // Average score
      const validScores = storeResps.map(r => r.nps_score).filter(s => typeof s === "number" && s > 0);
      const avgScore = validScores.length ? (validScores.reduce((a, b) => a + b, 0) / validScores.length).toFixed(1) : null;
      const latestResp = storeResps[0];
      const latestTime = latestResp?.submitted_at ? PVT.formatDate(latestResp.submitted_at) : "";

      detailsHtml = `
        <div style="display:flex;flex-direction:column;gap:3px">
          <div style="display:flex;align-items:center;gap:6px;flex-wrap:wrap">
            <span class="pill success" style="font-size:11px;font-weight:800;padding:2px 7px">${storeResps.length} ชุด</span>
            ${avgScore ? `<span class="pill info" style="font-size:11px;font-weight:750">${avgScore} ⭐</span>` : ""}
            ${prodChips}
          </div>
          ${latestTime ? `<div class="small muted">ล่าสุด: ${latestTime}</div>` : ""}
        </div>
      `;
    } else if (hasInv) {
      const invCreated = inv.created_at ? PVT.formatDate(inv.created_at) : "";
      detailsHtml = `
        <div class="small muted">
          <span>ลิงก์: ${invitePill(inv.status)}</span>
          ${invCreated ? ` • สร้างเมื่อ ${invCreated}` : ""}
        </div>
      `;
    } else {
      detailsHtml = `<span class="small muted">ยังไม่มีการตอบแบบสอบถาม</span>`;
    }

    return `
      <tr class="${hasResp ? 'clickable-table-row' : ''}" data-admin-store-row="${c.id}" title="${hasResp ? 'คลิกแถวนี้เพื่อดูคำตอบร้าน ' + PVT.escapeHtml(c.client_name) : ''}">
        <td><span style="font-family:monospace;font-size:12px;color:var(--muted)">${PVT.escapeHtml(c.client_id || "-")}</span></td>
        <td>
          <b style="color:#0f3b26;font-size:14px">${PVT.escapeHtml(c.client_name)}</b>
          <div class="small muted">${PVT.escapeHtml(c.province_normalized || c.province_raw || "-")}</div>
        </td>
        <td><span class="pill info" style="font-size:11px">${PVT.escapeHtml(c.province_normalized || c.province_raw || "-")}</span></td>
        <td>${PVT.escapeHtml(salesMap[c.salesperson_id] || "-")}</td>
        <td style="text-align:center">${statusBadge}</td>
        <td>${detailsHtml}</td>
        <td style="text-align:right">
          <div style="display:flex;gap:5px;justify-content:flex-end;align-items:center">
            ${hasResp ? `<button class="btn btn-primary btn-sm" data-view-store-answers="${c.id}" title="เปิดดูผลสำรวจร้านนี้" style="display:inline-flex;align-items:center;gap:4px">${PVT.icon('eye', {size: 13})} <span>ดูคำตอบ</span></button>` : ""}
            <a class="btn btn-secondary btn-sm" href="survey.html?customer=${encodeURIComponent(c.id)}" title="กรอกแบบสอบถามสำหรับร้านนี้" style="display:inline-flex;align-items:center;gap:4px">${PVT.icon('edit', {size: 13})} <span>กรอกแบบ</span></a>
            <button class="btn btn-outline btn-sm" data-admin-invite="${c.id}" title="สร้างลิงก์สำหรับร้านนี้" style="display:inline-flex;align-items:center;gap:4px">${PVT.icon('link', {size: 13})} <span>สร้างลิงก์</span></button>
          </div>
        </td>
      </tr>
    `;
  }).join("");

  // Bind row clicks and view buttons
  document.querySelectorAll("[data-view-store-answers]").forEach(b => {
    b.addEventListener("click", (e) => {
      e.stopPropagation();
      PVT.openResponseModal({ customerId: b.dataset.viewStoreAnswers });
    });
  });

  document.querySelectorAll("[data-admin-store-row]").forEach(tr => {
    tr.addEventListener("click", (e) => {
      if (e.target.closest("button") || e.target.closest("a")) return;
      const custId = tr.dataset.adminStoreRow;
      const resps = responsesByCustomer.get(custId);
      if (resps && resps.length > 0) {
        PVT.openResponseModal({ customerId: custId });
      }
    });
  });

  document.querySelectorAll("[data-admin-invite]").forEach(b => {
    b.addEventListener("click", (e) => {
      e.stopPropagation();
      openAdminInvite(b.dataset.adminInvite);
    });
  });
}
function invitePill(s){const m={created:["สร้างแล้ว","warning"],opened:["เปิดแล้ว","info"],completed:["ตอบแล้ว","success"],expired:["หมดอายุ","danger"],cancelled:["ยกเลิก","danger"]};const [t,c]=m[s]||[s,""];return `<span class="pill ${c}">${t}</span>`;}
function openAdminInvite(customerId){
  const c=A_CUSTOMERS.find(x=>x.id===customerId);if(!c)return;
  document.getElementById("admin-invite-customer-id").value=c.id;
  document.getElementById("admin-invite-name").textContent=c.client_name;
  const active=A_CAMPAIGNS.filter(c=>c.is_active);const camps=active.length?active:A_CAMPAIGNS;
  document.getElementById("admin-invite-campaign").innerHTML=camps.map(x=>`<option value="${x.id}">${PVT.escapeHtml(x.name)}</option>`).join("");
  document.getElementById("admin-invite-product").innerHTML=`<option value="">ให้ร้านเลือกสินค้าเอง</option>`+A_PRODUCTS.filter(x=>x.dealer_enabled).map(x=>`<option value="${x.id}">${PVT.escapeHtml(x.name_th)}</option>`).join("");
  document.getElementById("admin-invite-result").classList.add("hidden");
  document.getElementById("admin-invite-backdrop").classList.remove("hidden");
}
async function createAdminInvite(){
  const btn=document.getElementById("admin-create-invite");PVT.setBusy(btn,true,"กำลังสร้าง...");
  try{
    let token = null;
    const custId = document.getElementById("admin-invite-customer-id").value;
    const campId = document.getElementById("admin-invite-campaign").value;
    const prodId = document.getElementById("admin-invite-product").value||null;

    try {
      const {data,error}=await PVT.db.rpc("create_survey_invite",{p_customer_id:custId,p_campaign_id:campId,p_product_id:prodId,p_expires_at:null});
      if(!error && data?.token) token = data.token;
    } catch(rpcErr) {
      console.warn("RPC create_survey_invite notice:", rpcErr);
    }

    if (!token) {
      token = "inv-" + Math.random().toString(36).substring(2, 10);
    }

    const base = PVT.getPublicBaseUrl ? PVT.getPublicBaseUrl() : (window.PVT_SURVEY_CONFIG?.PUBLIC_BASE_URL||location.origin).replace(/\/$/,"");
    let link = `${base}/public-survey.html?token=${encodeURIComponent(token)}&customer=${encodeURIComponent(custId)}`;
    if (prodId) link += `&product=${encodeURIComponent(prodId)}`;

    document.getElementById("admin-public-link").value=link;
    const qr=document.getElementById("admin-qrcode");
    qr.innerHTML="";
    if (window.QRCode) new QRCode(qr,{text:link,width:190,height:190});
    document.getElementById("admin-invite-result").classList.remove("hidden");
    PVT.toast("สร้างลิงก์สำหรับร้านค้าเรียบร้อย", "success");
    await loadAdminData();
    renderAdminCustomers();
  }catch(err){PVT.toast(err.message,"error");}finally{PVT.setBusy(btn,false);}
}
function renderResults(){
  const term = (document.getElementById("result-search")?.value || "").trim().toLowerCase();
  const rows=A_RESPONSES.filter(r=>!term||`${r.client_id} ${r.client_name} ${r.product_name} ${r.salesperson_name} ${r.province}`.toLowerCase().includes(term));
  const countEl = document.getElementById("result-count-pill");
  if (countEl) countEl.textContent = `${rows.length.toLocaleString()} รายการ`;
  const tbody = document.getElementById("result-table");
  if (!tbody) return;
  if (!rows.length) {
    tbody.innerHTML = `<tr><td colspan="9" class="empty">ไม่พบข้อมูลแบบสอบถามตามเงื่อนไขค้นหา</td></tr>`;
    return;
  }
  tbody.innerHTML=rows.slice(0,1000).map(r=>`
    <tr id="result-row-${r.id}" class="clickable-table-row" data-admin-resp="${r.id}" title="คลิกเพื่อดูรายละเอียดแบบสอบถามฉบับเต็มของร้าน ${PVT.escapeHtml(r.client_name)}">
      <td>${PVT.formatDateTime(r.submitted_at)}</td>
      <td>${r.respondent_type==="farmer" ? "<span class='pill warning' style='font-size:11px'>👨‍🌾 เกษตรกร</span>" : "<span class='pill success' style='font-size:11px'>🏪 ร้านค้า</span>"}</td>
      <td><b>${PVT.escapeHtml(r.client_name)}</b><div class="muted small">${PVT.escapeHtml(r.client_id||"")}</div></td>
      <td><span class="pill" style="font-size:11px">${PVT.escapeHtml(r.province||"-")}</span></td>
      <td>${PVT.escapeHtml(r.salesperson_name||"-")}</td>
      <td><b>${PVT.escapeHtml(r.product_name)}</b></td>
      <td>${r.respondent_name ? PVT.escapeHtml(r.respondent_name) : `<span class="muted small">${r.respondent_type === "farmer" ? "เกษตรกร" : "ร้านค้า"}</span>`}</td>
      <td style="text-align:center">${typeof r.nps_score === "number" ? `<span class="pill ${r.nps_score>=4?'success':r.nps_score<=2?'danger':'warning'}" style="font-weight:800;display:inline-flex;align-items:center;gap:3px"><span>${r.nps_score}</span> ${PVT.icon('star', {size: 11})}</span>` : "-"}</td>
      <td style="text-align:right"><button class="btn btn-primary btn-sm" data-view-admin-resp="${r.id}" title="เปิดดูผลสำรวจ" style="display:inline-flex;align-items:center;gap:4px">${PVT.icon('eye', {size: 13})} <span>ดูคำตอบ</span></button></td>
    </tr>
  `).join("");

  tbody.querySelectorAll("[data-admin-resp]").forEach(tr => {
    tr.addEventListener("click", (e) => {
      if (e.target.closest("button") || e.target.closest("a")) return;
      PVT.openResponseModal({ responseId: tr.dataset.adminResp });
    });
  });

  tbody.querySelectorAll("[data-view-admin-resp]").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.stopPropagation();
      PVT.openResponseModal({ responseId: btn.dataset.viewAdminResp });
    });
  });
}
function humanAnswer(answer,q,oMap){
  const a=answer?.answer_json||{};
  if(q.question_type==="checkbox"){
    const labels=(a.selected||[]).map(id=>oMap[id]?.option_text||id);
    if(a.other) labels.push(`ระบุ: ${a.other}`);
    return labels.join(" | ");
  }
  if(q.question_type==="single_choice"){
    const label=a.selected?(oMap[a.selected]?.option_text||a.selected):"";
    return a.other?`${label}: ${a.other}`:label;
  }
  if(q.question_type==="rating_grid"){
    return Object.entries(a.ratings||{}).map(([id,v])=>`${oMap[id]?.option_text||id}=${v}`).join(" | ");
  }
  if(q.question_type==="scale") return a.value??"";
  return JSON.stringify(a);
}
function exportResults(){
  const selected=filteredResponses();
  if(!selected || !selected.length){
    PVT.toast("ไม่พบข้อมูลแบบสอบถามตามเงื่อนไขที่เลือก เพื่อส่งออก", "warning");
    return;
  }
  const qMap=Object.fromEntries(A_QUESTIONS.map(q=>[q.id,q]));
  const oMap=Object.fromEntries(A_OPTIONS.map(o=>[o.id,o]));
  const answersByResponse={};
  for(const a of A_ANSWERS) (answersByResponse[a.response_id] ||= []).push(a);
  const rows=selected.map(r=>{
    const qvals={Q1:"",Q2:"",Q3:"",Q4:"",Q5:""};
    const responseAnswers = answersByResponse[r.id] || r.answers || [];
    for(const a of responseAnswers){
      const q = qMap[a.question_id] || (A_QUESTIONS.find(item => item.id === a.question_id));
      if(!q) continue;
      qvals[`Q${q.question_no || 1}`] = humanAnswer(a, q, oMap);
    }
    return {
      วันที่: PVT.formatDateTime(r.submitted_at),
      กลุ่มผู้ตอบ: r.respondent_type === "farmer" ? "เกษตรกร" : "ร้านค้า",
      Campaign: r.campaign_name || "สำรวจความพึงพอใจ 2026",
      รหัสลูกค้า: r.client_id || "",
      ร้านค้า: r.client_name || "",
      จังหวัด: r.province || "",
      เซลล์ผู้สำรวจ: r.salesperson_name || "",
      สินค้า: r.product_name || "",
      ผู้ให้ข้อมูล: r.respondent_name || (r.respondent_type === "farmer" ? "เกษตรกร" : "ร้านค้า"),
      ...qvals,
      คะแนน_NPS: r.nps_score ?? ""
    };
  });
  const filename = `PVT_Survey_Export_${new Date().toISOString().slice(0,10)}.csv`;
  PVT.downloadCSV(filename, rows);
  PVT.toast(`ส่งออกไฟล์ CSV จำนวน ${rows.length.toLocaleString()} รายการสำเร็จ`, "success");
}
function getRoleBadgeHtml(role) {
  switch (role) {
    case "admin":
      return `<span class="role-badge role-badge-admin" title="ผู้ดูแลระบบสูงสุด (Full Access)">
        <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
        <span>Internal Staff (Admin)</span>
      </span>`;
    case "management":
      return `<span class="role-badge role-badge-management" title="ผู้บริหารและฝ่ายวิเคราะห์ข้อมูล">
        <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
        <span>Internal Staff (Executive)</span>
      </span>`;
    case "sales":
      return `<span class="role-badge role-badge-sales" title="ตัวแทนฝ่ายขายภาคสนาม">
        <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="8.5" cy="7" r="4"/><line x1="20" y1="8" x2="20" y2="14"/><line x1="23" y1="11" x2="17" y2="11"/></svg>
        <span>Field Representative (Sales)</span>
      </span>`;
    case "partner":
    case "store":
      return `<span class="role-badge role-badge-partner" title="ร้านค้าตัวแทนจำหน่าย">
        <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
        <span>Partner Store (Dealer)</span>
      </span>`;
    default:
      return `<span class="role-badge role-badge-default"><span>${PVT.escapeHtml(role || "User")}</span></span>`;
  }
}

function renderUsers(){
  const sm = Object.fromEntries(A_SALES.map(s => [s.id, s.display_name]));
  const tbody = document.getElementById("user-table");
  if (!tbody) return;

  if (!A_PROFILES || !A_PROFILES.length) {
    tbody.innerHTML = `<tr><td colspan="5" class="empty">ไม่พบข้อมูลผู้ใช้งานในระบบ</td></tr>`;
    return;
  }

  tbody.innerHTML = A_PROFILES.map(p => `
    <tr>
      <td><span style="font-family:monospace;font-weight:700;color:#0f3b26">${PVT.escapeHtml(p.username)}</span></td>
      <td><b>${PVT.escapeHtml(p.display_name)}</b></td>
      <td>${getRoleBadgeHtml(p.role)}</td>
      <td>${PVT.escapeHtml(sm[p.salesperson_id] || "-")}</td>
      <td>${p.is_active ? '<span class="pill success" style="font-size:11px">● ใช้งาน</span>' : '<span class="pill danger" style="font-size:11px">✕ ปิด</span>'}</td>
    </tr>
  `).join("");
}

async function createUser(e){
  e.preventDefault();if(ADMIN_CTX.profile.role!=="admin")return;
  const btn=e.submitter;PVT.setBusy(btn,true,"กำลังสร้าง...");
  try{
    const body={username:document.getElementById("new-username").value.trim(),display_name:document.getElementById("new-display-name").value.trim(),password:document.getElementById("new-password").value,role:document.getElementById("new-role").value,salesperson_id:document.getElementById("user-salesperson").value||null};
    const {data,error}=await PVT.db.functions.invoke("admin-create-user",{body});if(error)throw error;if(data?.error)throw new Error(data.error);
    e.target.reset();await loadAdminData();populateFilters();renderUsers();PVT.toast("สร้างผู้ใช้เรียบร้อย");
  }catch(err){PVT.toast(err.message||"สร้างผู้ใช้ไม่สำเร็จ","error");}finally{PVT.setBusy(btn,false);}
}

let chartCompare = null;

function renderComparison() {
  const selectA = document.getElementById("compare-camp-a");
  const selectB = document.getElementById("compare-camp-b");
  if (!selectA || !selectB) return;

  const idA = selectA.value;
  const idB = selectB.value;

  const campA = A_CAMPAIGNS.find(c => c.id === idA);
  const campB = A_CAMPAIGNS.find(c => c.id === idB);

  const responsesA = A_RESPONSES.filter(r => r.campaign_id === idA);
  const responsesB = A_RESPONSES.filter(r => r.campaign_id === idB);

  const getStats = (rows) => {
    const total = rows.length;
    const scores = rows.map(r => r.nps_score).filter(Number.isFinite);
    const avg = scores.length ? (scores.reduce((a,b)=>a+b,0) / scores.length) : 0;
    
    const dealers = rows.filter(r => !r.respondent_type || r.respondent_type === "dealer").length;
    const farmers = rows.filter(r => r.respondent_type === "farmer").length;
    
    const promoters = scores.filter(x => x >= 4).length;
    const passives = scores.filter(x => x === 3).length;
    const detractors = scores.filter(x => x <= 2).length;

    const promotersPct = total ? Math.round((promoters / total) * 100) : 0;
    const passivesPct = total ? Math.round((passives / total) * 100) : 0;
    const detractorsPct = total ? Math.round((detractors / total) * 100) : 0;

    let satisfactionLvl = "-";
    let satColor = "#475569";
    let satBg = "#e2ece5";
    if (scores.length) {
      if (avg >= 4.2) { satisfactionLvl = "ยอดเยี่ยม (Excellent)"; satColor = "#10b981"; satBg = "#e8f5ed"; }
      else if (avg >= 3.5) { satisfactionLvl = "ดีมาก (Good)"; satColor = "#059669"; satBg = "#edf8f2"; }
      else if (avg >= 2.8) { satisfactionLvl = "ปานกลาง (Fair)"; satColor = "#d97706"; satBg = "#fef3c7"; }
      else { satisfactionLvl = "ควรปรับปรุง (Needs Improvement)"; satColor = "#dc2626"; satBg = "#fee2e2"; }
    }

    const dist = [0, 0, 0, 0, 0];
    for (const s of scores) {
      if (s >= 1 && s <= 5) dist[s - 1]++;
    }

    return { total, avg, dealers, farmers, promotersPct, passivesPct, detractorsPct, satisfactionLvl, satColor, satBg, dist };
  };

  const statsA = getStats(responsesA);
  const statsB = getStats(responsesB);

  // Render metrics for A
  document.getElementById("comp-title-a").textContent = campA ? campA.name : "ไม่ได้เลือกแคมเปญ";
  document.getElementById("comp-dates-a").textContent = campA 
    ? `เริ่มต้น: ${campA.start_date || "-"} • สิ้นสุด: ${campA.end_date || "-"} • สถานะ: ${campA.is_active ? "🟢 เปิดใช้งาน" : "⚪ ปิดแล้ว"}`
    : "ไม่มีข้อมูล";
  document.getElementById("comp-responses-a").textContent = statsA.total.toLocaleString();
  document.getElementById("comp-respondent-split-a").textContent = `ร้านค้า: ${statsA.dealers.toLocaleString()} | เกษตรกร: ${statsA.farmers.toLocaleString()}`;
  document.getElementById("comp-avg-score-a").textContent = statsA.total ? statsA.avg.toFixed(2) : "-";
  document.getElementById("comp-avg-score-a").style.color = statsA.satColor;
  document.getElementById("comp-satisfaction-lvl-a").innerHTML = `<span class="pill" style="background:${statsA.satBg};color:${statsA.satColor};font-weight:800;font-size:11px;">${statsA.satisfactionLvl}</span>`;
  document.getElementById("comp-promoters-pct-a").textContent = `${statsA.promotersPct}%`;
  document.getElementById("comp-passives-pct-a").textContent = `${statsA.passivesPct}%`;
  document.getElementById("comp-detractors-pct-a").textContent = `${statsA.detractorsPct}%`;

  // Render metrics for B
  document.getElementById("comp-title-b").textContent = campB ? campB.name : "ไม่ได้เลือกแคมเปญ";
  document.getElementById("comp-dates-b").textContent = campB 
    ? `เริ่มต้น: ${campB.start_date || "-"} • สิ้นสุด: ${campB.end_date || "-"} • สถานะ: ${campB.is_active ? "🟢 เปิดใช้งาน" : "⚪ ปิดแล้ว"}`
    : "ไม่มีข้อมูล";
  document.getElementById("comp-responses-b").textContent = statsB.total.toLocaleString();
  document.getElementById("comp-respondent-split-b").textContent = `ร้านค้า: ${statsB.dealers.toLocaleString()} | เกษตรกร: ${statsB.farmers.toLocaleString()}`;
  document.getElementById("comp-avg-score-b").textContent = statsB.total ? statsB.avg.toFixed(2) : "-";
  document.getElementById("comp-avg-score-b").style.color = statsB.satColor;
  document.getElementById("comp-satisfaction-lvl-b").innerHTML = `<span class="pill" style="background:${statsB.satBg};color:${statsB.satColor};font-weight:800;font-size:11px;">${statsB.satisfactionLvl}</span>`;
  document.getElementById("comp-promoters-pct-b").textContent = `${statsB.promotersPct}%`;
  document.getElementById("comp-passives-pct-b").textContent = `${statsB.passivesPct}%`;
  document.getElementById("comp-detractors-pct-b").textContent = `${statsB.detractorsPct}%`;

  // Bar Chart Comparison
  if (chartCompare) chartCompare.destroy();
  const ctx = document.getElementById("chart-compare-distribution");
  if (ctx) {
    chartCompare = new Chart(ctx, {
      type: "bar",
      data: {
        labels: ["1 คะแนน (แย่)", "2 คะแนน", "3 คะแนน", "4 คะแนน", "5 คะแนน (ดีมาก)"],
        datasets: [
          {
            label: campA ? `${campA.name} (A)` : "Campaign A",
            data: statsA.dist,
            backgroundColor: "rgba(30, 58, 138, 0.85)",
            borderColor: "var(--brand)",
            borderWidth: 1,
            borderRadius: 6
          },
          {
            label: campB ? `${campB.name} (B)` : "Campaign B",
            data: statsB.dist,
            backgroundColor: "rgba(2, 132, 199, 0.85)",
            borderColor: "var(--brand-2)",
            borderWidth: 1,
            borderRadius: 6
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              stepSize: 1,
              font: { family: "Kanit", size: 11 }
            }
          },
          x: {
            ticks: {
              font: { family: "Kanit", size: 11 }
            }
          }
        },
        plugins: {
          legend: {
            position: "bottom",
            labels: { font: { family: "Kanit", size: 12 } }
          }
        }
      }
    });
  }

  // Products table side-by-side
  const prodBody = document.getElementById("comp-products-table-body");
  if (prodBody) {
    if (A_PRODUCTS.length === 0) {
      prodBody.innerHTML = `<tr><td colspan="4" class="text-center muted">ไม่มีข้อมูลสินค้าในระบบ</td></tr>`;
    } else {
      let trs = "";
      for (const p of A_PRODUCTS) {
        const scoresA = responsesA.filter(r => r.product_id === p.id).map(r => r.nps_score).filter(Number.isFinite);
        const scoresB = responsesB.filter(r => r.product_id === p.id).map(r => r.nps_score).filter(Number.isFinite);
        
        const avgA = scoresA.length ? (scoresA.reduce((a,b)=>a+b,0) / scoresA.length) : 0;
        const avgB = scoresB.length ? (scoresB.reduce((a,b)=>a+b,0) / scoresB.length) : 0;

        const valA = scoresA.length ? avgA.toFixed(2) : "-";
        const valB = scoresB.length ? avgB.toFixed(2) : "-";

        let diffHtml = "-";
        if (scoresA.length && scoresB.length) {
          const diff = avgA - avgB;
          const diffSign = diff > 0 ? `+${diff.toFixed(2)}` : diff.toFixed(2);
          const diffColor = diff > 0 ? "#10b981" : (diff < 0 ? "#ef4444" : "#475569");
          const diffIcon = diff > 0 ? "▲" : (diff < 0 ? "▼" : "•");
          diffHtml = `<strong style="color: ${diffColor}">${diffIcon} ${diffSign}</strong>`;
        }

        trs += `
          <tr>
            <td><strong>${PVT.escapeHtml(p.name_th)}</strong> <span class="muted small">(${PVT.escapeHtml(p.name_en)})</span></td>
            <td style="text-align:center; font-weight:700; color:var(--brand);">${valA} <span style="font-weight:normal; font-size:10.5px; color:#64748b">(${scoresA.length})</span></td>
            <td style="text-align:center; font-weight:700; color:var(--brand-2);">${valB} <span style="font-weight:normal; font-size:10.5px; color:#64748b">(${scoresB.length})</span></td>
            <td style="text-align:right">${diffHtml}</td>
          </tr>
        `;
      }
      prodBody.innerHTML = trs;
    }
  }

  // Provinces table side-by-side
  const provBody = document.getElementById("comp-provinces-table-body");
  if (provBody) {
    const provsA = responsesA.map(r => r.province).filter(Boolean);
    const provsB = responsesB.map(r => r.province).filter(Boolean);
    const allProvs = [...new Set([...provsA, ...provsB])].sort((a,b)=>a.localeCompare(b, "th"));

    if (allProvs.length === 0) {
      provBody.innerHTML = `<tr><td colspan="4" class="text-center muted" style="padding:16px;">ยังไม่มีข้อมูลจังหวัดในระบบ</td></tr>`;
    } else {
      let trs = "";
      for (const pr of allProvs) {
        const scoresA = responsesA.filter(r => r.province === pr).map(r => r.nps_score).filter(Number.isFinite);
        const scoresB = responsesB.filter(r => r.province === pr).map(r => r.nps_score).filter(Number.isFinite);
        
        const avgA = scoresA.length ? (scoresA.reduce((a,b)=>a+b,0) / scoresA.length) : 0;
        const avgB = scoresB.length ? (scoresB.reduce((a,b)=>a+b,0) / scoresB.length) : 0;

        const valA = scoresA.length ? avgA.toFixed(2) : "-";
        const valB = scoresB.length ? avgB.toFixed(2) : "-";

        let diffHtml = "-";
        if (scoresA.length && scoresB.length) {
          const diff = avgA - avgB;
          const diffSign = diff > 0 ? `+${diff.toFixed(2)}` : diff.toFixed(2);
          const diffColor = diff > 0 ? "#10b981" : (diff < 0 ? "#ef4444" : "#475569");
          const diffIcon = diff > 0 ? "▲" : (diff < 0 ? "▼" : "•");
          diffHtml = `<strong style="color: ${diffColor}">${diffIcon} ${diffSign}</strong>`;
        }

        trs += `
          <tr>
            <td><strong>${PVT.escapeHtml(pr)}</strong></td>
            <td style="text-align:center; font-weight:700; color:var(--brand);">${valA} <span style="font-weight:normal; font-size:10.5px; color:#64748b">(${scoresA.length})</span></td>
            <td style="text-align:center; font-weight:700; color:var(--brand-2);">${valB} <span style="font-weight:normal; font-size:10.5px; color:#64748b">(${scoresB.length})</span></td>
            <td style="text-align:right">${diffHtml}</td>
          </tr>
        `;
      }
      provBody.innerHTML = trs;
    }
  }
}
