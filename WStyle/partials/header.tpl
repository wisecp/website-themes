{function name=wstyle_nav_item item=[]}
<a class="dropdown-item"{if $item.link} href="{$item.link}"{/if}>
    {if $item.icon}<span class="icon-disc"><i class="{$item.icon}"></i></span>{/if}
    <span><span class="item-title">{$item.title}{if $item.extra.tag ?? false}<span class="badge" style="background-color:{$item.extra.tag.color};color:{$item.extra.tag.text_color}">{if $item.extra.tag.icon ?? ''}<i class="{$item.extra.tag.icon} me-1"></i>{/if}{$item.extra.tag.name}</span>{/if}</span>{if $item.extra.desc ?? ''}<span class="item-desc">{$item.extra.desc}</span>{/if}</span>
</a>
{/function}
<header class="site-header chrome-dark">
    <nav class="container d-flex align-items-center py-2" aria-label="{lang key='website/index/nav-aria-main'}">
        <a class="site-brand d-flex align-items-center me-lg-5{if $brand_no_logo} brand-no-logo{/if}" href="{link route='home'}">
            {if $light_logo_link}<img src="{$light_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-light">{/if}
            {if $dark_logo_link}<img src="{$dark_logo_link}" alt="{lang key='website/index/logo-alt'}" class="site-logo site-logo-dark">{/if}
            <span class="site-brand-text">{$brand_wordmark}</span>
        </a>
        <button class="btn btn-ghost header-icon-btn drawer-toggle d-lg-none ms-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#site-menu" aria-controls="site-menu" aria-label="{lang key='website/index/nav-aria-open'}"><i class="bi bi-list fs-4"></i></button>
        <ul class="nav site-nav d-none d-lg-flex">
            {foreach $header_menu as $item}
                {if $item.extra.mega ?? ''}
            <li class="nav-item dropdown">
                <a class="nav-link"{if $item.link} href="{$item.link}"{/if}>{$item.title}<i class="bi bi-chevron-down nav-chevron"></i></a>
                <div class="dropdown-menu nav-dropdown nav-mega">{$item.extra.mega nofilter}</div>
            </li>
                {else}
                {$mega_groups = []}
                {$mega_flat = []}
                {foreach $item.children as $child}
                    {if $child.children}{$mega_groups[] = $child}{else}{$mega_flat[] = $child}{/if}
                {/foreach}
                {if $item.children && count($mega_groups) >= 2}
            <li class="nav-item dropdown">
                <a class="nav-link"{if $item.link} href="{$item.link}"{/if}>{$item.title}<i class="bi bi-chevron-down nav-chevron"></i></a>
                <div class="dropdown-menu nav-dropdown nav-mega">
                    <div class="nav-mega-grid">
                        {foreach $mega_groups as $group}
                        <div class="nav-mega-col">
                            {if $group.title}<span class="nav-mega-label">{$group.title}</span>{/if}
                            {foreach $group.children as $child}
                            {call name=wstyle_nav_item item=$child}
                            {/foreach}
                        </div>
                        {/foreach}
                        {if $mega_flat}
                        <div class="nav-mega-col">
                            {foreach $mega_flat as $child}
                            {call name=wstyle_nav_item item=$child}
                            {/foreach}
                        </div>
                        {/if}
                    </div>
                </div>
            </li>
                {elseif $item.children}
            <li class="nav-item dropdown">
                <a class="nav-link"{if $item.link} href="{$item.link}"{/if}>{$item.title}<i class="bi bi-chevron-down nav-chevron"></i></a>
                <div class="dropdown-menu nav-dropdown">
                    {foreach $item.children as $child}
                        {if $child.children}
                    <div class="dropdown-sub">
                        <a class="dropdown-item nav-sub-toggle"{if $child.link} href="{$child.link}"{/if} aria-haspopup="true">
                            {if $child.icon}<span class="icon-disc"><i class="{$child.icon}"></i></span>{/if}
                            <span><span class="item-title">{$child.title}{if $child.extra.tag ?? false}<span class="badge" style="background-color:{$child.extra.tag.color};color:{$child.extra.tag.text_color}">{if $child.extra.tag.icon ?? ''}<i class="{$child.extra.tag.icon} me-1"></i>{/if}{$child.extra.tag.name}</span>{/if}</span>{if $child.extra.desc ?? ''}<span class="item-desc">{$child.extra.desc}</span>{/if}</span>
                            <i class="bi bi-chevron-right nav-sub-caret"></i>
                        </a>
                        <div class="dropdown-menu nav-dropdown nav-sub-menu">
                            {foreach $child.children as $grandchild}
                            {call name=wstyle_nav_item item=$grandchild}
                            {/foreach}
                        </div>
                    </div>
                        {else}
                    {call name=wstyle_nav_item item=$child}
                        {/if}
                    {/foreach}
                </div>
            </li>
                {else}
            <li class="nav-item"><a class="nav-link"{if $item.link} href="{$item.link}"{/if}>{$item.title}</a></li>
                {/if}
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
            {include file='components/account-menu.tpl'}
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
