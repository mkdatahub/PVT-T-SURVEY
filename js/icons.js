/**
 * icons.js
 * Crisp, modern, unified SVG vector icon system for PVT Survey.
 * Replaces all emojis with clean, professional icons styled to match the theme.
 */

(function () {
  "use strict";

  window.PVT = window.PVT || {};

  const ICONS = {
    // Brand & Logo
    tree: `<path d="M12 22v-6"/><path d="M7 16l-3-1 2-3-2-2 3-1-1-3 4-1 2-3 2 3 4 1-1 3 3 1-2 2 2 3-3 1z"/>`,

    // Navigation & Roles
    user: `<path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>`,
    briefcase: `<rect width="20" height="14" x="2" y="7" rx="2" ry="2"/><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/>`,
    lock: `<rect width="18" height="11" x="3" y="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>`,
    store: `<path d="m2 7 4.41-4.41A2 2 0 0 1 7.83 2h8.34a2 2 0 0 1 1.42.59L22 7"/><path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8"/><path d="M15 22v-4a2 2 0 0 0-2-2h-2a2 2 0 0 0-2 2v4"/><path d="M2 7h20"/><path d="M22 7v3a2 2 0 0 1-2 2v0a2.7 2.7 0 0 1-1.59-.63.7.7 0 0 0-.82 0A2.7 2.7 0 0 1 16 12a2.7 2.7 0 0 1-1.59-.63.7.7 0 0 0-.82 0A2.7 2.7 0 0 1 12 12a2.7 2.7 0 0 1-1.59-.63.7.7 0 0 0-.82 0A2.7 2.7 0 0 1 8 12a2.7 2.7 0 0 1-1.59-.63.7.7 0 0 0-.82 0A2.7 2.7 0 0 1 4 12v0a2 2 0 0 1-2-2V7"/>`,
    home: `<path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/>`,
    "log-in": `<path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/><polyline points="10 17 15 12 10 7"/><line x1="15" x2="3" y1="12" y2="12"/>`,
    "log-out": `<path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/>`,
    "arrow-right": `<line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>`,
    "chevron-right": `<polyline points="9 18 15 12 9 6"/>`,

    // Actions & Tools
    eye: `<path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>`,
    edit: `<path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>`,
    clipboard: `<rect width="14" height="18" x="5" y="4" rx="2"/><path d="M9 2h6a1 1 0 0 1 1 1v1H8V3a1 1 0 0 1 1-1z"/><path d="M9 12h6"/><path d="M9 16h4"/>`,
    copy: `<rect width="14" height="14" x="8" y="8" rx="2" ry="2"/><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"/>`,
    link: `<path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/>`,
    printer: `<polyline points="6 9 6 2 18 2 18 9"/><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/><rect width="12" height="8" x="6" y="14"/>`,
    refresh: `<path d="M21 12a9 9 0 0 0-9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"/><path d="M3 3v5h5"/><path d="M3 12a9 9 0 0 0 9 9 9.75 9.75 0 0 0 6.74-2.74L21 16"/><path d="M16 16h5v5"/>`,
    download: `<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" x2="12" y1="15" y2="3"/>`,
    image: `<rect width="18" height="18" x="3" y="3" rx="2" ry="2"/><circle cx="9" cy="9" r="2"/><path d="m21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21"/>`,
    send: `<line x1="22" x2="11" y1="2" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/>`,
    search: `<circle cx="11" cy="11" r="8"/><line x1="21" x2="16.65" y1="21" y2="16.65"/>`,
    plus: `<line x1="12" x2="12" y1="5" y2="19"/><line x1="5" x2="19" y1="12" y2="12"/>`,
    "plus-circle": `<circle cx="12" cy="12" r="10"/><line x1="12" x2="12" y1="8" y2="16"/><line x1="8" x2="16" y1="12" y2="12"/>`,
    x: `<line x1="18" x2="6" y1="6" y2="18"/><line x1="6" x2="18" y1="6" y2="18"/>`,
    check: `<polyline points="20 6 9 17 4 12"/>`,
    "check-circle": `<path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/>`,

    // Indicators, Status & Analytics
    "bar-chart": `<line x1="12" x2="12" y1="20" y2="10"/><line x1="18" x2="18" y1="20" y2="4"/><line x1="6" x2="6" y1="20" y2="16"/><line x1="3" x2="21" y1="20" y2="20"/>`,
    package: `<path d="m7.5 4.27 9 5.15"/><path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/><path d="m3.3 7 8.7 5 8.7-5"/><path d="M12 22V12"/>`,
    "map-pin": `<path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="3"/>`,
    pin: `<line x1="12" x2="12" y1="17" y2="22"/><path d="M5 17h14v-1.76a2 2 0 0 0-1.11-1.79l-1.78-.9A2 2 0 0 1 15 10.76V6h1a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H8a1 1 0 0 0-1 1v2a1 1 0 0 0 1 1h1v4.76a2 2 0 0 1-1.11 1.79l-1.78.9A2 2 0 0 0 5 15.24Z"/>`,
    lightbulb: `<path d="M15 14c.2-1 .7-1.7 1.5-2.5 1-.9 1.5-2.2 1.5-3.5A6 6 0 0 0 6 8c0 1 .2 2.2 1.5 3.5.7.7 1.3 1.5 1.5 2.5"/><path d="M9 18h6"/><path d="M10 22h4"/>`,
    "message-square": `<path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>`,
    target: `<circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="6"/><circle cx="12" cy="12" r="2"/>`,
    calendar: `<rect width="18" height="18" x="3" y="4" rx="2" ry="2"/><line x1="16" x2="16" y1="2" y2="6"/><line x1="8" x2="8" y1="2" y2="6"/><line x1="3" x2="21" y1="10" y2="10"/>`,
    signal: `<path d="M2 20h.01"/><path d="M7 20v-4"/><path d="M12 20v-8"/><path d="M17 20V8"/><path d="M22 20V4"/>`,
    clock: `<circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/>`,
    star: `<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>`,
    "star-filled": `<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" fill="currentColor"/>`,

    // Agricultural Products Vector Icons
    greenhouse: `<path d="M3 10 12 3l9 7"/><path d="M4 10v11h16V10"/><path d="M9 21v-7a3 3 0 0 1 6 0v7"/><path d="M12 3v7"/>`,
    "pond-liner": `<path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z"/><path d="M6 16c2 1 4 1 6-1 2-2 4-2 6-1"/>`,
    "shade-net": `<rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18"/><path d="M3 15h18"/><path d="M9 3v18"/><path d="M15 3v18"/>`,
    "mulch-film": `<path d="M12 22V12"/><path d="M12 12C9 7 4 7 4 12c0 3 3 5 8 5"/><path d="M12 12c3-5 8-5 8 0 0 3-3 5-8 5"/>`,
    "pe-pipe": `<rect x="3" y="8" width="18" height="8" rx="3"/><path d="M7 8v8"/><path d="M17 8v8"/><line x1="3" y1="12" x2="21" y2="12" stroke-dasharray="2 2"/>`,
    "nursery-bag": `<path d="M6 11h12l-1.5 10H7.5L6 11z"/><path d="M12 11V6"/><path d="M12 6a3 3 0 0 0 3-3 3 3 0 0 0-3 3z"/><path d="M12 8a3 3 0 0 1-3-3 3 3 0 0 1 3 3z"/>`,
    "drip-tape": `<path d="M2 12h20"/><circle cx="6" cy="12" r="1.5" fill="currentColor"/><circle cx="12" cy="12" r="1.5" fill="currentColor"/><circle cx="18" cy="12" r="1.5" fill="currentColor"/><path d="M12 15c-1 1-1 2-1 2.5a1 1 0 0 0 2 0c0-.5 0-1.5-1-2.5z" fill="currentColor"/>`,
    "general-bag": `<path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/><path d="M3 6h18"/><path d="M16 10a4 4 0 0 1-8 0"/>`
  };

  /**
   * Product code to vector icon name mapping
   */
  const PRODUCT_ICON_MAP = {
    GREENHOUSE: "greenhouse",
    POND_LINER: "pond-liner",
    SHADE_NET: "shade-net",
    MULCH_FILM: "mulch-film",
    PE_PIPE: "pe-pipe",
    NURSERY_BAG: "nursery-bag",
    DRIP_TAPE: "drip-tape",
    GENERAL_BAG: "general-bag",
    GENERAL: "package"
  };

  /**
   * Generates crisp SVG icon element
   * @param {string} name - Key from ICONS dictionary
   * @param {Object} [opts] - Options: size, class, style, fill, stroke, strokeWidth
   * @returns {string} - SVG markup
   */
  function renderIcon(name, opts = {}) {
    const iconName = name ? name.toLowerCase() : "package";
    const pathData = ICONS[iconName] || ICONS["package"];
    const size = opts.size || 18;
    const cls = opts.class ? `pvt-icon pvt-icon-${iconName} ${opts.class}` : `pvt-icon pvt-icon-${iconName}`;
    const fill = opts.fill || (iconName === "star-filled" ? "currentColor" : "none");
    const stroke = opts.stroke || "currentColor";
    const strokeWidth = opts.strokeWidth || (iconName === "star-filled" ? "0" : "2.5");
    const styleAttr = opts.style ? ` style="${opts.style}"` : "";

    return `<svg class="${cls}" width="${size}" height="${size}" viewBox="0 0 24 24" fill="${fill}" stroke="${stroke}" stroke-width="${strokeWidth}" stroke-linecap="round" stroke-linejoin="round"${styleAttr} aria-hidden="true">${pathData}</svg>`;
  }

  /**
   * Generates product icon by code
   * @param {string} productCode - e.g. "GREENHOUSE", "POND_LINER"
   * @param {Object} [opts]
   */
  function renderProductIcon(productCode, opts = {}) {
    const iconKey = PRODUCT_ICON_MAP[productCode] || "package";
    return renderIcon(iconKey, opts);
  }

  /**
   * Generates star rating string with SVG stars
   * @param {number} rating - 1 to 5
   * @param {number} [max=5]
   */
  function renderStarRating(rating = 0, max = 5) {
    const num = Math.max(0, Math.min(max, Math.round(rating)));
    let html = '<span class="pvt-star-rating" style="display:inline-flex;gap:2px;vertical-align:-2px;color:#d97706">';
    for (let i = 1; i <= max; i++) {
      if (i <= num) {
        html += renderIcon("star-filled", { size: 14, class: "star-active", fill: "#f59e0b", stroke: "none" });
      } else {
        html += renderIcon("star", { size: 14, class: "star-empty", stroke: "#cbd5e1", fill: "none" });
      }
    }
    html += "</span>";
    return html;
  }

  /**
   * Replaces elements with data-icon="name" in root
   */
  function replaceIconTags(root = document) {
    if (!root) return;
    const els = root.querySelectorAll("[data-icon]");
    els.forEach((el) => {
      const name = el.dataset.icon;
      const size = el.dataset.size ? parseInt(el.dataset.size, 10) : 16;
      const cls = el.dataset.class || "";
      const style = el.dataset.style || "";
      el.innerHTML = renderIcon(name, { size, class: cls, style });
    });
  }

  // Export to window.PVT
  PVT.icon = renderIcon;
  PVT.productIcon = renderProductIcon;
  PVT.starRating = renderStarRating;
  PVT.renderIcons = replaceIconTags;
  PVT.PRODUCT_ICON_MAP = PRODUCT_ICON_MAP;

  // Auto replace on DOM load
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", () => replaceIconTags());
  } else {
    replaceIconTags();
  }
})();
