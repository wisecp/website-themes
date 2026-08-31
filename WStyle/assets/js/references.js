/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";var r=document.querySelector("[data-ref-list]");if(!r)return;var l=document.querySelector("[data-ref-filter]"),n=document.querySelector('[data-role="ref-count"]'),u=r.getAttribute("data-ref-count-all")||"Showing all {total} references",d=r.getAttribute("data-ref-count-some")||"Showing {shown} of {total} references",s=Array.prototype.slice.call(r.querySelectorAll(".reference-card")),o=s.length,c="all";function i(){var e=0;s.forEach(function(t){var a=c==="all"||t.dataset.cat===c;t.classList.toggle("d-none",!a),a&&e++}),n&&(n.textContent=e===o?u.replace("{total}",o):d.replace("{shown}",e).replace("{total}",o))}l&&l.addEventListener("click",function(e){var t=e.target.closest("[data-cat]");!t||!l.contains(t)||(e.preventDefault(),c!==t.dataset.cat&&(c=t.dataset.cat,l.querySelectorAll("[data-cat]").forEach(function(a){var f=a===t;a.classList.toggle("active",f),a.setAttribute("aria-pressed",f?"true":"false")}),i()))}),i()})();
