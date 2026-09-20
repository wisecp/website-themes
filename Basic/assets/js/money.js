/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
function money_deformatter(r=""){if(r==="")return 0;let n=String(r).trim().charAt(0)==="-",i=r.replace(/([^0-9\.,])/gi,""),t=r.replace(/([^0-9])/gi,""),s=i.length-t.length-1,o=i.replace(/([,\.])/g,function(l,u,d,e){return s>0?(s--,""):l}).replace(/(\.|,)(?=[0-9]{3,}$)/,""),a=parseFloat(o.replace(",","."));return n?-Math.abs(a||0):a||0}function money_formatter(r=0,n="USD",i=!0){currency_formats[n]||(n="USD");const t=currency_formats[n],s=Math.max(t.lastIndexOf(","),t.lastIndexOf(".")),m=s===-1?"":t.slice(s+1).replace(/[^0-9]/g,"");let o,a,l;if(s===-1)o=".",a="",l=!0;else if(m.length===2){o=t.charAt(s);const c=t.substring(0,s);a=c.includes(".")?".":c.includes(",")?",":"",l=!1}else a=t.charAt(s),o=a==="."?",":".",l=!0;const u=typeof currency_digits<"u"&&currency_digits&&currency_digits[n]!=null?Number(currency_digits[n]):2,d=Number.isInteger(u)&&u>=0?u:2;let e=d===0?String(Math.trunc(Math.abs(r))):Math.abs(r).toFixed(d),[f,g]=e.split(".");a&&(f=f.replace(/\B(?=(\d{3})+(?!\d))/g,a)),e=g===void 0||l&&g==="00"?f:f+o+g;let b=r<0&&/[1-9]/.test(e);if(i){const c=t.replace(/[0-9\.,]/g,"");if(c){const p=t.indexOf(c);p===0?e=c+e:t.substring(0,p).endsWith(" ")?e=e+" "+c.trim():e=e+c}}return b&&(e="-"+e),e}function money_exChange(r,n,i){return!currency_rates[n]||!currency_rates[i]?(console.error("Currency not supported:",n,i),r):r/currency_rates[n]*currency_rates[i]}
