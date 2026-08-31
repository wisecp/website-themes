/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";const n={success:"Service renewed successfully",danger:"Payment failed - please check your card",warning:"Your domain expires in 5 days",info:"A new invoice has been generated"};document.addEventListener("click",function(s){const e=s.target.closest("[data-action]");if(e)switch(e.dataset.action){case"demo-toast":WStyle.toast(n[e.dataset.toastType]||n.success,e.dataset.toastType);break;case"demo-confirm":WStyle.confirm({title:"Cancel this service?",message:"Cloud Hosting - Pro will be cancelled at the end of the billing period.",actionText:"Cancel Service",actionVariant:"danger",onConfirm:function(){WStyle.toast("Cancellation request submitted","success")}});break;case"demo-rtl":WStyle.dir.toggle(),WStyle.toast(WStyle.dir.get()==="rtl"?"RTL preview enabled":"RTL preview disabled","info");break}});const t=document.getElementById("sc-range"),a=document.querySelector('label[for="sc-range"] .num-tabular');t&&a&&t.addEventListener("input",function(){a.textContent=t.value+" GB"})})();
