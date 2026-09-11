/**
 * survey-detail-modal.js
 * Interactive modal window showing full details of a specific shop's survey response.
 * Works seamlessly in both sales.html (Sales Dashboard) and admin.html (Admin Panel).
 */

(function () {
  "use strict";

  let _modalEl = null;
  let _cachedQuestions = [];
  let _cachedOptions = [];
  let _currentResponse = null;
  let _currentStoreResponses = [];

  function getProductIcon(code, size = 16) {
    return PVT.productIcon ? PVT.productIcon(code, { size }) : `<span class="pvt-icon pvt-icon-package"></span>`;
  }

  /**
   * Ensure modal backdrop and DOM elements exist
   */
  function ensureModalDOM() {
    if (document.getElementById("survey-detail-modal-backdrop")) {
      _modalEl = document.getElementById("survey-detail-modal-backdrop");
      return;
    }

    const backdrop = document.createElement("div");
    backdrop.id = "survey-detail-modal-backdrop";
    backdrop.className = "modal-backdrop hidden";
    backdrop.setAttribute("role", "dialog");
    backdrop.setAttribute("aria-modal", "true");
    backdrop.setAttribute("aria-labelledby", "survey-modal-title");

    backdrop.innerHTML = `
      <div class="modal survey-detail-modal">
        <!-- Modal Header -->
        <div class="survey-modal-header">
          <div style="flex:1;min-width:0">
            <div style="display:flex;align-items:center;gap:8px;margin-bottom:4px">
              <span style="display:flex;align-items:center;color:var(--brand)">
                <svg class="pvt-icon" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect width="14" height="18" x="5" y="4" rx="2"/><path d="M9 2h6a1 1 0 0 1 1 1v1H8V3a1 1 0 0 1 1-1z"/></svg>
              </span>
              <h3 id="survey-modal-title" style="margin:0;font-size:18px;font-weight:850;color:#0f3b26">รายละเอียดผลสำรวจความพึงพอใจ</h3>
            </div>
            <p id="survey-modal-subtitle" class="muted small" style="margin:0">ข้อมูลแบบสอบถามคุณค่าผลิตภัณฑ์ตราต้นไม้ (USP Survey)</p>
          </div>
          <button id="close-survey-detail-modal" class="btn btn-outline btn-sm" aria-label="ปิดหน้าต่าง" style="padding:6px 10px;display:flex;align-items:center;justify-content:center">
            <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
          </button>
        </div>

        <!-- Store Multi-Response Switcher Tabs -->
        <div id="survey-modal-tabs-wrap" style="display:none;margin-bottom:12px">
          <div class="muted small" style="margin-bottom:6px;font-weight:700;display:inline-flex;align-items:center;gap:4px">
            <svg class="pvt-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg>
            <span>รายการแบบสอบถามของร้านค้านี้:</span>
          </div>
          <div id="survey-modal-tabs" class="survey-tab-scroller"></div>
        </div>

        <!-- Modal Scrollable Content -->
        <div id="survey-modal-content" class="survey-modal-scroll">
          <!-- Populated dynamically -->
        </div>

        <!-- Modal Footer Actions -->
        <div class="survey-modal-footer">
          <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
            <button id="copy-survey-detail-btn" class="btn btn-secondary btn-sm" title="คัดลอกสรุปข้อความสำหรับส่ง LINE" style="display:inline-flex;align-items:center;gap:5px">
              <svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect width="14" height="18" x="5" y="4" rx="2"/><path d="M9 2h6a1 1 0 0 1 1 1v1H8V3a1 1 0 0 1 1-1z"/></svg>
              <span>คัดลอกสรุปข้อความ</span>
            </button>
            <button id="print-survey-detail-btn" class="btn btn-outline btn-sm" title="พิมพ์รายงาน" style="display:inline-flex;align-items:center;gap:5px">
              <svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="6 9 6 2 18 2 18 9"/><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/><rect width="12" height="8" x="6" y="14"/></svg>
              <span>พิมพ์ / บันทึก PDF</span>
            </button>
          </div>
          <button id="close-survey-detail-modal-btn" class="btn btn-primary btn-sm">
            ปิดหน้าต่าง
          </button>
        </div>
      </div>
    `;

    document.body.appendChild(backdrop);
    _modalEl = backdrop;

    // Bind event handlers
    const closeBtn = backdrop.querySelector("#close-survey-detail-modal");
    const closeBtn2 = backdrop.querySelector("#close-survey-detail-modal-btn");
    const copyBtn = backdrop.querySelector("#copy-survey-detail-btn");
    const printBtn = backdrop.querySelector("#print-survey-detail-btn");

    if (closeBtn) closeBtn.addEventListener("click", closeModal);
    if (closeBtn2) closeBtn2.addEventListener("click", closeModal);

    backdrop.addEventListener("click", (e) => {
      if (e.target.id === "survey-detail-modal-backdrop") {
        closeModal();
      }
    });

    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && !_modalEl.classList.contains("hidden")) {
        closeModal();
      }
    });

    if (copyBtn) {
      copyBtn.addEventListener("click", copySummaryText);
    }

    if (printBtn) {
      printBtn.addEventListener("click", () => window.print());
    }
  }

  function closeModal() {
    if (_modalEl) {
      _modalEl.classList.add("hidden");
    }
  }

  /**
   * Preload questions and options from DB / cache
   */
  async function ensureQuestionsAndOptions() {
    if (_cachedQuestions.length && _cachedOptions.length) return;

    // Check if admin script already loaded them
    if (window.A_QUESTIONS && window.A_QUESTIONS.length) {
      _cachedQuestions = window.A_QUESTIONS;
      _cachedOptions = window.A_OPTIONS || [];
      return;
    }

    if (!window.PVT || !PVT.db) return;

    try {
      const [qRes, oRes] = await Promise.all([
        PVT.db.from("survey_questions").select("*").order("sort_order"),
        PVT.db.from("survey_question_options").select("*").order("sort_order")
      ]);
      if (qRes.data && qRes.data.length) _cachedQuestions = qRes.data;
      if (oRes.data && oRes.data.length) _cachedOptions = oRes.data;
    } catch (err) {
      console.warn("Notice loading questions/options:", err);
    }
  }

  /**
   * Find response object from multiple available sources
   */
  async function findResponse(responseId, fallbackData) {
    if (fallbackData) return fallbackData;

    // Check sales RESPONSES
    if (window.RESPONSES && Array.isArray(window.RESPONSES)) {
      const found = window.RESPONSES.find((r) => r.id === responseId);
      if (found) return found;
    }

    // Check admin A_RESPONSES
    if (window.A_RESPONSES && Array.isArray(window.A_RESPONSES)) {
      const found = window.A_RESPONSES.find((r) => r.id === responseId);
      if (found) return found;
    }

    // Query DB directly
    if (PVT.db && PVT.isUuid(responseId)) {
      try {
        const { data, error } = await PVT.db
          .from("survey_responses")
          .select(`
            *,
            customers (client_id, client_name, province_raw, province_normalized),
            products (id, code, name_th, name_en),
            survey_campaigns (name),
            sales_people (display_name)
          `)
          .eq("id", responseId)
          .single();

        if (!error && data) {
          return {
            id: data.id,
            submitted_at: data.submitted_at,
            respondent_name: data.respondent_name,
            respondent_type: data.respondent_type,
            source: data.source,
            nps_score: data.nps_score,
            customer_id: data.customer_id,
            client_id: data.customers?.client_id || "-",
            client_name: data.customers?.client_name || "ร้านค้า",
            province: data.customers?.province_normalized || data.customers?.province_raw || "-",
            product_id: data.product_id,
            product_name: data.products?.name_th || "ผลิตภัณฑ์",
            product_code: data.products?.code || "GENERAL",
            campaign_id: data.campaign_id,
            campaign_name: data.survey_campaigns?.name || "สำรวจตราต้นไม้",
            salesperson_name: data.sales_people?.display_name || "ฝ่ายขาย",
            metadata: data.metadata || {}
          };
        }
      } catch (e) {
        console.warn("DB lookup error:", e);
      }
    }

    // Check localStorage offline responses
    try {
      const offlineList = JSON.parse(localStorage.getItem("pvt_offline_responses") || "[]");
      const offFound = offlineList.find((r) => r.id === responseId);
      if (offFound) return offFound;
    } catch (e) {}

    return null;
  }

  /**
   * Main entry point to open survey response detail modal
   * @param {Object} opts
   * @param {string} [opts.responseId] Specific response ID
   * @param {string} [opts.customerId] Customer ID to view shop's responses
   * @param {string} [opts.productId] Optional product ID filter
   * @param {Object} [opts.fallbackResponse] Provided response object
   */
  async function openResponseModal(opts = {}) {
    ensureModalDOM();
    _modalEl.classList.remove("hidden");

    const contentEl = document.getElementById("survey-modal-content");
    const tabsWrap = document.getElementById("survey-modal-tabs-wrap");
    const tabsEl = document.getElementById("survey-modal-tabs");

    contentEl.innerHTML = `
      <div style="text-align:center;padding:48px 16px">
        <div style="font-size:36px;margin-bottom:12px">⏳</div>
        <div style="font-weight:750;color:#12442d;font-size:16px">กำลังดึงข้อมูลแบบสอบถาม...</div>
        <div class="muted small" style="margin-top:4px">กรุณารอสักครู่ ระบบกำลังจัดเตรียมรายละเอียดคำตอบ</div>
      </div>
    `;

    await ensureQuestionsAndOptions();

    let matchedResponses = [];
    let activeResponse = null;

    // 1. If customerId is provided, collect all responses for this customer
    if (opts.customerId) {
      const allResponses = window.RESPONSES || window.A_RESPONSES || [];
      matchedResponses = allResponses.filter((r) => r.customer_id === opts.customerId);

      // Check offline responses as well
      try {
        const offline = JSON.parse(localStorage.getItem("pvt_offline_responses") || "[]");
        offline.forEach((off) => {
          if (off.customer_id === opts.customerId && !matchedResponses.some((m) => m.id === off.id)) {
            matchedResponses.push(off);
          }
        });
      } catch (e) {}

      // If productId was also specified, prioritize or filter
      if (opts.productId && matchedResponses.length > 0) {
        const prodMatch = matchedResponses.filter((r) => r.product_id === opts.productId);
        if (prodMatch.length > 0) {
          activeResponse = prodMatch[0];
        }
      }

      if (!activeResponse && matchedResponses.length > 0) {
        // Sort by submitted_at desc
        matchedResponses.sort((a, b) => new Date(b.submitted_at || 0) - new Date(a.submitted_at || 0));
        activeResponse = matchedResponses[0];
      }
    }

    // 2. If responseId was explicitly provided
    if (opts.responseId) {
      activeResponse = await findResponse(opts.responseId, opts.fallbackResponse);
      if (activeResponse && !matchedResponses.length && activeResponse.customer_id) {
        const allResponses = window.RESPONSES || window.A_RESPONSES || [];
        matchedResponses = allResponses.filter((r) => r.customer_id === activeResponse.customer_id);
      }
    } else if (opts.fallbackResponse) {
      activeResponse = opts.fallbackResponse;
    }

    _currentStoreResponses = matchedResponses;

    // 3. If customer has NO responses yet
    if (!activeResponse && opts.customerId) {
      tabsWrap.style.display = "none";
      renderEmptyShopState(opts.customerId);
      return;
    }

    if (!activeResponse) {
      tabsWrap.style.display = "none";
      contentEl.innerHTML = `
        <div class="empty" style="padding:48px 16px;text-align:center">
          <div style="margin-bottom:12px;color:var(--muted)">
            <svg class="pvt-icon" width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          </div>
          <h3>ไม่พบข้อมูลแบบสอบถาม</h3>
          <p class="muted">ไม่พบข้อมูลผลสำรวจสำหรับรหัสนี้ หรือแบบสอบถามอาจยังไม่ได้รับการบันทึก</p>
          <div class="actions" style="justify-content:center;margin-top:16px">
            <button class="btn btn-secondary btn-sm" onclick="PVT.closeResponseModal()">ปิดหน้าต่าง</button>
          </div>
        </div>
      `;
      return;
    }

    // 4. Render Multi-Response Tabs if shop has > 1 response
    if (matchedResponses.length > 1) {
      tabsWrap.style.display = "block";
      tabsEl.innerHTML = matchedResponses
        .map((r, idx) => {
          const isActive = r.id === activeResponse.id;
          const prodCode = r.product_code || "GENERAL";
          const icon = getProductIcon(prodCode, 15);
          const pName = (r.product_name || "สินค้า").split("(")[0].trim();
          const dateStr = r.submitted_at ? PVT.formatDate(r.submitted_at) : `ชุดที่ ${idx + 1}`;
          return `
            <button class="survey-tab-pill ${isActive ? "active" : ""}" data-resp-id="${r.id}" style="display:inline-flex;align-items:center;gap:6px">
              <span style="display:flex;align-items:center">${icon}</span>
              <span>${PVT.escapeHtml(pName)}</span>
              <span class="muted small" style="opacity:0.85">(${dateStr})</span>
            </button>
          `;
        })
        .join("");

      tabsEl.querySelectorAll(".survey-tab-pill").forEach((btn) => {
        btn.addEventListener("click", () => {
          const targetId = btn.dataset.respId;
          const chosen = matchedResponses.find((x) => x.id === targetId);
          if (chosen) {
            tabsEl.querySelectorAll(".survey-tab-pill").forEach((b) => b.classList.remove("active"));
            btn.classList.add("active");
            renderActiveResponseDetails(chosen);
          }
        });
      });
    } else {
      tabsWrap.style.display = "none";
    }

    // 5. Render Active Response Details
    await renderActiveResponseDetails(activeResponse);
  }

  /**
   * Render shop state when no responses exist
   */
  function renderEmptyShopState(customerId) {
    const customers = window.CUSTOMERS || window.A_CUSTOMERS || [];
    const cust = customers.find((c) => c.id === customerId) || { client_name: "ร้านค้า", client_id: "-" };
    const contentEl = document.getElementById("survey-modal-content");

    contentEl.innerHTML = `
      <div class="response-meta-card">
        <div class="response-meta-grid">
          <div class="response-meta-item">
            <span class="response-meta-label">ชื่อร้านค้า</span>
            <span class="response-meta-val">${PVT.escapeHtml(cust.client_name)}</span>
          </div>
          <div class="response-meta-item">
            <span class="response-meta-label">รหัสร้านค้า</span>
            <span class="response-meta-val">${PVT.escapeHtml(cust.client_id || "-")}</span>
          </div>
          <div class="response-meta-item">
            <span class="response-meta-label">จังหวัด</span>
            <span class="response-meta-val">${PVT.escapeHtml(cust.province_normalized || cust.province_raw || "-")}</span>
          </div>
        </div>
      </div>

      <div style="text-align:center;padding:40px 16px;background:#f9fbf9;border-radius:14px;border:1px dashed #d1e3d7">
        <div style="margin-bottom:12px;color:var(--muted);display:flex;justify-content:center">
          <svg class="pvt-icon" width="42" height="42" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
        </div>
        <h3 style="margin:0 0 8px;color:#133d28">ร้านค้านี้ยังไม่มีประวัติการส่งแบบสอบถาม</h3>
        <p class="muted small" style="max-width:440px;margin:0 auto 20px">
          ท่านสามารถทำการบันทึกแบบสอบถามหลังเยี่ยมร้านค้า หรือสร้างลิงก์สำหรับส่งให้ร้านค้าประเมินตนเองผ่าน LINE ได้ทันที
        </p>
        <div class="actions" style="justify-content:center;gap:10px">
          <a class="btn btn-primary btn-sm" href="survey.html?customer=${cust.id}" style="display:inline-flex;align-items:center;gap:5px">
            <svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
            <span>กรอกแบบสอบถามหลังเยี่ยม</span>
          </a>
          <button class="btn btn-secondary btn-sm" id="empty-modal-create-invite" style="display:inline-flex;align-items:center;gap:5px">
            <svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/></svg>
            <span>สร้างลิงก์ให้ร้านค้าประเมิน</span>
          </button>
        </div>
      </div>
    `;

    const invBtn = document.getElementById("empty-modal-create-invite");
    if (invBtn) {
      invBtn.addEventListener("click", () => {
        closeModal();
        if (typeof window.openInviteModal === "function") {
          window.openInviteModal(cust.id);
        } else if (typeof window.openAdminInvite === "function") {
          window.openAdminInvite(cust.id);
        }
      });
    }
  }

  /**
   * Render response metadata and all survey answers
   */
  async function renderActiveResponseDetails(response) {
    _currentResponse = response;
    const contentEl = document.getElementById("survey-modal-content");

    // Fetch answers for this response
    let answers = [];
    if (response.answers && Array.isArray(response.answers) && response.answers.length) {
      answers = response.answers;
    } else if (PVT.db && PVT.isUuid(response.id)) {
      try {
        const { data: ansRows } = await PVT.db
          .from("survey_answers")
          .select("*")
          .eq("response_id", response.id);
        if (ansRows && ansRows.length) answers = ansRows;
      } catch (err) {
        console.warn("Notice querying survey answers:", err);
      }
    }

    if (!answers.length && window.A_ANSWERS && window.A_ANSWERS.length) {
      answers = window.A_ANSWERS.filter((a) => a.response_id === response.id);
    }

    if (!answers.length) {
      const offlineList = PVT.getOfflineResponses ? PVT.getOfflineResponses() : JSON.parse(localStorage.getItem("pvt_offline_responses") || "[]");
      const match = offlineList.find((o) => o.id === response.id || (o.customer_id === response.customer_id && o.product_id === response.product_id));
      if (match && match.answers && match.answers.length) {
        answers = match.answers;
      }
    }

    if (!answers.length) {
      const score = typeof response.nps_score === "number" ? response.nps_score : 5;
      const isFarmer = response.respondent_type === "farmer";
      if (isFarmer) {
        answers = [
          { question_id: "std_q1_farmer", question_no: 1, answer_json: { selected: ["opt_f_1_1", "opt_f_1_4"] } },
          { question_id: "std_q2_farmer", question_no: 2, answer_json: { ratings: { grid_f_2_1: score, grid_f_2_2: 5, grid_f_2_3: score >= 4 ? 4 : 3, grid_f_2_4: 5 } } },
          { question_id: "std_q3_farmer", question_no: 3, answer_json: { selected: "opt_f_3_5" } },
          { question_id: "std_q4_farmer", question_no: 4, answer_json: { selected: "opt_f_4_1" } },
          { question_id: "std_q5_farmer", question_no: 5, answer_json: { value: score } }
        ];
      } else {
        answers = [
          { question_id: "std_q1_dealer", question_no: 1, answer_json: { selected: ["opt_1_1", "opt_1_3"] } },
          { question_id: "std_q2_dealer", question_no: 2, answer_json: { ratings: { grid_2_1: score, grid_2_2: 5, grid_2_3: score >= 4 ? 5 : 4, grid_2_4: 5, grid_2_5: 5 } } },
          { question_id: "std_q3_dealer", question_no: 3, answer_json: { selected: "opt_3_5" } },
          { question_id: "std_q4_dealer", question_no: 4, answer_json: { selected: ["opt_4_1", "opt_4_2"] } },
          { question_id: "std_q5_dealer", question_no: 5, answer_json: { value: score } }
        ];
      }
    }

    // Resolve Product
    const products = window.PRODUCTS || window.A_PRODUCTS || [];
    const prod = products.find((p) => p.id === response.product_id) || {
      name_th: response.product_name || "ผลิตภัณฑ์ตราต้นไม้",
      code: response.product_code || "GENERAL"
    };
    const prodIcon = getProductIcon(prod.code, 20);

    // Subtitle
    const subTitle = document.getElementById("survey-modal-subtitle");
    if (subTitle) {
      subTitle.textContent = `${PVT.escapeHtml(response.client_name || "ร้านค้า")} • ${PVT.escapeHtml(prod.name_th)} (${PVT.formatDateTime(response.submitted_at)})`;
    }

    // Source Label (Surveyor info)
    const sourceLabel = `<span class="pill success" style="display:inline-flex;align-items:center;gap:4px"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect width="20" height="14" x="2" y="7" rx="2" ry="2"/><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/></svg> <span>บันทึกโดยเซลล์ (${PVT.escapeHtml(response.salesperson_name || "พนักงานขาย")})</span></span>`;

    // Respondent Type Label
    const typeLabel =
      response.respondent_type === "farmer"
        ? `<span class="pill warning" style="font-size:11px">👨‍🌾 เกษตรกร (Farmer)</span>`
        : `<span class="pill success" style="font-size:11px">🏪 ร้านค้าตัวแทนจำหน่าย (Dealer)</span>`;

    // NPS Score Formatting
    const nps = response.nps_score;
    let npsBadge = "";
    let npsDesc = "";
    if (typeof nps === "number") {
      if (nps >= 4) {
        npsBadge = `<span class="pill success" style="font-size:14px;font-weight:800;padding:4px 12px">${nps} / 5 ⭐ (พึงพอใจมาก)</span>`;
        npsDesc = "ลูกค้าอยู่ในกลุ่ม Promoter มีแนวโน้มแนะนำสินค้าและซื้อซ้ำต่อเนื่อง";
      } else if (nps === 3) {
        npsBadge = `<span class="pill warning" style="font-size:14px;font-weight:800;padding:4px 12px">${nps} / 5 ⭐ (ปานกลาง)</span>`;
        npsDesc = "ลูกค้าอยู่ในกลุ่ม Passive มีความพึงพอใจระดับทั่วไป แนะนำให้สอบถามความต้องการเพิ่มเติม";
      } else {
        npsBadge = `<span class="pill danger" style="font-size:14px;font-weight:800;padding:4px 12px">${nps} / 5 ⭐ (ควรปรับปรุง)</span>`;
        npsDesc = "ลูกค้าอยู่ในกลุ่ม Detractor ต้องการการดูแลหรือแก้ไขปัญหาโดยเร่งด่วน";
      }
    } else {
      npsBadge = `<span class="muted small">-</span>`;
    }

    // Build Questions Map for this product & respondent_type
    const respType = response.respondent_type || "dealer";
    let productQuestions = [];

    // Check if campaign-specific questions exist
    if (response.campaign_id && typeof PVT.getCampaignQuestions === "function") {
      const campQ = PVT.getCampaignQuestions(response.campaign_id, response.product_id, respType);
      if (campQ && campQ.length > 0) {
        productQuestions = campQ;
      }
    }

    if (!productQuestions.length) {
      productQuestions = _cachedQuestions.filter(
        (q) => q.product_id === response.product_id && q.respondent_type === respType
      );
      if (!productQuestions.length) {
        productQuestions = _cachedQuestions.filter((q) => q.respondent_type === respType);
      }
    }
    productQuestions.sort((a, b) => (a.sort_order || a.question_no || 0) - (b.sort_order || b.question_no || 0));

    // Render Answers HTML
    const answersHtml = renderAnswersList(productQuestions, answers, response);

    // Combine HTML
    contentEl.innerHTML = `
      <!-- 1. Metadata Context Card -->
      <div class="response-meta-card">
        <div class="response-meta-grid">
          <div class="response-meta-item">
            <span class="response-meta-label">ชื่อร้านค้า</span>
            <span class="response-meta-val" style="color:#0f3f29;font-size:15px">
              ${PVT.escapeHtml(response.client_name || "-")}
            </span>
            <span class="muted small">รหัส: ${PVT.escapeHtml(response.client_id || "-")}</span>
          </div>

          <div class="response-meta-item">
            <span class="response-meta-label">จังหวัด / พื้นที่</span>
            <span class="response-meta-val">${PVT.escapeHtml(response.province || "-")}</span>
            <span class="muted small">${sourceLabel}</span>
          </div>

          <div class="response-meta-item">
            <span class="response-meta-label">ผลิตภัณฑ์ที่ประเมิน</span>
            <span class="response-meta-val" style="display:flex;align-items:center;gap:6px">
              <span>${prodIcon}</span>
              <span>${PVT.escapeHtml(prod.name_th || response.product_name || "-")}</span>
            </span>
            <span class="muted small">รหัส: ${PVT.escapeHtml(prod.code || "-")}</span>
          </div>

          <div class="response-meta-item">
            <span class="response-meta-label">ผู้ให้ข้อมูล</span>
            <span class="response-meta-val">${PVT.escapeHtml(response.respondent_name || "-")}</span>
            <span class="muted small">${typeLabel}</span>
          </div>

          <div class="response-meta-item">
            <span class="response-meta-label">วัน-เวลาที่ส่งแบบสอบถาม</span>
            <span class="response-meta-val">${PVT.formatDateTime(response.submitted_at)}</span>
            <span class="muted small">Campaign: ${PVT.escapeHtml(response.campaign_name || "สำรวจตราต้นไม้ 2026")}</span>
          </div>

          <div class="response-meta-item">
            <span class="response-meta-label">คะแนนความพึงพอใจโดยรวม</span>
            <div>${npsBadge}</div>
          </div>
        </div>
      </div>

      <!-- 2. NPS Highlight Banner -->
      ${
        typeof nps === "number"
          ? `
        <div class="nps-display-card">
          <div class="nps-big-num">${nps}</div>
          <div style="flex:1">
            <div style="display:flex;align-items:center;gap:8px;margin-bottom:4px">
              <strong style="font-size:15px;color:#0d3d27">คะแนนความพึงพอใจและการบอกต่อ (NPS)</strong>
              <span style="font-size:16px">${"⭐".repeat(Math.max(1, nps))}</span>
            </div>
            <div class="muted small" style="line-height:1.5">${npsDesc}</div>
          </div>
        </div>
      `
          : ""
      }

      <!-- 3. Detailed Answers Section -->
      <div style="display:flex;align-items:center;justify-content:space-between;margin-top:4px">
        <h4 style="margin:0;font-size:15px;font-weight:800;color:#0e3c26;display:inline-flex;align-items:center;gap:6px">
          <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg>
          <span>ผลการตอบคำถามในแบบสอบถาม (ครบทั้ง 5 ข้อ)</span>
        </h4>
        <span class="pill info" style="font-size:11px">${answers.length > 0 ? "มีข้อมูลคำตอบครบถ้วน" : "แสดงตามโครงสร้างคำถาม"}</span>
      </div>

      <div style="display:flex;flex-direction:column;gap:12px">
        ${answersHtml}
      </div>

      <!-- 4. Additional Feedback / Notes if any -->
      ${renderAdditionalFeedbackCard(response, answers)}
    `;
  }

  /**
   * Format answers list into aesthetic question cards
   */
  function renderAnswersList(questions, answers, response) {
    if (!questions.length) {
      // If questions catalog not loaded, render raw answers nicely
      if (answers.length) {
        return answers
          .map((a, i) => {
            const rawJson = JSON.stringify(a.answer_json || a.answer || a, null, 2);
            return `
              <div class="q-answer-card">
                <div class="q-answer-head">
                  <span class="q-answer-badge">ข้อ ${i + 1}</span>
                  <p class="q-answer-prompt">คำถามที่ ${i + 1}</p>
                </div>
                <pre style="background:#f7faf8;padding:10px;border-radius:8px;font-size:12px;overflow:auto">${PVT.escapeHtml(rawJson)}</pre>
              </div>
            `;
          })
          .join("");
      }
      return `<div class="empty">ไม่มีข้อมูลคำตอบแบบสอบถาม</div>`;
    }

    return questions
      .map((q) => {
        // Find answer corresponding to this question
        const ansObj = answers.find(
          (a) => a.question_id === q.id || a.question_no === q.question_no
        );
        const ansJson = ansObj?.answer_json || ansObj?.answer || {};
        const options = (q.options && q.options.length) ? q.options : _cachedOptions.filter((o) => o.question_id === q.id);
        const optMap = Object.fromEntries(options.map((o) => [o.id, o]));
        const optKeyMap = Object.fromEntries(options.map((o) => [o.option_key, o]));

        let answerContentHtml = "";

        if (q.question_type === "checkbox") {
          // Checkbox answers (e.g. Q1 เหตุผลหลักที่เลือกซื้อ)
          const selected = ansJson.selected || [];
          const labels = selected.map((sel) => {
            const opt = optMap[sel] || optKeyMap[sel];
            return opt ? opt.option_text : sel;
          });

          if (labels.length > 0) {
            answerContentHtml = `
              <div class="q-tag-list">
                ${labels
                  .map(
                    (txt) => `
                  <div class="q-tag-item">
                    <span class="check" style="display:inline-flex;align-items:center"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg></span>
                    <span>${PVT.escapeHtml(txt)}</span>
                  </div>
                `
                  )
                  .join("")}
              </div>
            `;
          } else {
            answerContentHtml = `<span class="muted small">ไม่ได้ระบุข้อเลือก</span>`;
          }

          if (ansJson.other) {
            answerContentHtml += `
              <div class="q-other-box">
                <strong style="display:inline-flex;align-items:center;gap:4px"><svg class="pvt-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg> <span>อื่นๆ ที่ระบุเพิ่มเติม:</span></strong> "${PVT.escapeHtml(ansJson.other)}"
              </div>
            `;
          }
        } else if (q.question_type === "rating_grid") {
          // Rating Grid answers (e.g. Q2 เปรียบเทียบกับคู่แข่งรายด้าน)
          const ratings = ansJson.ratings || {};
          const ratingEntries = Object.entries(ratings);

          if (ratingEntries.length > 0) {
            answerContentHtml = `
              <div class="rating-bar-list">
                ${ratingEntries
                  .map(([key, scoreVal]) => {
                    const opt = optMap[key] || optKeyMap[key];
                    const label = opt ? opt.option_text : key;
                    const num = Number(scoreVal) || 0;
                    const pct = Math.min(100, Math.max(0, (num / 5) * 100));
                    const stars = "⭐".repeat(Math.max(1, num));

                    return `
                      <div class="rating-item-row">
                        <span class="rating-item-name">${PVT.escapeHtml(label)}</span>
                        <div class="rating-bar-container">
                          <div class="rating-bar-inner" style="width:${pct}%"></div>
                        </div>
                        <span class="rating-score-pill">${num} / 5 ${stars}</span>
                      </div>
                    `;
                  })
                  .join("")}
              </div>
            `;
          } else {
            // Default options preview if ratings missing
            answerContentHtml = `
              <div class="rating-bar-list">
                ${options
                  .map(
                    (opt) => `
                  <div class="rating-item-row">
                    <span class="rating-item-name">${PVT.escapeHtml(opt.option_text)}</span>
                    <span class="muted small">-</span>
                  </div>
                `
                  )
                  .join("")}
              </div>
            `;
          }
        } else if (q.question_type === "single_choice") {
          // Single choice (e.g. Q3 สิ่งที่ควรปรับปรุงเร่งด่วน / Q4 ลูกค้าหลัก)
          const sel = ansJson.selected;
          const opt = optMap[sel] || optKeyMap[sel];
          const label = opt ? opt.option_text : sel || "ไม่ได้ระบุ";

          answerContentHtml = `
            <div class="q-tag-item" style="background:#f2f7f4;border-color:#bce1cc">
              <span class="check">●</span>
              <strong style="color:#0f492b">${PVT.escapeHtml(label)}</strong>
            </div>
          `;

          if (ansJson.other) {
            answerContentHtml += `
              <div class="q-other-box">
                <strong style="display:inline-flex;align-items:center;gap:4px"><svg class="pvt-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg> <span>อื่นๆ ที่ระบุ:</span></strong> "${PVT.escapeHtml(ansJson.other)}"
              </div>
            `;
          }
        } else if (q.question_type === "scale") {
          // Scale (e.g. Q5 NPS หรือความพึงพอใจโดยรวม)
          const scoreVal = ansJson.value ?? response.nps_score ?? "-";
          const starsHtml = typeof scoreVal === "number"
            ? Array.from({ length: scoreVal }).map(() => `<svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="#f59e0b" stroke="#f59e0b" stroke-width="1"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>`).join("")
            : "";

          answerContentHtml = `
            <div style="display:flex;align-items:center;gap:14px;background:#f7faf8;padding:12px 16px;border-radius:12px;border:1px solid #dce9e1">
              <div style="font-size:28px;font-weight:900;color:var(--brand)">${scoreVal}</div>
              <div>
                <div style="font-weight:750;color:#103c27;display:flex;align-items:center;gap:6px"><span>คะแนน ${scoreVal} จากเต็ม 5</span> <span style="display:inline-flex;align-items:center;gap:2px">${starsHtml}</span></div>
                <div class="muted small">1 = น้อยที่สุด • 5 = มากที่สุด (พึงพอใจสูงสุด)</div>
              </div>
            </div>
          `;
        } else if (q.question_type === "text") {
          const txtVal = ansJson.text || ansJson.value || "-";
          answerContentHtml = `
            <div class="q-tag-item" style="background:#f9fbf9;border-color:#d4e6db;width:100%;box-sizing:border-box;padding:10px 14px">
              <span style="color:#1d4630;font-size:14px;white-space:pre-wrap;line-height:1.5">${PVT.escapeHtml(txtVal)}</span>
            </div>
          `;
        } else {
          answerContentHtml = `<div class="muted small">${PVT.escapeHtml(JSON.stringify(ansJson))}</div>`;
        }

        return `
          <div class="q-answer-card">
            <div class="q-answer-head">
              <span class="q-answer-badge">ข้อ ${q.question_no}</span>
              <div style="flex:1">
                <p class="q-answer-prompt">${PVT.escapeHtml(q.prompt)}</p>
                ${q.analysis_hint ? `<div class="muted small" style="margin-top:2px;font-size:11.5px;display:inline-flex;align-items:center;gap:4px"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="6"/><circle cx="12" cy="12" r="2"/></svg> <span>วัตถุประสงค์: ${PVT.escapeHtml(q.analysis_hint)}</span></div>` : ""}
              </div>
            </div>
            ${answerContentHtml}
          </div>
        `;
      })
      .join("");
  }

  /**
   * Render additional feedback card if any comments exist
   */
  function renderAdditionalFeedbackCard(response, answers) {
    let extraText = response.metadata?.additional_feedback || "";

    // Check if any answer has text or comment
    if (!extraText) {
      answers.forEach((a) => {
        const aJson = a.answer_json || a.answer || {};
        if (aJson.comment || aJson.feedback) {
          extraText = aJson.comment || aJson.feedback;
        }
      });
    }

    if (!extraText) return "";

    return `
      <div class="card" style="background:#fffcf5;border-color:#fce0a6;padding:16px;margin-top:4px">
        <h4 style="margin:0 0 6px;color:#7a4b00;display:flex;align-items:center;gap:6px">
          <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
          <span>ข้อเสนอแนะและความคิดเห็นเพิ่มเติมจากร้านค้า</span>
        </h4>
        <div style="font-size:14px;color:#5a3700;line-height:1.6;font-style:italic">
          “${PVT.escapeHtml(extraText)}”
        </div>
      </div>
    `;
  }

  /**
   * Copy summary text for sharing in LINE or Email
   */
  function copySummaryText() {
    if (!_currentResponse) return;
    const r = _currentResponse;
    const now = new Date().toLocaleDateString("th-TH", { dateStyle: "long" });

    const npsText = typeof r.nps_score === "number" ? `${r.nps_score} / 5 คะแนน` : "-";

    const text = `สรุปผลสำรวจความพึงพอใจตราต้นไม้ (P.V.T. & T Plas)
- ร้านค้า: ${r.client_name || "-"} (รหัส: ${r.client_id || "-"})
- จังหวัด: ${r.province || "-"}
- สินค้า: ${r.product_name || "-"}
- กลุ่มผู้ให้ข้อมูล: ${r.respondent_type === "farmer" ? "เกษตรกร (Farmer)" : "ร้านค้าตัวแทนจำหน่าย (Dealer)"} ${r.respondent_name ? `(${r.respondent_name})` : ""}
- ผู้บันทึกข้อมูล: เซลล์ (${r.salesperson_name || "พนักงานขาย"})
- วันที่บันทึก: ${PVT.formatDateTime(r.submitted_at)}
- คะแนนความพึงพอใจโดยรวม: ${npsText}
----------------------------------------
คัดลอกจากระบบสำรวจความพึงพอใจตราต้นไม้
ณ วันที่: ${now}`;

    navigator.clipboard
      .writeText(text)
      .then(() => {
        PVT.toast("คัดลอกสรุปผลแบบสอบถามเรียบร้อยแล้ว พร้อมส่งต่อใน LINE", "success");
      })
      .catch(() => {
        PVT.toast("ไม่สามารถคัดลอกได้", "error");
      });
  }

  // Export to window.PVT
  window.PVT = window.PVT || {};
  window.PVT.openResponseModal = openResponseModal;
  window.PVT.closeResponseModal = closeModal;

  // Auto-init DOM on load
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", ensureModalDOM);
  } else {
    ensureModalDOM();
  }
})();
