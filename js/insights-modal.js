/**
 * insights-modal.js
 * Advanced Qualitative Text & Survey Insights Modal
 * Generates dynamic Word Clouds, Trending Keywords, Sentiment Categorization,
 * and Qualitative Comment Filtering from survey responses.
 */

(function () {
  "use strict";

  let _insightsBackdrop = null;
  let _activeFilterCategory = "all";
  let _activeKeyword = "";
  let _cachedData = null;

  // Common Thai & English stopwords to ignore in text mining
  const STOPWORDS = new Set([
    "และ", "หรือ", "ของ", "ที่", "ใน", "กับ", "ให้", "ได้", "เป็น", "มี", "จะ", "ว่า", "ไม่",
    "ก็", "ไป", "มา", "จาก", "โดย", "การ", "ความ", "นี้", "นั้น", "มาก", "ดี", "ครับ", "ค่ะ",
    "นะ", "นะคะ", "นะครับ", "จ้า", "แล้ว", "เลย", "แต่", "ถ้า", "อยาก", "ให้มี", "อยากให้",
    "ขึ้น", "ลง", "ทั้ง", "อย่าง", "ทำ", "ใช้", "อยู่", "เพื่อ", "ตาม", "ตน", "คน", "ทาง",
    "อัน", "ข้อ", "พวก", "ยัง", "อีก", "บ้าง", "หน่อย", "ด้วย", "เรา", "เขา", "มัน", "ร้าน",
    "สินค้า", "ลูกค้า", "ตราต้นไม้", "ต้นไม้", "ตัว", "อันนี้", "แบบ", "เช่น", "a", "an",
    "the", "and", "or", "in", "on", "at", "to", "for", "of", "with", "is", "it", "are"
  ]);

  // Specific domain multi-word phrases and synonyms to map cleanly
  const DOMAIN_PHRASES = [
    { pattern: /(หนาเหนียว|เหนียวทน|เหนียวแน่น|เนื้อเหนียว)/gi, keyword: "หนาเหนียว", weight: 3, type: "positive", label: "ความหนาเหนียว / ทนทาน" },
    { pattern: /(ทนแดด|ทนแสงแดด|ทนUV|ทนทานต่อแดด)/gi, keyword: "ทนแดด", weight: 3, type: "positive", label: "ทนแดด ทน UV" },
    { pattern: /(ไม่แตกกรอบ|ไม่กรอบ|ไม่ฉีกขาด|ไม่ขาดง่าย|ทนแรงดึง)/gi, keyword: "ไม่กรอบง่าย", weight: 3, type: "positive", label: "ไม่กรอบ / ไม่ฉีกขาด" },
    { pattern: /(ราคาคุ้มค่า|ราคาเหมาะสม|ราคาถูก|สมราคา|ราคาส่งดี|กำไรดี)/gi, keyword: "ราคาคุ้มค่า", weight: 3, type: "positive", label: "ราคาเหมาะสม / คุ้มค่า" },
    { pattern: /(คุณภาพดี|เกรดA|เกรดพรีเมียม|มาตรฐานดี|พลาสติกใหม่)/gi, keyword: "คุณภาพพรีเมียม", weight: 3, type: "positive", label: "คุณภาพมาตรฐานสูง" },
    { pattern: /(ขายดี|ติดตลาด|ลูกค้าถามหา|ซื้อง่าย|เป็นที่นิยม)/gi, keyword: "ขายง่ายติดตลาด", weight: 3, type: "positive", label: "ขายง่าย / ติดตลาด" },
    { pattern: /(ส่งไว|ส่งตรงเวลา|บริการดี|เซลล์ดูแลดี|แนะนำดี)/gi, keyword: "เซลล์บริการดี", weight: 2, type: "positive", label: "การบริการ / ดูแลดี" },
    { pattern: /(รูน้ำหยดสม่ำเสมอ|น้ำออกสม่ำเสมอ|ไม่อุดตัน|รูเรียบ)/gi, keyword: "น้ำหยดสม่ำเสมอ", weight: 2, type: "positive", label: "อัตราจ่ายน้ำสม่ำเสมอ" },
    { pattern: /(ความยาวเต็ม|ม้วนเต็ม|น้ำหนักได้มาตรฐาน)/gi, keyword: "ม้วนยาวเต็มสเปก", weight: 2, type: "positive", label: "ความยาวเต็มม้วน" },
    
    // Improvement / Request keywords
    { pattern: /(เพิ่มขนาด|อยากได้ขนาดอื่น|ขยายไซส์|เบอร์ใหญ่|ขนาดใหญ่ขึ้น)/gi, keyword: "ขอเพิ่มขนาด/ไซส์", weight: 3, type: "suggestion", label: "ต้องการขนาด/สเปกเพิ่ม" },
    { pattern: /(โปรโมชั่น|ส่วนลด|ของแถม|แจกทอง|สะสมแต้ม|ลดราคา)/gi, keyword: "ขอโปรโมชั่น/ของแถม", weight: 3, type: "suggestion", label: "ขอโปรโมชัน & ส่วนลด" },
    { pattern: /(ป้ายไวนิล|สื่อหน้าร้าน|โบรชัวร์|ป้ายโฆษณา|แคตตาล็อก)/gi, keyword: "สื่อโฆษณาหน้าร้าน", weight: 3, type: "suggestion", label: "ขอป้าย/สื่อโปรโมท" },
    { pattern: /(สต็อกสินค้า|ส่งของเร็วขึ้น|รอบส่ง|ขาดตลาด|สต็อกขาด)/gi, keyword: "เพิ่มสต็อก/ส่งไว", weight: 2, type: "suggestion", label: "การสำรองสต็อก / รอบส่ง" },
    { pattern: /(แพ็กเกจจิ้ง|กล่องบรรจุ|ถุงห่อ|ป้ายฉลาก|บาร์โค้ด)/gi, keyword: "ปรับปรุงบรรจุภัณฑ์", weight: 2, type: "suggestion", label: "บรรจุภัณฑ์ / ฉลาก" }
  ];

  /**
   * Extract and extract keywords, phrases, sentiments, and quotes
   */
  function analyzeQualitativeResponses(rows, answers, questions, options) {
    const oMap = Object.fromEntries((options || []).map(o => [o.id, o]));
    const qMap = Object.fromEntries((questions || []).map(q => [q.id, q]));
    const respMap = Object.fromEntries((rows || []).map(r => [r.id, r]));

    const extractedQuotes = [];
    const keywordFreq = {};
    const categoryCounts = { all: 0, positive: 0, suggestion: 0, competitive: 0 };

    // 1. Scan direct text answers (Q4, Q5 remarks, other text inputs)
    for (const a of answers) {
      if (!respMap[a.response_id]) continue;
      const resp = respMap[a.response_id];
      const q = qMap[a.question_id];
      const ansJson = a.answer_json || {};

      const candidateTexts = [];
      if (ansJson.text) candidateTexts.push(ansJson.text);
      if (ansJson.comment) candidateTexts.push(ansJson.comment);
      if (ansJson.other) candidateTexts.push(ansJson.other);
      if (typeof ansJson === "string") candidateTexts.push(ansJson);

      for (const rawText of candidateTexts) {
        if (!rawText || typeof rawText !== "string") continue;
        const cleanText = rawText.trim();
        if (cleanText.length < 2) continue;

        // Categorize sentiment
        let category = "positive";
        if (/(อยากให้|ควร|ขอ|ปรับปรุง|เพิ่ม|ปัญหา|ช้า|แพง|แถม|โปรโมชั่น)/i.test(cleanText)) {
          category = "suggestion";
        } else if (/(คู่แข่ง|แบรนด์อื่น|เทียบกับ|ดีกว่า|สู้ได้)/i.test(cleanText)) {
          category = "competitive";
        }

        extractedQuotes.push({
          id: a.id || Math.random().toString(),
          responseId: a.response_id,
          text: cleanText,
          category: category,
          clientName: resp.client_name || (resp.respondent_type === "farmer" ? "เกษตรกร" : "ร้านค้าตัวแทน"),
          province: resp.province || "",
          productName: resp.product_name || "สินค้าตราต้นไม้",
          salesName: resp.salesperson_name || "-",
          respondentType: resp.respondent_type || "dealer",
          npsScore: resp.nps_score ?? null,
          submittedAt: resp.submitted_at ? PVT.formatDateTime(resp.submitted_at) : "",
          matchedKeywords: []
        });
      }
    }

    // 2. Also incorporate selections from structured multi-choice options to enrich word frequency
    for (const a of answers) {
      if (!respMap[a.response_id]) continue;
      const ansJson = a.answer_json || {};
      const selected = Array.isArray(ansJson.selected) ? ansJson.selected : (ansJson.selected ? [ansJson.selected] : []);
      for (const optId of selected) {
        const opt = oMap[optId];
        if (opt && opt.option_text) {
          const optText = opt.option_text.trim();
          // Extract meaningful keywords from choice text
          for (const phrase of DOMAIN_PHRASES) {
            if (phrase.pattern.test(optText)) {
              const kw = phrase.keyword;
              if (!keywordFreq[kw]) {
                keywordFreq[kw] = {
                  keyword: kw,
                  count: 0,
                  type: phrase.type,
                  label: phrase.label,
                  weight: phrase.weight
                };
              }
              keywordFreq[kw].count += 1;
            }
          }
        }
      }
    }

    // 3. Scan quotes for phrase and keyword occurrences
    extractedQuotes.forEach(quote => {
      categoryCounts.all++;
      categoryCounts[quote.category] = (categoryCounts[quote.category] || 0) + 1;

      // Match domain phrases
      DOMAIN_PHRASES.forEach(phrase => {
        if (phrase.pattern.test(quote.text)) {
          quote.matchedKeywords.push(phrase.keyword);
          const kw = phrase.keyword;
          if (!keywordFreq[kw]) {
            keywordFreq[kw] = {
              keyword: kw,
              count: 0,
              type: phrase.type,
              label: phrase.label,
              weight: phrase.weight
            };
          }
          keywordFreq[kw].count += 2; // Extra weight for text mentions
        }
      });

      // Simple word tokenization for fallback tags
      const words = quote.text.split(/[\s,./()—\-+:]+/);
      words.forEach(w => {
        const cw = w.trim().toLowerCase();
        if (cw.length >= 3 && !STOPWORDS.has(cw) && !/^\d+$/.test(cw)) {
          if (!keywordFreq[cw]) {
            keywordFreq[cw] = {
              keyword: cw,
              count: 0,
              type: quote.category === "suggestion" ? "suggestion" : "positive",
              label: cw,
              weight: 1
            };
          }
          keywordFreq[cw].count += 1;
        }
      });
    });

    // 4. Transform keyword frequencies into sorted list
    const sortedKeywords = Object.values(keywordFreq)
      .filter(k => k.count >= 1)
      .sort((a, b) => b.count - a.count)
      .slice(0, 32);

    // Compute relative word cloud sizes (1 to 5 scale)
    const maxCount = sortedKeywords.length > 0 ? sortedKeywords[0].count : 1;
    const minCount = sortedKeywords.length > 0 ? sortedKeywords[sortedKeywords.length - 1].count : 1;

    sortedKeywords.forEach(k => {
      if (maxCount === minCount) {
        k.sizeRank = 3;
      } else {
        const normalized = (k.count - minCount) / (maxCount - minCount);
        k.sizeRank = Math.min(5, Math.max(1, Math.round(normalized * 4) + 1));
      }
    });

    return {
      quotes: extractedQuotes,
      keywords: sortedKeywords,
      categoryCounts: categoryCounts,
      totalQuotes: extractedQuotes.length
    };
  }

  /**
   * Build or retrieve the Insights Modal DOM
   */
  function ensureInsightsModalDOM() {
    if (document.getElementById("pvt-insights-modal-backdrop")) {
      _insightsBackdrop = document.getElementById("pvt-insights-modal-backdrop");
      return _insightsBackdrop;
    }

    const backdrop = document.createElement("div");
    backdrop.id = "pvt-insights-modal-backdrop";
    backdrop.className = "modal-backdrop hidden";
    backdrop.setAttribute("role", "dialog");
    backdrop.setAttribute("aria-modal", "true");
    backdrop.setAttribute("aria-labelledby", "insights-modal-title");

    backdrop.innerHTML = `
      <div class="modal pvt-insights-modal">
        <!-- Header -->
        <div class="insights-modal-header">
          <div style="display:flex;align-items:center;gap:10px;min-width:0;flex:1">
            <div class="insights-header-icon">
              <svg class="pvt-icon" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/><polyline points="3.27 6.96 12 12.01 20.73 6.96"/><line x1="12" y1="22.08" x2="12" y2="12"/></svg>
            </div>
            <div style="min-width:0">
              <div style="display:flex;align-items:center;gap:8px;flex-wrap:wrap">
                <h3 id="insights-modal-title" style="margin:0;font-size:18px;font-weight:850;color:#0c3622">
                  Qualitative Text & Voice of Customer Insights
                </h3>
                <span id="insights-kpi-source-badge" class="pill success" style="font-size:11.5px;font-weight:750">
                  Total Responses
                </span>
              </div>
              <p id="insights-modal-subtitle" class="muted small" style="margin:2px 0 0">
                ประมวลผลคำสำคัญ (Trending Keywords), กลุ่มคำยอดนิยม (Word Cloud) และข้อเสนอแนะจริงจากลูกค้า
              </p>
            </div>
          </div>
          <button id="close-insights-modal" class="btn btn-outline btn-sm" aria-label="ปิดหน้าต่าง" style="padding:6px 10px">
            <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
          </button>
        </div>

        <!-- Body -->
        <div class="insights-modal-body">
          
          <!-- Top Stat Metrics Bar inside Modal -->
          <div class="insights-stats-bar">
            <div class="insights-stat-box">
              <span class="insights-stat-num" id="insights-stat-total-comments">0</span>
              <span class="insights-stat-label">ข้อความความคิดเห็น/ข้อเสนอแนะ</span>
            </div>
            <div class="insights-stat-box">
              <span class="insights-stat-num text-success" id="insights-stat-positive-count">0</span>
              <span class="insights-stat-label">จุดเด่นที่ชื่นชอบ (Key Strengths)</span>
            </div>
            <div class="insights-stat-box">
              <span class="insights-stat-num text-warning" id="insights-stat-suggest-count">0</span>
              <span class="insights-stat-label">สิ่งที่อยากให้พัฒนา (Suggestions)</span>
            </div>
            <div class="insights-stat-box">
              <span class="insights-stat-num text-brand" id="insights-stat-keywords-count">0</span>
              <span class="insights-stat-label">คำสำคัญที่ถูกวิเคราะห์</span>
            </div>
          </div>

          <!-- Section 1: Interactive Word Cloud & Key Trends -->
          <div class="insights-section-card">
            <div class="insights-section-header">
              <div style="display:flex;align-items:center;gap:6px">
                <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="color:var(--brand)"><path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
                <h4 style="margin:0;font-size:14px;font-weight:800;color:#13442c">Word Cloud — คำและประเด็นที่ถูกกล่าวถึงบ่อยที่สุด</h4>
              </div>
              <span class="small muted">คลิกที่คำสำคัญเพื่อกรองข้อความความคิดเห็นด้านล่าง</span>
            </div>
            <div id="insights-word-cloud-container" class="insights-word-cloud">
              <!-- Populated by JS -->
            </div>
          </div>

          <!-- Section 2: Top Trending Keywords Bar -->
          <div class="insights-section-card">
            <div class="insights-section-header">
              <div style="display:flex;align-items:center;gap:6px">
                <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="color:var(--brand)"><polyline points="22 7 13.5 15.5 8.5 10.5 2 17"/><polyline points="16 7 22 7 22 13"/></svg>
                <h4 style="margin:0;font-size:14px;font-weight:800;color:#13442c">Top-Trending Keywords (ความถี่สูงสุด)</h4>
              </div>
              <div id="insights-active-keyword-filter" class="pill" style="display:none;font-size:11px;background:#e9f6ef;color:#0f5132;font-weight:750">
                กำลังกรอง: <b id="insights-active-keyword-name"></b>
                <button id="insights-clear-keyword-btn" style="background:none;border:none;cursor:pointer;padding:0 0 0 4px;color:#0f5132;font-weight:800">&times;</button>
              </div>
            </div>
            <div id="insights-keyword-bars-container" class="insights-keyword-bars">
              <!-- Populated by JS -->
            </div>
          </div>

          <!-- Section 3: Customer Quotes & Verbatim Feedback Stream -->
          <div class="insights-section-card">
            <div class="insights-quotes-header">
              <div style="display:flex;align-items:center;gap:8px">
                <svg class="pvt-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="color:var(--brand)"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                <h4 style="margin:0;font-size:14px;font-weight:800;color:#13442c">เสียงตอบรับจริงจากลูกค้า (Customer Verbatim Feed)</h4>
                <span id="insights-filtered-quote-count" class="pill" style="font-size:11.5px">0 รายการ</span>
              </div>
              <!-- Category Filter Buttons -->
              <div class="insights-filter-group">
                <button class="insights-filter-btn active" data-quote-category="all">ทั้งหมด</button>
                <button class="insights-filter-btn" data-quote-category="positive">จุดเด่นที่ชอบ</button>
                <button class="insights-filter-btn" data-quote-category="suggestion">ข้อเสนอแนะ/คำแนะนำ</button>
                <button class="insights-filter-btn" data-quote-category="competitive">เปรียบเทียบคู่แข่ง</button>
              </div>
            </div>

            <!-- Quotes List -->
            <div id="insights-quotes-list" class="insights-quotes-list">
              <!-- Populated by JS -->
            </div>
          </div>

        </div>

        <!-- Footer -->
        <div class="insights-modal-footer">
          <div class="small muted" style="display:inline-flex;align-items:center;gap:6px">
            <svg class="pvt-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>
            <span>ข้อมูลสรุปจากการวิเคราะห์คำตอบแบบสอบถามจริงในระบบ (Qualitative Text Analysis)</span>
          </div>
          <button id="close-insights-modal-btn" class="btn btn-primary btn-sm">
            ปิดหน้าต่าง Insights
          </button>
        </div>
      </div>
    `;

    document.body.appendChild(backdrop);
    _insightsBackdrop = backdrop;

    // Bind event handlers
    const closeBtn1 = backdrop.querySelector("#close-insights-modal");
    const closeBtn2 = backdrop.querySelector("#close-insights-modal-btn");
    const clearKwBtn = backdrop.querySelector("#insights-clear-keyword-btn");

    if (closeBtn1) closeBtn1.addEventListener("click", closeInsightsModal);
    if (closeBtn2) closeBtn2.addEventListener("click", closeInsightsModal);
    if (clearKwBtn) clearKwBtn.addEventListener("click", () => {
      _activeKeyword = "";
      renderQuotesView();
      renderWordCloudView();
      renderKeywordBarsView();
    });

    backdrop.addEventListener("click", (e) => {
      if (e.target.id === "pvt-insights-modal-backdrop") {
        closeInsightsModal();
      }
    });

    // Category filter tabs
    backdrop.querySelectorAll(".insights-filter-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        backdrop.querySelectorAll(".insights-filter-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
        _activeFilterCategory = btn.dataset.quoteCategory || "all";
        renderQuotesView();
      });
    });

    return backdrop;
  }

  function closeInsightsModal() {
    if (_insightsBackdrop) {
      _insightsBackdrop.classList.add("hidden");
    }
  }

  /**
   * Render the Word Cloud visually
   */
  function renderWordCloudView() {
    if (!_cachedData || !_insightsBackdrop) return;
    const container = _insightsBackdrop.querySelector("#insights-word-cloud-container");
    if (!container) return;

    const keywords = _cachedData.keywords || [];
    if (!keywords.length) {
      container.innerHTML = `<div class="empty" style="padding:24px 0;text-align:center;width:100%">ยังไม่มีข้อมูลข้อความคำตอบเพียงพอสำหรับการสร้าง Word Cloud</div>`;
      return;
    }

    container.innerHTML = keywords.map(kw => {
      const isSelected = _activeKeyword === kw.keyword;
      const typeClass = kw.type === "suggestion" ? "cloud-tag-suggestion" : (kw.type === "competitive" ? "cloud-tag-comp" : "cloud-tag-pos");
      const sizeClass = `cloud-size-${kw.sizeRank || 3}`;
      const activeClass = isSelected ? "cloud-tag-active" : "";

      return `
        <button type="button" class="insights-cloud-tag ${typeClass} ${sizeClass} ${activeClass}" data-cloud-kw="${PVT.escapeHtml(kw.keyword)}" title="กล่าวถึง ${kw.count} ครั้ง">
          <span>${PVT.escapeHtml(kw.keyword)}</span>
          <small class="cloud-count">${kw.count}</small>
        </button>
      `;
    }).join("");

    // Attach click events to cloud tags
    container.querySelectorAll("[data-cloud-kw]").forEach(btn => {
      btn.addEventListener("click", () => {
        const kw = btn.dataset.cloudKw;
        if (_activeKeyword === kw) {
          _activeKeyword = "";
        } else {
          _activeKeyword = kw;
        }
        renderWordCloudView();
        renderKeywordBarsView();
        renderQuotesView();
      });
    });
  }

  /**
   * Render Top-Trending Keyword Progress Bars
   */
  function renderKeywordBarsView() {
    if (!_cachedData || !_insightsBackdrop) return;
    const container = _insightsBackdrop.querySelector("#insights-keyword-bars-container");
    const activeBadge = _insightsBackdrop.querySelector("#insights-active-keyword-filter");
    const activeName = _insightsBackdrop.querySelector("#insights-active-keyword-name");
    if (!container) return;

    if (activeBadge && activeName) {
      if (_activeKeyword) {
        activeBadge.style.display = "inline-flex";
        activeName.textContent = _activeKeyword;
      } else {
        activeBadge.style.display = "none";
      }
    }

    const topKeywords = (_cachedData.keywords || []).slice(0, 8);
    if (!topKeywords.length) {
      container.innerHTML = `<div class="empty" style="padding:16px 0;text-align:center">ยังไม่มีข้อมูลคำสำคัญ</div>`;
      return;
    }

    const maxCount = topKeywords[0].count || 1;

    container.innerHTML = topKeywords.map(kw => {
      const isSelected = _activeKeyword === kw.keyword;
      const pct = Math.round((kw.count / maxCount) * 100);
      const barColor = kw.type === "suggestion" ? "linear-gradient(90deg,#f59e0b,#d97706)" : "linear-gradient(90deg,#166534,#22c55e)";
      const borderClass = isSelected ? "keyword-bar-row-active" : "";

      return `
        <div class="keyword-bar-row ${borderClass}" data-bar-kw="${PVT.escapeHtml(kw.keyword)}">
          <div class="keyword-bar-info">
            <span class="keyword-bar-title">${PVT.escapeHtml(kw.label || kw.keyword)}</span>
            <div class="keyword-bar-val">
              <span class="pill ${kw.type === 'suggestion' ? 'warning' : 'success'}" style="font-size:11px;font-weight:750">
                ${kw.count} ครั้ง
              </span>
            </div>
          </div>
          <div class="dist-bar" style="height:7px;background:#e3eee7;border-radius:99px">
            <div class="dist-bar-fill" style="width:${pct}%;background:${barColor};border-radius:99px"></div>
          </div>
        </div>
      `;
    }).join("");

    container.querySelectorAll("[data-bar-kw]").forEach(row => {
      row.addEventListener("click", () => {
        const kw = row.dataset.barKw;
        _activeKeyword = (_activeKeyword === kw) ? "" : kw;
        renderWordCloudView();
        renderKeywordBarsView();
        renderQuotesView();
      });
    });
  }

  /**
   * Render Quotes list with active category and keyword filter
   */
  function renderQuotesView() {
    if (!_cachedData || !_insightsBackdrop) return;
    const container = _insightsBackdrop.querySelector("#insights-quotes-list");
    const countBadge = _insightsBackdrop.querySelector("#insights-filtered-quote-count");
    if (!container) return;

    let filtered = _cachedData.quotes || [];

    // Filter by category
    if (_activeFilterCategory !== "all") {
      filtered = filtered.filter(q => q.category === _activeFilterCategory);
    }

    // Filter by keyword if selected
    if (_activeKeyword) {
      const searchKw = _activeKeyword.toLowerCase();
      filtered = filtered.filter(q => {
        return q.text.toLowerCase().includes(searchKw) || (q.matchedKeywords || []).some(k => k.toLowerCase() === searchKw);
      });
    }

    if (countBadge) {
      countBadge.textContent = `${filtered.length.toLocaleString()} รายการ`;
    }

    if (!filtered.length) {
      container.innerHTML = `
        <div class="empty" style="padding:28px 20px;text-align:center">
          <div style="font-size:14px;color:#334155;font-weight:600;margin-bottom:4px">ไม่พบข้อความความคิดเห็นตามเงื่อนไขที่เลือก</div>
          <div class="small muted">ลองเลือกหมวดหมู่อื่น หรือยกเลิกการกรองคำสำคัญด้านบน</div>
        </div>
      `;
      return;
    }

    container.innerHTML = filtered.map(quote => {
      const badgeType = quote.category === "suggestion" ? "warning" : (quote.category === "competitive" ? "info" : "success");
      const badgeText = quote.category === "suggestion" ? "ข้อเสนอแนะ" : (quote.category === "competitive" ? "เปรียบเทียบคู่แข่ง" : "จุดเด่นที่ประทับใจ");
      const respBadge = quote.respondentType === "farmer" ? "เกษตรกร" : "ร้านค้า";
      const scoreBadge = quote.npsScore ? `<span class="pill success" style="font-size:11px">คะแนน: ${quote.npsScore} ★</span>` : "";

      // Highlight active keyword if present
      let displayText = PVT.escapeHtml(quote.text);
      if (_activeKeyword) {
        const regex = new RegExp(`(${_activeKeyword.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')})`, "gi");
        displayText = displayText.replace(regex, `<mark class="insights-highlight">$1</mark>`);
      }

      return `
        <div class="insights-quote-card ${quote.category === 'suggestion' ? 'quote-card-suggestion' : ''}">
          <div class="insights-quote-top">
            <div style="display:flex;align-items:center;gap:6px;flex-wrap:wrap">
              <span class="pill ${badgeType}" style="font-size:11px;font-weight:750">${badgeText}</span>
              <span class="pill" style="font-size:11px;background:#f1f5f9;color:#334155;border:1px solid #e2e8f0">${respBadge}</span>
              ${scoreBadge}
            </div>
            <span class="small muted">${PVT.escapeHtml(quote.submittedAt)}</span>
          </div>

          <div class="insights-quote-text">
            “${displayText}”
          </div>

          <div class="insights-quote-footer">
            <div style="display:flex;align-items:center;gap:6px;min-width:0">
              <span style="font-weight:750;color:#0d462b;font-size:12.5px;display:inline-flex;align-items:center;gap:4px;" title="${PVT.escapeHtml(quote.clientName)}">
                <svg class="pvt-icon" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="color:#0d462b;"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg> ${PVT.escapeHtml(quote.clientName)}
              </span>
              ${quote.province ? `<span class="small muted">(${PVT.escapeHtml(quote.province)})</span>` : ''}
            </div>
            <div style="display:flex;align-items:center;gap:8px">
              <span class="small muted" style="font-size:11.5px">สินค้า: <b>${PVT.escapeHtml(quote.productName)}</b></span>
              <span class="small muted" style="font-size:11.5px">• เซลล์: ${PVT.escapeHtml(quote.salesName)}</span>
            </div>
          </div>
        </div>
      `;
    }).join("");
  }

  /**
   * Public API to open the Insights Modal
   * @param {Object} options - { title, source, rows, answers, questions, options }
   */
  function openInsightsModal(options = {}) {
    const backdrop = ensureInsightsModalDOM();

    const titleEl = backdrop.querySelector("#insights-modal-title");
    const badgeEl = backdrop.querySelector("#insights-kpi-source-badge");

    if (titleEl && options.title) {
      titleEl.textContent = options.title;
    }
    if (badgeEl && options.source) {
      badgeEl.textContent = options.source;
    }

    const rows = options.rows || window.A_RESPONSES || [];
    const answers = options.answers || window.A_ANSWERS || [];
    const questions = options.questions || window.A_QUESTIONS || [];
    const optList = options.options || window.A_OPTIONS || [];

    // Analyze data
    _cachedData = analyzeQualitativeResponses(rows, answers, questions, optList);
    _activeFilterCategory = "all";
    _activeKeyword = "";

    // Reset filter buttons
    backdrop.querySelectorAll(".insights-filter-btn").forEach(btn => {
      btn.classList.toggle("active", btn.dataset.quoteCategory === "all");
    });

    // Populate Top Stats
    const totEl = backdrop.querySelector("#insights-stat-total-comments");
    const posEl = backdrop.querySelector("#insights-stat-positive-count");
    const sugEl = backdrop.querySelector("#insights-stat-suggest-count");
    const kwEl = backdrop.querySelector("#insights-stat-keywords-count");

    if (totEl) totEl.textContent = _cachedData.totalQuotes.toLocaleString();
    if (posEl) posEl.textContent = (_cachedData.categoryCounts.positive || 0).toLocaleString();
    if (sugEl) sugEl.textContent = (_cachedData.categoryCounts.suggestion || 0).toLocaleString();
    if (kwEl) kwEl.textContent = (_cachedData.keywords.length || 0).toLocaleString();

    // Render Subviews
    renderWordCloudView();
    renderKeywordBarsView();
    renderQuotesView();

    // Show modal
    backdrop.classList.remove("hidden");
  }

  // Export globally under PVT namespace
  window.PVT = window.PVT || {};
  window.PVT.openInsightsModal = openInsightsModal;
  window.PVT.closeInsightsModal = closeInsightsModal;
  window.PVT.analyzeQualitativeResponses = analyzeQualitativeResponses;

})();
