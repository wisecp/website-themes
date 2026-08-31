{$subnav = $subnav_active|default:''}
<nav class="client-subnav" aria-label="{lang key='website/index/subnav-aria'}">
    <div class="container client-subnav-inner">
        <ul class="client-subnav-nav">
            <li><a class="client-subnav-link{if $subnav == 'dashboard'} active{/if}"{if $subnav == 'dashboard'} aria-current="page"{/if} href="{link route='my-account'}"><i class="bi bi-grid-1x2-fill"></i>{lang key='website/index/subnav-dashboard'}</a></li>
            {if $show_services}<li><a class="client-subnav-link{if $subnav == 'services'} active{/if}"{if $subnav == 'services'} aria-current="page"{/if} href="{link route='services'}"><i class="bi bi-hdd-stack"></i>{lang key='website/index/subnav-services'}{if $client_badges.services > 0}<span class="client-subnav-badge" aria-label="{lang key='website/index/subnav-badge-services' count=$client_badges.services}">{$client_badges_text.services}</span>{/if}</a></li>{/if}
            {if !empty($show_domains)}<li><a class="client-subnav-link{if $subnav == 'domains'} active{/if}"{if $subnav == 'domains'} aria-current="page"{/if} href="{link route='domains'}"><i class="bi bi-globe2"></i>{lang key='website/index/subnav-domains'}{if $client_badges.domains > 0}<span class="client-subnav-badge" aria-label="{lang key='website/index/subnav-badge-domains' count=$client_badges.domains}">{$client_badges_text.domains}</span>{/if}</a></li>{/if}
            {if !empty($show_sms)}<li><a class="client-subnav-link{if $subnav == 'sms'} active{/if}"{if $subnav == 'sms'} aria-current="page"{/if} href="{link route='sms'}"><i class="bi bi-chat-dots"></i>{lang key='website/index/subnav-sms'}</a></li>{/if}
            {if $show_invoices}<li><a class="client-subnav-link{if $subnav == 'billing'} active{/if}"{if $subnav == 'billing'} aria-current="page"{/if} href="{link route='invoices'}"><i class="bi bi-receipt"></i>{lang key='website/index/subnav-billing'}{if $client_badges.invoices > 0}<span class="client-subnav-badge" aria-label="{lang key='website/index/subnav-badge-invoices' count=$client_badges.invoices}">{$client_badges_text.invoices}</span>{/if}</a></li>{/if}
            {if !empty($show_support)}<li><a class="client-subnav-link{if $subnav == 'support'} active{/if}"{if $subnav == 'support'} aria-current="page"{/if} href="{link route='tickets'}"><i class="bi bi-life-preserver"></i>{lang key='website/index/subnav-support'}{if $client_badges.support > 0}<span class="client-subnav-badge" aria-label="{lang key='website/index/subnav-badge-support' count=$client_badges.support}">{$client_badges_text.support}</span>{/if}</a></li>{/if}
            {if !empty($client_addon_links)}{foreach $client_addon_links as $al}
            <li><a class="client-subnav-link{if $subnav == "addon-`$al.key`"} active{/if}"{if $subnav == "addon-`$al.key`"} aria-current="page"{/if} href="{$al.link}">{if $al.icon.type == 'image'}<img src="{$al.icon.value}" alt="" style="width:1em;height:1em;object-fit:contain">{else}<i class="{$al.icon.value}"></i>{/if}{$al.name}</a></li>
            {/foreach}{/if}
            {hook name='ui:client.subnav.items'}
            <li class="dropdown client-subnav-more d-none" data-role="subnav-more">
                <button type="button" class="client-subnav-link" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/index/subnav-more'}"><i class="bi bi-three-dots"></i></button>
                <ul class="dropdown-menu dropdown-menu-end nav-dropdown" data-role="subnav-more-menu"></ul>
            </li>
        </ul>

        {if !empty($switch_accounts) && $switch_accounts|@count > 1}
        {$active_acc = $switch_accounts[0]}
        {foreach $switch_accounts as $a}{if $a.is_active}{$active_acc = $a}{/if}{/foreach}
        <div class="dropdown account-switcher" data-switch-url="{link route='my-account'}">
            <button class="account-switcher-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/index/switcher-aria'}">
                <span class="account-switcher-ava">{$active_acc.initials}</span>
                <span class="account-switcher-text">
                    <span class="account-switcher-name">{$active_acc.name}</span>
                    <span class="account-switcher-role">{if $active_acc.is_self}{lang key='website/index/account-owner'}{else}{lang key='website/index/account-member'}{/if}</span>
                </span>
                {if !empty($active_acc.reseller)}<span class="badge bg-primary-subtle text-primary-emphasis account-switcher-reseller bs-tooltip" data-bs-title="{lang key='website/index/switcher-reseller'}" aria-label="{lang key='website/index/switcher-reseller'}"><i class="bi bi-shop"></i></span>{/if}
                <i class="bi bi-chevron-expand account-switcher-caret" aria-hidden="true"></i>
            </button>
            <div class="dropdown-menu dropdown-menu-end nav-dropdown account-switcher-menu">
                <div class="account-switcher-label">{lang key='website/index/switcher-title'}</div>
                {foreach $switch_accounts as $a}
                <button type="button" class="dropdown-item account-switcher-item{if $a.is_active} is-active{/if}" data-action="switch-account" data-account-id="{$a.owner_id}"{if $a.is_active} aria-current="page"{/if}>
                    <span class="account-switcher-ava">{$a.initials}</span>
                    <span class="account-switcher-item-text">
                        <span class="account-switcher-name">{$a.name}</span>
                        <span class="account-switcher-sub">{if $a.is_self}{lang key='website/index/switcher-owner-self'}{else}{lang key='website/index/account-member'}{/if}</span>
                    </span>
                    {if !empty($a.reseller)}<span class="badge bg-primary-subtle text-primary-emphasis account-switcher-tag"><i class="bi bi-shop me-1"></i>{lang key='website/index/switcher-reseller'}</span>{/if}
                    <i class="bi bi-check2 account-switcher-check" aria-hidden="true"></i>
                </button>
                {/foreach}
                <hr class="dropdown-divider">
                <a class="dropdown-item" href="{link route='sub-accounts'}"><i class="bi bi-person-badge"></i>{lang key='website/index/switcher-manage'}</a>
            </div>
            {csrf form='account-switch'}
        </div>
        {/if}
    </div>
</nav>
