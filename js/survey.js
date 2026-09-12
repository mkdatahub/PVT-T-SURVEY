let SURVEY_CTX = null, CUSTOMER = null, MY_CUSTOMERS = [], FILTERED_CUSTOMERS = [], PRODUCTS_ALL = [], QUESTIONS = [], ACTIVE_CAMPAIGN = null, ALL_CAMPAIGNS = [], COMPLETED_CUSTOMER_IDS = new Set(), COMPLETED_PRODUCT_IDS = new Set();

const PVT_THAILAND_PROVINCES = [
  "กรุงเทพมหานคร", "กระบี่", "กาญจนบุรี", "กาฬสินธุ์", "กำแพงเพชร",
  "ขอนแก่น", "จันทบุรี", "ฉะเชิงเทรา", "ชลบุรี", "ชัยนาท",
  "ชัยภูมิ", "ชุมพร", "เชียงราย", "เชียงใหม่", "ตรัง",
  "ตราด", "ตาก", "นครนายก", "นครปฐม", "นครพนม",
  "นครราชสีมา", "นครศรีธรรมราช", "นครสวรรค์", "นนทบุรี", "นราธิวาส",
  "น่าน", "บึงกาฬ", "บุรีรัมย์", "ปทุมธานี", "ประจวบคีรีขันธ์",
  "ปราจีนบุรี", "ปัตตานี", "พระนครศรีอยุธยา", "พะเยา", "พังงา",
  "พัทลุง", "พิจิตร", "พิษณุโลก", "เพชรบุรี", "เพชรบูรณ์",
  "แพร่", "ภูเก็ต", "มหาสารคาม", "มุกดาหาร", "แม่ฮ่องสอน",
  "ยโสธร", "ยะลา", "ร้อยเอ็ด", "ระนอง", "ระยอง",
  "ราชบุรี", "ลพบุรี", "ลำปาง", "ลำพูน", "เลย",
  "ศรีสะเกษ", "สกลนคร", "สงขลา", "สตูล", "สมุทรปราการ",
  "สมุทรสงคราม", "สมุทรสาคร", "สระแก้ว", "สระบุรี", "สิงห์บุรี",
  "สุโขทัย", "สุพรรณบุรี", "สุราษฎร์ธานี", "สุรินทร์", "หนองคาย",
  "หนองบัวลำภู", "อ่างทอง", "อำนาจเจริญ", "อุดรธานี", "อุตรดิตถ์",
  "อุทัยธานี", "อุบลราชธานี"
].sort((a, b) => a.localeCompare(b, "th"));

function getSelectedFarmerProvince() {
  const provSelect = document.getElementById("farmer-province");
  if (!provSelect) return "";
  const val = provSelect.value;
  if (val === "__OTHER__") {
    const otherInput = document.getElementById("farmer-province-other");
    return otherInput ? otherInput.value.trim() : "";
  }
  return val.trim();
}

document.addEventListener("DOMContentLoaded", async () => {
  PVT.requireConfigured();
  SURVEY_CTX = await PVT.requireAuth(["sales", "admin", "management"]);
  if (!SURVEY_CTX) return;

  try {
    // 1. Load active campaign and all available campaigns
    let campaigns = [];
    try {
      const { data, error: cpErr } = await PVT.db.from("survey_campaigns").select("*").order("start_date", { ascending: false });
      if (!cpErr && data && data.length) campaigns = data;
    } catch (e) {
      console.warn("Campaigns DB query notice:", e);
    }

    // Merge in-memory window.A_CAMPAIGNS
    if (window.A_CAMPAIGNS && Array.isArray(window.A_CAMPAIGNS)) {
      window.A_CAMPAIGNS.forEach(ac => {
        if (!campaigns.find(c => c.id === ac.id)) campaigns.push(ac);
      });
    }

    // Merge local storage campaigns
    try {
      const rawLocal = localStorage.getItem("pvt_local_campaigns");
      if (rawLocal) {
        const parsed = JSON.parse(rawLocal);
        if (Array.isArray(parsed)) {
          parsed.forEach(lc => {
            if (!campaigns.find(c => c.id === lc.id)) campaigns.push(lc);
          });
        }
      }
    } catch(e) {}

    if (!campaigns.length) {
      campaigns = [{
        id: "c0000000-0000-0000-0000-000000000001",
        name: "สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026",
        is_active: true
      }];
    }
    ALL_CAMPAIGNS = campaigns;

    // Determine default selected campaign:
    // a) From query param ?campaign=...
    // b) Or latest campaign edited in campaign-questions-manager
    // c) Or active campaign
    // d) Or first campaign
    const paramCampId = PVT.params().get("campaign");
    const latestCustomCampId = (PVT.getLatestCustomCampaignId ? PVT.getLatestCustomCampaignId() : null) || localStorage.getItem("pvt_latest_campaign_id");
    
    let targetCamp = null;
    if (paramCampId) targetCamp = ALL_CAMPAIGNS.find(c => c.id === paramCampId);
    if (!targetCamp && latestCustomCampId) targetCamp = ALL_CAMPAIGNS.find(c => c.id === latestCustomCampId);
    if (!targetCamp) targetCamp = ALL_CAMPAIGNS.find(c => c.is_active);
    if (!targetCamp) targetCamp = ALL_CAMPAIGNS[0];

    ACTIVE_CAMPAIGN = targetCamp;

    // Fetch completed customers for active campaign
    await fetchCompletedCustomers();

    // 2. Load Customers for this salesperson
    const seedList = await PVT.getSeedCustomers();
    let dbList = [];
    try {
      const { data: cData, error: cErr } = await PVT.db.from("customers").select("*");
      if (!cErr && cData && cData.length) dbList = cData;
    } catch (e) {
      console.warn("DB customer query notice:", e);
    }

    // Merge seed & DB customers deduplicated safely
    const allCustomers = PVT.dedupeCustomers([...seedList, ...dbList]);

    // Filter by salesperson if logged in as sales
    const mySalesId = SURVEY_CTX?.profile?.salesperson_id;
    if (SURVEY_CTX?.profile?.role === "sales" && mySalesId) {
      MY_CUSTOMERS = allCustomers.filter(c => c.salesperson_id === mySalesId || c.sale_id === mySalesId);
      if (!MY_CUSTOMERS.length) {
        MY_CUSTOMERS = allCustomers;
      }
    } else {
      MY_CUSTOMERS = allCustomers;
    }

    // Sort alphabetically by store name
    MY_CUSTOMERS.sort((a, b) => (a.client_name || "").localeCompare(b.client_name || "", "th"));

    window.MY_CUSTOMERS = MY_CUSTOMERS;

    // 3. Resolve current selected customer & respondent type (from URL or session)
    let rawCustomerId = PVT.params().get("customer");
    let rawType = PVT.params().get("type");
    let rawProvince = PVT.params().get("province");

    if (!rawCustomerId) {
      try {
        const savedCust = sessionStorage.getItem("pvt_active_customer");
        if (savedCust) {
          const parsed = JSON.parse(savedCust);
          if (parsed && parsed.id) rawCustomerId = parsed.id;
        }
      } catch (e) {}
    }

    if (!rawType) {
      try {
        rawType = sessionStorage.getItem("pvt_active_type");
      } catch (e) {}
    }

    if (rawCustomerId) {
      let resolved = MY_CUSTOMERS.find(c => c.id === rawCustomerId || c.client_id === rawCustomerId);
      if (!resolved) {
        resolved = await PVT.resolveCustomer(rawCustomerId);
      }
      if (resolved) {
        CUSTOMER = resolved;
        window.CUSTOMER = resolved;
        if (!MY_CUSTOMERS.find(c => c.id === resolved.id)) {
          MY_CUSTOMERS.unshift(resolved);
        }
        try {
          sessionStorage.setItem("pvt_active_customer", JSON.stringify(CUSTOMER));
        } catch (e) {}
      }
    }

    // Determine and set initial Respondent Type
    const typeSelect = document.getElementById("respondent-type");
    if (rawType === "farmer" || rawType === "dealer") {
      if (typeSelect) typeSelect.value = rawType;
    } else if (CUSTOMER) {
      if (CUSTOMER.client_id && CUSTOMER.client_id.startsWith("FARMER-")) {
        if (typeSelect) typeSelect.value = "farmer";
      } else {
        if (typeSelect) typeSelect.value = "dealer";
      }
    }

    // 4. Load Products
    PRODUCTS_ALL = await PVT.loadProducts();

    renderCampaignSelect();
    renderProvinceFilter();

    if (rawProvince) {
      const farmerProvSelect = document.getElementById("farmer-province");
      const otherWrap = document.getElementById("farmer-province-other-wrap");
      const otherInput = document.getElementById("farmer-province-other");
      if (farmerProvSelect) {
        const hasOption = Array.from(farmerProvSelect.options).some(o => o.value === rawProvince);
        if (hasOption) {
          farmerProvSelect.value = rawProvince;
          if (otherWrap) otherWrap.classList.add("hidden");
        } else {
          farmerProvSelect.value = "__OTHER__";
          if (otherWrap) otherWrap.classList.remove("hidden");
          if (otherInput) otherInput.value = rawProvince;
        }
      }
    }

    applyCustomerFilters(false);
    handleRespondentTypeChange();
    renderHeader();
    await fetchCompletedProductsForSelectedCustomer();
    bindEvents();
    syncMetadataHighlights();

    // If customer was loaded from URL, smoothly focus product selector
    if (CUSTOMER && document.getElementById("product-select")) {
      setTimeout(() => {
        const prodEl = document.getElementById("product-select");
        if (prodEl) {
          prodEl.scrollIntoView({ behavior: "smooth", block: "center" });
        }
      }, 200);
    }

  } catch (err) {
    document.getElementById("survey-area").innerHTML = `<div class="notice error">${PVT.escapeHtml(err.message)}</div>`;
  }
});

function renderHeader() {
  const nameEl = document.getElementById("customer-name");
  const metaEl = document.getElementById("customer-meta");
  const type = document.getElementById("respondent-type")?.value || "";

  if (type === "farmer") {
    const prov = getSelectedFarmerProvince();
    if (nameEl) nameEl.textContent = "กลุ่มผู้ตอบแบบสอบถาม: เกษตรกร / ผู้ใช้จริง";
    if (metaEl) metaEl.textContent = prov ? `พื้นที่เป้าหมาย: จังหวัด ${prov}` : "โปรดระบุจังหวัดของเกษตรกรด้านล่างเพื่อเริ่มทำแบบสอบถาม";
  } else {
    if (!CUSTOMER) {
      if (nameEl) nameEl.textContent = "กรุณาเลือกร้านค้า";
      if (metaEl) metaEl.textContent = "โปรดเลือกร้านค้าด้านล่างเพื่อเริ่มทำแบบสอบถาม";
    } else {
      if (nameEl) nameEl.textContent = CUSTOMER.client_name || "ไม่ได้ระบุชื่อร้าน";
      const province = CUSTOMER.province_normalized || CUSTOMER.province_raw || "";
      const code = CUSTOMER.client_id ? `รหัส: ${CUSTOMER.client_id}` : "";
      if (metaEl) metaEl.textContent = [code, province].filter(Boolean).join(" • ") || "ร้านค้าของทีมขาย";
    }
  }

  const surveyorBadge = document.getElementById("surveyor-info-badge");
  if (surveyorBadge && SURVEY_CTX && SURVEY_CTX.profile) {
    const prof = SURVEY_CTX.profile;
    const name = prof.display_name || "ไม่ระบุชื่อ";
    const roleMap = {
      sales: "ทีมขาย / ฝ่ายปฏิบัติการภาคสนาม",
      admin: "ผู้ดูแลระบบ",
      management: "ผู้บริหาร"
    };
    const roleText = roleMap[prof.role] || prof.role || "เจ้าหน้าที่";
    
    surveyorBadge.style.display = "flex";
    surveyorBadge.innerHTML = `
      <div style="display:inline-flex; align-items:center; justify-content:center; width:24px; height:24px; border-radius:50%; background:#e0f2fe; color:#0369a1; font-weight:bold; flex-shrink:0;">👤</div>
      <div style="display:flex; flex-direction:column; gap:1px;">
        <span style="font-size:10px; text-transform:uppercase; letter-spacing:0.05em; color:#64748b; font-weight:600;">ผู้ทำแบบสอบถามปัจจุบัน</span>
        <span style="font-weight:600; color:#1e293b;">คุณ${PVT.escapeHtml(name)} <span style="font-weight:normal; color:#64748b; margin-left:4px;">(${PVT.escapeHtml(roleText)})</span></span>
      </div>
    `;
  }
}

function renderCampaignSelect() {
  const campSelect = document.getElementById("campaign-select");
  const badgeEl = document.getElementById("campaign-badge");
  if (!campSelect) return;

  if (!ALL_CAMPAIGNS || ALL_CAMPAIGNS.length === 0) {
    campSelect.innerHTML = `<option value="">-- ไม่พบรอบสำรวจ --</option>`;
    return;
  }

  campSelect.innerHTML = ALL_CAMPAIGNS.map(c => {
    const isSelected = ACTIVE_CAMPAIGN && c.id === ACTIVE_CAMPAIGN.id ? "selected" : "";
    const isCustom = PVT.hasCampaignCustomQuestions ? PVT.hasCampaignCustomQuestions(c.id) : false;
    const customTag = isCustom ? " ✦ (ชุดคำถามปรับแต่ง)" : "";
    return `<option value="${c.id}" ${isSelected}>${PVT.escapeHtml(c.name)}${customTag}</option>`;
  }).join("");

  if (badgeEl && ACTIVE_CAMPAIGN) {
    const hasCustom = PVT.hasCampaignCustomQuestions ? PVT.hasCampaignCustomQuestions(ACTIVE_CAMPAIGN.id) : false;
    badgeEl.innerHTML = hasCustom 
      ? `<span class="pill success" style="font-size:11px">✦ ใช้ชุดคำถามปรับแต่งเฉพาะ Campaign</span>`
      : `<span class="pill muted" style="font-size:11px">ชุดคำถามมาตรฐาน</span>`;
  }
}

function renderProvinceFilter() {
  const provSelect = document.getElementById("province-filter");
  const farmerProvSelect = document.getElementById("farmer-province");
  if (!provSelect) return;

  // Count stores per province
  const provMap = new Map();
  MY_CUSTOMERS.forEach(c => {
    const prov = c.province_normalized || c.province_raw || "ไม่ระบุจังหวัด";
    provMap.set(prov, (provMap.get(prov) || 0) + 1);
  });

  const sortedProvs = Array.from(provMap.keys()).sort((a, b) => a.localeCompare(b, "th"));

  let optionsHtml = `<option value="">-- กรุณาเลือกจังหวัด --</option>`;
  sortedProvs.forEach(prov => {
    const count = provMap.get(prov);
    optionsHtml += `<option value="${PVT.escapeHtml(prov)}">${PVT.escapeHtml(prov)} (${count.toLocaleString()} ร้าน)</option>`;
  });
  provSelect.innerHTML = optionsHtml;

  if (farmerProvSelect) {
    const currentVal = farmerProvSelect.value;
    let farmerOptionsHtml = `<option value="">-- กรุณาเลือกจังหวัดของเกษตรกร --</option>`;
    
    // 1. Group by salesperson assigned store provinces (if any)
    if (sortedProvs.length > 0) {
      farmerOptionsHtml += `<optgroup label="📍 จังหวัดในเขตดูแลของคุณ">`;
      sortedProvs.forEach(prov => {
        farmerOptionsHtml += `<option value="${PVT.escapeHtml(prov)}">${PVT.escapeHtml(prov)}</option>`;
      });
      farmerOptionsHtml += `</optgroup>`;
    }

    // 2. All 77 provinces across Thailand
    farmerOptionsHtml += `<optgroup label="🌐 ทุกจังหวัดในประเทศไทย (77 จังหวัด)">`;
    PVT_THAILAND_PROVINCES.forEach(prov => {
      farmerOptionsHtml += `<option value="${PVT.escapeHtml(prov)}">${PVT.escapeHtml(prov)}</option>`;
    });
    farmerOptionsHtml += `</optgroup>`;

    // 3. Custom / Other province entry
    farmerOptionsHtml += `<option value="__OTHER__">✏️ อื่นๆ (พิมพ์ระบุจังหวัดเอง)</option>`;
    
    farmerProvSelect.innerHTML = farmerOptionsHtml;
    if (currentVal) {
      farmerProvSelect.value = currentVal;
    }
  }

  // If CUSTOMER has a specific province, pre-select
  if (CUSTOMER) {
    const custProv = CUSTOMER.province_normalized || CUSTOMER.province_raw || "";
    if (custProv && provMap.has(custProv)) {
      provSelect.value = custProv;
    }
  }
}

function applyCustomerFilters(autoSelectFirst = true) {
  const provSelect = document.getElementById("province-filter");
  const searchInput = document.getElementById("customer-search");
  const selectedProv = provSelect ? provSelect.value : "";
  const searchTerm = searchInput ? searchInput.value.trim().toLowerCase() : "";

  FILTERED_CUSTOMERS = MY_CUSTOMERS.filter(c => {
    const p = c.province_normalized || c.province_raw || "ไม่ระบุจังหวัด";
    if (selectedProv && p !== selectedProv) return false;
    if (searchTerm) {
      const name = (c.client_name || "").toLowerCase();
      const code = (c.client_id || "").toLowerCase();
      const prov = (c.province_normalized || c.province_raw || "").toLowerCase();
      if (!name.includes(searchTerm) && !code.includes(searchTerm) && !prov.includes(searchTerm)) {
        return false;
      }
    }
    return true;
  });

  // CRITICAL: If a CUSTOMER is selected (e.g. from URL), make sure it is in FILTERED_CUSTOMERS
  if (CUSTOMER && !FILTERED_CUSTOMERS.some(c => c.id === CUSTOMER.id)) {
    FILTERED_CUSTOMERS.unshift(CUSTOMER);
  }

  renderCustomerSelect(autoSelectFirst);
}

function renderCustomerSelect(autoSelectFirst) {
  const custSelect = document.getElementById("customer-select");
  const badgeEl = document.getElementById("customer-count-badge");
  if (!custSelect) return;

  if (badgeEl) {
    badgeEl.textContent = `พบ ${FILTERED_CUSTOMERS.length.toLocaleString()} จาก ${MY_CUSTOMERS.length.toLocaleString()} ร้าน`;
  }

  if (FILTERED_CUSTOMERS.length === 0) {
    custSelect.innerHTML = `<option value="">-- ไม่พบร้านค้าที่ตรงกับเงื่อนไข --</option>`;
    return;
  }

  // Check if current CUSTOMER is in FILTERED_CUSTOMERS
  let isCurrentInList = CUSTOMER && FILTERED_CUSTOMERS.some(c => c.id === CUSTOMER.id);

  if (!isCurrentInList && autoSelectFirst && FILTERED_CUSTOMERS.length > 0) {
    CUSTOMER = FILTERED_CUSTOMERS[0];
    renderHeader();
    history.replaceState(null, "", `survey.html?customer=${encodeURIComponent(CUSTOMER.id)}&type=dealer`);
  }

  const isPlaceholderSelected = !CUSTOMER ? "selected" : "";
  let optionsHtml = `<option value="" ${isPlaceholderSelected}>-- ร้านที่ต้องการทำแบบสอบถาม --</option>`;

  optionsHtml += FILTERED_CUSTOMERS.map(c => {
    const prov = c.province_normalized || c.province_raw || "";
    const code = c.client_id ? `[${c.client_id}] ` : "";
    const isDone = COMPLETED_CUSTOMER_IDS.has(c.id);
    const prefix = isDone ? "✅ " : "";
    const suffix = isDone ? " (ทำแล้ว)" : "";
    const label = `${prefix}${code}${c.client_name}${prov ? ` - ${prov}` : ""}${suffix}`;
    const isSelected = CUSTOMER && c.id === CUSTOMER.id ? "selected" : "";
    return `<option value="${c.id}" ${isSelected}>${PVT.escapeHtml(label)}</option>`;
  }).join("");

  custSelect.innerHTML = optionsHtml;
  if (CUSTOMER) {
    custSelect.value = CUSTOMER.id;
  }
}

function renderProducts() {
  const prodSelect = document.getElementById("product-select");
  if (prodSelect) {
    const currentVal = prodSelect.value;
    const type = document.getElementById("respondent-type")?.value || "";

    // Filter products based on selected respondent type
    const filteredProducts = PRODUCTS_ALL.filter(p => {
      if (type === "dealer") return p.dealer_enabled;
      if (type === "farmer") return p.farmer_enabled;
      return true; // Show all if no type is selected yet
    });

    let optionsHtml = `<option value="">-- เลือกสินค้าที่ต้องการสำรวจ --</option>`;
    optionsHtml += filteredProducts.map(p => {
      const isDone = COMPLETED_PRODUCT_IDS.has(p.id);
      const prefix = isDone ? "✅ " : "";
      const suffix = isDone ? " (ทำแล้ว)" : "";
      const label = `${prefix}${p.name_th}${suffix}`;
      const isSelected = currentVal === p.id ? "selected" : "";
      return `<option value="${p.id}" ${isSelected}>${PVT.escapeHtml(label)}</option>`;
    }).join("");
    prodSelect.innerHTML = optionsHtml;
  }
}

function syncMetadataHighlights() {
  const ids = [
    "province-filter",
    "customer-search",
    "campaign-select",
    "customer-select",
    "product-select",
    "respondent-type",
    "respondent-name",
    "farmer-province",
    "farmer-province-other"
  ];
  ids.forEach(id => {
    const el = document.getElementById(id);
    if (!el) return;
    const val = el.value ? el.value.trim() : "";
    if (val !== "") {
      el.classList.add("metadata-filled");
    } else {
      el.classList.remove("metadata-filled");
    }
  });
}

function handleRespondentTypeChange() {
  const type = document.getElementById("respondent-type").value;
  const dealerContainer = document.getElementById("dealer-fields-container");
  const farmerContainer = document.getElementById("farmer-fields-container");
  const farmerOtherWrap = document.getElementById("farmer-province-other-wrap");

  if (type === "dealer") {
    if (dealerContainer) dealerContainer.classList.remove("hidden");
    if (farmerContainer) farmerContainer.classList.add("hidden");
    const custSelect = document.getElementById("customer-select");
    if (!CUSTOMER && custSelect && custSelect.value) {
      CUSTOMER = MY_CUSTOMERS.find(c => c.id === custSelect.value) || null;
    }
  } else if (type === "farmer") {
    if (dealerContainer) dealerContainer.classList.add("hidden");
    if (farmerContainer) farmerContainer.classList.remove("hidden");
    const farmerProvSelect = document.getElementById("farmer-province");
    if (farmerOtherWrap && farmerProvSelect) {
      farmerOtherWrap.classList.toggle("hidden", farmerProvSelect.value !== "__OTHER__");
    }
    if (CUSTOMER && !CUSTOMER.client_id?.startsWith("FARMER-")) {
      CUSTOMER = null;
    }
  } else {
    if (dealerContainer) dealerContainer.classList.add("hidden");
    if (farmerContainer) farmerContainer.classList.add("hidden");
    CUSTOMER = null;
  }
  renderHeader();
  renderProducts();
}

function bindEvents() {
  const ids = [
    "province-filter",
    "customer-search",
    "campaign-select",
    "customer-select",
    "product-select",
    "respondent-type",
    "respondent-name",
    "farmer-province",
    "farmer-province-other"
  ];
  ids.forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener("change", syncMetadataHighlights);
      el.addEventListener("input", syncMetadataHighlights);
    }
  });

  const provSelect = document.getElementById("province-filter");
  if (provSelect) {
    provSelect.addEventListener("change", () => {
      applyCustomerFilters(true);
    });
  }

  const searchInput = document.getElementById("customer-search");
  if (searchInput) {
    let debounceTimer;
    searchInput.addEventListener("input", () => {
      clearTimeout(debounceTimer);
      debounceTimer = setTimeout(() => {
        applyCustomerFilters(true);
      }, 150);
    });
  }

  const custSelect = document.getElementById("customer-select");
  if (custSelect) {
    custSelect.addEventListener("change", async (e) => {
      const selectedId = e.target.value;
      const found = MY_CUSTOMERS.find(c => c.id === selectedId);
      if (found) {
        CUSTOMER = found;
        renderHeader();
        history.replaceState(null, "", `survey.html?customer=${encodeURIComponent(CUSTOMER.id)}`);
      } else {
        CUSTOMER = null;
        renderHeader();
        history.replaceState(null, "", "survey.html");
      }
      await fetchCompletedProductsForSelectedCustomer();
    });
  }

  const campSelect = document.getElementById("campaign-select");
  if (campSelect) {
    campSelect.addEventListener("change", async (e) => {
      const selectedCampId = e.target.value;
      const foundCamp = ALL_CAMPAIGNS.find(c => c.id === selectedCampId);
      if (foundCamp) {
        ACTIVE_CAMPAIGN = foundCamp;
        await fetchCompletedCustomers();
        await fetchCompletedProductsForSelectedCustomer();
        applyCustomerFilters(false);
        const badgeEl = document.getElementById("campaign-badge");
        if (badgeEl) {
          const hasCustom = PVT.hasCampaignCustomQuestions ? PVT.hasCampaignCustomQuestions(ACTIVE_CAMPAIGN.id) : false;
          badgeEl.innerHTML = hasCustom 
            ? `<span class="pill success" style="font-size:11px">✦ ใช้ชุดคำถามปรับแต่งเฉพาะ Campaign</span>`
            : `<span class="pill muted" style="font-size:11px">ชุดคำถามมาตรฐาน</span>`;
        }
        refreshQuestionSet();
      }
    });
  }

  document.getElementById("product-select").addEventListener("change", refreshQuestionSet);
  
  const typeSelect = document.getElementById("respondent-type");
  if (typeSelect) {
    typeSelect.addEventListener("change", async () => {
      handleRespondentTypeChange();
      await fetchCompletedProductsForSelectedCustomer();
      refreshQuestionSet();
    });
  }

  const farmerProvSelect = document.getElementById("farmer-province");
  const farmerProvOtherWrap = document.getElementById("farmer-province-other-wrap");
  const farmerProvOtherInput = document.getElementById("farmer-province-other");

  if (farmerProvSelect) {
    farmerProvSelect.addEventListener("change", async () => {
      const isOther = farmerProvSelect.value === "__OTHER__";
      if (farmerProvOtherWrap) {
        farmerProvOtherWrap.classList.toggle("hidden", !isOther);
      }
      if (isOther && farmerProvOtherInput) {
        farmerProvOtherInput.focus();
      }
      renderHeader();
      await fetchCompletedProductsForSelectedCustomer();
      syncMetadataHighlights();
    });
  }

  if (farmerProvOtherInput) {
    let provDebounce;
    farmerProvOtherInput.addEventListener("input", () => {
      clearTimeout(provDebounce);
      provDebounce = setTimeout(async () => {
        renderHeader();
        await fetchCompletedProductsForSelectedCustomer();
        syncMetadataHighlights();
      }, 200);
    });
  }

  document.getElementById("question-container").addEventListener("change", updateProgress);
  document.getElementById("submit-survey").addEventListener("click", submitSurvey);
}

async function refreshQuestionSet() {
  const productId = document.getElementById("product-select").value;
  const type = document.getElementById("respondent-type").value;
  const product = PRODUCTS_ALL.find(p => p.id === productId);

  if (product) {
    const farmerOpt = document.querySelector('#respondent-type option[value="farmer"]');
    if (farmerOpt) farmerOpt.disabled = !product.farmer_enabled;
    if (type === "farmer" && !product.farmer_enabled) {
      document.getElementById("respondent-type").value = "dealer";
      return refreshQuestionSet();
    }
    const painEl = document.getElementById("pain-point");
    if (painEl) {
      painEl.textContent = product.pain_point ? `จุดเด่น/จุดเน้นของสินค้า: ${product.pain_point}` : "";
      painEl.style.display = product.pain_point ? "block" : "none";
    }
  } else {
    const painEl = document.getElementById("pain-point");
    if (painEl) painEl.style.display = "none";
  }

  if (!productId) {
    QUESTIONS = [];
    document.getElementById("question-container").innerHTML = "";
    document.getElementById("questions-panel").classList.add("hidden");
    return;
  }

  try {
    QUESTIONS = await PVT.loadQuestionSet(productId, document.getElementById("respondent-type").value, ACTIVE_CAMPAIGN?.id);
    PVT.renderQuestions(document.getElementById("question-container"), QUESTIONS);
    document.getElementById("questions-panel").classList.toggle("hidden", !QUESTIONS.length);
    updateProgress();
    syncMetadataHighlights();
  } catch (err) {
    PVT.toast(err.message, "error");
  }
}

function answered(q) {
  const root = document.querySelector(`[data-question="${q.id}"]`);
  if (!root) return false;
  if (q.question_type === "rating_grid") {
    const opts = q.options || [];
    return opts.length > 0 && opts.every(o => root.querySelector(`input[name="q_${q.id}_${o.id || o.option_text}"]:checked`));
  }
  if (q.question_type === "text") {
    return !!root.querySelector(`textarea[name="q_${q.id}"]`)?.value?.trim();
  }
  return !!root.querySelector(`input[name="q_${q.id}"]:checked`);
}

function updateProgress() {
  const done = QUESTIONS.filter(answered).length;
  const pct = QUESTIONS.length ? Math.round(done / QUESTIONS.length * 100) : 0;
  document.getElementById("progress-bar").style.width = pct + "%";
  document.getElementById("progress-text").textContent = `ตอบแล้ว ${done}/${QUESTIONS.length} ข้อ`;
}

async function submitSurvey() {
  const btn = document.getElementById("submit-survey");
  const productId = document.getElementById("product-select").value;
  const respondentType = document.getElementById("respondent-type").value;
  const campaignId = ACTIVE_CAMPAIGN?.id || "c0000000-0000-0000-0000-000000000001";

  if (!respondentType) return PVT.toast("กรุณาเลือกกลุ่มเป้าหมายผู้ตอบแบบสอบถาม", "error");
  if (!productId) return PVT.toast("กรุณาเลือกสินค้า", "error");

  if (respondentType === "farmer") {
    const province = getSelectedFarmerProvince();
    if (!province) {
      const provSelect = document.getElementById("farmer-province");
      if (provSelect && provSelect.value === "__OTHER__") {
        document.getElementById("farmer-province-other")?.focus();
        return PVT.toast("กรุณาระบุชื่อจังหวัดของเกษตรกรในช่อง 'ระบุชื่อจังหวัด (อื่นๆ)'", "error");
      }
      return PVT.toast("กรุณาเลือกหรือระบุจังหวัดของเกษตรกร", "error");
    }

    const mySalesId = SURVEY_CTX?.profile?.salesperson_id || "c03a7c5e-ccc8-559d-9223-3379b540f53d";
    let farmerCust = MY_CUSTOMERS.find(c => c.client_name === `เกษตรกรทั่วไป (${province})`);
    if (!farmerCust) {
      const farmerId = crypto.randomUUID ? crypto.randomUUID() : (Array.from(crypto.getRandomValues(new Uint8Array(16))).map(b=>b.toString(16).padStart(2,'0')).join(''));
      farmerCust = {
        id: farmerId,
        client_id: "FARMER-" + province,
        client_name: `เกษตรกรทั่วไป (${province})`,
        province_raw: province,
        province_normalized: province,
        salesperson_id: mySalesId,
        is_active: true
      };
      MY_CUSTOMERS.push(farmerCust);
    }
    CUSTOMER = farmerCust;
  } else {
    if (!CUSTOMER) return PVT.toast("กรุณาเลือกร้านค้า", "error");
  }

  if (!QUESTIONS.length) return PVT.toast("ไม่พบชุดคำถาม", "error");

  let answers;
  try {
    answers = PVT.collectAnswers(document.getElementById("question-container"), QUESTIONS);
  } catch (err) {
    return PVT.toast(err.message, "error");
  }

  PVT.setBusy(btn, true, "กำลังบันทึก...");
  try {
    let responseId = null;
    let submittedToDb = false;

    // 1. Calculate NPS score
    let npsScore = null;
    for (const a of answers) {
      if (typeof a.answer?.value === "number") npsScore = a.answer.value;
      else if (typeof a.answer?.rating === "number") npsScore = a.answer.rating;
    }
    if (typeof npsScore !== "number" || !Number.isFinite(npsScore)) {
      npsScore = 5;
    }

    const prodObj = PRODUCTS_ALL.find(p => p.id === productId) || { name_th: "ผลิตภัณฑ์ตราต้นไม้", code: "GENERAL" };
    const mySalesId = CUSTOMER.salesperson_id || SURVEY_CTX?.profile?.salesperson_id || "c03a7c5e-ccc8-559d-9223-3379b540f53d";
    const mySalesName = SURVEY_CTX?.profile?.display_name || CUSTOMER.employee_name || "ฝ่ายขายตราต้นไม้";
    const campaignName = ACTIVE_CAMPAIGN?.name || "สำรวจความพึงพอใจและคุณค่าตราต้นไม้ 2026";
    const respondentNameVal = document.getElementById("respondent-name").value.trim() || null;
    const nowIso = new Date().toISOString();

    // Ensure questions exist in survey_questions table so foreign keys in survey_answers are valid
    if (typeof PVT.ensureQuestionsExistInDb === "function") {
      await PVT.ensureQuestionsExistInDb(QUESTIONS || [], productId, respondentType);
    }

    // Deduplicate answers by question_id and ensure valid UUID syntax for PostgreSQL
    const answerMap = new Map();
    for (const a of (answers || [])) {
      const qUuid = PVT.toValidUuid(a.question_id);
      if (!answerMap.has(qUuid)) {
        answerMap.set(qUuid, {
          question_id: qUuid,
          answer: a.answer
        });
      }
    }
    const sanitizedAnswers = Array.from(answerMap.values());

    // 2. Submit survey via database RPC function (security definer handles customer & campaign automatically)
    try {
      const { data, error } = await PVT.db.rpc("submit_internal_survey", {
        p_campaign_id: PVT.toValidUuid(campaignId),
        p_customer_id: PVT.toValidUuid(CUSTOMER.id),
        p_product_id: PVT.toValidUuid(productId),
        p_respondent_type: respondentType,
        p_respondent_name: respondentNameVal,
        p_answers: sanitizedAnswers,
        p_salesperson_id: PVT.toValidUuid(mySalesId),
        p_customer_name: CUSTOMER.client_name,
        p_province: CUSTOMER.province_raw || ""
      });

      if (!error && data) {
        responseId = data;
        submittedToDb = true;
        // Ensure nps_score is explicitly updated on the newly created response row
        try {
          await PVT.db.from("survey_responses").update({ nps_score: npsScore }).eq("id", responseId);
        } catch (updateErr) {
          console.warn("Notice updating nps_score in survey_responses:", updateErr);
        }
      } else if (error) {
        console.warn("RPC submit_internal_survey returned notice:", error.message || error);
      }
    } catch (rpcErr) {
      console.warn("RPC submit_internal_survey exception:", rpcErr);
    }

    // 5. Direct insert fallback
    if (!responseId) {
      try {
        const { data: resRow, error: insErr } = await PVT.db.from("survey_responses").insert({
          campaign_id: PVT.toValidUuid(campaignId),
          customer_id: PVT.toValidUuid(CUSTOMER.id),
          salesperson_id: PVT.toValidUuid(mySalesId),
          product_id: PVT.toValidUuid(productId),
          respondent_type: respondentType,
          source: 'sales',
          respondent_name: respondentNameVal,
          nps_score: npsScore
        }).select("id").single();

        if (!insErr && resRow?.id) {
          responseId = resRow.id;
          submittedToDb = true;

          const answerRows = sanitizedAnswers.map(item => ({
            response_id: responseId,
            question_id: item.question_id,
            answer_json: item.answer
          }));
          if (answerRows.length) {
            const { error: ansErr } = await PVT.db.from("survey_answers").upsert(answerRows, { onConflict: "response_id,question_id" });
            if (ansErr) {
              console.warn("Notice upserting survey_answers:", ansErr.message || ansErr);
            }
          }
        }
      } catch (insErr) {
        console.warn("Direct DB insert notice:", insErr);
      }
    }

    // 6. ALWAYS save complete record into local/offline storage
    if (!responseId) {
      responseId = `local-${Date.now()}`;
    }

    const offlineRecord = {
      id: responseId,
      campaign_id: campaignId,
      campaign_name: campaignName,
      customer_id: CUSTOMER.id,
      client_id: CUSTOMER.client_id || "-",
      client_name: CUSTOMER.client_name,
      customer_name: CUSTOMER.client_name,
      province: CUSTOMER.province_normalized || CUSTOMER.province_raw || "-",
      salesperson_id: mySalesId,
      salesperson_name: mySalesName,
      product_id: productId,
      product_name: prodObj.name_th || "ผลิตภัณฑ์ตราต้นไม้",
      product_code: prodObj.code || "GENERAL",
      respondent_type: respondentType,
      respondent_name: respondentNameVal || CUSTOMER.client_name,
      source: "sales",
      nps_score: npsScore,
      answers: answers,
      submitted_at: nowIso,
      created_at: nowIso,
      synced: submittedToDb
    };

    PVT.saveOfflineResponse(offlineRecord);
    if (CUSTOMER && CUSTOMER.id) {
      COMPLETED_CUSTOMER_IDS.add(CUSTOMER.id);
    }

    // Persist active customer and respondent type to session storage
    try {
      if (CUSTOMER) sessionStorage.setItem("pvt_active_customer", JSON.stringify(CUSTOMER));
      sessionStorage.setItem("pvt_active_type", respondentType);
    } catch (e) {}

    const formContainer = document.getElementById("survey-form-container");
    const successCard = document.getElementById("survey-success-card");

    const nextBtnLabel = respondentType === "farmer"
      ? "กรอกสินค้าอื่นให้เกษตรกรต่อ"
      : "กรอกสินค้าอื่นให้ร้านนี้ต่อ";

    const subtitle = respondentType === "farmer"
      ? `เกษตรกร: <b>${PVT.escapeHtml(CUSTOMER.client_name)}</b>`
      : `ร้าน: <b>${PVT.escapeHtml(CUSTOMER.client_name)}</b> (${PVT.escapeHtml(CUSTOMER.province_normalized || CUSTOMER.province_raw || "")})`;

    if (formContainer && successCard) {
      formContainer.classList.add("hidden");
      successCard.classList.remove("hidden");
      successCard.innerHTML = `
        <div style="color:var(--brand);margin-bottom:14px;display:flex;justify-content:center">
          <svg class="pvt-icon" width="56" height="56" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></svg>
        </div>
        <h2 style="margin:0 0 8px">บันทึกแบบสอบถามเรียบร้อยแล้ว</h2>
        <p class="muted" style="margin:8px 0 10px;font-size:15px">${subtitle}</p>
        <div style="display:inline-block;background:#eff6ff;border:1px solid #bfdbfe;color:#1e3a8a;border-radius:20px;padding:4px 16px;font-size:13px;font-weight:600;margin-bottom:24px">
          สินค้าที่เพิ่งบันทึก: ${PVT.escapeHtml(prodObj.name_th)} • คะแนนความพึงพอใจ: ${npsScore}/5 ดาว
        </div>
        <div class="actions" style="justify-content:center;gap:12px;flex-wrap:wrap">
          <button id="btn-continue-same-customer" class="btn btn-primary" style="background-color: #000c85; font-weight: 600; padding:12px 22px; display:inline-flex;align-items:center;gap:8px">
            <svg class="pvt-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 5v14M5 12h14"/></svg>
            <span>${nextBtnLabel}</span>
          </button>
          <button id="btn-choose-next-customer" class="btn btn-secondary" style="border-width: 0px; border-style: solid; padding:12px 20px; display:inline-flex;align-items:center;gap:8px">
            <svg class="pvt-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>
            <span style="color: #000c85; font-weight: 600;">เลือกร้านค้าถัดไป</span>
          </button>
        </div>
      `;

      document.getElementById("btn-continue-same-customer")?.addEventListener("click", () => {
        continueWithSameCustomer();
      });

      document.getElementById("btn-choose-next-customer")?.addEventListener("click", () => {
        chooseNextCustomer();
      });

      window.scrollTo({ top: 0, behavior: "smooth" });
    } else {
      // Fallback if formContainer not found
      const nextUrl = respondentType === "farmer"
        ? `survey.html?type=farmer${CUSTOMER?.province_raw ? `&province=${encodeURIComponent(CUSTOMER.province_raw)}` : ""}`
        : `survey.html?customer=${encodeURIComponent(CUSTOMER.id)}&type=dealer`;

      document.getElementById("survey-area").innerHTML = `<div class="card" style="text-align:center;padding:34px">
        <div style="color:var(--brand);margin-bottom:14px;display:flex;justify-content:center">
          <svg class="pvt-icon" width="56" height="56" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></svg>
        </div>
        <h2>บันทึกแบบสอบถามเรียบร้อย</h2>
        <p class="muted" style="margin:8px 0 16px">${subtitle}</p>
        <div class="actions" style="justify-content:center;margin-top:20px;gap:12px;flex-wrap:wrap">
          <button class="btn btn-primary" onclick="location.href='${nextUrl}'" style="background-color: #000c85; font-weight: normal; display:inline-flex;align-items:center;gap:6px">
            <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 5v14M5 12h14"/></svg>
            <span>${nextBtnLabel}</span>
          </button>
          <button class="btn btn-secondary" onclick="location.href='survey.html'" style="border-width: 0px; border-style: solid; display:inline-flex;align-items:center;gap:6px">
            <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>
            <span style="color: #000c85; font-weight: normal;">เลือกร้านค้าถัดไป</span>
          </button>
        </div>
      </div>`;
    }
  } catch (err) {
    PVT.toast(err.message || "บันทึกไม่สำเร็จ", "error");
  } finally {
    PVT.setBusy(btn, false);
  }
}

async function fetchCompletedCustomers() {
  COMPLETED_CUSTOMER_IDS.clear();
  if (ACTIVE_CAMPAIGN && ACTIVE_CAMPAIGN.id) {
    try {
      let q = PVT.db.from("survey_responses").select("customer_id").eq("campaign_id", ACTIVE_CAMPAIGN.id);
      const mySalesId = SURVEY_CTX?.profile?.salesperson_id;
      if (SURVEY_CTX?.profile?.role === "sales" && mySalesId) {
        q = q.eq("salesperson_id", mySalesId);
      }
      const { data: respData, error: respErr } = await q;
      if (!respErr && respData) {
        respData.forEach(r => {
          if (r.customer_id) {
            COMPLETED_CUSTOMER_IDS.add(r.customer_id);
          }
        });
      }
    } catch (e) {
      console.warn("Failed to fetch completed customer IDs:", e);
    }
  }
}

async function fetchCompletedProductsForSelectedCustomer() {
  COMPLETED_PRODUCT_IDS.clear();
  let targetCustomerId = null;

  const respondentType = document.getElementById("respondent-type")?.value || "";
  if (respondentType === "farmer") {
    const province = getSelectedFarmerProvince();
    if (province) {
      const farmerCust = MY_CUSTOMERS.find(c => c.client_name === `เกษตรกรทั่วไป (${province})`);
      if (farmerCust) {
        targetCustomerId = farmerCust.id;
      }
    }
  } else {
    if (CUSTOMER) {
      targetCustomerId = CUSTOMER.id;
    }
  }

  // Load offline completed products for this customer
  try {
    const offlineList = JSON.parse(localStorage.getItem("pvt_offline_responses") || "[]");
    offlineList.forEach(off => {
      if (off.customer_id === targetCustomerId && off.campaign_id === ACTIVE_CAMPAIGN?.id) {
        if (off.product_id) {
          COMPLETED_PRODUCT_IDS.add(off.product_id);
        }
      }
    });
  } catch (e) {
    console.warn("Failed to load offline completed products:", e);
  }

  console.log("fetchCompletedProductsForSelectedCustomer targetCustomerId:", targetCustomerId, "campaignId:", ACTIVE_CAMPAIGN?.id);
  if (targetCustomerId && ACTIVE_CAMPAIGN && ACTIVE_CAMPAIGN.id) {
    try {
      let q = PVT.db.from("survey_responses")
        .select("product_id")
        .eq("campaign_id", ACTIVE_CAMPAIGN.id)
        .eq("customer_id", targetCustomerId);
      const mySalesId = SURVEY_CTX?.profile?.salesperson_id;
      if (SURVEY_CTX?.profile?.role === "sales" && mySalesId) {
        q = q.eq("salesperson_id", mySalesId);
      }
      const { data, error } = await q;
      console.log("fetchCompletedProductsForSelectedCustomer query data:", data, "error:", error);
      if (!error && data) {
        data.forEach(r => {
          if (r.product_id) {
            COMPLETED_PRODUCT_IDS.add(r.product_id);
          }
        });
      }
    } catch (e) {
      console.warn("Failed to fetch completed product IDs:", e);
    }
  }

  console.log("COMPLETED_PRODUCT_IDS Set values:", Array.from(COMPLETED_PRODUCT_IDS));
  renderProducts();
}

window.continueWithSameCustomer = async function() {
  const successCard = document.getElementById("survey-success-card");
  const formContainer = document.getElementById("survey-form-container");
  if (successCard) successCard.classList.add("hidden");
  if (formContainer) formContainer.classList.remove("hidden");

  // Keep CUSTOMER and respondent-type exactly as-is!
  const typeSelect = document.getElementById("respondent-type");
  const type = typeSelect?.value || (CUSTOMER?.client_id?.startsWith("FARMER-") ? "farmer" : "dealer");
  if (typeSelect) typeSelect.value = type;

  // Reset product selection
  const prodSelect = document.getElementById("product-select");
  if (prodSelect) prodSelect.value = "";

  // Hide questions panel until next product is selected
  const qPanel = document.getElementById("questions-panel");
  if (qPanel) qPanel.classList.add("hidden");

  // Reset progress bar & answers
  ANSWERS = {};
  CURRENT_QUESTION_SET = [];
  const qContainer = document.getElementById("question-container");
  if (qContainer) qContainer.innerHTML = "";
  const painPointEl = document.getElementById("pain-point");
  if (painPointEl) {
    painPointEl.style.display = "none";
    painPointEl.textContent = "";
  }

  // Refresh completed products so the just-completed product shows "(ทำแล้ว)"
  await fetchCompletedProductsForSelectedCustomer();
  renderProducts();
  syncMetadataHighlights();

  // Highlight and focus product selector
  if (prodSelect) {
    prodSelect.scrollIntoView({ behavior: "smooth", block: "center" });
    prodSelect.focus();
    prodSelect.style.outline = "3px solid #16a34a";
    prodSelect.style.boxShadow = "0 0 0 4px rgba(22, 163, 74, 0.2)";
    setTimeout(() => {
      prodSelect.style.outline = "";
      prodSelect.style.boxShadow = "";
    }, 2500);
  }

  PVT.toast(`กรอกสินค้าอื่นต่อให้ "${CUSTOMER?.client_name || 'ลูกค้ารายนี้'}" ได้เลย`, "info");
};

window.chooseNextCustomer = function() {
  CUSTOMER = null;
  window.CUSTOMER = null;
  try {
    sessionStorage.removeItem("pvt_active_customer");
    sessionStorage.removeItem("pvt_active_type");
  } catch(e) {}
  history.replaceState(null, "", "survey.html");
  
  const successCard = document.getElementById("survey-success-card");
  const formContainer = document.getElementById("survey-form-container");
  if (successCard) successCard.classList.add("hidden");
  if (formContainer) formContainer.classList.remove("hidden");

  // Reset selects
  const custSelect = document.getElementById("customer-select");
  if (custSelect) custSelect.value = "";
  const prodSelect = document.getElementById("product-select");
  if (prodSelect) prodSelect.value = "";
  const farmerProvSelect = document.getElementById("farmer-province");
  if (farmerProvSelect) farmerProvSelect.value = "";
  const farmerProvOtherInput = document.getElementById("farmer-province-other");
  if (farmerProvOtherInput) farmerProvOtherInput.value = "";
  const farmerProvOtherWrap = document.getElementById("farmer-province-other-wrap");
  if (farmerProvOtherWrap) farmerProvOtherWrap.classList.add("hidden");
  const qPanel = document.getElementById("questions-panel");
  if (qPanel) qPanel.classList.add("hidden");

  renderHeader();
  applyCustomerFilters(false);
  window.scrollTo({ top: 0, behavior: "smooth" });
  PVT.toast("กรุณาเลือกร้านค้าถัดไป", "info");
};


