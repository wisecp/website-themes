/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
function money_deformatter(t=""){if(t==="")return 0;let n=String(t).trim().charAt(0)==="-",o=t.replace(/([^0-9\.,])/gi,""),e=t.replace(/([^0-9])/gi,""),a=o.length-e.length-1,c=o.replace(/([,\.])/g,function(i,r,f,u){return a>0?(a--,""):i}).replace(/(\.|,)(?=[0-9]{3,}$)/,""),s=parseFloat(c.replace(",","."));return n?-Math.abs(s||0):s||0}function money_formatter(t=0,n="USD",o=!0){currency_formats[n]||(n="USD");const e=currency_formats[n],a=Math.max(e.lastIndexOf(","),e.lastIndexOf(".")),g=a===-1?"":e.slice(a+1).replace(/[^0-9]/g,"");let c,s,i;if(a===-1)c=".",s="",i=!0;else if(g.length===2){c=e.charAt(a);const l=e.substring(0,a);s=l.includes(".")?".":l.includes(",")?",":"",i=!1}else s=e.charAt(a),c=s==="."?",":".",i=!0;let r=Math.abs(t).toFixed(2),[f,u]=r.split(".");s&&(f=f.replace(/\B(?=(\d{3})+(?!\d))/g,s)),r=i&&u==="00"?f:f+c+u;let d=t<0;if(o){const l=e.replace(/[0-9\.,]/g,"");if(l){const m=e.indexOf(l);m===0?r=l+r:e.substring(0,m).endsWith(" ")?r=r+" "+l.trim():r=r+l}}return d&&(r="-"+r),r}function money_exChange(t,n,o){return!currency_rates[n]||!currency_rates[o]?(console.error("Currency not supported:",n,o),t):t/currency_rates[n]*currency_rates[o]}
