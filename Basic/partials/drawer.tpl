<div class="offcanvas offcanvas-start site-drawer" tabindex="-1" id="site-menu" aria-labelledby="site-menu-title">
    <div class="offcanvas-header">
        <span class="visually-hidden" id="site-menu-title">{lang key='website/index/nav-aria-main'}</span>
        <a class="site-brand d-inline-flex align-items-center{if $brand_no_logo} brand-no-logo{/if}" href="{if $only_client_panel}{link route='my-account'}{else}{link route='home'}{/if}">
            {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
            {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
            <span class="site-brand-text">{$brand_wordmark}</span>
        </a>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="{lang key='website/index/nav-aria-close'}"></button>
    </div>
    <div class="offcanvas-body d-flex flex-column">
        <nav class="drawer-nav mb-4" aria-label="{lang key='website/index/nav-aria-main'}">
            {foreach $mobile_menu as $item}
                {if $item.children}
            <button class="drawer-link" type="button" data-wui-toggle data-wui-target="#drawer-m-{$item.id}" aria-expanded="false" aria-controls="drawer-m-{$item.id}">{if $item.icon}<i class="{$item.icon}"></i>{/if}{$item.title}<i class="bi bi-chevron-down drawer-caret"></i></button>
            <div class="wui-collapse" id="drawer-m-{$item.id}">
                <div class="wui-collapse-inner">
                    <div class="drawer-sub">
                        {foreach $item.children as $child}
                        <a class="drawer-sublink"{if $child.link} href="{$child.link}"{/if}>{$child.title}</a>
                        {/foreach}
                    </div>
                </div>
            </div>
                {else}
            <a class="drawer-link"{if $item.link} href="{$item.link}"{/if}>{if $item.icon}<i class="{$item.icon}"></i>{/if}{$item.title}</a>
                {/if}
            {/foreach}
            {hook name='ui:client.drawer.items'}
        </nav>
        <div class="mt-auto">
        {include file='components/locale-switcher.tpl' idsuffix='-m' wrapclass='dropdown mb-3' toggleclass='btn btn-soft btn-sm w-100 dropdown-toggle' menuclass='dropdown-menu locale-menu w-100'}
        {if !$is_logged_in && $account_actions_enabled}
        <div class="d-grid gap-2">
            {if $login_enabled}<a class="btn btn-soft" href="{link route='sign-in'}">{lang key='website/index/auth-login'}</a>{/if}
            {if $registration_enabled}<a class="btn btn-primary" href="{link route='sign-up'}">{lang key='website/index/auth-signup'}</a>{/if}
        </div>
        {/if}
        </div>
    </div>
</div>
