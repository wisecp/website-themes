{$subnav = $subnav_active|default:''}
<nav class="client-sidebar chrome-dark" id="client-menu" aria-label="{lang key='website/index/subnav-aria'}">
    <div class="client-sidebar-head">
        <a class="site-brand client-sidebar-brand{if $brand_no_logo} brand-no-logo{/if}" href="{link route='my-account'}" aria-label="{lang key='website/index/account-dashboard'}">
            {if $favicon_link}<img src="{$favicon_link}" alt="{lang key='website/index/logo-alt'}" class="client-sidebar-mark">
            {else}<span class="client-sidebar-mark client-sidebar-mark-text" aria-hidden="true">{$brand_initial}</span>{/if}
            {if $client_logo_dark_link}<img src="{$client_logo_dark_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo client-sidebar-logo">
            {else}<span class="site-brand-text client-sidebar-logo">{$brand_wordmark}</span>{/if}
        </a>
        <button class="client-sidebar-toggle" type="button" data-action="sidebar-toggle" aria-expanded="false" aria-label="{lang key='client_menu_expand'}" data-txt-expand="{lang key='client_menu_expand'}" data-txt-collapse="{lang key='client_menu_collapse'}"><i class="bi bi-chevron-double-right"></i></button>
        <button type="button" class="btn-close btn-close-white d-lg-none ms-auto" data-action="client-drawer-close" aria-label="{lang key='client_menu_close'}"></button>
    </div>

    <div class="client-sidebar-scroll">
        <ul class="client-sidebar-nav">
            <li><a class="client-sidebar-link{if $subnav == 'dashboard'} active{/if}"{if $subnav == 'dashboard'} aria-current="page"{/if} href="{link route='my-account'}"><span class="client-sidebar-ico"><i class="bi bi-grid-1x2-fill"></i></span><span class="client-sidebar-label">{lang key='website/index/subnav-dashboard'}</span></a></li>
            {if $show_services}<li><a class="client-sidebar-link{if $subnav == 'services'} active{/if}"{if $subnav == 'services'} aria-current="page"{/if} href="{link route='services'}"><span class="client-sidebar-ico"><i class="bi bi-hdd-stack"></i></span><span class="client-sidebar-label">{lang key='website/index/subnav-services'}</span>{if $client_badges.services > 0}<span class="client-sidebar-badge" data-role="service-count" aria-label="{lang key='website/index/subnav-badge-services' count=$client_badges.services}">{$client_badges_text.services}</span>{/if}</a></li>{/if}
            {if !empty($show_domains)}<li><a class="client-sidebar-link{if $subnav == 'domains'} active{/if}"{if $subnav == 'domains'} aria-current="page"{/if} href="{link route='domains'}"><span class="client-sidebar-ico"><i class="bi bi-globe2"></i></span><span class="client-sidebar-label">{lang key='website/index/subnav-domains'}</span>{if $client_badges.domains > 0}<span class="client-sidebar-badge" data-role="domain-count" aria-label="{lang key='website/index/subnav-badge-domains' count=$client_badges.domains}">{$client_badges_text.domains}</span>{/if}</a></li>{/if}
            {if !empty($show_sms)}<li><a class="client-sidebar-link{if $subnav == 'sms'} active{/if}"{if $subnav == 'sms'} aria-current="page"{/if} href="{link route='sms'}"><span class="client-sidebar-ico"><i class="bi bi-chat-dots"></i></span><span class="client-sidebar-label">{lang key='website/index/subnav-sms'}</span></a></li>{/if}
            {if $show_invoices}<li><a class="client-sidebar-link{if $subnav == 'billing'} active{/if}"{if $subnav == 'billing'} aria-current="page"{/if} href="{link route='invoices'}"><span class="client-sidebar-ico"><i class="bi bi-receipt"></i></span><span class="client-sidebar-label">{lang key='website/index/subnav-billing'}</span>{if $client_badges.invoices > 0}<span class="client-sidebar-badge" data-role="invoice-count" aria-label="{lang key='website/index/subnav-badge-invoices' count=$client_badges.invoices}">{$client_badges_text.invoices}</span>{/if}</a></li>{/if}
            {if !empty($show_support)}<li><a class="client-sidebar-link{if $subnav == 'support'} active{/if}"{if $subnav == 'support'} aria-current="page"{/if} href="{link route='tickets'}"><span class="client-sidebar-ico"><i class="bi bi-life-preserver"></i></span><span class="client-sidebar-label">{lang key='website/index/subnav-support'}</span>{if $client_badges.support > 0}<span class="client-sidebar-badge" data-role="ticket-count" aria-label="{lang key='website/index/subnav-badge-support' count=$client_badges.support}">{$client_badges_text.support}</span>{/if}</a></li>{/if}
            {if !empty($client_addon_links)}{foreach $client_addon_links as $al}
            <li><a class="client-sidebar-link{if $subnav == "addon-`$al.key`"} active{/if}"{if $subnav == "addon-`$al.key`"} aria-current="page"{/if} href="{$al.link}"><span class="client-sidebar-ico">{if $al.icon.type == 'image'}<img src="{$al.icon.value}" alt="" style="width:1em;height:1em;object-fit:contain">{else}<i class="{$al.icon.value}"></i>{/if}</span><span class="client-sidebar-label">{$al.name}</span></a></li>
            {/foreach}{/if}
            {hook name='ui:client.subnav.items'}
        </ul>
    </div>

    <div class="client-sidebar-foot">
        {capture assign=locale_aria}{lang key='client_locale_aria'}{/capture}
        {include file='components/locale-switcher.tpl' idsuffix='-s' wrapclass='dropup client-sidebar-locale' toggleclass='client-sidebar-link' menuclass='dropdown-menu locale-menu' icon='bi-translate' icoclass='client-sidebar-ico' labelclass='client-sidebar-label' arialabel=$locale_aria}
        <button class="client-sidebar-link" type="button" data-action="theme-toggle" aria-label="{lang key='website/account/display-mode'}">
            <span class="client-sidebar-ico"><i class="bi bi-moon-stars"></i></span>
            <span class="client-sidebar-label">{lang key='website/account/display-mode'}</span>
        </button>
        {if !$only_client_panel}<a class="client-sidebar-link" href="{link route='home'}"><span class="client-sidebar-ico"><i class="bi bi-box-arrow-up-right"></i></span><span class="client-sidebar-label">{lang key='client_back_to_site'}</span></a>{/if}
    </div>
</nav>
