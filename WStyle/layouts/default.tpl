{$is_client_area = $is_logged_in && !empty($show_client_subnav)}<!DOCTYPE html>
<html lang="{$ui_lang|default:'en'}" dir="{$ui_dir|default:'ltr'}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{block name=title}{$head_title|default:$page_title|default:$company_name}{/block}</title>
    {if !empty($meta_description)}<meta name="description" content="{$meta_description}">{/if}
    {if !empty($meta_keywords)}<meta name="keywords" content="{$meta_keywords}">{/if}
    {if !empty($meta_robots)}<meta name="robots" content="{$meta_robots}">{/if}
    {if !empty($canonical_link)}<link rel="canonical" href="{$canonical_link}">{/if}
    {if !empty($lang_list)}{foreach $lang_list as $l}
    <link rel="alternate" hreflang="{$l.key}" href="{$l.link}">{if $l.local}
    <link rel="alternate" hreflang="x-default" href="{$l.link}">{/if}{/foreach}
    {/if}
    <meta property="og:type" content="{$og_type|default:'website'}">
    {if !empty($company_name)}<meta property="og:site_name" content="{$company_name}">{/if}
    {if !empty($page_title)}<meta property="og:title" content="{$page_title}">{/if}
    {if !empty($meta_description)}<meta property="og:description" content="{$meta_description}">{/if}
    {if !empty($canonical_link)}<meta property="og:url" content="{$canonical_link}">{/if}
    {if !empty($light_logo_link)}<meta property="og:image" content="{$light_logo_link}">{/if}
    <meta name="twitter:card" content="summary_large_image">
    {if !empty($page_title)}<meta name="twitter:title" content="{$page_title}">{/if}
    {if !empty($meta_description)}<meta name="twitter:description" content="{$meta_description}">{/if}
    {if !empty($light_logo_link)}<meta name="twitter:image" content="{$light_logo_link}">{/if}
    {favicon}
    <script>
      var mc = document.cookie.split("; ").filter(function(c) {
        return c.indexOf("wcp_theme_mode=") === 0;
      });
      var mv = mc.length === 1 ? mc[0].slice(15) : "";
      var m = (mv === "light" || mv === "dark" || mv === "auto" ? mv : "") || localStorage.getItem("wstyle-theme-mode") || localStorage.getItem("wstyle-theme") || "light";
      var t = m === "light" || m === "dark" ? m : window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
      document.documentElement.setAttribute("data-bs-theme", t);
      try {
        localStorage.removeItem("wstyle-dir");
      } catch (e) {
      }
      if (window.IntersectionObserver && !(window.matchMedia && matchMedia("(prefers-reduced-motion: reduce)").matches)) {
        document.documentElement.classList.add("js-reveal");
        setTimeout(function() {
          var d = document.documentElement;
          if (d.hasAttribute("data-reveal-booted")) return;
          d.setAttribute("data-reveal-timeout", "1");
          d.classList.remove("js-reveal");
        }, 2500);
      }
    </script>
    <link rel="preload" href="{asset path='css/libs/bootstrap-icons/fonts/bootstrap-icons.woff2'}?e34853135f9e39acf64315236852cd5a" as="font" type="font/woff2" crossorigin>
    <link rel="stylesheet" href="{if ($ui_dir|default:'ltr') == 'rtl'}{asset path='css/bootstrap.rtl.min.css'}{else}{asset path='css/bootstrap.min.css'}{/if}" id="css-bootstrap" data-ltr="{asset path='css/bootstrap.min.css'}" data-rtl="{asset path='css/bootstrap.rtl.min.css'}">
    <link rel="stylesheet" href="{asset path='css/libs/bootstrap-icons/bootstrap-icons.min.css'}">
    <link rel="stylesheet" href="{asset path='css/libs/fontawesome/css/all.min.css'}">
    <link rel="preload" href="{asset path='css/libs/fonts/manrope/manrope-latin.woff2'}" as="font" type="font/woff2" crossorigin>
    <link rel="preload" href="{asset path='css/libs/fonts/manrope/manrope-latin-ext.woff2'}" as="font" type="font/woff2" crossorigin>
    <link rel="stylesheet" href="{asset path='css/libs/fonts/manrope.css'}">
    <link rel="stylesheet" href="{asset path='css/theme.css'}">
    <link rel="stylesheet" href="{asset path='css/default.css'}">
    <link rel="stylesheet" href="{asset path='css/default-dark.css'}">
    <link rel="stylesheet" href="{asset path='css/default.rtl.css'}">
    {if $is_client_area}<link rel="stylesheet" href="{asset path='css/client-nav.css'}">{/if}
    <style>
    :root {
        --wstyle-primary: {$setting.primary_color|default:'#095174'};
        --wstyle-primary-rgb: {$setting.primary_color_rgb|default:'9, 81, 116'};
        --wstyle-secondary: {$setting.secondary_color|default:'#0d9488'};
        --wstyle-secondary-rgb: {$setting.secondary_color_rgb|default:'13, 148, 136'};
    }
    </style>
    {block name=head}{/block}
    {hook name='ui:client.head.css'}
    {hook name='ui:client.head.js'}
    <script>
        const wcp_cookie_domain = "{$cookie_domain|default:''|escape:'javascript'}";

        const wcp_password_chars = {$password_special_chars|default:'[]' nofilter};
        const wcp_password_min = {$password_min_length|default:0};
        const currency_formats = {$currency_formats_json|default:'{}' nofilter};
        const currency_ids     = {$currency_ids_json|default:'{}' nofilter};
        const currency_rates   = {$currency_rates_json|default:'{}' nofilter};
        const currency_digits  = {$currency_digits_json|default:'{}' nofilter};
        const currency_default = '{$currency_default|default:"USD"}';
        const currencies       = Object.keys(currency_ids).map(code => ({ code: code, id: parseInt(currency_ids[code]) }));
        const site_default_country = '{$default_country|default:""}';
</script>
    <script src="{asset path='js/bootstrap.bundle.min.js'}" defer></script>
    <script src="{asset path='js/money.js'}" defer></script>
    <script src="{asset path='js/default.js'}" defer></script>
    {if $is_client_area}
    <script src="{asset path='js/client-nav.js'}" defer></script>
    {else}
    <script src="{asset path='js/news.js'}" defer></script>
    {/if}
    {block name=scripts}{/block}
    {if !empty($demo_mode)}{include file='partials/customizer-head.tpl'}{/if}
</head>
<body class="{block name=body_class}{/block}"{if $is_client_area} data-client-nav="sidebar"{/if}{if $dashboard_modal} data-dashboard-modal="{$dashboard_modal}"{/if}>
{if $is_client_area}
<script>
  try {
    if (localStorage.getItem("wstyle-sidebar") === "expanded") document.body.classList.add("is-sidebar-expanded");
  } catch (e) {
  }
</script>
{/if}
{hook name='ui:client.body.begin'}
{if $is_client_area}
{include file='partials/client-topbar.tpl'}
{include file='partials/client-sidebar.tpl'}
<div class="client-main">
{else}
{include file='partials/topbar.tpl'}
{include file='partials/header.tpl'}
{include file='partials/drawer.tpl'}
{/if}
{* Verification-gate banner: after the header of BOTH branches. verification_banner is only
   raised on client-panel pages (the account page excepted, its settings view carries the gate
   notice card), so it lands at the top of .client-main under the sidebar shell. *}
{if $is_logged_in && !empty($verification_banner)}
<div class="alert alert-warning border-0 rounded-0 mb-0 py-2 shadow-sm" role="alert" data-verify-gate-banner>
    <div class="container d-flex align-items-center justify-content-center flex-wrap gap-2 fs-8 mb-0">
        <i class="bi bi-shield-exclamation"></i>
        <span>{lang key='website/index/verify-banner-text'}</span>
        <a class="fw-semibold text-decoration-none" href="{$verify_link}">{lang key='website/index/verify-banner-cta'} <i class="bi bi-arrow-right-short"></i></a>
    </div>
</div>
{/if}

<main>
{hook name='ui:client.content.top'}
{block name=content}{/block}
{block name=bands}
{if !$is_client_area}
{include file='partials/band-contact.tpl'}
{include file='partials/band-newsletter.tpl'}
{/if}
{/block}
</main>

{hook name='ui:client.footer.before'}

{if $is_client_area}
{include file='partials/client-footer.tpl'}
</div>
{else}
{include file='partials/footer.tpl'}
{include file='partials/popup.tpl'}
{/if}
{if $is_logged_in}{include file='partials/announcements.tpl'}{/if}
{if $is_logged_in}{include file='components/dash-passkey-modal.tpl'}{/if}
{include file='partials/cookie-notice.tpl'}
{block name=body_end}{/block}
{hook name='ui:client.body.end'}
</body>
</html>
