<header class="client-topbar">
    <a class="client-topbar-brand d-lg-none d-inline-flex align-items-center" href="{link route='my-account'}" aria-label="{lang key='website/index/account-dashboard'}">
        {if $client_logo_light_link}<img src="{$client_logo_light_link}" alt="{lang key='website/index/logo-alt'}" class="client-topbar-mark client-topbar-mark-light">{/if}
        {if $client_logo_dark_link}<img src="{$client_logo_dark_link}" alt="{lang key='website/index/logo-alt'}" class="client-topbar-mark client-topbar-mark-dark">{/if}
        {if !$client_logo_light_link && !$client_logo_dark_link}<span class="client-topbar-mark client-topbar-mark-text">{$brand_wordmark}</span>{/if}
    </a>
    <button class="btn btn-ghost header-icon-btn d-lg-none ms-2" type="button" data-action="client-drawer-toggle" aria-controls="client-menu" aria-expanded="false" aria-label="{lang key='client_menu_open'}"><i class="bi bi-list fs-4"></i></button>
    <div class="dropdown client-quickactions d-none d-lg-block">
        <button class="btn btn-soft header-icon-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='client_quickactions'}"><i class="bi bi-grid-fill"></i></button>
        <div class="dropdown-menu nav-dropdown">
            <div class="client-topbar-menu-head"><span class="client-topbar-menu-title">{lang key='client_quickactions'}</span></div>
            {if $order_service_link}
            <a class="dropdown-item" href="{$order_service_link}">
                <span class="icon-disc"><i class="bi bi-bag-plus"></i></span>
                <span><span class="item-title">{lang key='client_qa_order'}</span><span class="item-desc">{lang key='client_qa_order_desc'}</span></span>
            </a>
            {/if}
            {if !empty($show_support)}
            <a class="dropdown-item" href="{link route='ticket-create'}">
                <span class="icon-disc"><i class="bi bi-life-preserver"></i></span>
                <span><span class="item-title">{lang key='client_qa_ticket'}</span><span class="item-desc">{lang key='client_qa_ticket_desc'}</span></span>
            </a>
            {/if}
            <a class="dropdown-item" href="{link route='balance'}">
                <span class="icon-disc"><i class="bi bi-wallet2"></i></span>
                <span><span class="item-title">{lang key='client_qa_funds'}</span><span class="item-desc">{lang key='client_qa_funds_desc'}</span></span>
            </a>
        </div>
    </div>
    <div class="client-topbar-end">
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
                {if !empty($active_acc.reseller)}<span class="badge bg-primary-subtle text-primary-emphasis account-switcher-reseller" data-bs-toggle="tooltip" title="{lang key='website/index/switcher-reseller'}" aria-label="{lang key='website/index/switcher-reseller'}"><i class="bi bi-shop"></i></span>{/if}
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
        <div class="dropdown position-relative" data-notif
             data-notif-url="{link route='my-account'}"
             data-txt-empty="{lang key='website/dashboard/notif-empty'}"
             data-txt-error="{lang key='website/dashboard/notif-error'}"
             data-txt-new="{lang key='website/dashboard/notif-new'}"
             data-txt-read="{lang key='website/dashboard/notif-read-one'}">
            <button class="btn btn-soft header-icon-btn client-topbar-notif" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false" aria-label="{lang key='website/dashboard/notif-aria'}"><i class="bi bi-bell"></i><span class="client-topbar-badge{if !$notification_count} d-none{/if}" data-role="notif-count">{$notification_count_text|default:0}</span></button>
            <div class="dropdown-menu dropdown-menu-end nav-dropdown notif-menu">
                <div class="client-topbar-menu-head">
                    <span class="client-topbar-menu-title">{lang key='website/dashboard/notif-title'}</span>
                    <span class="notif-head-end">
                        <button type="button" class="notif-markall" data-action="notif-read-all">{lang key='website/dashboard/notif-read-all'}</button>
                        <span class="notif-new{if !$notification_count} d-none{/if}" data-role="notif-new">{lang key='website/dashboard/notif-new' count=$notification_count|default:0}</span>
                    </span>
                </div>
                <div class="notif-list" data-role="notif-list"></div>
                <a class="notif-foot" href="{link route='info'}#notifications">{lang key='website/dashboard/notif-view-all'}<i class="bi bi-arrow-right"></i></a>
            </div>
            {* First page of the feed, rendered WITH the shell: the dropdown used to fetch it on
               first open and show skeleton rows for the length of the round trip. Read by
               client-nav.js, which hands it to the same renderer the scroll paging uses. *}
            {if $notification_seed_json}<script type="application/json" data-notif-seed>{$notification_seed_json nofilter}</script>{/if}
            {csrf form='notifications'}
        </div>
        {if $visibility_cart && $account_actions_enabled}
        <a class="btn btn-soft header-icon-btn client-topbar-cart{if $cart_count == 0} d-none{/if}" data-cart-btn href="{link route='cart'}" aria-label="{lang key='website/index/nav-aria-cart'}"><i class="bi bi-cart3"></i><span class="client-topbar-badge cart-count{if $cart_count == 0} d-none{/if}">{$cart_count}</span></a>
        {/if}
        {include file='components/account-menu.tpl'}
        {hook name='ui:client.header.actions'}
    </div>
</header>
