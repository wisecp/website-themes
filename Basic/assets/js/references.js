/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";var r=document.querySelector("[data-ref-list]");if(!r)return;var c=document.querySelector("[data-ref-filter]"),n=document.querySelector('[data-role="ref-count"]'),f=r.getAttribute("data-ref-count-all")||"Showing all {total} references",d=r.getAttribute("data-ref-count-some")||"Showing {shown} of {total} references",s=Array.prototype.slice.call(r.querySelectorAll(".reference-card")),o=s.length,l="all";function u(){var e=0;s.forEach(function(t){var a=l==="all"||t.dataset.cat===l;t.classList.toggle("d-none",!a),a&&e++}),n&&(n.textContent=e===o?f.replace("{total}",o):d.replace("{shown}",e).replace("{total}",o))}c&&c.addEventListener("click",function(e){var t=e.target.closest("[data-cat]");!t||!c.contains(t)||(e.preventDefault(),l!==t.dataset.cat&&(l=t.dataset.cat,c.querySelectorAll("[data-cat]").forEach(function(a){var i=a===t;a.classList.toggle("active",i),a.setAttribute("aria-pressed",i?"true":"false")}),u()))}),u()})();
