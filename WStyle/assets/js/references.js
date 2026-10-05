/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";var l=document.querySelector("[data-ref-list]");if(!l)return;var e=document.querySelector("[data-ref-filter]"),n=document.querySelector('[data-role="ref-count"]'),d=l.getAttribute("data-ref-count-all")||"Showing all {total} references",v=l.getAttribute("data-ref-count-some")||"Showing {shown} of {total} references",s=Array.prototype.slice.call(l.querySelectorAll(".reference-card")),o=s.length,i=e&&e.querySelector("[data-cat].active"),c=i?i.dataset.cat:"all";function u(){var a=0;s.forEach(function(t){var r=c==="all"||t.dataset.cat===c;t.classList.toggle("d-none",!r),r&&a++}),n&&(n.textContent=a===o?d.replace("{total}",o):v.replace("{shown}",a).replace("{total}",o))}e&&e.addEventListener("click",function(a){var t=a.target.closest("[data-cat]");!t||!e.contains(t)||(a.preventDefault(),c!==t.dataset.cat&&(c=t.dataset.cat,e.querySelectorAll("[data-cat]").forEach(function(r){var f=r===t;r.classList.toggle("active",f),r.setAttribute("aria-pressed",f?"true":"false")}),u()))}),u()})();
