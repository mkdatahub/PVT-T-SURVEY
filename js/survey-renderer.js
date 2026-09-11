window.PVT = window.PVT || {};

PVT.loadProducts = async (respondentType=null) => {
  let q=PVT.db.from("products").select("*").eq("is_active",true).order("sort_order");
  const {data,error}=await q;
  if(error) throw error;
  
  const products = (data || []).map(p => {
    if (p.code === "NURSERY_BAG" || p.id === "797feb8b-d26a-52aa-8b69-084776513497" || p.id === "p0000000-0000-0000-0000-000000000006") {
      return { ...p, farmer_enabled: true };
    }
    return p;
  });

  if (respondentType === "dealer") return products.filter(p => p.dealer_enabled);
  if (respondentType === "farmer") return products.filter(p => p.farmer_enabled);
  return products;
};

PVT.loadQuestionSet = async (productId, respondentType, campaignId = null) => {
  // Check if campaign has customized questions
  if (typeof PVT.getCampaignQuestions === "function") {
    let customQ = null;
    if (campaignId) {
      const hasCustom = typeof PVT.hasCampaignCustomQuestions === "function" ? PVT.hasCampaignCustomQuestions(campaignId) : false;
      if (hasCustom) {
        customQ = PVT.getCampaignQuestions(campaignId, productId, respondentType);
      } else {
        // If the campaign is set to use standard questions, do not load any custom questions
        customQ = null;
      }
    } else {
      customQ = PVT.getCampaignQuestions(null, productId, respondentType);
    }
    if (customQ && customQ.length > 0) {
      console.log(`[PVT Survey] Loaded ${customQ.length} custom campaign questions (product=${productId}, resp=${respondentType}, campaign=${campaignId})`);
      return customQ;
    }
  }

  try {
    const {data:questions,error}=await PVT.db
      .from("survey_questions")
      .select("*")
      .eq("product_id",productId)
      .eq("respondent_type",respondentType)
      .order("sort_order");
    if(!error && questions?.length) {
      const ids=questions.map(q=>q.id);
      const {data:options,error:oErr}=await PVT.db
        .from("survey_question_options")
        .select("*")
        .in("question_id",ids)
        .order("sort_order");
      if(!oErr) {
        const byQ={};
        for(const o of options || []) (byQ[o.question_id] ||= []).push(o);
        return questions.map(q=>({...q,options:byQ[q.id] || []}));
      }
    }
  } catch(e) {
    console.warn("DB question query notice:", e);
  }

  if (typeof PVT.getStandardDefaultQuestions === "function") {
    return PVT.getStandardDefaultQuestions(productId, respondentType);
  }
  return [];
};

PVT.renderQuestions = (container, questions, options={}) => {
  const isPublic = !!options.isPublic;
  if (!questions || !Array.isArray(questions)) {
    container.innerHTML = `<div class="notice muted">ไม่พบคำถาม</div>`;
    return;
  }

  container.innerHTML = questions.map((q,index)=>{
    let title = "";
    if (isPublic) {
      title = `
        <div class="public-q-head">
          <div class="public-q-badge-row">
            <span class="public-q-num">ข้อ ${q.question_no || index + 1} จาก ${questions.length}</span>
            ${q.required ? '<span class="public-q-req">*จำเป็น</span>' : '<span class="public-q-opt">ไม่บังคับ</span>'}
          </div>
          <h3 class="public-q-title">${PVT.escapeHtml(q.prompt || "")}</h3>
        </div>
      `;
    } else {
      title = `<h3><span class="pill info">Q${q.question_no || index + 1}</span> ${PVT.escapeHtml(q.prompt || "")}</h3>`;
    }

    const hint = (!isPublic && q.analysis_hint) ? `<small style="display:inline-flex;align-items:center;gap:4px"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg> <span>${PVT.escapeHtml(q.analysis_hint)}</span></small>` : "";
    let body = "";

    const qOpts = Array.isArray(q.options) ? q.options : [];

    if(q.question_type === "checkbox"){
      const optClass = isPublic ? "public-option-card" : "option";
      body = `<div class="${isPublic ? 'public-options-list' : ''}">` + qOpts.map(o=>`
        <label class="${optClass}">
          <input type="checkbox" name="q_${q.id}" value="${o.id || o.option_text}" data-other="${!!o.is_other}">
          <span class="option-text">${PVT.escapeHtml(o.option_text || o.text || "")}</span>
        </label>
        ${o.is_other?`<input class="input hidden other-input" data-for-option="${o.id || o.option_text}" placeholder="โปรดระบุรายละเอียด...">`:""}
      `).join("") + `</div>`;
      if(q.max_selections) {
        body += `<div class="${isPublic ? 'public-q-limit' : 'small muted'}" style="display:inline-flex;align-items:center;gap:4px"><svg class="pvt-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg> <span>เลือกได้ไม่เกิน ${q.max_selections} ข้อ</span></div>`;
      }
    } else if(q.question_type === "single_choice"){
      const optClass = isPublic ? "public-option-card" : "option";
      body = `<div class="${isPublic ? 'public-options-list' : ''}">` + qOpts.map(o=>`
        <label class="${optClass}">
          <input type="radio" name="q_${q.id}" value="${o.id || o.option_text}" data-other="${!!o.is_other}">
          <span class="option-text">${PVT.escapeHtml(o.option_text || o.text || "")}</span>
        </label>
        ${o.is_other?`<input class="input hidden other-input" data-for-option="${o.id || o.option_text}" placeholder="โปรดระบุรายละเอียด...">`:""}
      `).join("") + `</div>`;
    } else if(q.question_type === "rating_grid"){
      body = `<div class="public-rating-grid" style="margin-top: 8px;">` + qOpts.map((o, oIdx) => `
        <div class="public-rating-item" data-option-id="${o.id || o.option_text}">
          <div class="public-rating-label">
            <span class="public-sub-num">${oIdx + 1}.</span> <strong>${PVT.escapeHtml(o.option_text || o.text || "")}</strong>
          </div>
          <div class="public-rating-choices">
            ${[1, 2, 3, 4, 5].map(n => `
              <label class="public-choice-pill">
                <input type="radio" name="q_${q.id}_${o.id || o.option_text}" value="${n}">
                <span class="choice-val">${n}</span>
              </label>
            `).join("")}
          </div>
          <div class="public-choice-hint">
            <span>1 = น้อยที่สุด</span>
            <span>3 = ปานกลาง</span>
            <span>5 = มากที่สุด</span>
          </div>
        </div>
      `).join("") + `</div>`;
    } else if(q.question_type === "scale"){
      const min=q.scale_min || 1,max=q.scale_max || 5;
      const nums=Array.from({length:max-min+1},(_,i)=>i+min);
      body = `
        <div class="public-scale-wrapper" style="margin-top: 8px;">
          <div class="public-scale-row">
            ${nums.map(n=>`
              <label class="public-scale-pill">
                <input id="q_${q.id}_${n}" type="radio" name="q_${q.id}" value="${n}">
                <span class="pill-number">${n}</span>
              </label>
            `).join("")}
          </div>
          <div class="public-scale-labels">
            <span>${PVT.escapeHtml(q.scale_min_label || "น้อยที่สุด")}</span>
            <span>${PVT.escapeHtml(q.scale_mid_label || "")}</span>
            <span>${PVT.escapeHtml(q.scale_max_label || "มากที่สุด")}</span>
          </div>
        </div>
      `;
    } else if(q.question_type === "text"){
      body = `<div style="margin-top:10px">
        <textarea class="textarea" name="q_${q.id}" rows="3" placeholder="ระบุรายละเอียดหรือความคิดเห็น..." style="width:100%;font-family:inherit;font-size:14px;padding:10px 12px;border-radius:10px;border:1px solid #cce0d2;background:#fff;box-sizing:border-box"></textarea>
      </div>`;
    }

    const cardClass = isPublic ? "question public-q-card" : "question";
    return `<section class="${cardClass}" data-question="${q.id}" data-index="${index}">${title}${body}${hint ? `<div style="margin-top:11px">${hint}</div>` : ''}</section>`;
  }).join("");

  // Helper to dynamically update the completed state/highlight of a question card
  PVT.updateQuestionFilledState = (qEl, q) => {
    if (!qEl || !q) return;
    let isFilled = false;
    if (q.question_type === "checkbox") {
      isFilled = qEl.querySelectorAll(`input[type="checkbox"][name="q_${q.id}"]:checked`).length > 0;
    } else if (q.question_type === "single_choice" || q.question_type === "scale") {
      isFilled = qEl.querySelectorAll(`input[type="radio"][name="q_${q.id}"]:checked`).length > 0;
    } else if (q.question_type === "rating_grid") {
      const totalRows = q.options?.length || 0;
      const checkedRows = qEl.querySelectorAll(`input[type="radio"]:checked`).length;
      isFilled = totalRows > 0 && checkedRows >= totalRows;
    } else if (q.question_type === "text") {
      const textVal = qEl.querySelector(`textarea[name="q_${q.id}"]`)?.value?.trim() || "";
      isFilled = textVal.length > 0;
    }

    if (isFilled) {
      qEl.classList.add("q-filled");
    } else {
      qEl.classList.remove("q-filled");
    }
  };

  // "Other" inputs, checkbox limit, and dynamic highlight updates
  const handleStateUpdate = (e) => {
    const input = e.target;
    if (!(input instanceof HTMLInputElement || input instanceof HTMLTextAreaElement)) return;
    const qEl = input.closest("[data-question]");
    if (!qEl) return;
    const q = questions.find(x => x.id === qEl.dataset.question);

    // Toggle "other" detailed text input if selected
    if (input instanceof HTMLInputElement && input.dataset.other === "true") {
      const other = qEl.querySelector(`[data-for-option="${input.value}"]`);
      if (other) other.classList.toggle("hidden", !input.checked);
    }

    // Limit checkboxes selection
    if (q?.question_type === "checkbox" && q.max_selections) {
      const checks = [...qEl.querySelectorAll(`input[type="checkbox"][name="q_${q.id}"]`)];
      const count = checks.filter(x => x.checked).length;
      for (const c of checks) c.disabled = !c.checked && count >= q.max_selections;
    }

    // Update the visual completed state
    if (q) PVT.updateQuestionFilledState(qEl, q);
  };

  container.addEventListener("change", handleStateUpdate);
  container.addEventListener("input", handleStateUpdate);

  // Set initial completed states (in case of cached responses or default pre-fills)
  questions.forEach(q => {
    const qEl = container.querySelector(`[data-question="${q.id}"]`);
    if (qEl) PVT.updateQuestionFilledState(qEl, q);
  });
};

PVT.collectAnswers = (container, questions) => {
  const answers=[];
  for(const q of questions){
    const qEl=container.querySelector(`[data-question="${q.id}"]`);
    let answer=null, valid=true;
    if(q.question_type==="checkbox"){
      const selected=[...qEl.querySelectorAll(`input[type="checkbox"][name="q_${q.id}"]:checked`)];
      valid=!q.required || selected.length>0;
      const otherInput=selected.find(x=>x.dataset.other==="true");
      answer={selected:selected.map(x=>x.value),other:otherInput ? (qEl.querySelector(`[data-for-option="${otherInput.value}"]`)?.value?.trim() || "") : ""};
      if(otherInput && !answer.other) valid=false;
    } else if(q.question_type==="single_choice"){
      const selected=qEl.querySelector(`input[type="radio"][name="q_${q.id}"]:checked`);
      valid=!q.required || !!selected;
      let other="";
      if(selected?.dataset.other==="true"){
        other=qEl.querySelector(`[data-for-option="${selected.value}"]`)?.value?.trim() || "";
        if(!other) valid=false;
      }
      answer={selected:selected?.value || null,other};
    } else if(q.question_type==="rating_grid"){
      const ratings={};
      const opts = q.options || [];
      for(const o of opts){
        const optKey = o.id || o.option_text;
        const selected=qEl.querySelector(`input[name="q_${q.id}_${optKey}"]:checked`);
        if(selected) ratings[optKey]=Number(selected.value);
        else if(q.required) valid=false;
      }
      answer={ratings};
    } else if(q.question_type==="scale"){
      const selected=qEl.querySelector(`input[name="q_${q.id}"]:checked`);
      valid=!q.required || !!selected;
      answer={value:selected ? Number(selected.value) : null};
    } else if(q.question_type==="text"){
      const txt=qEl.querySelector(`textarea[name="q_${q.id}"]`)?.value?.trim() || "";
      valid=!q.required || txt.length>0;
      answer={text:txt};
    }
    if(!valid){
      qEl.scrollIntoView({behavior:"smooth",block:"center"});
      qEl.style.outline="2px solid #e5484d";
      setTimeout(()=>qEl.style.outline="",2200);
      throw new Error(`กรุณาตอบ Q${q.question_no} ให้ครบ`);
    }
    answers.push({question_id:q.id,answer});
  }
  return answers;
};
