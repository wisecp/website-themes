{function name=basic_nav_item item=[]}
<a class="dropdown-item"{if $item.link} href="{$item.link}"{/if}>
    <span class="icon-disc"><i class="{$item.icon}"></i></span>
    <span><span class="item-title">{$item.title}{if $item.extra.tag ?? false}<span class="badge" style="background-color:{$item.extra.tag.color};color:{$item.extra.tag.text_color}">{if $item.extra.tag.icon ?? ''}<i class="{$item.extra.tag.icon} me-1"></i>{/if}{$item.extra.tag.name}</span>{/if}</span>{if $item.extra.desc ?? ''}<span class="item-desc">{$item.extra.desc}</span>{/if}</span>
</a>
{/function}
<header class="site-header">
    <nav class="container d-flex align-items-center py-2" aria-label="{lang key='website/index/nav-aria-main'}">
        <a class="site-brand d-flex align-items-center me-lg-5{if $brand_no_logo} brand-no-logo{/if}" href="{if $only_client_panel}{link route='my-account'}{else}{link route='home'}{/if}">
            {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
            {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
            <span class="site-brand-text">{$brand_wordmark}</span>
        </a>
        <button class="btn btn-ghost header-icon-btn drawer-toggle d-lg-none ms-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#site-menu" aria-controls="site-menu" aria-label="{lang key='website/index/nav-aria-open'}"><i class="bi bi-list fs-4"></i></button>
        <ul class="nav site-nav d-none d-lg-flex">
            {foreach $header_menu as $item}
                {if $item.children}
            <li class="nav-item dropdown">
                <a class="nav-link"{if $item.link} href="{$item.link}"{/if}>{$item.title}<i class="bi bi-chevron-down nav-chevron"></i></a>
                <div class="dropdown-menu nav-dropdown">
                    {foreach $item.children as $child}
                        {if $child.children}
                    <div class="dropdown-sub">
                        <a class="dropdown-item nav-sub-toggle"{if $child.link} href="{$child.link}"{/if} aria-haspopup="true">
                            <span class="icon-disc"><i class="{$child.icon}"></i></span>
                            <span><span class="item-title">{$child.title}{if $child.extra.tag ?? false}<span class="badge" style="background-color:{$child.extra.tag.color};color:{$child.extra.tag.text_color}">{if $child.extra.tag.icon ?? ''}<i class="{$child.extra.tag.icon} me-1"></i>{/if}{$child.extra.tag.name}</span>{/if}</span>{if $child.extra.desc ?? ''}<span class="item-desc">{$child.extra.desc}</span>{/if}</span>
                            <i class="bi bi-chevron-right nav-sub-caret"></i>
                        </a>
                        <div class="dropdown-menu nav-dropdown nav-sub-menu">
                            {foreach $child.children as $grandchild}
                            {call name=basic_nav_item item=$grandchild}
                            {/foreach}
                        </div>
                    </div>
                        {else}
                    {call name=basic_nav_item item=$child}
                        {/if}
                    {/foreach}
                </div>
            </li>
                {else}
            <li class="nav-item"><a class="nav-link"{if $item.link} href="{$item.link}"{/if}>{$item.title}</a></li>
                {/if}
            {/foreach}
            {hook name='ui:client.nav.items'}
        </ul>
        <div class="d-flex align-items-center gap-3 ms-auto">
            {if $visibility_cart && $account_actions_enabled}
            <a class="btn btn-soft header-icon-btn position-relative{if $cart_count == 0} d-none{/if}" data-cart-btn href="{link route='cart'}" aria-label="{lang key='website/index/nav-aria-cart'}"><i class="bi bi-cart3"></i><span class="cart-count{if $cart_count == 0} d-none{/if}">{$cart_count}</span></a>
            {/if}
            {if $account_actions_enabled}
            {if $is_logged_in}
            {if !empty($show_client_subnav)}
            <div class="dropdown position-relative" data-notif
                 data-notif-url="{link route='my-account'}"
                 data-txt-empty="{lang key='website/dashboard/notif-empty'}"
                 data-txt-error="{lang key='website/dashboard/notif-error'}"
                 data-txt-new="{lang key='website/dashboard/notif-new'}"
                 data-txt-read="{lang key='website/dashboard/notif-read-one'}">
                <button class="btn btn-soft header-icon-btn client-topbar-notif" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false" aria-label="{lang key='website/dashboard/notif-aria'}"><i class="bi bi-bell"></i><span class="cart-count{if !$notification_count} d-none{/if}" data-role="notif-count">{$notification_count_text|default:0}</span></button>
                <div class="dropdown-menu dropdown-menu-end nav-dropdown notif-menu">
                    <div class="notif-head">
                        <span class="notif-label">{lang key='website/dashboard/notif-title'}</span>
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
                   client-notifications.js, which hands it to the same renderer the scroll paging uses. *}
                {if $notification_seed_json}<script type="application/json" data-notif-seed>{$notification_seed_json nofilter}</script>{/if}
                {csrf form='notifications'}
            </div>
            {/if}
            <div class="dropdown position-relative">
                <button class="btn btn-soft header-icon-btn account-avatar" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/index/nav-aria-account'}">{if $account_info.avatar}<img class="account-avatar-img" src="{$account_info.avatar}" alt="">{elseif $account_info.initials}{$account_info.initials}{else}<i class="bi bi-person"></i>{/if}</button>
                {if $account_info.two_factor}
                <a class="account-avatar-shop" href="{link route='info'}#two-factor" data-bs-toggle="tooltip" title="{lang key='website/index/account-2fa-enabled'}" aria-label="{lang key='website/index/account-2fa-enabled'}"><i class="bi bi-shield-fill-check"></i></a>
                {/if}
                <div class="dropdown-menu dropdown-menu-end nav-dropdown account-menu">
                    <div class="account-menu-head">
                        <span class="account-avatar-lg-wrap"><span class="account-avatar-lg">{if $account_info.avatar}<img class="account-avatar-img" src="{$account_info.avatar}" alt="">{elseif $account_info.initials}{$account_info.initials}{else}<i class="bi bi-person"></i>{/if}</span>{if $account_info.two_factor}<a class="account-avatar-shop" href="{link route='info'}#two-factor" data-bs-toggle="tooltip" title="{lang key='website/index/account-2fa-enabled'}" aria-label="{lang key='website/index/account-2fa-enabled'}"><i class="bi bi-shield-fill-check"></i></a>{/if}</span>
                        <span>
                            <a class="account-menu-name stretched-link" href="{link route='my-account'}">{$account_info.full_name}</a>
                            <span class="account-menu-email">{$account_info.email}</span>
                            {if $reseller_enabled && !empty($account_info.is_reseller)}
                            <span class="badge bg-primary-subtle text-primary-emphasis mt-1"><i class="bi bi-shop me-1"></i>{lang key='website/index/account-reseller-badge'}</span>
                            {/if}
                        </span>
                    </div>
                    {if $account_info.support_pin}
                    <div class="account-menu-balance">
                        <span data-bs-toggle="tooltip" title="{lang key='website/index/account-pin-hint'}"><i class="bi bi-shield-lock me-1"></i>{lang key='website/index/account-support-pin'}</span>
                        <span class="num-tabular fw-bold" data-role="pin-value">{$account_info.support_pin}</span>
                    </div>
                    {/if}
                    <a class="dropdown-item" href="{link route='my-account'}"><i class="bi bi-grid-1x2-fill"></i>{lang key='website/index/account-dashboard'}</a>
                    <a class="dropdown-item" href="{link route='balance'}"><i class="bi bi-wallet2"></i>{lang key='website/index/account-balance'}<span class="num-tabular fw-bold ms-auto" data-role="account-balance">{$account_info.balance}</span></a>
                    <a class="dropdown-item" href="{link route='info'}"><i class="bi bi-person-gear"></i>{lang key='website/index/account-settings'}</a>
                    <a class="dropdown-item" href="{link route='info'}#security"><i class="bi bi-shield-lock"></i>{lang key='website/index/account-security'}</a>
                    {if $affiliate_enabled}
                    <a class="dropdown-item" href="{link route='affiliate'}"><i class="bi bi-people"></i>{lang key='website/index/account-affiliate'}</a>
                    {/if}
                    {if $reseller_enabled && !empty($account_info.is_reseller)}
                    <a class="dropdown-item" href="{link route='reseller'}"><i class="bi bi-shop"></i>{lang key='website/index/account-reseller'}</a>
                    {/if}
                    <a class="dropdown-item" href="{link route='sub-accounts'}"><i class="bi bi-person-badge"></i>{lang key='website/index/account-subaccounts'}</a>
                    {if !empty($show_api_credentials)}<a class="dropdown-item" href="{link route='api'}"><i class="bi bi-key"></i>{lang key='website/index/account-api'}</a>{/if}
                    {hook name='ui:client.user_menu.items'}
                    <hr class="dropdown-divider">
                    <a class="dropdown-item" href="{link route='sign-out'}"><i class="bi bi-box-arrow-right"></i>{lang key='website/index/account-logout'}</a>
                </div>
            </div>
            {else}
            <div class="dropdown">
                <button class="btn btn-soft header-icon-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/index/nav-aria-account'}"><i class="bi bi-person"></i></button>
                <div class="dropdown-menu dropdown-menu-end nav-dropdown">
                    {if $login_enabled}
                    <a class="dropdown-item" href="{link route='sign-in'}">
                        <span class="icon-disc"><i class="bi bi-box-arrow-in-right"></i></span>
                        <span><span class="item-title">{lang key='website/index/auth-login'}</span><span class="item-desc">{lang key='website/index/auth-login-desc'}</span></span>
                    </a>
                    {/if}
                    {if $registration_enabled}
                    <a class="dropdown-item" href="{link route='sign-up'}">
                        <span class="icon-disc"><i class="bi bi-person-plus"></i></span>
                        <span><span class="item-title">{lang key='website/index/auth-signup'}</span><span class="item-desc">{lang key='website/index/auth-signup-desc'}</span></span>
                    </a>
                    {/if}
                </div>
            </div>
            {/if}
            {/if}
            {hook name='ui:client.header.actions'}
        </div>
    </nav>
</header>
