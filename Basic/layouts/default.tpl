<!DOCTYPE html>
<html lang="{$ui_lang|default:'en'}" dir="{$ui_dir|default:'ltr'}"{if ($setting.content_width|default:'') == 'wide'} data-content-width="wide"{elseif ($setting.content_width|default:'') == 'wider'} data-content-width="wider"{/if}{if ($setting.default_mode|default:'') == 'dark'} data-theme-default="dark"{elseif ($setting.default_mode|default:'') == 'auto'} data-theme-default="auto"{/if}>
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
      var m = (mv === "light" || mv === "dark" || mv === "auto" ? mv : "") || localStorage.getItem("basic-theme-mode") || localStorage.getItem("basic-theme") || document.documentElement.getAttribute("data-theme-default") || "light";
      var t = m === "light" || m === "dark" ? m : window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
      document.documentElement.setAttribute("data-bs-theme", t);
      try {
        localStorage.removeItem("basic-dir");
      } catch (e) {
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
    <style>
    :root {
        --basic-primary: {$setting.primary_color|default:'#095174'};
        --basic-primary-rgb: {$setting.primary_color_rgb|default:'9, 81, 116'};
        --basic-secondary: {$setting.secondary_color|default:'#0d9488'};
        --basic-secondary-rgb: {$setting.secondary_color_rgb|default:'13, 148, 136'};
        --basic-text: {$setting.text_color|default:'#607d8b'};
        --basic-text-rgb: {$setting.text_color_rgb|default:'96, 125, 139'};
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
        const currency_numbers = {$currency_numbers_json|default:'{}' nofilter};
        const currency_default = '{$currency_default|default:"USD"}';
        const currencies       = Object.keys(currency_ids).map(code => ({ code: code, id: parseInt(currency_ids[code]) }));
        const site_default_country = '{$default_country|default:""}';
</script>
    <script src="{asset path='js/bootstrap.bundle.min.js'}" defer></script>
    <script src="{asset path='js/money.js'}" defer></script>
    <script src="{asset path='js/default.js'}" defer></script>
    {if $is_logged_in && !empty($show_client_subnav)}<script src="{asset path='js/client-notifications.js'}" defer></script>{/if}
    {block name=scripts}{/block}
    {if !empty($demo_mode)}{include file='partials/customizer-head.tpl'}{/if}
</head>
<body{if $dashboard_modal} data-dashboard-modal="{$dashboard_modal}"{/if}>
{hook name='ui:client.body.begin'}
{include file='partials/topbar.tpl'}
{include file='partials/header.tpl'}
{include file='partials/drawer.tpl'}
{if $is_logged_in && !empty($show_client_subnav)}{include file='partials/client-subnav.tpl'}{/if}
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
</main>

{hook name='ui:client.footer.before'}

{include file='partials/footer.tpl'}
<button class="btn btn-primary scroll-top" type="button" data-action="scroll-top" aria-label="Back to top"><i class="bi bi-arrow-up"></i></button>
{include file='partials/popup.tpl'}
{if $is_logged_in}{include file='partials/announcements.tpl'}{/if}
{if $is_logged_in}{include file='components/dash-passkey-modal.tpl'}{/if}
{include file='partials/cookie-notice.tpl'}
{block name=body_end}{/block}
{hook name='ui:client.body.end'}
</body>
</html>
