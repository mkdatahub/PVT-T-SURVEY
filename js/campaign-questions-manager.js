/**
 * P.V.T. & T Plas Survey System
 * Campaign-specific Questions Manager (จัดการและปรับแต่งชุดคำถามเฉพาะ Campaign)
 */
window.PVT = window.PVT || {};

(() => {
  const STORAGE_PREFIX = "pvt_campaign_custom_q_";
  const LATEST_KEY = "pvt_latest_campaign_id";
  const ACTIVE_Q_KEY = "pvt_active_custom_questions";

  /**
   * 1. STORAGE & DATA APIS
   */

  PVT.getLatestCustomCampaignId = () => {
    return localStorage.getItem(LATEST_KEY) || null;
  };

  PVT.getActiveCustomQuestions = (productId = null, respondentType = null) => {
    try {
      const raw = localStorage.getItem(ACTIVE_Q_KEY);
      if (!raw) return null;
      const parsed = JSON.parse(raw);
      if (!Array.isArray(parsed) || !parsed.length) return null;
      let list = [...parsed];
      if (productId) {
        const pFiltered = list.filter(q => !q.product_id || q.product_id === "all" || q.product_id === productId);
        if (pFiltered.length > 0) list = pFiltered;
      }
      if (respondentType) {
        const rFiltered = list.filter(q => !q.respondent_type || q.respondent_type === "all" || q.respondent_type === respondentType);
        if (rFiltered.length > 0) list = rFiltered;
      }
      list.sort((a, b) => (a.sort_order || a.question_no || 0) - (b.sort_order || b.question_no || 0));
      return list.length > 0 ? list : parsed;
    } catch(e) {
      return null;
    }
  };

  PVT.getCampaignConfig = (campaignId) => {
    if (!campaignId) {
      const latestId = localStorage.getItem(LATEST_KEY);
      if (latestId) campaignId = latestId;
      else return null;
    }
    try {
      const raw = localStorage.getItem(STORAGE_PREFIX + campaignId);
      if (raw) return JSON.parse(raw);
      
      // Fallback: check if campaign in window.A_CAMPAIGNS has custom_questions
      if (window.A_CAMPAIGNS) {
        const c = window.A_CAMPAIGNS.find(x => x.id === campaignId);
        if (c?.custom_questions && Array.isArray(c.custom_questions) && c.custom_questions.length > 0) {
          return { campaign_id: campaignId, has_custom: true, questions: c.custom_questions };
        }
      }
      return null;
    } catch (e) {
      console.warn("Error reading campaign questions config:", e);
      return null;
    }
  };

  PVT.hasCampaignCustomQuestions = (campaignId) => {
    const cfg = PVT.getCampaignConfig(campaignId);
    return !!(cfg && cfg.has_custom && Array.isArray(cfg.questions) && cfg.questions.length > 0);
  };

  PVT.getCampaignQuestions = (campaignId = null, productId = null, respondentType = null) => {
    let cfg = campaignId ? PVT.getCampaignConfig(campaignId) : null;

    // Only fallback to latest configured campaign if campaignId is not explicitly specified
    if (!campaignId && (!cfg || !cfg.has_custom || !Array.isArray(cfg.questions) || cfg.questions.length === 0)) {
      const latestId = localStorage.getItem(LATEST_KEY);
      if (latestId) {
        cfg = PVT.getCampaignConfig(latestId);
      }
    }

    // If still not found and no specific campaignId was requested, check global active custom questions
    if (!cfg || !cfg.has_custom || !Array.isArray(cfg.questions) || cfg.questions.length === 0) {
      if (!campaignId) {
        const direct = PVT.getActiveCustomQuestions(productId, respondentType);
        if (direct && direct.length > 0) return direct;
      }
      return null;
    }

    let list = [...cfg.questions];

    // Filter by product if specified and questions have product_id specified
    if (productId) {
      const prodFiltered = list.filter(q => !q.product_id || q.product_id === "all" || q.product_id === productId);
      if (prodFiltered.length > 0) {
        list = prodFiltered;
      }
    }

    // Filter by respondent type if specified
    if (respondentType) {
      const respFiltered = list.filter(q => !q.respondent_type || q.respondent_type === "all" || q.respondent_type === respondentType);
      if (respFiltered.length > 0) {
        list = respFiltered;
      }
    }

    list.sort((a, b) => (a.sort_order || a.question_no || 0) - (b.sort_order || b.question_no || 0));
    return list;
  };

  PVT.saveCampaignQuestions = async (campaignId, questions, meta = {}) => {
    if (!campaignId) throw new Error("Missing campaignId");

    const payload = {
      campaign_id: campaignId,
      has_custom: true,
      updated_at: new Date().toISOString(),
      updated_by: meta.updated_by || "admin",
      ...meta,
      questions: questions || []
    };

    try {
      localStorage.setItem(STORAGE_PREFIX + campaignId, JSON.stringify(payload));
      localStorage.setItem(LATEST_KEY, campaignId);
      localStorage.setItem(ACTIVE_Q_KEY, JSON.stringify(payload.questions));
    } catch (e) {
      console.error("Local storage write error:", e);
    }

    // Update in-memory campaigns list if available
    if (window.A_CAMPAIGNS) {
      const c = window.A_CAMPAIGNS.find(x => x.id === campaignId);
      if (c) c.custom_questions = payload.questions;
      try {
        localStorage.setItem("pvt_local_campaigns", JSON.stringify(window.A_CAMPAIGNS));
      } catch(e) {}
    }

    // Attempt to persist to database if table/column supports it
    const hasCol = PVT.hasCustomQuestionsCol || (window.A_CAMPAIGNS && window.A_CAMPAIGNS.length > 0 && Object.prototype.hasOwnProperty.call(window.A_CAMPAIGNS[0], "custom_questions"));
    if (PVT.db && hasCol) {
      try {
        await PVT.db.from("survey_campaigns").update({
          custom_questions: payload.questions
        }).eq("id", campaignId);
      } catch (err) {
        // Ignored if column not in schema; localStorage acts as reliable persistence
      }
    }

    return payload;
  };

  PVT.resetCampaignToStandard = async (campaignId) => {
    if (!campaignId) return;
    try {
      localStorage.removeItem(STORAGE_PREFIX + campaignId);
      if (localStorage.getItem(LATEST_KEY) === campaignId) {
        localStorage.removeItem(LATEST_KEY);
        localStorage.removeItem(ACTIVE_Q_KEY);
      }
    } catch (e) {}

    if (window.A_CAMPAIGNS) {
      const c = window.A_CAMPAIGNS.find(x => x.id === campaignId);
      if (c) c.custom_questions = null;
    }

    const hasColReset = PVT.hasCustomQuestionsCol || (window.A_CAMPAIGNS && window.A_CAMPAIGNS.length > 0 && Object.prototype.hasOwnProperty.call(window.A_CAMPAIGNS[0], "custom_questions"));
    if (PVT.db && hasColReset) {
      try {
        await PVT.db.from("survey_campaigns").update({
          custom_questions: null
        }).eq("id", campaignId);
      } catch (err) {}
    }
  };

  PVT.getStandardDefaultQuestions = (productId = null, respondentType = "dealer") => {
    if (respondentType === "farmer") {
      return [
        {
          id: `std_q1_farmer`,
          product_id: productId || "all",
          respondent_type: "farmer",
          question_no: 1,
          prompt: "เหตุผลหลักที่ท่านตัดสินใจเลือกใช้ผลิตภัณฑ์ตราต้นไม้ (เลือกได้ไม่เกิน 2 ข้อ)",
          question_type: "checkbox",
          max_selections: 2,
          required: true,
          analysis_hint: "วิเคราะห์จุดขายและ Key Buying Factor สำหรับกลุ่มเกษตรกร/ผู้ใช้งานจริง",
          sort_order: 1,
          options: [
            { id: "opt_f_1_1", option_key: "quality", option_text: "สินค้าคุณภาพดี หนา ทนแดด ทนฝน ไม่ขาดง่าย", sort_order: 1, is_other: false },
            { id: "opt_f_1_2", option_key: "price", option_text: "ราคาสมเหตุสมผล คุ้มค่าเงินเมื่อเทียบกับยี่ห้ออื่น", sort_order: 2, is_other: false },
            { id: "opt_f_1_3", option_key: "recommendation", option_text: "ร้านค้าแนะนำ หรือ เพื่อนบ้าน/เกษตรกรคนอื่นแนะนำต่อ", sort_order: 3, is_other: false },
            { id: "opt_f_1_4", option_key: "brand_trust", option_text: "เชื่อมั่นในตราสินค้า (ตราต้นไม้) มีชื่อเสียงยาวนาน", sort_order: 4, is_other: false },
            { id: "opt_f_1_5", option_key: "easy_to_find", option_text: "หาซื้อง่าย มีจำหน่ายตามร้านค้าเกษตรใกล้บ้าน", sort_order: 5, is_other: false },
            { id: "opt_f_1_6", option_key: "other", option_text: "อื่นๆ โปรดระบุ", sort_order: 6, is_other: true }
          ]
        },
        {
          id: `std_q2_farmer`,
          product_id: productId || "all",
          respondent_type: "farmer",
          question_no: 2,
          prompt: "ความพึงพอใจหลังการใช้งานผลิตภัณฑ์ตราต้นไม้ (1 = น้อยที่สุด, 5 = มากที่สุด)",
          question_type: "rating_grid",
          required: true,
          analysis_hint: "ประเมินคุณภาพสินค้าจากการใช้งานจริงของเกษตรกร",
          sort_order: 2,
          options: [
            { id: "grid_f_2_1", option_key: "durability", option_text: "ความทนทานต่อสภาพแดด ฝน ลม พายุ", sort_order: 1 },
            { id: "grid_f_2_2", option_key: "ease_of_use", option_text: "ความสะดวกและง่ายต่อการติดตั้ง/ใช้งาน", sort_order: 2 },
            { id: "grid_f_2_3", option_key: "value_for_money", option_text: "ความคุ้มราคาเมื่อเทียบกับอายุการใช้งาน", sort_order: 3 },
            { id: "grid_f_2_4", option_key: "package_quality", option_text: "คุณภาพของบรรจุภัณฑ์และการจัดเก็บสินค้า", sort_order: 4 }
          ]
        },
        {
          id: `std_q3_farmer`,
          product_id: productId || "all",
          respondent_type: "farmer",
          question_no: 3,
          prompt: "ข้อเสนอแนะหรือจุดที่อยากให้ตราต้นไม้ปรับปรุงเพิ่มเติมมากที่สุดคืออะไร",
          question_type: "single_choice",
          required: true,
          analysis_hint: "หาแนวทางการปรับปรุงสินค้าเพื่อมัดใจผู้ใช้งานจริง",
          sort_order: 3,
          options: [
            { id: "opt_f_3_1", option_key: "lower_price", option_text: "ปรับราคาลงให้ย่อมเยากว่านี้", sort_order: 1, is_other: false },
            { id: "opt_f_3_2", option_key: "more_sizes", option_text: "เพิ่มขนาดและสเปกให้เลือกมากกว่านี้", sort_order: 2, is_other: false },
            { id: "opt_f_3_3", option_key: "easy_to_buy", option_text: "เพิ่มจุดจัดจำหน่ายให้อำเภอ/ตำบลต่างๆ หาซื้อง่ายขึ้น", sort_order: 3, is_other: false },
            { id: "opt_f_3_4", option_key: "advertise", option_text: "จัดกิจกรรมส่งเสริมความรู้/สาธิตการใช้งานในพื้นที่", sort_order: 4, is_other: false },
            { id: "opt_f_3_5", option_key: "none", option_text: "ไม่มี ข้อเสนอแนะ สินค้าดีอยู่แล้ว", sort_order: 5, is_other: false },
            { id: "opt_f_3_6", option_key: "other", option_text: "อื่นๆ โปรดระบุ", sort_order: 6, is_other: true }
          ]
        },
        {
          id: `std_q4_farmer`,
          product_id: productId || "all",
          respondent_type: "farmer",
          question_no: 4,
          prompt: "พืชหลักที่ท่านปลูกหรือนำผลิตภัณฑ์นี้ไปใช้งานคือพืชประเภทใด",
          question_type: "single_choice",
          required: true,
          analysis_hint: "เจาะกลุ่มประชากรพืชที่นิยมใช้ผลิตภัณฑ์เพื่อการทำตลาดตรงจุด",
          sort_order: 4,
          options: [
            { id: "opt_f_4_1", option_key: "fruits", option_text: "ไม้ผล (ทุเรียน / ส้ม / ลำไย / มะม่วง ฯลฯ)", sort_order: 1, is_other: false },
            { id: "opt_f_4_2", option_key: "vegetables", option_text: "พืชผักสวนครัว / พืชผักกินใบ", sort_order: 2, is_other: false },
            { id: "opt_f_4_3", option_key: "field_crops", option_text: "พืชไร่ (ข้าว / อ้อย / ข้าวโพด / มันสำปะหลัง)", sort_order: 3, is_other: false },
            { id: "opt_f_4_4", option_key: "flowers", option_text: "ไม้ดอกไม้ประดับ / เพาะกล้าไม้", sort_order: 4, is_other: false },
            { id: "opt_f_4_5", option_key: "other", option_text: "อื่นๆ โปรดระบุ", sort_order: 5, is_other: true }
          ]
        },
        {
          id: `std_q5_farmer`,
          product_id: productId || "all",
          respondent_type: "farmer",
          question_no: 5,
          prompt: "โอกาสที่ท่านจะแนะนำผลิตภัณฑ์ตราต้นไม้ ให้แก่เพื่อนเกษตรกรท่านอื่น (1 = น้อยที่สุด, 5 = มากที่สุด)",
          question_type: "scale",
          required: true,
          scale_min: 1,
          scale_max: 5,
          scale_min_label: "ไม่แนะนำแน่นอน",
          scale_mid_label: "ปานกลาง",
          scale_max_label: "แนะนำแน่นอน",
          analysis_hint: "คำนวณ Net Promoter Score (NPS) ของกลุ่มผู้ใช้งานจริง",
          sort_order: 5
        }
      ];
    }

    return [
      {
        id: `std_q1_dealer`,
        product_id: productId || "all",
        respondent_type: respondentType,
        question_no: 1,
        prompt: "เหตุผลหลักที่ร้านค้าของท่านตัดสินใจเลือกจำหน่ายผลิตภัณฑ์ตราต้นไม้ (เลือกได้ไม่เกิน 2 ข้อ)",
        question_type: "checkbox",
        max_selections: 2,
        required: true,
        analysis_hint: "วิเคราะห์จุดขายและ Key Buying Factor ของตราต้นไม้",
        sort_order: 1,
        options: [
          { id: "opt_1_1", option_key: "quality", option_text: "สินค้าคุณภาพดี ทนทาน ลูกค้ากลับมาซื้อซ้ำ", sort_order: 1, is_other: false },
          { id: "opt_1_2", option_key: "margin", option_text: "ราคาและผลกำไร (Margin) เหมาะสม คุ้มค่า", sort_order: 2, is_other: false },
          { id: "opt_1_3", option_key: "brand", option_text: "แบรนด์น่าเชื่อถือ เกษตรกรในพื้นที่ยอมรับ", sort_order: 3, is_other: false },
          { id: "opt_1_4", option_key: "delivery", option_text: "ทีมงานจัดส่งรวดเร็ว สินค้าไม่ขาดสต็อก", sort_order: 4, is_other: false },
          { id: "opt_1_5", option_key: "credit", option_text: "เงื่อนไขการค้าและเครดิตเทอมยืดหยุ่น", sort_order: 5, is_other: false },
          { id: "opt_1_6", option_key: "other", option_text: "อื่นๆ โปรดระบุ", sort_order: 6, is_other: true }
        ]
      },
      {
        id: `std_q2_dealer`,
        product_id: productId || "all",
        respondent_type: respondentType,
        question_no: 2,
        prompt: "ความพึงพอใจในด้านต่างๆ ของผลิตภัณฑ์ตราต้นไม้ (1 = น้อยที่สุด, 5 = มากที่สุด)",
        question_type: "rating_grid",
        required: true,
        analysis_hint: "ประเมินคะแนนแยกปัจจัยคุณภาพและบริการ",
        sort_order: 2,
        options: [
          { id: "grid_2_1", option_key: "durability", option_text: "ความทนทานและคุณภาพเนื้อพลาสติก", sort_order: 1 },
          { id: "grid_2_2", option_key: "consistency", option_text: "ความสม่ำเสมอของมาตรฐานสินค้าในทุกรอบจัดส่ง", sort_order: 2 },
          { id: "grid_2_3", option_key: "price_value", option_text: "ความคุ้มค่าของราคาเมื่อเทียบกับคุณภาพ", sort_order: 3 },
          { id: "grid_2_4", option_key: "lead_time", option_text: "ความสะดวกและตรงเวลาในการจัดส่งสินค้า", sort_order: 4 },
          { id: "grid_2_5", option_key: "sales_service", option_text: "การดูแลและให้คำแนะนำของเจ้าหน้าที่ฝ่ายขาย", sort_order: 5 }
        ]
      },
      {
        id: `std_q3_dealer`,
        product_id: productId || "all",
        respondent_type: respondentType,
        question_no: 3,
        prompt: "หากมีข้อที่ตราต้นไม้ควรปรับปรุงหรือพัฒนาเพิ่มเติมเพื่อร้านค้าของท่านมากที่สุด คือข้อใด",
        question_type: "single_choice",
        required: true,
        analysis_hint: "จุดที่ควรปรับปรุงเร่งด่วน (Pain Points)",
        sort_order: 3,
        options: [
          { id: "opt_3_1", option_key: "promo", option_text: "โปรโมชั่นส่วนลดหรือของแถมส่งเสริมการขาย", sort_order: 1, is_other: false },
          { id: "opt_3_2", option_key: "pop", option_text: "ป้ายโฆษณา สื่อหน้าร้าน และตัวอย่างสินค้า", sort_order: 2, is_other: false },
          { id: "opt_3_3", option_key: "sizes", option_text: "เพิ่มขนาดและความยาวให้หลากหลายขึ้น", sort_order: 3, is_other: false },
          { id: "opt_3_4", option_key: "packaging", option_text: "การมัดม้วนและบรรจุภัณฑ์ให้สะดวกต่อการจัดเรียง", sort_order: 4, is_other: false },
          { id: "opt_3_5", option_key: "none", option_text: "ไม่มี ข้อเสนอแนะ สินค้าดีอยู่แล้ว", sort_order: 5, is_other: false },
          { id: "opt_3_6", option_key: "other", option_text: "อื่นๆ โปรดระบุ", sort_order: 6, is_other: true }
        ]
      },
      {
        id: `std_q4_dealer`,
        product_id: productId || "all",
        respondent_type: respondentType,
        question_no: 4,
        prompt: "กลุ่มลูกค้าหลักที่มาซื้อสินค้านี้ที่ร้านของท่าน คือกลุ่มใดมากที่สุด",
        question_type: "checkbox",
        max_selections: 2,
        required: true,
        analysis_hint: "Customer Segment และพฤติกรรมหน้าร้าน",
        sort_order: 4,
        options: [
          { id: "opt_4_1", option_key: "durian_orchard", option_text: "ชาวสวนผลไม้ (ทุเรียน / ลำไย / มังคุด / ส้ม)", sort_order: 1, is_other: false },
          { id: "opt_4_2", option_key: "field_crops", option_text: "เกษตรกรพืชไร่ (อ้อย / ข้าวโพด / มันสำปะหลัง)", sort_order: 2, is_other: false },
          { id: "opt_4_3", option_key: "general_home", option_text: "บ้านเรือนทั่วไป / งานสวนรอบบ้าน", sort_order: 3, is_other: false },
          { id: "opt_4_4", option_key: "contractor", option_text: "ช่างรับเหมา / ระบบชลประทานเกษตร", sort_order: 4, is_other: false },
          { id: "opt_4_5", option_key: "other", option_text: "อื่นๆ โปรดระบุ", sort_order: 5, is_other: true }
        ]
      },
      {
        id: `std_q5_dealer`,
        product_id: productId || "all",
        respondent_type: respondentType,
        question_no: 5,
        prompt: "โอกาสที่ท่านจะแนะนำผลิตภัณฑ์ตราต้นไม้ ให้แก่ร้านค้าหรือพันธมิตรทางการค้าท่านอื่น (1 = น้อยที่สุด, 5 = มากที่สุด)",
        question_type: "scale",
        required: true,
        scale_min: 1,
        scale_max: 5,
        scale_min_label: "ไม่แนะนำแน่นอน",
        scale_mid_label: "ปานกลาง",
        scale_max_label: "แนะนำแน่นอน",
        analysis_hint: "คำนวณ Net Promoter Score (NPS) ของกลุ่มร้านค้าตัวแทนจำหน่าย",
        sort_order: 5
      }
    ];
  };

  /**
   * 2. CAMPAIGN QUESTION BUILDER & MODAL UI
   */

  let _activeCampaign = null;
  let _activeQuestions = [];
  let _selectedProductId = "all";
  let _selectedRespType = "all";
  let _isCustomMode = false;
  let _editingQuestionIndex = -1;

  PVT.openCampaignQuestionModal = async (campaignId) => {
    // Find campaign object
    let camp = (window.A_CAMPAIGNS || []).find(c => c.id === campaignId);
    if (!camp && PVT.db) {
      try {
        const { data } = await PVT.db.from("survey_campaigns").select("*").eq("id", campaignId).single();
        if (data) camp = data;
      } catch (e) {}
    }

    if (!camp) {
      return PVT.toast("ไม่พบข้อมูล Campaign", "error");
    }

    _activeCampaign = camp;
    _isCustomMode = PVT.hasCampaignCustomQuestions(campaignId);

    if (_isCustomMode) {
      const existing = PVT.getCampaignQuestions(campaignId);
      _activeQuestions = JSON.parse(JSON.stringify(existing || []));
    } else {
      // Clone standard default questions as initial working draft
      _activeQuestions = PVT.getStandardDefaultQuestions("all", "dealer");
    }

    ensureModalContainer();
    renderModalContent();
    document.getElementById("campaign-questions-modal-backdrop").classList.remove("hidden");
    document.body.style.overflow = "hidden";
  };

  function closeCampaignQuestionModal() {
    const backdrop = document.getElementById("campaign-questions-modal-backdrop");
    if (backdrop) backdrop.classList.add("hidden");
    document.body.style.overflow = "";
    _activeCampaign = null;
    _activeQuestions = [];
  }

  function ensureModalContainer() {
    if (document.getElementById("campaign-questions-modal-backdrop")) return;

    const div = document.createElement("div");
    div.id = "campaign-questions-modal-backdrop";
    div.className = "modal-backdrop hidden";
    div.style.zIndex = "120";
    div.innerHTML = `
      <div class="modal" style="width:min(900px,calc(100vw - 32px));max-height:92vh;padding:24px;border-radius:20px;display:flex;flex-direction:column">
        <div id="cq-modal-inner" style="display:flex;flex-direction:column;height:100%;overflow:hidden"></div>
      </div>
    `;
    document.body.appendChild(div);
  }

  function renderModalContent() {
    const container = document.getElementById("cq-modal-inner");
    if (!container || !_activeCampaign) return;

    const camp = _activeCampaign;
    const isCustom = _isCustomMode;
    const products = window.A_PRODUCTS || [];

    container.innerHTML = `
      <!-- Header -->
      <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:12px;margin-bottom:16px;padding-bottom:12px;border-bottom:1px solid #e2ece5">
        <div>
          <div style="display:flex;align-items:center;gap:8px;flex-wrap:wrap">
            <h2 style="margin:0;font-size:18px;color:#0e3823;display:inline-flex;align-items:center;gap:8px">
              <svg class="pvt-icon" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="color:var(--brand)">
                <path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/>
              </svg>
              <span>จัดการชุดคำถาม: ${PVT.escapeHtml(camp.name)}</span>
            </h2>
            ${isCustom 
              ? `<span class="pill success" style="font-weight:800;font-size:11px">✨ กำลังใช้คำถามเฉพาะของ Campaign นี้</span>` 
              : `<span class="pill" style="font-size:11px">คำถามมาตรฐานของระบบ</span>`}
          </div>
          <p class="small muted" style="margin:4px 0 0">
            ช่วงเวลา: ${PVT.formatDate(camp.start_date)} – ${PVT.formatDate(camp.end_date)} • 
            ท่านสามารถแก้ไขคำถามเดิม เพิ่มข้อใหม่ หรือเพิ่มตัวเลือกสำหรับแคมเปญนี้ได้โดยไม่กระทบแคมเปญอื่น
          </p>
        </div>
        <button id="cq-btn-close-x" class="btn btn-outline btn-sm" style="padding:4px 10px" title="ปิด">
          <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>

      <!-- Mode Selector Card -->
      <div style="background:#f8faf8;border:1px solid #d7e8dc;border-radius:14px;padding:14px 16px;margin-bottom:16px">
        <div style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px">
          <div>
            <strong style="font-size:13.5px;color:#133d27">โหมดคำถามของ Campaign นี้</strong>
            <div class="small muted">เลือกว่าจะใช้ชุดคำถามมาตรฐานกลาง หรือปรับแต่งคำถามเฉพาะสำหรับรอบนี้</div>
          </div>
          <div style="display:flex;gap:6px">
            <button id="cq-btn-mode-standard" class="btn btn-sm ${!isCustom ? 'btn-primary' : 'btn-outline'}" style="font-size:12.5px;padding:6px 12px">
              ⚪ ใช้คำถามมาตรฐาน
            </button>
            <button id="cq-btn-mode-custom" class="btn btn-sm ${isCustom ? 'btn-primary' : 'btn-outline'}" style="font-size:12.5px;padding:6px 12px;font-weight:750">
              🟢 ปรับแต่งคำถามเฉพาะของ Campaign นี้
            </button>
          </div>
        </div>
      </div>

      <!-- Action & Filter Bar -->
      <div style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px;margin-bottom:14px">
        <div style="display:flex;align-items:center;gap:8px;flex-wrap:wrap">
          <label class="small muted" style="font-weight:750">กรองสินค้า:</label>
          <select id="cq-filter-product" class="select" style="font-size:12.5px;padding:5px 10px;min-width:140px">
            <option value="all" ${_selectedProductId === "all" ? "selected" : ""}>ทุกสินค้า (ค่าเริ่มต้นทั่วไป)</option>
            ${products.map(p => `<option value="${p.id}" ${_selectedProductId === p.id ? "selected" : ""}>${PVT.escapeHtml(p.name_th)}</option>`).join("")}
          </select>

          <label class="small muted" style="font-weight:750;margin-left:4px">กลุ่มเป้าหมาย:</label>
          <select id="cq-filter-resp" class="select" style="font-size:12.5px;padding:5px 10px">
            <option value="all" ${_selectedRespType === "all" ? "selected" : ""}>เพิ่มทั้งสองชุด (ร้านค้าและเกษตรกร)</option>
            <option value="dealer" ${_selectedRespType === "dealer" ? "selected" : ""}>เฉพาะร้านค้าตัวแทน (Dealer)</option>
            <option value="farmer" ${_selectedRespType === "farmer" ? "selected" : ""}>เฉพาะเกษตรกร (Farmer)</option>
          </select>
        </div>

        <div style="display:flex;align-items:center;gap:6px">
          <button id="cq-btn-add-q" class="btn btn-primary btn-sm" style="display:inline-flex;align-items:center;gap:4px;font-weight:750">
            <svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            <span>+ เพิ่มคำถามใหม่</span>
          </button>
          <button id="cq-btn-clone-std" class="btn btn-outline btn-sm" title="นำเข้าคำถามมาตรฐานมาเป็นต้นแบบ" style="display:inline-flex;align-items:center;gap:4px">
            <svg class="pvt-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 1 0 2.13-9.36L1 10"/></svg>
            <span>โหลดคำถามมาตรฐาน</span>
          </button>
        </div>
      </div>

      <!-- Questions List Scroll Container -->
      <div id="cq-questions-container" style="flex:1;overflow-y:auto;overflow-x:hidden;padding-right:6px;display:flex;flex-direction:column;gap:12px;min-height:220px">
        ${renderQuestionsCardsHtml()}
      </div>

      <!-- Footer -->
      <div style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px;margin-top:16px;padding-top:14px;border-top:1px solid #e2ece5">
        <div class="small muted">
          จำนวนคำถาม: <b>${_activeQuestions.length} ข้อ</b> 
          ${isCustom ? `• <span style="color:#0f5132;font-weight:750">ระบบจะใช้ชุดคำถามนี้เมื่อเปิดทำแบบสอบถาม</span>` : `• ใช้คำถามมาตรฐาน`}
        </div>
        <div style="display:flex;gap:8px;flex-wrap:wrap;align-items:center">
          <a href="survey.html?campaign=${encodeURIComponent(camp.id)}" target="_blank" class="btn btn-outline btn-sm" style="padding:7px 12px;font-size:12.5px;display:inline-flex;align-items:center;gap:6px;text-decoration:none;border-color:#a4c9b1;background:#fbfdfb" title="ทดสอบเปิดหน้าแบบสอบถามทีมขาย">
            <svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
            <span>ทดสอบหน้าเซลล์ (survey)</span>
          </a>
          <a href="public-survey.html?campaign=${encodeURIComponent(camp.id)}" target="_blank" class="btn btn-outline btn-sm" style="padding:7px 12px;font-size:12.5px;display:inline-flex;align-items:center;gap:6px;text-decoration:none;border-color:#a4c9b1;background:#fbfdfb" title="ทดสอบเปิดหน้าแบบสอบถามร้านค้ากรอกเอง">
            <svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>
            <span>ทดสอบหน้าร้านค้า (public)</span>
          </a>
          <button id="cq-btn-close" class="btn btn-outline" style="padding:8px 16px">ปิด</button>
          <button id="cq-btn-save-all" class="btn btn-primary" style="padding:8px 20px;font-weight:750;display:inline-flex;align-items:center;gap:6px">
            <svg class="pvt-icon" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
            <span>บันทึกชุดคำถามของ Campaign</span>
          </button>
        </div>
      </div>
    `;

    bindModalEvents();
  }

  function renderQuestionsCardsHtml() {
    if (!_activeQuestions || !_activeQuestions.length) {
      return `
        <div style="text-align:center;padding:36px 16px;background:#fcfdfc;border:1px dashed #cde2d3;border-radius:14px">
          <svg class="pvt-icon" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="color:#8fa799;margin-bottom:8px">
            <circle cx="12" cy="12" r="10"/><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/><line x1="12" y1="17" x2="12.01" y2="17"/>
          </svg>
          <div style="font-weight:700;color:#1d4630;margin-bottom:4px">ยังไม่มีคำถามใน Campaign นี้</div>
          <div class="small muted" style="margin-bottom:12px">คลิก "+ เพิ่มคำถามใหม่" หรือกด "โหลดคำถามมาตรฐาน" เพื่อเริ่มต้น</div>
          <button id="cq-btn-empty-load" class="btn btn-sm btn-primary">โหลดคำถามมาตรฐาน</button>
        </div>
      `;
    }

    const products = window.A_PRODUCTS || [];

    return _activeQuestions.map((q, idx) => {
      const typeLabels = {
        checkbox: "เลือกได้หลายข้อ (Checkbox)",
        single_choice: "เลือกได้ข้อเดียว (Radio)",
        rating_grid: "ประเมินคะแนนแยกหัวข้อ (Rating Grid 1-5)",
        scale: "สเกลคะแนนรวม (Scale)",
        text: "พิมพ์ข้อความอิสระ (Text)"
      };

      const typeLabel = typeLabels[q.question_type] || q.question_type;
      const opts = q.options || [];

      // Determine product label
      let prodLabel = "ทุกสินค้า (ทั่วไป)";
      if (q.product_id && q.product_id !== "all") {
        const p = products.find(x => x.id === q.product_id);
        prodLabel = p ? p.name_th : q.product_id;
      }

      // Determine respondent label
      let respLabel = "ทุกกลุ่มผู้ตอบ";
      if (q.respondent_type === "dealer") respLabel = "ร้านค้า (Dealer)";
      else if (q.respondent_type === "farmer") respLabel = "เกษตรกร (Farmer)";

      return `
        <div class="card" style="margin:0;padding:16px;background:#fff;border:1px solid #d5e6db;border-radius:14px;box-shadow:0 2px 8px rgba(15,81,50,.04)">
          <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:10px;margin-bottom:8px">
            <div style="display:flex;align-items:center;gap:6px;flex-wrap:wrap">
              <span class="pill info" style="font-weight:800;font-size:12px;background:#e0f2fe;color:#0369a1">ข้อ ${q.question_no || idx + 1}</span>
              <span class="pill" style="font-size:11px;background:#f1f5f9;color:#334155">${typeLabel}</span>
              <span class="pill" style="font-size:11px;background:#ecfdf5;color:#065f46;border:1px solid #a7f3d0">📦 ${PVT.escapeHtml(prodLabel)}</span>
              <span class="pill" style="font-size:11px;background:#fffbeb;color:#92400e;border:1px solid #fde68a">👥 ${PVT.escapeHtml(respLabel)}</span>
              ${q.required ? `<span class="pill danger" style="font-size:10.5px;padding:1px 6px">*จำเป็น</span>` : `<span class="pill" style="font-size:10.5px;padding:1px 6px">ไม่บังคับ</span>`}
              ${q.max_selections ? `<span class="small muted" style="font-size:11px">• ไม่เกิน ${q.max_selections} ข้อ</span>` : ''}
            </div>
            <div class="actions" style="display:flex;align-items:center;gap:4px">
              <button class="btn btn-outline btn-sm" data-move-up="${idx}" ${idx === 0 ? "disabled" : ""} title="เลื่อนขึ้น" style="padding:2px 7px">▲</button>
              <button class="btn btn-outline btn-sm" data-move-down="${idx}" ${idx === _activeQuestions.length - 1 ? "disabled" : ""} title="เลื่อนลง" style="padding:2px 7px">▼</button>
              <button class="btn btn-primary btn-sm" data-edit-q="${idx}" style="display:inline-flex;align-items:center;gap:4px;padding:3px 9px">
                <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
                <span>แก้ไข</span>
              </button>
              <button class="btn btn-outline btn-sm" data-delete-q="${idx}" title="ลบคำถามนี้" style="color:#b91c1c;padding:3px 7px">
                <svg class="pvt-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
              </button>
            </div>
          </div>

          <!-- Question Prompt -->
          <div style="font-size:14.5px;font-weight:750;color:#0e3823;margin-bottom:8px;line-height:1.4">
            ${PVT.escapeHtml(q.prompt)}
          </div>

          ${q.analysis_hint ? `
            <div class="small muted" style="margin-bottom:10px;display:flex;align-items:center;gap:4px;color:#496b58">
              <svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
              <span>คำอธิบายการวิเคราะห์: ${PVT.escapeHtml(q.analysis_hint)}</span>
            </div>
          ` : ''}

          <!-- Options Preview -->
          ${opts.length > 0 ? `
            <div style="background:#f9fbf9;border:1px solid #e6f0e9;border-radius:10px;padding:8px 12px;font-size:12.5px">
              <div style="font-weight:700;color:#274a35;margin-bottom:4px;font-size:11.5px">ตัวเลือกคำตอบ (${opts.length} ข้อ):</div>
              <div style="display:flex;flex-wrap:wrap;gap:6px">
                ${opts.map((o, oIdx) => `
                  <span class="pill" style="font-size:11.5px;background:#fff;border:1px solid #d4e7db;color:#18402b;padding:2px 8px">
                    ${oIdx + 1}. ${PVT.escapeHtml(o.option_text)} ${o.is_other ? `<b style="color:#ea580c">(อื่นๆ)</b>` : ''}
                  </span>
                `).join("")}
              </div>
            </div>
          ` : (q.question_type === 'text' ? `
            <div class="small muted" style="font-style:italic">กล่องข้อความสำหรับผู้ตอบพิมพ์แสดงความคิดเห็น</div>
          ` : '')}
        </div>
      `;
    }).join("");
  }

  function bindModalEvents() {
    const container = document.getElementById("cq-modal-inner");
    if (!container) return;

    // Close buttons
    document.getElementById("cq-btn-close-x")?.addEventListener("click", closeCampaignQuestionModal);
    document.getElementById("cq-btn-close")?.addEventListener("click", closeCampaignQuestionModal);

    // Mode toggles
    document.getElementById("cq-btn-mode-standard")?.addEventListener("click", async () => {
      if (confirm(`ต้องการเปลี่ยนให้ Campaign "${_activeCampaign.name}" กลับไปใช้ชุดคำถามมาตรฐานกลางของระบบหรือไม่?`)) {
        await PVT.resetCampaignToStandard(_activeCampaign.id);
        _isCustomMode = false;
        _activeQuestions = PVT.getStandardDefaultQuestions("all", "dealer");
        PVT.toast("ตั้งค่าเป็นคำถามมาตรฐานแล้ว", "info");
        renderModalContent();
        if (window.renderCampaigns) window.renderCampaigns();
      }
    });

    document.getElementById("cq-btn-mode-custom")?.addEventListener("click", () => {
      _isCustomMode = true;
      PVT.toast("เปิดโหมดปรับแต่งคำถามเฉพาะของ Campaign แล้ว", "success");
      renderModalContent();
    });

    // Clone standard
    document.getElementById("cq-btn-clone-std")?.addEventListener("click", () => {
      if (confirm("ต้องการดึงชุดคำถามมาตรฐานมาทับคำถามปัจจุบันหรือไม่?")) {
        _activeQuestions = PVT.getStandardDefaultQuestions(_selectedProductId, _selectedRespType);
        _isCustomMode = true;
        PVT.saveCampaignQuestions(_activeCampaign.id, _activeQuestions, { auto_saved: true });
        renderModalContent();
        PVT.toast("โหลดคำถามมาตรฐานเรียบร้อย", "success");
      }
    });

    document.getElementById("cq-btn-empty-load")?.addEventListener("click", () => {
      _activeQuestions = PVT.getStandardDefaultQuestions(_selectedProductId, _selectedRespType);
      _isCustomMode = true;
      PVT.saveCampaignQuestions(_activeCampaign.id, _activeQuestions, { auto_saved: true });
      renderModalContent();
    });

    // Filters
    document.getElementById("cq-filter-product")?.addEventListener("change", (e) => {
      _selectedProductId = e.target.value;
    });

    document.getElementById("cq-filter-resp")?.addEventListener("change", (e) => {
      _selectedRespType = e.target.value;
    });

    // Add question
    document.getElementById("cq-btn-add-q")?.addEventListener("click", () => {
      _isCustomMode = true;
      openQuestionEditor(-1);
    });

    // Card actions
    container.querySelectorAll("[data-edit-q]").forEach(btn => {
      btn.addEventListener("click", () => {
        const idx = parseInt(btn.dataset.editQ, 10);
        openQuestionEditor(idx);
      });
    });

    container.querySelectorAll("[data-delete-q]").forEach(btn => {
      btn.addEventListener("click", () => {
        const idx = parseInt(btn.dataset.deleteQ, 10);
        if (confirm(`ต้องการลบข้อที่ ${idx + 1} หรือไม่?`)) {
          _activeQuestions.splice(idx, 1);
          // re-number
          _activeQuestions.forEach((q, i) => { q.question_no = i + 1; q.sort_order = i + 1; });
          _isCustomMode = true;
          PVT.saveCampaignQuestions(_activeCampaign.id, _activeQuestions, { auto_saved: true });
          renderModalContent();
          PVT.toast("ลบคำถามและอัปเดตระบบแล้ว", "info");
        }
      });
    });

    container.querySelectorAll("[data-move-up]").forEach(btn => {
      btn.addEventListener("click", () => {
        const idx = parseInt(btn.dataset.moveUp, 10);
        if (idx > 0) {
          const temp = _activeQuestions[idx];
          _activeQuestions[idx] = _activeQuestions[idx - 1];
          _activeQuestions[idx - 1] = temp;
          _activeQuestions.forEach((q, i) => { q.question_no = i + 1; q.sort_order = i + 1; });
          _isCustomMode = true;
          PVT.saveCampaignQuestions(_activeCampaign.id, _activeQuestions, { auto_saved: true });
          renderModalContent();
        }
      });
    });

    container.querySelectorAll("[data-move-down]").forEach(btn => {
      btn.addEventListener("click", () => {
        const idx = parseInt(btn.dataset.moveDown, 10);
        if (idx < _activeQuestions.length - 1) {
          const temp = _activeQuestions[idx];
          _activeQuestions[idx] = _activeQuestions[idx + 1];
          _activeQuestions[idx + 1] = temp;
          _activeQuestions.forEach((q, i) => { q.question_no = i + 1; q.sort_order = i + 1; });
          _isCustomMode = true;
          PVT.saveCampaignQuestions(_activeCampaign.id, _activeQuestions, { auto_saved: true });
          renderModalContent();
        }
      });
    });

    // Save All
    document.getElementById("cq-btn-save-all")?.addEventListener("click", async () => {
      const btn = document.getElementById("cq-btn-save-all");
      PVT.setBusy(btn, true, "กำลังบันทึก...");
      try {
        if (_isCustomMode) {
          await PVT.saveCampaignQuestions(_activeCampaign.id, _activeQuestions, {
            updated_by: window.ADMIN_CTX?.session?.user?.id || "admin"
          });
          PVT.toast(`บันทึกชุดคำถามเฉพาะสำหรับ Campaign "${_activeCampaign.name}" สำเร็จ (${_activeQuestions.length} ข้อ)`, "success");
        } else {
          await PVT.resetCampaignToStandard(_activeCampaign.id);
          PVT.toast(`Campaign "${_activeCampaign.name}" ใช้คำถามมาตรฐานของระบบเรียบร้อย`, "success");
        }

        if (window.renderCampaigns) window.renderCampaigns();
        closeCampaignQuestionModal();
      } catch (err) {
        PVT.toast(err.message || "เกิดข้อผิดพลาดในการบันทึก", "error");
      } finally {
        PVT.setBusy(btn, false);
      }
    });
  }

  /**
   * 3. IN-DEPTH QUESTION EDITOR DIALOG
   */
  function openQuestionEditor(index) {
    _editingQuestionIndex = index;
    const isNew = index < 0;
    const qData = isNew ? {
      id: `cq_${Date.now()}`,
      product_id: _selectedProductId || "all",
      respondent_type: _selectedRespType || "all",
      question_no: _activeQuestions.length + 1,
      prompt: "",
      question_type: "checkbox",
      max_selections: 2,
      required: true,
      analysis_hint: "",
      sort_order: _activeQuestions.length + 1,
      options: [
        { id: `opt_${Date.now()}_1`, option_key: "opt_1", option_text: "", sort_order: 1, is_other: false },
        { id: `opt_${Date.now()}_2`, option_key: "opt_2", option_text: "", sort_order: 2, is_other: false },
        { id: `opt_${Date.now()}_3`, option_key: "opt_3", option_text: "อื่นๆ โปรดระบุ", sort_order: 3, is_other: true }
      ]
    } : JSON.parse(JSON.stringify(_activeQuestions[index]));

    let editorBackdrop = document.getElementById("cq-editor-submodal");
    if (!editorBackdrop) {
      editorBackdrop = document.createElement("div");
      editorBackdrop.id = "cq-editor-submodal";
      editorBackdrop.className = "modal-backdrop";
      editorBackdrop.style.zIndex = "150";
      document.body.appendChild(editorBackdrop);
    }

    editorBackdrop.classList.remove("hidden");

    function renderEditorForm() {
      const products = window.A_PRODUCTS || [];

      editorBackdrop.innerHTML = `
        <div class="modal" style="width:min(680px,calc(100vw - 32px));max-height:88vh;padding:22px;border-radius:18px;display:flex;flex-direction:column">
          <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;padding-bottom:10px;border-bottom:1px solid #e2ece5">
            <h3 style="margin:0;color:#0e3823;font-size:16.5px">
              ${isNew ? "+ เพิ่มคำถามใหม่ใน Campaign" : `แก้ไขคำถามข้อ ${qData.question_no}`}
            </h3>
            <button id="cq-sub-close-x" class="btn btn-outline btn-sm" style="padding:2px 8px">✕</button>
          </div>

          <form id="cq-sub-form" class="stack" style="flex:1;overflow-y:auto;padding-right:4px;gap:12px">
            <div class="grid grid-2" style="gap:10px">
              <div class="field">
                <label>ข้อที่ (Question No.)</label>
                <input id="sub-q-no" class="input" type="number" min="1" max="99" value="${qData.question_no || 1}" required>
              </div>
              <div class="field">
                <label>ประเภทคำถาม (Question Type)</label>
                <select id="sub-q-type" class="select">
                  <option value="checkbox" ${qData.question_type === 'checkbox' ? 'selected' : ''}>เลือกได้หลายข้อ (Checkbox)</option>
                  <option value="single_choice" ${qData.question_type === 'single_choice' ? 'selected' : ''}>เลือกได้ข้อเดียว (Radio)</option>
                  <option value="rating_grid" ${qData.question_type === 'rating_grid' ? 'selected' : ''}>ประเมินคะแนนแยกหัวข้อ (Rating Grid 1-5)</option>
                  <option value="scale" ${qData.question_type === 'scale' ? 'selected' : ''}>สเกลคะแนนรวม (Scale)</option>
                  <option value="text" ${qData.question_type === 'text' ? 'selected' : ''}>พิมพ์ข้อความอิสระ (Text)</option>
                </select>
              </div>
            </div>

            <!-- Scope of Question -->
            <div class="grid grid-2" style="gap:10px">
              <div class="field">
                <label>สินค้าที่ใช้คำถามนี้ (Product Scope)</label>
                <select id="sub-q-product" class="select">
                  <option value="all" ${(!qData.product_id || qData.product_id === 'all') ? 'selected' : ''}>ทุกสินค้า (แนะนำ - ปรากฏในทุกสินค้า)</option>
                  ${products.map(p => `<option value="${p.id}" ${qData.product_id === p.id ? 'selected' : ''}>${PVT.escapeHtml(p.name_th)}</option>`).join("")}
                </select>
              </div>
              <div class="field">
                <label>กลุ่มผู้ตอบ (Respondent Scope)</label>
                <select id="sub-q-resp" class="select">
                  <option value="all" ${(!qData.respondent_type || qData.respondent_type === 'all') ? 'selected' : ''}>ทุกกลุ่ม (ร้านค้า และ เกษตรกร)</option>
                  <option value="dealer" ${qData.respondent_type === 'dealer' ? 'selected' : ''}>เฉพาะร้านค้าตัวแทนจำหน่าย (Dealer)</option>
                  <option value="farmer" ${qData.respondent_type === 'farmer' ? 'selected' : ''}>เฉพาะเกษตรกร (Farmer)</option>
                </select>
              </div>
            </div>

            <div class="field">
              <label>ข้อความโจทย์คำถาม (Prompt) *</label>
              <textarea id="sub-q-prompt" class="textarea" rows="2" required placeholder="เช่น ปัจจัยสำคัญที่สุดในการตัดสินใจสั่งซื้อผลิตภัณฑ์ตราต้นไม้...">${PVT.escapeHtml(qData.prompt)}</textarea>
            </div>

            <div class="grid grid-2" style="gap:10px">
              <div class="field">
                <label>คำอธิบายสำหรับการวิเคราะห์ (Analysis Hint)</label>
                <input id="sub-q-hint" class="input" placeholder="เช่น วิเคราะห์ Key Buying Factor" value="${PVT.escapeHtml(qData.analysis_hint || '')}">
              </div>
              <div class="field" id="sub-max-sel-group" style="${qData.question_type === 'checkbox' ? '' : 'display:none'}">
                <label>จำนวนตัวเลือกสูงสุดที่เลือกได้ (Max Selections)</label>
                <input id="sub-q-max" class="input" type="number" min="1" max="10" value="${qData.max_selections || 2}">
              </div>
            </div>

            <div style="display:flex;gap:16px;align-items:center;margin:4px 0">
              <label class="option" style="cursor:pointer;display:inline-flex;align-items:center;gap:6px">
                <input id="sub-q-req" type="checkbox" ${qData.required !== false ? 'checked' : ''}>
                <span style="font-weight:700;font-size:13px">จำเป็นต้องตอบ (*Required)</span>
              </label>
            </div>

            <!-- Options Section -->
            <div id="sub-options-box" style="${['checkbox', 'single_choice', 'rating_grid'].includes(qData.question_type) ? '' : 'display:none'}">
              <div style="display:flex;justify-content:space-between;align-items:center;margin:10px 0 6px">
                <strong style="font-size:13px;color:#18442c">ตัวเลือกคำตอบ (Answer Options)</strong>
                <button type="button" id="sub-add-option-btn" class="btn btn-outline btn-sm" style="font-size:11.5px;padding:3px 8px">
                  + เพิ่มตัวเลือก
                </button>
              </div>

              <div id="sub-options-list" style="display:flex;flex-direction:column;gap:6px">
                ${(qData.options || []).map((opt, oIdx) => `
                  <div class="option-edit-row" style="display:flex;align-items:center;gap:6px;background:#f9fbf9;border:1px solid #dbe8df;padding:6px 10px;border-radius:10px">
                    <span style="font-size:12px;font-weight:750;color:#2f5940;min-width:20px">${oIdx + 1}.</span>
                    <input class="input sub-opt-text" data-opt-idx="${oIdx}" value="${PVT.escapeHtml(opt.option_text)}" placeholder="ข้อความตัวเลือก..." style="flex:1;padding:5px 10px;font-size:13px" required>
                    <label style="display:inline-flex;align-items:center;gap:4px;font-size:11px;color:#c2410c;cursor:pointer;white-space:nowrap">
                      <input type="checkbox" class="sub-opt-other" data-opt-idx="${oIdx}" ${opt.is_other ? 'checked' : ''}>
                      <span>อื่นๆ (ระบุ)</span>
                    </label>
                    <button type="button" class="btn btn-outline btn-sm sub-opt-del" data-opt-idx="${oIdx}" style="color:#b91c1c;padding:2px 6px" title="ลบตัวเลือก">✕</button>
                  </div>
                `).join("")}
              </div>
            </div>

            <div class="actions" style="justify-content:flex-end;gap:8px;margin-top:14px;padding-top:10px;border-top:1px solid #e2ece5">
              <button type="button" id="cq-sub-cancel" class="btn btn-outline">ยกเลิก</button>
              <button type="submit" class="btn btn-primary" style="padding:8px 20px;font-weight:750">
                ${isNew ? "เพิ่มคำถามนี้" : "บันทึกการแก้ไขคำถาม"}
              </button>
            </div>
          </form>
        </div>
      `;

      // Bind inner events
      document.getElementById("cq-sub-close-x")?.addEventListener("click", () => editorBackdrop.classList.add("hidden"));
      document.getElementById("cq-sub-cancel")?.addEventListener("click", () => editorBackdrop.classList.add("hidden"));

      function syncState() {
        const qNoEl = document.getElementById("sub-q-no");
        if (qNoEl) qData.question_no = parseInt(qNoEl.value, 10) || 1;

        const typeEl = document.getElementById("sub-q-type");
        if (typeEl) qData.question_type = typeEl.value;

        const prodEl = document.getElementById("sub-q-product");
        if (prodEl) qData.product_id = prodEl.value || "all";

        const respEl = document.getElementById("sub-q-resp");
        if (respEl) qData.respondent_type = respEl.value || "all";

        const promptEl = document.getElementById("sub-q-prompt");
        if (promptEl) qData.prompt = promptEl.value;

        const hintEl = document.getElementById("sub-q-hint");
        if (hintEl) qData.analysis_hint = hintEl.value;

        const reqEl = document.getElementById("sub-q-req");
        if (reqEl) qData.required = reqEl.checked;

        const maxEl = document.getElementById("sub-q-max");
        if (maxEl) qData.max_selections = parseInt(maxEl.value, 10) || null;
      }

      // Attach sync listeners on every keypress and change to immediately update state
      ["sub-q-no", "sub-q-prompt", "sub-q-hint", "sub-q-max"].forEach(id => {
        document.getElementById(id)?.addEventListener("input", syncState);
      });
      ["sub-q-type", "sub-q-product", "sub-q-resp", "sub-q-req"].forEach(id => {
        document.getElementById(id)?.addEventListener("change", syncState);
      });

      const typeSelect = document.getElementById("sub-q-type");
      typeSelect?.addEventListener("change", () => {
        qData.question_type = typeSelect.value;
        const isChoice = ['checkbox', 'single_choice', 'rating_grid'].includes(qData.question_type);
        document.getElementById("sub-options-box").style.display = isChoice ? "" : "none";
        document.getElementById("sub-max-sel-group").style.display = qData.question_type === 'checkbox' ? "" : "none";
      });

      // Add Option
      document.getElementById("sub-add-option-btn")?.addEventListener("click", () => {
        syncState();
        qData.options = qData.options || [];
        qData.options.push({
          id: `opt_${Date.now()}_${qData.options.length + 1}`,
          option_key: `opt_${qData.options.length + 1}`,
          option_text: "",
          sort_order: qData.options.length + 1,
          is_other: false
        });
        renderEditorForm();
      });

      // Option text edits
      editorBackdrop.querySelectorAll(".sub-opt-text").forEach(inp => {
        inp.addEventListener("input", () => {
          const idx = parseInt(inp.dataset.optIdx, 10);
          if (qData.options[idx]) qData.options[idx].option_text = inp.value;
        });
      });

      // Option other checkbox
      editorBackdrop.querySelectorAll(".sub-opt-other").forEach(cb => {
        cb.addEventListener("change", () => {
          const idx = parseInt(cb.dataset.optIdx, 10);
          if (qData.options[idx]) qData.options[idx].is_other = cb.checked;
        });
      });

      // Delete option
      editorBackdrop.querySelectorAll(".sub-opt-del").forEach(btn => {
        btn.addEventListener("click", () => {
          syncState();
          const idx = parseInt(btn.dataset.optIdx, 10);
          if (qData.options.length <= 1) {
            return PVT.toast("คำถามต้องมีตัวเลือกอย่างน้อย 1 ข้อ", "error");
          }
          qData.options.splice(idx, 1);
          renderEditorForm();
        });
      });

      // Submit
      document.getElementById("cq-sub-form")?.addEventListener("submit", (e) => {
        e.preventDefault();
        qData.question_no = parseInt(document.getElementById("sub-q-no").value, 10) || 1;
        qData.product_id = document.getElementById("sub-q-product")?.value || "all";
        qData.respondent_type = document.getElementById("sub-q-resp")?.value || "all";
        qData.prompt = document.getElementById("sub-q-prompt").value.trim();
        qData.question_type = document.getElementById("sub-q-type").value;
        qData.analysis_hint = document.getElementById("sub-q-hint").value.trim();
        qData.required = document.getElementById("sub-q-req").checked;
        if (qData.question_type === 'checkbox') {
          qData.max_selections = parseInt(document.getElementById("sub-q-max")?.value, 10) || null;
        } else {
          qData.max_selections = null;
        }

        // Validate options if choice
        if (['checkbox', 'single_choice', 'rating_grid'].includes(qData.question_type)) {
          qData.options = (qData.options || []).filter(o => o.option_text && o.option_text.trim());
          if (!qData.options.length) {
            return PVT.toast("กรุณาระบุตัวเลือกคำตอบอย่างน้อย 1 ตัวเลือก", "error");
          }
        }

        if (isNew) {
          _activeQuestions.push(qData);
        } else {
          _activeQuestions[index] = qData;
        }

        // Sort by question_no
        _activeQuestions.sort((a, b) => a.question_no - b.question_no);
        _activeQuestions.forEach((q, i) => { q.sort_order = i + 1; });

        editorBackdrop.classList.add("hidden");
        _isCustomMode = true;

        // Auto-save immediately so it's live in survey
        PVT.saveCampaignQuestions(_activeCampaign.id, _activeQuestions, { auto_saved: true });

        renderModalContent();
        PVT.toast(isNew ? "เพิ่มคำถามและบันทึกอัตโนมัติเรียบร้อย (มีผลทันที)" : "แก้ไขคำถามและบันทึกเรียบร้อย", "success");
      });
    }

    renderEditorForm();
  }

})();
