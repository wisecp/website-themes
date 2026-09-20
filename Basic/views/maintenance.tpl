<!DOCTYPE html>
<html lang="{$ui_lang|default:'en'}" dir="{$ui_dir|default:'ltr'}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>{lang key='system/maintenance/meta'}</title>
    {favicon}
    <script>
      var mc = document.cookie.split("; ").filter(function(c) {
        return c.indexOf("wcp_theme_mode=") === 0;
      });
      var mv = mc.length === 1 ? mc[0].slice(15) : "";
      var m = (mv === "light" || mv === "dark" || mv === "auto" ? mv : "") || localStorage.getItem("basic-theme-mode") || localStorage.getItem("basic-theme") || "light";
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
    <link rel="stylesheet" href="{asset path='css/libs/fonts/manrope.css'}">
    <link rel="stylesheet" href="{asset path='css/theme.css'}">
    <link rel="stylesheet" href="{asset path='css/default.css'}">
    <link rel="stylesheet" href="{asset path='css/default-dark.css'}">
    <link rel="stylesheet" href="{asset path='css/default.rtl.css'}">
    <link rel="stylesheet" href="{asset path='css/maintenance.css'}">
    <style>
    :root {
        --basic-primary: {$setting.primary_color|default:'#009595'};
        --basic-primary-rgb: {$setting.primary_color_rgb|default:'0, 149, 149'};
        --basic-secondary: {$setting.secondary_color|default:'#345a6c'};
        --basic-secondary-rgb: {$setting.secondary_color_rgb|default:'52, 90, 108'};
        --basic-text: {$setting.text_color|default:'#607d8b'};
        --basic-text-rgb: {$setting.text_color_rgb|default:'96, 125, 139'};
    }
    </style>
    {hook name='ui:client.head.css'}
    {hook name='ui:client.head.js'}
    <script src="{asset path='js/bootstrap.bundle.min.js'}" defer></script>
    <script src="{asset path='js/default.js'}" defer></script>
</head>
<body class="maintenance-page">
{hook name='ui:client.body.begin'}

<a class="visually-hidden-focusable" href="#maintenance-content">{lang key='system/maintenance/skip-link'}</a>

<header class="maintenance-header">
    <div class="container d-flex align-items-center justify-content-between gap-3 py-3">
        <a class="site-brand d-inline-flex align-items-center{if $brand_no_logo} brand-no-logo{/if}" href="{link route='home'}">
            {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
            {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
            <span class="site-brand-text">{$brand_wordmark}</span>
        </a>
        {if $lang_count > 1}
        <div class="dropdown">
            <button class="btn btn-ghost btn-sm dropdown-toggle locale-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='system/maintenance/change-language'}">
                <i class="bi bi-globe2 me-1"></i><span>{$selected_lang_key|default:'EN'}</span>
            </button>
            <div class="dropdown-menu dropdown-menu-end locale-menu">
                <div class="locale-list">
                    {foreach $lang_list as $l}
                    <a class="dropdown-item{if $l.selected} active{/if}" href="{$l.link}">{$l.name}<i class="bi bi-check2"></i></a>
                    {/foreach}
                </div>
            </div>
        </div>
        {/if}
    </div>
</header>

<main class="maintenance-main" id="maintenance-content">
    <section class="container py-5" aria-labelledby="maintenance-title">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-8 col-xl-7">
                <div class="maintenance-copy">
                    <h1 class="maintenance-title" id="maintenance-title">{lang key='system/maintenance/title'}</h1>
                    <p class="maintenance-lead">{lang key='system/maintenance/lead'}</p>

                    <div class="maintenance-summary" role="status" aria-live="polite">
                        <div class="maintenance-summary-head">
                            <span><i class="bi bi-activity me-2"></i>{lang key='system/maintenance/status-heading'}</span>
                        </div>
                        <div class="maintenance-service-list">
                            <div class="maintenance-service-row">
                                <span class="maintenance-service-name"><i class="bi bi-box-arrow-in-right"></i>{lang key='system/maintenance/status-access'}</span>
                                <span class="maintenance-status-value is-warning"><i class="bi bi-clock-history"></i>{lang key='system/maintenance/status-access-value'}</span>
                            </div>
                            <div class="maintenance-service-row">
                                <span class="maintenance-service-name"><i class="bi bi-boxes"></i>{lang key='system/maintenance/status-services'}</span>
                                <span class="maintenance-status-value is-success"><i class="bi bi-check-circle"></i>{lang key='system/maintenance/status-services-value'}</span>
                            </div>
                        </div>
                    </div>

                    <div class="maintenance-note">
                        <span class="maintenance-note-icon"><i class="bi bi-shield-check"></i></span>
                        <p>{lang key='system/maintenance/note'}</p>
                    </div>

                </div>
            </div>
        </div>
    </section>
</main>

<footer class="maintenance-footer">
    <div class="container d-flex flex-wrap align-items-center justify-content-between gap-2 py-3">
        <span>© {$current_year} {$company_name} {lang key='website/index/footer-rights'}</span>
        {if $show_powered_by}<span>{lang key='website/index/footer-powered-by'} <a href="https://www.wisecp.com">WISECP</a></span>{/if}
    </div>
</footer>

{hook name='ui:client.body.end'}
</body>
</html>
