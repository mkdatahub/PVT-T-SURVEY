let PUBLIC_CONTEXT = null;
let PUBLIC_PRODUCTS = [];
let PUBLIC_QUESTIONS = [];
let ALL_CUSTOMERS = [];
let PUBLIC_SALESPERSON_ID = null;
let PUBLIC_SALESPERSON_NAME = "";
let PUBLIC_CUSTOMER_ID = null;
let COMPLETED_PRODUCT_IDS = new Set();
let SELECTED_PRODUCT_ID = null;

function getProductIcon(code, size = 28) {
  return PVT.productIcon ? PVT.productIcon(code, { size }) : `<span class="pvt-icon pvt-icon-package"></span>`;
}

async function checkCompletedProducts() {
  const custId = PUBLIC_CUSTOMER_ID || (PUBLIC_CONTEXT?.customer_id);
  
  // Check local device storage
  try {
    const localDone = JSON.parse(localStorage.getItem("pvt_done_products") || "[]");
    if (Array.isArray(localDone)) {
      localDone.forEach(id => COMPLETED_PRODUCT_IDS.add(id));
    }
  } catch(e){}

  // Query database for this customer
  if (custId && PVT.isUuid(custId)) {
    try {
      const { data, error } = await PVT.db
        .from("survey_responses")
        .select("product_id")
        .eq("customer_id", custId);
      if (!error && Array.isArray(data)) {
        data.forEach(r => {
          if (r.product_id) COMPLETED_PRODUCT_IDS.add(r.product_id);
        });
      }
    } catch(err) {
      console.warn("Check completed products error:", err);
    }
  }
}

document.addEventListener("DOMContentLoaded", async () => {
  PVT.requireConfigured();
  const token = PVT.params().get("token");

  try {
    // Load products for dealers
    PUBLIC_PRODUCTS = await PVT.loadProducts("dealer");
    if (!PUBLIC_PRODUCTS.length) {
      // Fallback default dealer products if empty DB
      PUBLIC_PRODUCTS = [
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

    if (token) {
      await initTokenFlow(token);
    } else {
      await initOpenFlow();
    }

    await checkCompletedProducts();
    renderProductCards();
    bindEvents();

    document.getElementById("public-loading").classList.add("hidden");
    document.getElementById("public-content").classList.remove("hidden");
  } catch (err) {
    console.error("Public survey init error:", err);
    // Even if error, allow open flow so user can still take survey
    await initOpenFlow();
    await checkCompletedProducts();
    renderProductCards();
    bindEvents();
    document.getElementById("public-loading").classList.add("hidden");
    document.getElementById("public-content").classList.remove("hidden");
  }
});

async function initTokenFlow(token) {
  try {
    const { data, error } = await PVT.db.rpc("get_public_survey_context", { p_token: token });
    if (!error && data?.valid) {
      if (data.status === "completed") {
        return showCompleted(true);
      }
      PUBLIC_CONTEXT = data;
      try { await PVT.db.rpc("mark_invite_opened", { p_token: token }); } catch(e){}

      // Show verified shop info
      document.getElementById("token-shop-box").classList.remove("hidden");
      document.getElementById("token-respondent-box").classList.remove("hidden");
      document.getElementById("open-shop-box").classList.add("hidden");

      document.getElementById("token-shop-name").textContent = data.customer_name || "ร้านค้าตัวแทนจำหน่าย";
      document.getElementById("token-shop-meta").textContent = data.province ? `จังหวัด: ${data.province}` : "";

      if (data.preselected_product_id) {
        setTimeout(() => selectProduct(data.preselected_product_id, true), 100);
      }
      return;
    }
  } catch (rpcErr) {
    console.warn("RPC context error, falling back to open flow:", rpcErr);
  }
  // If token invalid, gracefully switch to open flow
  await initOpenFlow();
}

async function initOpenFlow() {
  const params = PVT.params();
  const spParam = params.get("sp") || params.get("salesperson") || params.get("salesperson_id") || params.get("sales");
  const spNameParam = params.get("sp_name") || params.get("salesperson_name");
  const storeParam = params.get("store") || params.get("customer") || params.get("customer_id") || params.get("cust");
  const prodParam = params.get("product") || params.get("product_id") || params.get("p");

  if (spParam) {
    PUBLIC_SALESPERSON_ID = spParam;
  }
  if (spNameParam) {
    PUBLIC_SALESPERSON_NAME = decodeURIComponent(spNameParam);
  }

  // Load customer seeds in background for matching customer/salesperson on submit
  try {
    ALL_CUSTOMERS = await PVT.getSeedCustomers();
  } catch (custErr) {
    console.warn("Error loading customer seed reference:", custErr);
  }

  // Check if storeParam is provided (Store-Specific Unique Survey Link)
  if (storeParam && ALL_CUSTOMERS.length) {
    const matchedStore = ALL_CUSTOMERS.find(c => 
      c.id === storeParam || 
      c.client_id === storeParam || 
      (c.client_name || "").toLowerCase() === storeParam.toLowerCase()
    );
    if (matchedStore) {
      PUBLIC_CUSTOMER_ID = matchedStore.id;
      if (matchedStore.salesperson_id && !PUBLIC_SALESPERSON_ID) {
        PUBLIC_SALESPERSON_ID = matchedStore.salesperson_id;
      }
      
      // Show verified customer header
      document.getElementById("token-shop-box").classList.remove("hidden");
      document.getElementById("open-shop-box").classList.add("hidden");
      document.getElementById("token-shop-name").textContent = matchedStore.client_name;
      const provStr = matchedStore.province_normalized || matchedStore.province_raw || "-";
      const codeStr = matchedStore.client_id ? `รหัส: ${matchedStore.client_id} • ` : "";
      document.getElementById("token-shop-meta").textContent = `${codeStr}จังหวัด: ${provStr}`;
      document.getElementById("token-respondent-box").classList.remove("hidden");
    }
  }

  if (!PUBLIC_CUSTOMER_ID) {
    document.getElementById("open-shop-box").classList.remove("hidden");
    document.getElementById("token-shop-box").classList.add("hidden");
    document.getElementById("token-respondent-box").classList.add("hidden");
  }

  // If salesperson referral info exists, display the referral badge
  if (PUBLIC_SALESPERSON_NAME || PUBLIC_SALESPERSON_ID) {
    const refBox = document.getElementById("salesperson-referral-box");
    const refName = document.getElementById("salesperson-referral-name");
    if (refBox && refName) {
      let displayName = PUBLIC_SALESPERSON_NAME;
      if (!displayName && PUBLIC_SALESPERSON_ID && ALL_CUSTOMERS.length) {
        const foundCust = ALL_CUSTOMERS.find(c => c.salesperson_id === PUBLIC_SALESPERSON_ID && c.salesperson_name);
        if (foundCust) {
          displayName = foundCust.salesperson_name;
        }
      }
      if (displayName) {
        refName.textContent = displayName;
        refBox.classList.remove("hidden");
      }
    }
  }

  // Auto-match store only internally in background upon typing without showing other stores list
  const shopInput = document.getElementById("shop-search-input");
  if (shopInput) {
    shopInput.addEventListener("input", () => {
      const val = shopInput.value.trim().toLowerCase();
      if (!val) return;
      const match = ALL_CUSTOMERS.find(c => (c.client_name || "").toLowerCase() === val);
      const provInput = document.getElementById("shop-province-input");
      if (match) {
        PUBLIC_CUSTOMER_ID = match.id;
        if (match.salesperson_id && !PUBLIC_SALESPERSON_ID) {
          PUBLIC_SALESPERSON_ID = match.salesperson_id;
        }
        if (provInput && !provInput.value) {
          provInput.value = match.province_normalized || match.province_raw || "";
        }
      }
    });
  }

  // Pre-select product if product param given
  if (prodParam && PUBLIC_PRODUCTS.length) {
    const matchedProd = PUBLIC_PRODUCTS.find(p => p.id === prodParam || (p.code && p.code.toUpperCase() === prodParam.toUpperCase()));
    if (matchedProd) {
      setTimeout(() => selectProduct(matchedProd.id, true), 100);
    }
  }
}

function renderProductCards() {
  const container = document.getElementById("product-cards-grid");
  const sel = document.getElementById("public-product");
  if (!container) return;

  container.innerHTML = PUBLIC_PRODUCTS.map(p => {
    const icon = getProductIcon(p.code, 32);
    const isCompleted = COMPLETED_PRODUCT_IDS.has(p.id);
    const isSelected = SELECTED_PRODUCT_ID === p.id;
    
    let badgeHtml = "";
    if (isCompleted) {
      badgeHtml = `
        <div class="public-prod-status-badge is-completed">
          <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
          <span>ทำแบบสอบถามแล้ว</span>
        </div>
      `;
    } else if (isSelected) {
      badgeHtml = `
        <div class="public-prod-status-badge is-active">
          <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
          <span>กำลังเลือกประเมิน</span>
        </div>
      `;
    }

    return `
      <label class="public-prod-card ${isCompleted ? 'completed' : ''} ${isSelected ? 'active' : ''}" data-product-id="${p.id}">
        <input type="radio" name="product_select_radio" value="${p.id}" ${isSelected ? 'checked' : ''}>
        <div class="public-prod-icon" style="display:flex;align-items:center;justify-content:center;color:var(--brand)">${icon}</div>
        <div class="public-prod-name">${PVT.escapeHtml(p.name_th || p.name)}</div>
        <div class="public-prod-en">${PVT.escapeHtml(p.name_en || "")}</div>
        <div class="public-prod-status-box" id="status-box-${p.id}">
          ${badgeHtml}
        </div>
      </label>
    `;
  }).join("");

  sel.innerHTML = `<option value="">-- เลือกสินค้า --</option>` + 
    PUBLIC_PRODUCTS.map(p => `<option value="${p.id}">${PVT.escapeHtml(p.name_th || p.name)}</option>`).join("");
}

function bindEvents() {
  // Click on product card
  document.getElementById("product-cards-grid").addEventListener("click", (e) => {
    const card = e.target.closest(".public-prod-card");
    if (!card) return;
    const prodId = card.dataset.productId;
    selectProduct(prodId);
  });

  // Submit button
  document.getElementById("public-submit").addEventListener("click", submitPublicSurvey);
}

async function selectProduct(productId, isLocked = false) {
  SELECTED_PRODUCT_ID = productId;
  const cards = document.querySelectorAll(".public-prod-card");
  cards.forEach(c => {
    const pId = c.dataset.productId;
    const isSelected = pId === productId;
    const isCompleted = COMPLETED_PRODUCT_IDS.has(pId);

    c.classList.toggle("active", isSelected);
    const radio = c.querySelector("input");
    if (radio) radio.checked = isSelected;

    const statusBox = document.getElementById(`status-box-${pId}`);
    if (statusBox) {
      if (isCompleted) {
        statusBox.innerHTML = `
          <div class="public-prod-status-badge is-completed">
            <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
            <span>${isSelected ? 'ทำแล้ว (เลือกดู)' : 'ทำแบบสอบถามแล้ว'}</span>
          </div>
        `;
      } else if (isSelected) {
        statusBox.innerHTML = `
          <div class="public-prod-status-badge is-active">
            <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
            <span>กำลังเลือกประเมิน</span>
          </div>
        `;
      } else {
        statusBox.innerHTML = "";
      }
    }

    if (isLocked && !isSelected) {
      c.style.opacity = "0.45";
      c.style.pointerEvents = "none";
    }
  });

  document.getElementById("public-product").value = productId;
  await loadPublicQuestions(productId);
}

async function loadPublicQuestions(productId) {
  const panel = document.getElementById("public-questions-panel");
  if (!productId) {
    panel.classList.add("hidden");
    return;
  }

  const qContainer = document.getElementById("public-question-container");
  qContainer.innerHTML = `<div class="card public-card" style="text-align:center;padding:24px"><div class="small muted">กำลังโหลดชุดคำถาม...</div></div>`;
  panel.classList.remove("hidden");

  try {
    const activeCampId = PUBLIC_CONTEXT?.campaign_id || PVT.params().get("campaign");
    PUBLIC_QUESTIONS = await PVT.loadQuestionSet(productId, "dealer", activeCampId);
    
    // If no questions in DB for this product yet, provide standard dealer questions
    if (!PUBLIC_QUESTIONS || !PUBLIC_QUESTIONS.length) {
      PUBLIC_QUESTIONS = getDefaultQuestions(productId);
    }

    PVT.renderQuestions(qContainer, PUBLIC_QUESTIONS, { isPublic: true });
    updateProgress();

    // Attach real-time progress update
    qContainer.addEventListener("change", updateProgress);

    // Smooth scroll down to questions
    setTimeout(() => {
      panel.scrollIntoView({ behavior: "smooth", block: "start" });
    }, 150);
  } catch (err) {
    console.error("Load questions error:", err);
    PUBLIC_QUESTIONS = getDefaultQuestions(productId);
    PVT.renderQuestions(qContainer, PUBLIC_QUESTIONS, { isPublic: true });
    updateProgress();
    qContainer.addEventListener("change", updateProgress);
  }
}

function updateProgress() {
  if (!PUBLIC_QUESTIONS.length) return;
  const qContainer = document.getElementById("public-question-container");
  let answeredCount = 0;

  PUBLIC_QUESTIONS.forEach(q => {
    const qEl = qContainer.querySelector(`[data-question="${q.id}"]`);
    if (!qEl) return;
    if (q.question_type === "checkbox") {
      if (qEl.querySelectorAll("input[type='checkbox']:checked").length > 0) answeredCount++;
    } else if (q.question_type === "single_choice") {
      if (qEl.querySelector("input[type='radio']:checked")) answeredCount++;
    } else if (q.question_type === "rating_grid") {
      const requiredOptions = q.options || [];
      let filled = 0;
      requiredOptions.forEach(o => {
        if (qEl.querySelector(`input[name="q_${q.id}_${o.id}"]:checked`)) filled++;
      });
      if (filled === requiredOptions.length) answeredCount++;
    } else if (q.question_type === "scale") {
      if (qEl.querySelector("input[type='radio']:checked")) answeredCount++;
    } else if (q.question_type === "text") {
      if (qEl.querySelector(`textarea[name="q_${q.id}"]`)?.value?.trim()) answeredCount++;
    }
  });

  const percent = Math.round((answeredCount / PUBLIC_QUESTIONS.length) * 100);
  document.getElementById("public-progress-bar").style.width = `${percent}%`;
  document.getElementById("progress-percent-text").textContent = `${percent}%`;
  document.getElementById("progress-status-text").textContent = `ตอบแล้ว ${answeredCount} จาก ${PUBLIC_QUESTIONS.length} ข้อ`;
}

async function submitPublicSurvey() {
  const btn = document.getElementById("public-submit");
  const productId = document.getElementById("public-product").value;
  if (!productId) {
    PVT.toast("กรุณาเลือกผลิตภัณฑ์ที่ต้องการประเมินในตอนที่ 2", "warning");
    document.getElementById("section-product-select")?.scrollIntoView({ behavior: "smooth" });
    return;
  }

  // Validate Store Name if in Open Flow
  let storeName = "";
  let province = "";
  let respondentName = "";

  if (PUBLIC_CONTEXT?.valid) {
    storeName = PUBLIC_CONTEXT.customer_name;
    province = PUBLIC_CONTEXT.province;
    respondentName = document.getElementById("public-respondent-name").value.trim();
  } else {
    storeName = document.getElementById("shop-search-input").value.trim();
    province = document.getElementById("shop-province-input").value.trim();
    respondentName = document.getElementById("shop-respondent-name").value.trim();

    if (!storeName) {
      PVT.toast("กรุณาระบุชื่อร้านค้าของท่านในตอนที่ 1", "warning");
      const sInput = document.getElementById("shop-search-input");
      sInput.focus();
      sInput.scrollIntoView({ behavior: "smooth", block: "center" });
      return;
    }

    if (!province) {
      PVT.toast("กรุณาระบุจังหวัดที่ตั้งร้านค้าในตอนที่ 1", "warning");
      const pInput = document.getElementById("shop-province-input");
      pInput.focus();
      pInput.scrollIntoView({ behavior: "smooth", block: "center" });
      return;
    }
  }

  let answers;
  try {
    answers = PVT.collectAnswers(document.getElementById("public-question-container"), PUBLIC_QUESTIONS);
  } catch (err) {
    return PVT.toast(err.message, "error");
  }

  // Append extra feedback if provided
  const extraFeedback = document.getElementById("public-additional-feedback").value.trim();
  if (extraFeedback) {
    answers.push({
      question_id: "feedback-extra",
      answer: { comment: extraFeedback }
    });
  }

  PVT.setBusy(btn, true, "กำลังส่งแบบสอบถาม...");

  let submittedSuccessfully = false;
  const token = PVT.params().get("token");

  try {
    if (typeof PVT.ensureQuestionsExistInDb === "function") {
      await PVT.ensureQuestionsExistInDb(PUBLIC_QUESTIONS || [], productId, "dealer");
    }

    const answerMap = new Map();
    for (const a of (answers || [])) {
      if (a.question_id === "feedback-extra") continue;
      const qUuid = PVT.toValidUuid(a.question_id);
      if (!answerMap.has(qUuid)) {
        answerMap.set(qUuid, {
          question_id: qUuid,
          answer: a.answer
        });
      }
    }
    const cleanPublicAnswers = Array.from(answerMap.values());

    if (token) {
      // Try token RPC submission first
      try {
        const { error } = await PVT.db.rpc("submit_public_survey", {
          p_token: token,
          p_product_id: PVT.toValidUuid(productId),
          p_respondent_name: respondentName || storeName,
          p_answers: cleanPublicAnswers
        });
        if (!error) {
          submittedSuccessfully = true;
        } else {
          console.warn("RPC submit_public_survey notice, switching to direct save:", error.message);
        }
      } catch (rpcErr) {
        console.warn("RPC submit_public_survey exception, switching to direct save:", rpcErr);
      }
    }

    if (!submittedSuccessfully) {
      // Direct open flow / salesperson share link flow / token fallback: find customer and insert response
      let customerId = PUBLIC_CUSTOMER_ID || (PUBLIC_CONTEXT?.customer_id) || "ed61e4e0-1449-5fd7-ab4b-a537751a08f7";
      let salespersonId = PUBLIC_SALESPERSON_ID || (PUBLIC_CONTEXT?.salesperson_id) || "c03a7c5e-ccc8-559d-9223-3379b540f53d";
      
      const matchedCust = ALL_CUSTOMERS.find(c => (storeName && c.client_name === storeName) || c.id === customerId);
      if (matchedCust && PVT.isUuid(matchedCust.id)) {
        customerId = matchedCust.id;
        if (!PUBLIC_SALESPERSON_ID && matchedCust.salesperson_id) {
          salespersonId = matchedCust.salesperson_id;
        }
      }

      const campaignId = (PUBLIC_CONTEXT?.campaign_id) || "c0000000-0000-0000-0000-000000000001";
      const responseId = crypto.randomUUID ? crypto.randomUUID() : (Array.from(crypto.getRandomValues(new Uint8Array(16))).map(b=>b.toString(16).padStart(2,'0')).join(''));

      // Calculate NPS score from answers if available
      let npsScore = null;
      for (const a of answers) {
        if (typeof a.answer?.value === "number") npsScore = a.answer.value;
      }

      const matchedProd = ALL_PRODUCTS.find(p => p.id === productId);
      const prodName = matchedProd?.name_th || "ผลิตภัณฑ์ตราต้นไม้";
      const prodCode = matchedProd?.code || "GENERAL";
      const storeDisplayName = storeName || matchedCust?.client_name || "ร้านค้าตัวแทน";
      const storeProvince = province || matchedCust?.province_normalized || matchedCust?.province_raw || "-";
      const nowIso = new Date().toISOString();
      let insertedToDb = false;

      try {
        await PVT.db.from("survey_responses").insert({
          id: responseId,
          campaign_id: campaignId,
          customer_id: customerId,
          salesperson_id: salespersonId,
          product_id: productId,
          respondent_type: "dealer",
          source: "customer",
          respondent_name: respondentName || storeDisplayName,
          nps_score: npsScore,
          metadata: {
            store_name_raw: storeDisplayName,
            province_raw: storeProvince,
            additional_feedback: extraFeedback,
            salesperson_referred_id: PUBLIC_SALESPERSON_ID || salespersonId,
            submitted_token: token || null
          }
        });

        // Insert answers
        const answerRows = cleanPublicAnswers.map(a => ({
          response_id: responseId,
          question_id: a.question_id,
          answer_json: a.answer
        }));
        if (answerRows.length) {
          const { error: ansErr } = await PVT.db.from("survey_answers").upsert(answerRows, { onConflict: "response_id,question_id" });
          if (ansErr) {
            console.warn("Notice upserting public survey_answers:", ansErr.message || ansErr);
          }
        }
        insertedToDb = true;
        submittedSuccessfully = true;
      } catch (dbErr) {
        console.warn("Direct DB insert note, backing up offline:", dbErr);
        submittedSuccessfully = true;
      }

      // Always save to offline / local storage with complete metadata
      PVT.saveOfflineResponse({
        id: responseId,
        campaign_id: campaignId,
        campaign_name: PUBLIC_CONTEXT?.campaign?.name || "สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026",
        customer_id: customerId,
        client_id: matchedCust?.client_id || "-",
        client_name: storeDisplayName,
        customer_name: storeDisplayName,
        province: storeProvince,
        salesperson_id: salespersonId,
        salesperson_name: PUBLIC_SALESPERSON_NAME || "ฝ่ายขายตราต้นไม้",
        product_id: productId,
        product_name: prodName,
        product_code: prodCode,
        respondent_type: "dealer",
        source: "customer",
        respondent_name: respondentName || storeDisplayName,
        nps_score: npsScore,
        answers: answers,
        submitted_at: nowIso,
        created_at: nowIso,
        synced: insertedToDb
      });
    }

    // Mark product as completed in this session
    if (productId) {
      COMPLETED_PRODUCT_IDS.add(productId);
      try {
        localStorage.setItem("pvt_done_products", JSON.stringify(Array.from(COMPLETED_PRODUCT_IDS)));
      } catch(e){}
    }

    showCompleted();
  } catch (err) {
    console.error("Survey submission error:", err);
    PVT.toast(err.message || "ส่งแบบประเมินไม่สำเร็จ กรุณาลองใหม่อีกครั้ง", "error");
  } finally {
    PVT.setBusy(btn, false);
  }
}

function showCompleted(isAlreadyCompleted = false) {
  const root = document.getElementById("public-root");
  
  // Build url for evaluating another product while keeping store/salesperson context
  const nextParams = new URLSearchParams();
  if (PUBLIC_CUSTOMER_ID) nextParams.set("customer", PUBLIC_CUSTOMER_ID);
  if (PUBLIC_SALESPERSON_ID) nextParams.set("sp", PUBLIC_SALESPERSON_ID);
  if (PUBLIC_SALESPERSON_NAME) nextParams.set("sp_name", PUBLIC_SALESPERSON_NAME);
  const nextUrl = "public-survey.html" + (nextParams.toString() ? "?" + nextParams.toString() : "");

  root.innerHTML = `
    <div class="card public-thankyou-card">
      <div class="public-thankyou-icon" style="color:var(--brand);display:flex;justify-content:center;margin-bottom:12px">
        <svg class="pvt-icon" width="56" height="56" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></svg>
      </div>
      <h1 class="public-thankyou-title">${isAlreadyCompleted ? "แบบสอบถามนี้ได้รับการบันทึกแล้ว" : "ขอขอบพระคุณเป็นอย่างยิ่งสำหรับการให้ข้อมูล"}</h1>
      <p class="public-thankyou-text">
        ความคิดเห็นและข้อเสนอแนะของท่านร้านค้ามีคุณค่าอย่างยิ่งสำหรับทีมงาน “ตราต้นไม้”<br>
        เราจะนำข้อมูลนี้ไปพัฒนาคุณภาพผลิตภัณฑ์และยกระดับการให้บริการเพื่อสนับสนุนธุรกิจของท่านให้เติบโตอย่างยั่งยืน
      </p>
      
      <div style="display:flex;gap:12px;justify-content:center;flex-wrap:wrap">
        <a href="${nextUrl}" class="btn btn-primary" style="padding:12px 20px;border-radius:12px;font-size:14px;text-decoration:none;display:inline-flex;align-items:center;gap:6px">
          <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
          <span>ทำแบบสอบถามสำหรับสินค้าอื่นเพิ่มเติม</span>
        </a>
        <a href="index.html" class="btn btn-outline" style="padding:12px 20px;border-radius:12px;font-size:14px;text-decoration:none;display:inline-flex;align-items:center;gap:6px">
          <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
          <span>กลับสู่หน้าหลัก</span>
        </a>
      </div>
    </div>
  `;
  window.scrollTo({ top: 0, behavior: "smooth" });
}

function getDefaultQuestions(productId) {
  return [
    {
      id: "q0000001-0000-0000-0000-000000000001",
      question_no: 1,
      prompt: "เหตุผลหลักที่ร้านค้าของท่านตัดสินใจเลือกจำหน่ายผลิตภัณฑ์ตราต้นไม้ (เลือกได้ไม่เกิน 2 ข้อ)",
      question_type: "checkbox",
      max_selections: 2,
      required: true,
      options: [
        { id: "opt-1-1", option_text: "สินค้าคุณภาพดี ทนทาน ลูกค้ากลับมาซื้อซ้ำ", is_other: false },
        { id: "opt-1-2", option_text: "ราคาและผลกำไร (Margin) เหมาะสม คุ้มค่า", is_other: false },
        { id: "opt-1-3", option_text: "แบรนด์น่าเชื่อถือ เกษตรกรในพื้นที่ยอมรับ", is_other: false },
        { id: "opt-1-4", option_text: "ทีมงานจัดส่งรวดเร็ว สินค้าไม่ขาดสต็อก", is_other: false },
        { id: "opt-1-5", option_text: "อื่นๆ โปรดระบุ", is_other: true }
      ]
    },
    {
      id: "q0000002-0000-0000-0000-000000000002",
      question_no: 2,
      prompt: "ความพึงพอใจในด้านต่างๆ ของผลิตภัณฑ์ตราต้นไม้ (1 = น้อยที่สุด, 5 = มากที่สุด)",
      question_type: "rating_grid",
      required: true,
      options: [
        { id: "grid-1", option_text: "ความทนทานและคุณภาพเนื้อพลาสติก" },
        { id: "grid-2", option_text: "ความสม่ำเสมอของมาตรฐานสินค้าในทุกรอบจัดส่ง" },
        { id: "grid-3", option_text: "ความคุ้มค่าของราคาเมื่อเทียบกับคุณภาพ" },
        { id: "grid-4", option_text: "ความสะดวกและตรงเวลาในการจัดส่งสินค้า" },
        { id: "grid-5", option_text: "การดูแลและให้คำแนะนำของเจ้าหน้าที่ฝ่ายขาย" }
      ]
    },
    {
      id: "q0000003-0000-0000-0000-000000000003",
      question_no: 3,
      prompt: "ท่านคิดว่าสิ่งที่เกษตรกรหรือผู้ใช้งานชื่นชอบในผลิตภัณฑ์นี้มากที่สุดคือข้อใด?",
      question_type: "single_choice",
      required: true,
      options: [
        { id: "opt-3-1", option_text: "ความเหนียว ทนแดด ทนฝน ใช้งานได้ยาวนาน", is_other: false },
        { id: "opt-3-2", option_text: "ขนาดและความหนาเต็มสเปก ไม่ลดคุณภาพ", is_other: false },
        { id: "opt-3-3", option_text: "ใช้งานง่าย ติดตั้งสะดวก ตอบโจทย์แปลงเกษตร", is_other: false },
        { id: "opt-3-4", option_text: "มั่นใจในชื่อเสียงและความซื่อสัตย์ของแบรนด์", is_other: false }
      ]
    },
    {
      id: "q0000004-0000-0000-0000-000000000004",
      question_no: 4,
      prompt: "โอกาสที่ท่านจะแนะนำผลิตภัณฑ์ตราต้นไม้ ให้กับร้านค้าพันธมิตรหรือเกษตรกรรายอื่น (1 = น้อยที่สุด, 5 = มากที่สุด)",
      question_type: "scale",
      scale_min: 1,
      scale_max: 5,
      scale_min_label: "ไม่แนะนำแน่นอน",
      scale_mid_label: "ปานกลาง",
      scale_max_label: "แนะนำอย่างแน่นอน",
      required: true,
      options: []
    }
  ];
}
