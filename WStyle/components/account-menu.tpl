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
