/**
 * pdf-report.js
 * Generates an executive PDF report document formatted for A4 printing / saving as PDF.
 * Includes Top KPI metrics, Customer Voice, Coverage statistics, Top Rated Products,
 * and the latest Word Cloud Insights & Key Trending Keywords.
 */

(function () {
  "use strict";

  function generatePdfReport(data = {}) {
    const {
      title = "รายงานสรุปผลการสำรวจความพึงพอใจลูกค้าและสินค้า",
      subtitle = "ผลิตภัณฑ์พลาสติกการเกษตรตราต้นไม้ • Executive Survey Summary & Insights",
      generatedAt = PVT.formatDateTime(new Date().toISOString()),
      filterLabel = "ข้อมูลภาพรวมทั้งหมด",
      responses = [],
      products = [],
      salesList = [],
      customers = [],
      qualitativeData = null
    } = data;

    const totalResponses = responses.length;
    const uniqueShops = new Set(responses.map(r => r.customer_id).filter(Boolean)).size;
    const totalCustomers = customers.length || 1;
    const coveragePct = ((uniqueShops / totalCustomers) * 100).toFixed(1);

    const scores = responses.map(r => r.nps_score).filter(Number.isFinite);
    const avgScore = scores.length ? (scores.reduce((a, b) => a + b, 0) / scores.length).toFixed(2) : "0.00";
    const promoterCount = scores.filter(s => s >= 4).length;
    const promoterPct = scores.length ? Math.round((promoterCount / scores.length) * 100) : 0;
    const passCount = scores.filter(s => s === 3).length;
    const passPct = scores.length ? Math.round((passCount / scores.length) * 100) : 0;
    const detractorCount = scores.filter(s => s <= 2).length;
    const detractorPct = scores.length ? Math.round((detractorCount / scores.length) * 100) : 0;

    const dealerCount = responses.filter(r => !r.respondent_type || r.respondent_type === "dealer").length;
    const farmerCount = responses.filter(r => r.respondent_type === "farmer").length;

    // Product score aggregation
    const prodMap = new Map();
    products.forEach(p => {
      prodMap.set(p.id, { id: p.id, name: p.name_th, code: p.code, scores: [], count: 0 });
    });
    responses.forEach(r => {
      if (r.product_id && prodMap.has(r.product_id)) {
        const item = prodMap.get(r.product_id);
        item.count++;
        if (typeof r.nps_score === "number") item.scores.push(r.nps_score);
      }
    });

    const rankedProducts = Array.from(prodMap.values())
      .filter(p => p.count > 0)
      .map(p => ({
        ...p,
        avg: p.scores.length ? (p.scores.reduce((a, b) => a + b, 0) / p.scores.length) : 0
      }))
      .sort((a, b) => b.avg - a.avg || b.count - a.count);

    // Qualitative keywords and word cloud
    const qual = qualitativeData || { keywords: [], quotes: [], categoryCounts: {} };
    const keywords = qual.keywords || [];
    const topKeywords = keywords.slice(0, 12);
    const topQuotes = (qual.quotes || []).slice(0, 6);

    // Build standalone printable HTML document
    const printWindow = window.open("", "_blank");
    if (!printWindow) {
      PVT.toast("กรุณาอนุญาตป๊อปอัป (Popup) เพื่อเปิดหน้ารายงาน PDF", "warning");
      return;
    }

    const htmlContent = `<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <title>PVT_Survey_Executive_Report_${new Date().toISOString().slice(0,10)}</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    @page {
      size: A4 portrait;
      margin: 14mm 12mm 14mm 12mm;
    }
    *, *::before, *::after {
      box-sizing: border-box;
      -webkit-print-color-adjust: exact !important;
      print-color-adjust: exact !important;
    }
    body {
      font-family: 'Kanit', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      margin: 0;
      padding: 0;
      background: #ffffff;
      color: #0f172a;
      font-size: 13px;
      line-height: 1.45;
    }
    .print-actions-bar {
      background: #0284c7;
      color: #ffffff;
      padding: 12px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: sticky;
      top: 0;
      z-index: 100;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    .btn-print {
      background: #ffffff;
      color: #0284c7;
      font-weight: 800;
      border: none;
      padding: 8px 18px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 13.5px;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
    .btn-print:hover {
      background: #f0f9ff;
    }
    .btn-close {
      background: transparent;
      color: #bae6fd;
      border: 1px solid rgba(255,255,255,0.4);
      padding: 7px 14px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 13px;
    }
    .btn-close:hover {
      background: rgba(255,255,255,0.1);
      color: #fff;
    }
    @media print {
      .print-actions-bar { display: none !important; }
      body { background: transparent; }
      .page-container { padding: 0 !important; max-width: 100% !important; }
      .page-break { page-break-before: always; }
    }
    .page-container {
      max-width: 820px;
      margin: 0 auto;
      padding: 24px 20px;
    }
    /* Header */
    .report-header {
      border-bottom: 2px solid #0284c7;
      padding-bottom: 14px;
      margin-bottom: 18px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
    }
    .brand-title {
      font-size: 20px;
      font-weight: 850;
      color: #0284c7;
      margin: 0 0 3px;
    }
    .brand-sub {
      font-size: 12px;
      color: #475569;
      margin: 0;
    }
    .header-meta {
      text-align: right;
      font-size: 11.5px;
      color: #475569;
    }
    .header-badge {
      display: inline-block;
      background: #f0f9ff;
      color: #0284c7;
      font-weight: 750;
      padding: 3px 8px;
      border-radius: 6px;
      margin-top: 4px;
      font-size: 11px;
      border: 1px solid #bae6fd;
    }
    /* KPI Cards */
    .kpi-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 10px;
      margin-bottom: 18px;
    }
    .kpi-box {
      border: 1px solid #e2e8f0;
      border-radius: 10px;
      padding: 10px 12px;
      background: #f8fafc;
    }
    .kpi-num {
      font-size: 22px;
      font-weight: 850;
      color: #0284c7;
      line-height: 1.1;
      margin-bottom: 3px;
    }
    .kpi-label {
      font-size: 11px;
      color: #475569;
      font-weight: 600;
    }
    .kpi-sub {
      font-size: 10.5px;
      color: #64748b;
      margin-top: 3px;
    }
    /* Section Styles */
    .section-card {
      border: 1px solid #e2e8f0;
      border-radius: 10px;
      padding: 14px;
      background: #ffffff;
      margin-bottom: 16px;
    }
    .section-title {
      font-size: 13.5px;
      font-weight: 800;
      color: #0369a1;
      margin: 0 0 10px;
      padding-bottom: 6px;
      border-bottom: 1px solid #f1f5f9;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    /* Word Cloud & Keywords */
    .word-cloud-box {
      display: flex;
      flex-wrap: wrap;
      gap: 7px;
      justify-content: center;
      align-items: center;
      padding: 14px 10px;
      background: #f8fafc;
      border-radius: 8px;
      border: 1px dashed #bae6fd;
      margin-bottom: 12px;
    }
    .cloud-pill {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      padding: 4px 10px;
      border-radius: 99px;
      font-weight: 750;
      white-space: nowrap;
    }
    .cloud-pos {
      background: #f0f9ff;
      color: #0369a1;
      border: 1px solid #bae6fd;
    }
    .cloud-sug {
      background: #fff8e6;
      color: #92400e;
      border: 1px solid #fde68a;
    }
    .keyword-list-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 8px;
    }
    .keyword-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 6px 10px;
      border-radius: 6px;
      background: #f8fafc;
      border: 1px solid #e2e8f0;
      font-size: 11.5px;
    }
    .keyword-name {
      font-weight: 700;
      color: #0f172a;
    }
    .keyword-count {
      font-weight: 800;
      color: #0284c7;
      background: #e0f2fe;
      padding: 2px 7px;
      border-radius: 99px;
      font-size: 10.5px;
    }
    /* Tables */
    .report-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 11.5px;
    }
    .report-table th, .report-table td {
      padding: 7px 9px;
      text-align: left;
      border-bottom: 1px solid #cbd5e1;
    }
    .report-table th {
      background: #f1f5f9;
      font-weight: 750;
      color: #0f172a;
    }
    /* Verbatim Quotes */
    .quote-item {
      padding: 8px 10px;
      background: #f8fafc;
      border-left: 3.5px solid #0284c7;
      border-radius: 4px;
      margin-bottom: 7px;
      font-size: 11.5px;
    }
    .quote-item.quote-sug {
      border-left-color: #d97706;
      background: #fffdfa;
    }
    .quote-text {
      color: #1e293b;
      margin-bottom: 3px;
      font-style: italic;
    }
    .quote-author {
      font-size: 10.5px;
      color: #64748b;
      display: flex;
      justify-content: space-between;
    }
    /* Footer */
    .report-footer {
      margin-top: 20px;
      padding-top: 10px;
      border-top: 1px solid #dce8e1;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 10.5px;
      color: #7b8f84;
    }
  </style>
</head>
<body>
  <div class="print-actions-bar">
    <div style="display:flex;align-items:center;gap:10px">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg>
      <span style="font-weight:750;font-size:14px">Executive Survey Report Preview (พร้อมพิมพ์ / บันทึก PDF)</span>
    </div>
    <div style="display:flex;gap:10px">
      <button class="btn-print" onclick="window.print()">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="6 9 6 2 18 2 18 9"/><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/><rect x="6" y="14" width="12" height="8"/></svg>
        <span>พิมพ์ / บันทึกเป็น PDF (Print)</span>
      </button>
      <button class="btn-close" onclick="window.close()">ปิดหน้าต่าง</button>
    </div>
  </div>

  <div class="page-container">
    <!-- Header -->
    <div class="report-header">
      <div>
        <h1 class="brand-title">${PVT.escapeHtml(title)}</h1>
        <p class="brand-sub">${PVT.escapeHtml(subtitle)}</p>
      </div>
      <div class="header-meta">
        <div>วันที่ออกรายงาน: <b>${PVT.escapeHtml(generatedAt)}</b></div>
        <div class="header-badge">เงื่อนไข: ${PVT.escapeHtml(filterLabel)}</div>
      </div>
    </div>

    <!-- Top KPI Grid -->
    <div class="kpi-grid">
      <div class="kpi-box">
        <div class="kpi-num">${totalResponses.toLocaleString()}</div>
        <div class="kpi-label">จำนวนคำตอบทั้งหมด</div>
        <div class="kpi-sub">ร้านค้า ${dealerCount} • เกษตรกร ${farmerCount}</div>
      </div>
      <div class="kpi-box">
        <div class="kpi-num">${uniqueShops.toLocaleString()}</div>
        <div class="kpi-label">ร้านค้าที่มีผลสำรวจ</div>
        <div class="kpi-sub">Coverage: ${coveragePct}% (${uniqueShops}/${totalCustomers})</div>
      </div>
      <div class="kpi-box">
        <div class="kpi-num" style="color:#0284c7">${avgScore} ⭐</div>
        <div class="kpi-label">คะแนนความพึงพอใจเฉลี่ย</div>
        <div class="kpi-sub">คะแนนเต็ม 5.00 ดาว</div>
      </div>
      <div class="kpi-box">
        <div class="kpi-num" style="color:#0369a1">${promoterPct}%</div>
        <div class="kpi-label">สัดส่วน Promoter (4-5 ดาว)</div>
        <div class="kpi-sub">${promoterCount.toLocaleString()} จาก ${scores.length.toLocaleString()} ชุด</div>
      </div>
    </div>

    <!-- Section 1: Latest Word Cloud Insights -->
    <div class="section-card">
      <div class="section-title">
        <span>1. ประมวลผลคำสำคัญและกลุ่มคำยอดนิยม (Word Cloud Insights)</span>
        <small style="font-size:11px;color:#5a7366">วิเคราะห์จากข้อความความคิดเห็น ${qual.quotes.length} รายการ</small>
      </div>
      <div class="word-cloud-box">
        ${topKeywords.length > 0 ? topKeywords.map(k => {
          const cls = k.type === "suggestion" ? "cloud-sug" : "cloud-pos";
          const fs = 11 + (k.sizeRank || 2) * 2;
          return `<span class="cloud-pill ${cls}" style="font-size:${fs}px">${PVT.escapeHtml(k.keyword)} <small style="opacity:0.8;font-size:10px">(${k.count})</small></span>`;
        }).join(" ") : '<span style="color:#718096">ไม่มีข้อมูลคำสำคัญเพียงพอสำหรับการสร้าง Word Cloud</span>'}
      </div>

      <div class="keyword-list-grid">
        ${topKeywords.slice(0, 8).map(k => `
          <div class="keyword-row">
            <span class="keyword-name">${PVT.escapeHtml(k.label || k.keyword)}</span>
            <span class="keyword-count">${k.count} ครั้ง</span>
          </div>
        `).join("")}
      </div>
    </div>

    <!-- Section 2: Top-Rated Products -->
    <div class="section-card">
      <div class="section-title">
        <span>2. อันดับความพึงพอใจรายผลิตภัณฑ์ (Product Performance Ranking)</span>
      </div>
      <table class="report-table">
        <thead>
          <tr>
            <th style="width:30px">#</th>
            <th>ชื่อสินค้า</th>
            <th style="width:100px;text-align:center">จำนวนประเมิน</th>
            <th style="width:110px;text-align:center">คะแนนเฉลี่ย</th>
            <th style="width:140px">ระดับความพึงพอใจ</th>
          </tr>
        </thead>
        <tbody>
          ${rankedProducts.length > 0 ? rankedProducts.map((p, idx) => {
            const grade = p.avg >= 4.5 ? "ดีเยี่ยม (Excellent)" : (p.avg >= 3.5 ? "ดี (Good)" : "ปานกลาง (Fair)");
            return `
              <tr>
                <td><b>${idx + 1}</b></td>
                <td><b>${PVT.escapeHtml(p.name)}</b> <span style="font-size:10.5px;color:#64748b">(${PVT.escapeHtml(p.code || "-")})</span></td>
                <td style="text-align:center">${p.count} ชุด</td>
                <td style="text-align:center;font-weight:800;color:#0284c7">${p.avg.toFixed(2)} / 5.00</td>
                <td><span style="font-size:11px;font-weight:700;color:#0369a1">${grade}</span></td>
              </tr>
            `;
          }).join("") : `<tr><td colspan="5" style="text-align:center;color:#64748b;padding:12px">ยังไม่มีข้อมูลการประเมินสินค้า</td></tr>`}
        </tbody>
      </table>
    </div>

    <!-- Section 3: Customer Verbatim Quotes -->
    <div class="section-card">
      <div class="section-title">
        <span>3. ตัวอย่างข้อเสนอแนะและเสียงตอบรับจริงจากลูกค้า (Customer Feedback Stream)</span>
      </div>
      ${topQuotes.length > 0 ? topQuotes.map(q => {
        const isSug = q.category === "suggestion";
        const badge = isSug ? "ข้อเสนอแนะ" : "จุดเด่นที่ประทับใจ";
        return `
          <div class="quote-item ${isSug ? 'quote-sug' : ''}">
            <div class="quote-text">“${PVT.escapeHtml(q.text)}”</div>
            <div class="quote-author">
              <span><b>${badge}</b> • ร้านค้า: ${PVT.escapeHtml(q.clientName)} (${PVT.escapeHtml(q.province || "-")})</span>
              <span>สินค้า: <b>${PVT.escapeHtml(q.productName)}</b> • วันที่: ${PVT.escapeHtml(q.submittedAt)}</span>
            </div>
          </div>
        `;
      }).join("") : '<div style="color:#64748b;font-size:11.5px;text-align:center;padding:10px">ไม่มีข้อความความคิดเห็น</div>'}
    </div>

    <!-- Footer -->
    <div class="report-footer">
      <div>ระบบบริหารจัดการแบบสอบถามความพึงพอใจลูกค้า • บริษัท ผลิตภัณฑ์พลาสติกการเกษตรตราต้นไม้</div>
      <div>หน้า 1 / 1 • เอกสารสรุปผลสำหรับผู้บริหาร</div>
    </div>
  </div>

  <script>
    // Auto focus and encourage print
    window.addEventListener('load', () => {
      // Allow preview inspection before printing
    });
  </script>
</body>
</html>`;

    printWindow.document.open();
    printWindow.document.write(htmlContent);
    printWindow.document.close();
  }

  // Export globally under PVT namespace
  window.PVT = window.PVT || {};
  window.PVT.generatePdfReport = generatePdfReport;

})();
