<script>
    window.czDefaults = {
        primary: '{$setting.primary_color|default:'#009595'}',
        secondary: '{$setting.secondary_color|default:'#345a6c'}',
        textColor: '#606e84', 
        font: 'Manrope',
        dashboardVariant: '{$cz_dashboard_variant|default:''}',
        links: { dashboard: '{link route='my-account'}', cart: '{link route='cart'}' },
        themes: [{foreach $demo_themes|default:[] as $t}{if !$t@first}, {/if}{ldelim}name:'{$t.name|escape:'javascript'}',label:'{$t.label|escape:'javascript'}',active:{if $t.active}true{else}false{/if}{rdelim}{/foreach}],
        i18n: {
            title: '{lang key='cz_title'}',
            subtitle: '{lang key='cz_subtitle'}',
            theme: '{lang key='cz_theme'}',
            soon: '{lang key='cz_soon'}',
            layout: '{lang key='cz_layout'}',
            dashboard: '{lang key='cz_dashboard'}',
            hero: '{lang key='cz_hero'}',
            standard: '{lang key='cz_standard'}',
            checkout: '{lang key='cz_checkout'}',
            rail: '{lang key='cz_rail'}',
            card: '{lang key='cz_card'}',
            stack: '{lang key='cz_stack'}',
            appearance: '{lang key='cz_appearance'}',
            light: '{lang key='website/account/theme-light'}',
            dark: '{lang key='website/account/theme-dark'}',
            brandLogo: '{lang key='cz_brand_logo'}',
            logoUpload: '{lang key='cz_logo_upload'}',
            logoHint: '{lang key='cz_logo_hint'}',
            logoRemove: '{lang key='cz_logo_remove'}',
            colors: '{lang key='cz_colors'}',
            primary: '{lang key='cz_primary'}',
            secondary: '{lang key='cz_secondary'}',
            text: '{lang key='cz_text'}',
            textNote: '{lang key='cz_text_note'}',
            pickPrimary: '{lang key='cz_pick_primary'}',
            pickSecondary: '{lang key='cz_pick_secondary'}',
            pickText: '{lang key='cz_pick_text'}',
            typography: '{lang key='cz_typography'}',
            fontFamily: '{lang key='cz_font_family'}',
            reset: '{lang key='cz_reset'}',
            close: '{lang key='cz_close'}',
            toastExtracted: '{lang key='cz_toast_extracted'}',
            toastReset: '{lang key='cz_toast_reset'}',
            nudgeDashboard: '{lang key='cz_nudge_dashboard'}',
            nudgeCheckout: '{lang key='cz_nudge_checkout'}',
            nudgeExplore: '{lang key='cz_nudge_explore'}'
        }
    };
    try {
        var cz = JSON.parse(localStorage.getItem('basic-customizer') || '{ }');
        var czD = window.czDefaults;
        var czS = document.documentElement.style;
        var czRgb = function (x) { x = x.replace('#', ''); return parseInt(x.substr(0, 2), 16) + ', ' + parseInt(x.substr(2, 2), 16) + ', ' + parseInt(x.substr(4, 2), 16); };
        if (cz.primary && cz.primary !== czD.primary) { czS.setProperty('--basic-primary', cz.primary); czS.setProperty('--basic-primary-rgb', czRgb(cz.primary)); }
        if (cz.secondary && cz.secondary !== czD.secondary) { czS.setProperty('--basic-secondary', cz.secondary); czS.setProperty('--basic-secondary-rgb', czRgb(cz.secondary)); }
        if (cz.font === 'Urbanist') cz.font = czD.font; 
        if (cz.font && cz.font !== czD.font) czS.setProperty('--basic-font-family', '"' + cz.font + '", system-ui, -apple-system, "Segoe UI", Roboto, sans-serif');
        if (cz.textColor && cz.textColor !== czD.textColor && document.documentElement.getAttribute('data-bs-theme') !== 'dark') { czS.setProperty('--basic-body-color', cz.textColor); czS.setProperty('--basic-heading-color', 'color-mix(in srgb, ' + cz.textColor + ' 80%, black)'); }
        if (cz.logo) document.write('<style id="cz-logo-fouc">.site-logo{ldelim}opacity:0{rdelim}</style>');
        var czCo = localStorage.getItem('basic-checkout-layout');
        if (czCo) {
            var czCl = document.documentElement.classList;
            czCl.remove('checkout-layout-card', 'checkout-layout-stack');
            if (czCo === 'card' || czCo === 'stack') czCl.add('checkout-layout-' + czCo);
        }
    } catch (e) {  }
</script>
<link rel="stylesheet" href="{asset path='css/customizer.css'}">
<script src="{asset path='js/customizer.js'}" defer></script>
