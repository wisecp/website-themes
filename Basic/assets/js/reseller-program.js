/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";document.addEventListener("click",function(c){var e=c.target.closest('[data-action="rsp-product"]');if(e){var s=e.getAttribute("data-product"),a=e.closest("[data-rsp-product-toggle]");a&&a.querySelectorAll('[data-action="rsp-product"]').forEach(function(t){var r=t===e;t.classList.toggle("active",r),t.setAttribute("aria-pressed",r?"true":"false")}),document.querySelectorAll("[data-rsp-tiers]").forEach(function(t){t.classList.toggle("d-none",t.getAttribute("data-rsp-tiers")!==s)})}})})();
