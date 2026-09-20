/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
(function(){"use strict";const a=document.querySelector('.list-rows[data-noun="services"]');if(!a)return;const u=a.getAttribute("data-op-url")||"";if(!u)return;const i=document.querySelector("[data-services-page]");function w(){const t=i&&i.querySelector('input[name="token"]');return t?t.value:""}const r={on:a.getAttribute("data-txt-autorenew-on")||"Auto-Renew On",off:a.getAttribute("data-txt-autorenew-off")||"Auto-Renew Off"};function c(t,e){t.classList.toggle("is-on",e),t.setAttribute("aria-pressed",e?"true":"false");const n=t.querySelector(".list-chip-text");n&&(n.textContent=e?r.on:r.off)}function f(t,e){const n=window.Basic;t&&n&&typeof n.toast=="function"&&n.toast(t,e)}function g(t){if(t.dataset.busy==="1"||t.disabled)return;const e=t.dataset.id||"";if(!e)return;const n=t.classList.contains("is-on"),d=!n;t.dataset.busy="1",c(t,d);const o=new URLSearchParams;o.set("operation","toggle_service_autorenew"),o.set("id",e),o.set("status",d?"enable":"disable"),o.set("token",w()),fetch(u,{method:"POST",headers:{"X-Requested-With":"XMLHttpRequest","Content-Type":"application/x-www-form-urlencoded"},body:o.toString()}).then(function(s){return s.json()}).then(function(s){if(s&&s.status==="successful"){const l=!!s.autorenew;c(t,l),f(s.message,l?"success":"info")}else c(t,n),f(s&&s.message,"danger")}).catch(function(){c(t,n)}).finally(function(){t.dataset.busy="0"})}document.addEventListener("click",function(t){const e=t.target.closest('[data-action="service-autorenew"]');e&&g(e)})})();
