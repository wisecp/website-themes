/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";const a=document.querySelector('.list-rows[data-noun="services"]');if(!a)return;const c=a.getAttribute("data-op-url")||"";if(!c)return;const u=document.querySelector("[data-services-page]");function g(){const t=u&&u.querySelector('input[name="token"]');return t?t.value:""}const r={on:a.getAttribute("data-txt-autorenew-on")||"Auto-Renew On",off:a.getAttribute("data-txt-autorenew-off")||"Auto-Renew Off"};function i(t,e){t.classList.toggle("is-on",e),t.setAttribute("aria-pressed",e?"true":"false");const n=t.querySelector(".list-chip-text");n&&(n.textContent=e?r.on:r.off)}function f(t,e){const n=window.Basic;t&&n&&typeof n.toast=="function"&&n.toast(t,e)}function w(t){if(t.dataset.busy==="1"||t.disabled)return;const e=t.dataset.id||"";if(!e)return;const n=t.classList.contains("is-on"),d=!n;t.dataset.busy="1",i(t,d);const s=new URLSearchParams;s.set("operation","toggle_service_autorenew"),s.set("id",e),s.set("status",d?"enable":"disable"),s.set("token",g()),fetch(c,{method:"POST",headers:{"X-Requested-With":"XMLHttpRequest","Content-Type":"application/x-www-form-urlencoded"},body:s.toString()}).then(function(o){return o.json()}).then(function(o){if(o&&o.status==="successful"){const l=!!o.autorenew;i(t,l),f(o.message,l?"success":"info")}else i(t,n),f(o&&o.message,"danger")}).catch(function(){i(t,n)}).finally(function(){t.dataset.busy="0"})}document.addEventListener("click",function(t){const e=t.target.closest('[data-action="service-autorenew"]');e&&w(e)})})();
