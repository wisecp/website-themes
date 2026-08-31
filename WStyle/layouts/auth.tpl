<!DOCTYPE html>
<html lang="{$ui_lang|default:'en'}" dir="{$ui_dir|default:'ltr'}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{block name=title}{$head_title|default:$page_title|default:$company_name}{/block}</title>
    {if !empty($meta_description)}<meta name="description" content="{$meta_description}">{/if}
    {if !empty($meta_robots)}<meta name="robots" content="{$meta_robots}">{/if}
    {if !empty($canonical_link)}<link rel="canonical" href="{$canonical_link}">{/if}
    {if !empty($lang_list)}{foreach $lang_list as $l}
    <link rel="alternate" hreflang="{$l.key}" href="{$l.link}">{if $l.local}
    <link rel="alternate" hreflang="x-default" href="{$l.link}">{/if}{/foreach}
    {/if}
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
    </script>
    <link rel="preload" href="{asset path='css/libs/bootstrap-icons/fonts/bootstrap-icons.woff2'}?e34853135f9e39acf64315236852cd5a" as="font" type="font/woff2" crossorigin>
    <link rel="stylesheet" href="{if ($ui_dir|default:'ltr') == 'rtl'}{asset path='css/bootstrap.rtl.min.css'}{else}{asset path='css/bootstrap.min.css'}{/if}" id="css-bootstrap" data-ltr="{asset path='css/bootstrap.min.css'}" data-rtl="{asset path='css/bootstrap.rtl.min.css'}">
    <link rel="stylesheet" href="{asset path='css/libs/bootstrap-icons/bootstrap-icons.min.css'}">
    <link rel="stylesheet" href="{asset path='css/libs/fontawesome/css/all.min.css'}">
    <link rel="preload" href="{asset path='css/libs/fonts/urbanist/urbanist-latin.woff2'}" as="font" type="font/woff2" crossorigin>
    <link rel="preload" href="{asset path='css/libs/fonts/urbanist/urbanist-latin-ext.woff2'}" as="font" type="font/woff2" crossorigin>
    <link rel="stylesheet" href="{asset path='css/libs/fonts/urbanist.css'}">
    <link rel="stylesheet" href="{asset path='css/theme.css'}">
    <link rel="stylesheet" href="{asset path='css/default.css'}">
    <link rel="stylesheet" href="{asset path='css/default-dark.css'}">
    <link rel="stylesheet" href="{asset path='css/default.rtl.css'}">
    <link rel="stylesheet" href="{asset path='css/auth.css'}">
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
        const currency_default = '{$currency_default|default:"USD"}';
        const currencies       = Object.keys(currency_ids).map(code => ({ code: code, id: parseInt(currency_ids[code]) }));
        const site_default_country = '{$default_country|default:""}';
</script>
    <script src="{asset path='js/bootstrap.bundle.min.js'}" defer></script>
    <script src="{asset path='js/money.js'}" defer></script>
    <script src="{asset path='js/default.js'}" defer></script>
    <script src="{asset path='js/auth.js'}" defer></script>
    {block name=scripts}{/block}
    {if !empty($demo_mode)}{include file='partials/customizer-head.tpl'}{/if}
</head>
<body class="{block name=body_class}{/block}">
{hook name='ui:client.body.begin'}

<div class="auth-split{block name=split_class}{/block}">

    <aside class="auth-stage chrome-dark d-none d-lg-flex">
        <video class="auth-stage-video" autoplay muted loop playsinline poster="{asset path='images/auth-poster.jpg'}" aria-hidden="true" data-auth-video data-src="{asset path='videos/auth-stage.mp4'}"></video>
        <span class="auth-stage-scrim" aria-hidden="true"></span>
        <div class="auth-stage-inner">
            <div class="auth-stage-head">
                <a class="site-brand auth-stage-brand d-inline-flex align-items-center{if $brand_no_logo} brand-no-logo{/if}" href="{link route='home'}">
                    {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
                    {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
                    <span class="site-brand-text">{$brand_wordmark}</span>
                </a>
                <div class="auth-form-tools">
                    {include file='components/locale-switcher.tpl'
                        wrapclass='dropdown auth-locale'
                        toggleclass='btn btn-ghost btn-sm locale-toggle'
                        menuclass='dropdown-menu dropdown-menu-end locale-menu'
                        idsuffix=''}
                </div>
            </div>
            {capture assign=auth_stage_foot}{block name=stage_foot}{/block}{/capture}
            <div class="auth-stage-copy">
                <p class="auth-stage-title">{block name=stage_title}{/block}</p>
                <p class="auth-stage-text">{block name=stage_text}{/block}</p>
                {if $auth_stage_foot != ''}<p class="auth-stage-foot">{$auth_stage_foot nofilter}</p>{/if}
            </div>
        </div>
    </aside>

    <main class="auth-form">
        <div class="auth-form-bar d-lg-none">
            <a class="site-brand d-inline-flex align-items-center{if $brand_no_logo} brand-no-logo{/if}" href="{link route='home'}">
                {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
                {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
                <span class="site-brand-text">{$brand_wordmark}</span>
            </a>
            <div class="auth-form-tools">
                {include file='components/locale-switcher.tpl'
                    wrapclass='dropdown auth-locale'
                    toggleclass='btn btn-ghost btn-sm locale-toggle'
                    menuclass='dropdown-menu dropdown-menu-end locale-menu'
                    idsuffix='-m'}
            </div>
        </div>

        <div class="auth-form-body">
            <div class="auth-form-inner{block name=inner_class}{/block}">
                {block name=content}{/block}
            </div>
        </div>
    </main>

</div>

{include file='partials/cookie-notice.tpl'}
{block name=body_end}{/block}
{hook name='ui:client.body.end'}
</body>
</html>
