/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";(function(){var t=document.querySelector(".rs-head-actions");if(!t)return;var r=t.querySelector('[data-rs-trigger="dashboard"]'),n=t.querySelector('[data-rs-trigger="rates"]');function o(s){var a=s==="dashboard";r&&r.classList.toggle("d-none",a),n&&n.classList.toggle("d-none",!a)}t.addEventListener("shown.bs.tab",function(s){var a=s.target.getAttribute("data-rs-trigger");a&&o(a)}),o("dashboard")})(),document.addEventListener("change",function(e){if(e.target.matches('[data-action="rs-product"]')){var t=e.target.value;document.querySelectorAll("[data-rs-tiers]").forEach(function(r){r.classList.toggle("d-none",r.getAttribute("data-rs-tiers")!==t)})}})})();
