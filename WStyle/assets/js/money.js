/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
function money_deformatter(t=""){if(t==="")return 0;let n=String(t).trim().charAt(0)==="-",i=t.replace(/([^0-9\.,])/gi,""),s=t.replace(/([^0-9])/gi,""),e=i.length-s.length-1,o=i.replace(/([,\.])/g,function(d,r,a,u){return e>0?(e--,""):d}).replace(/(\.|,)(?=[0-9]{3,}$)/,""),c=parseFloat(o.replace(",","."));return n?-Math.abs(c||0):c||0}function money_formatter(t=0,n="USD",i=!0){const s=typeof currency_numbers<"u"&&currency_numbers?currency_numbers:{};s[n]||(n=s.USD?"USD":currency_default);const e=s[n]||{},g=Number(t)||0,o=Math.abs(g),c=Number.isInteger(e.digits)&&e.digits>=0?e.digits:2,d=e.round==="trunc"?String(Math.trunc(o)):new Intl.NumberFormat("en-US",{useGrouping:!1,minimumFractionDigits:c,maximumFractionDigits:c,roundingMode:e.round||"halfExpand"}).format(e.exact?o:e.pre?o.toPrecision(15):String(o));let[r,a]=d.split(".");a!==void 0&&e.bare&&!/[1-9]/.test(a)&&(a=void 0);const u=e.primary>0?e.primary:3,m=e.secondary>0?e.secondary:u;if(e.group&&r.length>=u+(e.min>0?e.min:1)){let f=r.slice(-u);for(r=r.slice(0,-u);r.length>m;r=r.slice(0,-m))f=r.slice(-m)+e.group+f;r=r+e.group+f}let l=a===void 0?r:r+(e.decimal||".")+a;const p=g<0&&/[1-9]/.test(l);return i&&(l=(e.left||"")+l+(e.right||"")),p?(e.minus||"-")+l:l}function money_exChange(t,n,i){return!currency_rates[n]||!currency_rates[i]?(console.error("Currency not supported:",n,i),t):t/currency_rates[n]*currency_rates[i]}
