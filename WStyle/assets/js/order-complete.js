/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";const e=new URLSearchParams(location.search).get("state");if(e==="bank-transfer"||e==="bank"){const t=document.querySelector('[data-result="success"]'),s=document.querySelector('[data-result="bank-transfer"]');t&&t.classList.add("d-none"),s&&s.classList.remove("d-none")}})();
