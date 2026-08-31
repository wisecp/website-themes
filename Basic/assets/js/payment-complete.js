/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";const s=new URLSearchParams(location.search).get("state");if(s==="bank-transfer"||s==="bank"){const e=document.querySelector('[data-result="success"]'),t=document.querySelector('[data-result="bank-transfer"]');e&&e.classList.add("d-none"),t&&t.classList.remove("d-none")}})();
