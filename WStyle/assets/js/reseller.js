/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";(function(){var t=document.querySelector(".rs-head-actions");if(!t)return;var a=t.querySelector('[data-rs-trigger="dashboard"]'),e=t.querySelector('[data-rs-trigger="rates"]');function s(n){var r=n==="dashboard";a&&a.classList.toggle("d-none",r),e&&e.classList.toggle("d-none",!r)}t.addEventListener("shown.bs.tab",function(n){var r=n.target.getAttribute("data-rs-trigger");r&&s(r)}),s("dashboard")})(),document.addEventListener("change",function(t){if(t.target.matches('[data-action="rs-product"]')){var a=t.target.value;document.querySelectorAll("[data-rs-tiers]").forEach(function(e){e.classList.toggle("d-none",e.getAttribute("data-rs-tiers")!==a)})}})})();
