<!DOCTYPE html>
<html lang="{$ui_lang|default:'en'}" dir="{$ui_dir|default:'ltr'}"{if $setting.checkout_sidebar == 'card'} class="checkout-layout-card"{elseif $setting.checkout_sidebar == 'stack'} class="checkout-layout-stack"{/if}{if ($setting.default_mode|default:'') == 'dark'} data-theme-default="dark"{elseif ($setting.default_mode|default:'') == 'auto'} data-theme-default="auto"{/if}>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{block name=title}{$head_title|default:$page_title|default:$company_name}{/block}</title>
    {if !empty($meta_robots)}<meta name="robots" content="{$meta_robots}">{/if}
    {if !empty($canonical_link)}<link rel="canonical" href="{$canonical_link}">{/if}
    {favicon}
    <script>
      var mc = document.cookie.split("; ").filter(function(c) {
        return c.indexOf("wcp_theme_mode=") === 0;
      });
      var mv = mc.length === 1 ? mc[0].slice(15) : "";
      var m = (mv === "light" || mv === "dark" || mv === "auto" ? mv : "") || localStorage.getItem("wstyle-theme-mode") || localStorage.getItem("wstyle-theme") || document.documentElement.getAttribute("data-theme-default") || "light";
      var t = m === "light" || m === "dark" ? m : window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
      document.documentElement.setAttribute("data-bs-theme", t);
      try {
        localStorage.removeItem("wstyle-dir");
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
    <link rel="stylesheet" href="{asset path='css/checkout-shell.css'}">
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
        const currency_numbers = {$currency_numbers_json|default:'{}' nofilter};
        const currency_default = '{$currency_default|default:"USD"}';
        const currencies       = Object.keys(currency_ids).map(code => ({ code: code, id: parseInt(currency_ids[code]) }));
        const site_default_country = '{$default_country|default:""}';
</script>
    <script src="{asset path='js/bootstrap.bundle.min.js'}" defer></script>
    <script src="{asset path='js/money.js'}" defer></script>
    <script src="{asset path='js/default.js'}" defer></script>
    {block name=scripts}{/block}
    <script src="{asset path='js/checkout-shell.js'}" defer></script>
    {if !empty($demo_mode)}{include file='partials/customizer-head.tpl'}{/if}
</head>
<body class="checkout-shell{block name=body_class}{/block}">
{hook name='ui:client.body.begin'}
{include file='partials/checkout-header.tpl'}

<main>
{block name=content}{/block}
</main>

{include file='partials/checkout-footer.tpl'}
{include file='partials/cookie-notice.tpl'}
{block name=body_end}{/block}
{hook name='ui:client.body.end'}
</body>
</html>
