{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/sub-accounts.css'}">
    <script src="{asset path='js/sub-accounts.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-5" data-sa-page data-sa-url="{link route='sub-accounts'}" data-txt-remove-title="{lang key='website/sub-accounts/remove-title'}" data-txt-remove-msg="{lang key='website/sub-accounts/remove-msg'}" data-txt-remove-ok="{lang key='website/sub-accounts/act-remove'}" data-txt-cancel="{lang key='website/sub-accounts/cancel'}" data-txt-sent="{lang key='website/sub-accounts/sent'}" data-txt-link-copied="{lang key='website/sub-accounts/link-copied'}">
    <div class="container">
        {csrf form='sub-accounts'}

            <nav aria-label="{lang key='website/sub-accounts/breadcrumb-aria'}">
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">{lang key='website/sub-accounts/title'}</li>
                </ol>
            </nav>
            <div class="sa-pagehead">
                <h1 class="list-title mb-0">{lang key='website/sub-accounts/title'}</h1>
                <div class="sa-pagehead-end">
                    <p class="sa-pagehead-sub mb-0 text-body-secondary">{lang key='website/sub-accounts/lead'}</p>
                    <button type="button" class="btn btn-primary" data-action="sa-invite"><i class="bi bi-person-plus me-1"></i>{lang key='website/sub-accounts/invite'}</button>
                </div>
            </div>

            <div class="sa-note">
                <i class="bi bi-info-circle" aria-hidden="true"></i>
                <p>{lang key='website/sub-accounts/note'}</p>
            </div>

            <div class="sa-list" data-role="sa-list">

                <article class="sa-user sa-user-owner" data-user-id="owner">
                    <span class="sa-ava{if $sa_owner.avatar} sa-ava-photo{/if}">{if $sa_owner.avatar}<img src="{$sa_owner.avatar}" alt="">{elseif $sa_owner.initials}{$sa_owner.initials}{else}<i class="bi bi-person"></i>{/if}</span>
                    <div class="sa-user-main">
                        <div class="sa-user-head">
                            <span class="sa-user-name">{$sa_owner.name}</span>
                            <span class="sa-user-you">{lang key='website/sub-accounts/you'}</span>
                            <span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-person-badge me-1"></i>{lang key='website/index/account-owner'}</span>
                        </div>
                        <div class="sa-user-meta">
                            <span class="list-chip"><i class="bi bi-envelope"></i>{$sa_owner.email}</span>
                        </div>
                        <div class="sa-user-access">
                            <span class="sa-access is-full"><i class="bi bi-shield-lock-fill"></i>{lang key='website/sub-accounts/access-full'}</span>
                        </div>
                    </div>
                </article>

                {foreach $sa_users as $u}
                <article class="sa-user{if $u.status == 'pending'} sa-user-pending{elseif $u.status == 'inactive'} sa-user-suspended{/if}" data-user-id="{$u.id}" data-status="{$u.status}" data-perms="{$u.perms_attr}" data-name="{$u.name|escape}" data-email="{$u.email|escape}"{if $u.invite_url} data-invite-url="{$u.invite_url}"{/if}>
                    <span class="sa-ava{if $u.status == 'pending'} sa-ava-pending{/if}">{if $u.status == 'pending'}<i class="bi bi-envelope-paper"></i>{else}{$u.initials}{/if}</span>
                    <div class="sa-user-main">
                        <div class="sa-user-head">
                            <span class="sa-user-name">{$u.name}</span>
                            {if $u.status == 'pending'}<span class="badge bg-warning-subtle text-warning-emphasis" data-role="sa-status"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/sub-accounts/st-pending'}</span>
                            {elseif $u.status == 'inactive'}<span class="badge bg-secondary-subtle text-secondary-emphasis" data-role="sa-status"><i class="bi bi-pause-circle me-1"></i>{lang key='website/sub-accounts/st-suspended'}</span>
                            {else}<span class="badge bg-success-subtle text-success-emphasis" data-role="sa-status"><i class="bi bi-check-circle me-1"></i>{lang key='website/sub-accounts/st-active'}</span>{/if}
                        </div>
                        <div class="sa-user-meta">
                            <span class="list-chip"><i class="bi bi-envelope"></i>{$u.email}</span>
                            {if $u.when}<span class="sa-user-dim">{$u.when}</span>{/if}
                        </div>
                        <div class="sa-user-access">
                            <span class="sa-access{if $u.access_level == 'full'} is-full{/if}" data-role="sa-access"><i class="bi {if $u.access_level == 'full'}bi-shield-lock-fill{elseif $u.access_level == 'billing'}bi-receipt{elseif $u.access_level == 'support'}bi-life-preserver{else}bi-sliders{/if}"></i>{$u.access_label}</span>
                            {if $u.access_sub}<span class="sa-user-dim" data-role="sa-access-sub">{$u.access_sub}</span>{/if}
                        </div>
                    </div>
                    <div class="sa-user-actions">
                        {if $u.status == 'pending'}
                        <button type="button" class="btn btn-soft btn-sm" data-action="sa-resend" data-user-id="{$u.id}" data-user-name="{$u.name|escape}" data-busy-text="{lang key='website/sub-accounts/busy-sending'}"><i class="bi bi-send me-1"></i>{lang key='website/sub-accounts/act-resend'}</button>
                        <div class="dropdown">
                            <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/sub-accounts/more-actions'}"><i class="bi bi-three-dots"></i></button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><button type="button" class="dropdown-item" data-action="sa-edit" data-user-id="{$u.id}"><i class="bi bi-sliders"></i>{lang key='website/sub-accounts/act-edit'}</button></li>
                                {if $u.invite_url}<li><button type="button" class="dropdown-item" data-action="sa-copy-link" data-user-id="{$u.id}"><i class="bi bi-link-45deg"></i>{lang key='website/sub-accounts/act-copy-link'}</button></li>{/if}
                                <li><hr class="dropdown-divider"></li>
                                <li><button type="button" class="dropdown-item text-danger" data-action="sa-remove" data-user-id="{$u.id}" data-user-name="{$u.name|escape}"><i class="bi bi-x-circle"></i>{lang key='website/sub-accounts/act-cancel'}</button></li>
                            </ul>
                        </div>
                        {else}
                        <button type="button" class="btn btn-soft btn-sm" data-action="sa-edit" data-user-id="{$u.id}"><i class="bi bi-sliders me-1"></i>{lang key='website/sub-accounts/act-edit'}</button>
                        <div class="dropdown">
                            <button type="button" class="btn btn-soft btn-sm" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/sub-accounts/more-actions'}"><i class="bi bi-three-dots"></i></button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                {if $u.status == 'inactive'}<li><button type="button" class="dropdown-item" data-action="sa-enable" data-user-id="{$u.id}" data-user-name="{$u.name|escape}"><i class="bi bi-play-circle"></i>{lang key='website/sub-accounts/act-enable'}</button></li>
                                {else}<li><button type="button" class="dropdown-item" data-action="sa-suspend" data-user-id="{$u.id}" data-user-name="{$u.name|escape}"><i class="bi bi-pause-circle"></i>{lang key='website/sub-accounts/act-suspend'}</button></li>{/if}
                                <li><hr class="dropdown-divider"></li>
                                <li><button type="button" class="dropdown-item text-danger" data-action="sa-remove" data-user-id="{$u.id}" data-user-name="{$u.name|escape}"><i class="bi bi-trash3"></i>{lang key='website/sub-accounts/act-remove'}</button></li>
                            </ul>
                        </div>
                        {/if}
                    </div>
                </article>
                {/foreach}

                <div class="wstyle-empty-state{if $sa_users} d-none{/if}" data-role="sa-empty">
                    <i class="bi bi-person-badge" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/sub-accounts/empty-title'}</span>
                    <span class="fs-7">{lang key='website/sub-accounts/empty-text'}</span>
                    <button type="button" class="btn btn-soft btn-sm mt-1" data-action="sa-invite"><i class="bi bi-person-plus me-1"></i>{lang key='website/sub-accounts/empty-cta'}</button>
                </div>
            </div>

            {hook name='ui:client.sub_accounts.list.after'}

        </div>
    </section>
{/block}

{block name=body_end}
<div class="modal fade" id="sa-invite-modal" tabindex="-1" aria-labelledby="sa-invite-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon modal-icon--primary" data-role="sa-modal-ico"><i class="bi bi-person-plus"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="sa-invite-title" data-role="sa-modal-title">{lang key='website/sub-accounts/modal-invite-title'}</h2>
                    <p class="modal-subtitle" data-role="sa-modal-sub">{lang key='website/sub-accounts/modal-invite-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/sub-accounts/close'}"></button>
            </div>
            <form id="sa-invite-form" novalidate
                  data-txt-edit-title="{lang key='website/sub-accounts/modal-edit-title'}"
                  data-txt-edit-sub="{lang key='website/sub-accounts/modal-edit-sub'}"
                  data-txt-invite-title="{lang key='website/sub-accounts/modal-invite-title'}"
                  data-txt-invite-sub="{lang key='website/sub-accounts/modal-invite-sub'}"
                  data-txt-save="{lang key='website/sub-accounts/save'}"
                  data-txt-send="{lang key='website/sub-accounts/invite'}"
                  data-txt-saving="{lang key='website/sub-accounts/busy-saving'}"
                  data-txt-sending="{lang key='website/sub-accounts/busy-sending'}">
                <input type="hidden" name="subuser_id" value="">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-sm-7">
                            <label for="sa-inv-email" class="form-label">{lang key='website/sub-accounts/email'} <span class="text-danger" aria-hidden="true">*</span></label>
                            <input type="email" class="form-control" id="sa-inv-email" name="email" autocomplete="off" placeholder="name@example.com" required>
                            <div class="invalid-feedback">{lang key='website/sub-accounts/err-email-invalid'}</div>
                        </div>
                        <div class="col-sm-5">
                            <label for="sa-inv-name" class="form-label">{lang key='website/sub-accounts/name'} <span class="text-body-secondary fw-normal">{lang key='website/sub-accounts/optional'}</span></label>
                            <input type="text" class="form-control" id="sa-inv-name" name="name" autocomplete="off" placeholder="e.g. Michael Chen">
                        </div>
                    </div>

                    <h3 class="sa-modal-section">{lang key='website/sub-accounts/access-level'}</h3>
                    <div class="sa-presets" role="group" aria-label="{lang key='website/sub-accounts/access-level'}">
                        <button type="button" class="sa-preset is-active" data-action="sa-preset" data-preset="full" aria-pressed="true">
                            <span class="sa-preset-ico"><i class="bi bi-shield-lock"></i></span>
                            <span class="sa-preset-text"><span class="sa-preset-name">{lang key='website/sub-accounts/access-full'}</span><span class="sa-preset-desc">{lang key='website/sub-accounts/preset-full-d'}</span></span>
                            <i class="bi bi-check-circle-fill sa-preset-check" aria-hidden="true"></i>
                        </button>
                        <button type="button" class="sa-preset" data-action="sa-preset" data-preset="billing" aria-pressed="false">
                            <span class="sa-preset-ico"><i class="bi bi-receipt"></i></span>
                            <span class="sa-preset-text"><span class="sa-preset-name">{lang key='website/sub-accounts/access-billing'}</span><span class="sa-preset-desc">{lang key='website/sub-accounts/preset-billing-d'}</span></span>
                            <i class="bi bi-check-circle-fill sa-preset-check" aria-hidden="true"></i>
                        </button>
                        <button type="button" class="sa-preset" data-action="sa-preset" data-preset="support" aria-pressed="false">
                            <span class="sa-preset-ico"><i class="bi bi-life-preserver"></i></span>
                            <span class="sa-preset-text"><span class="sa-preset-name">{lang key='website/sub-accounts/access-support'}</span><span class="sa-preset-desc">{lang key='website/sub-accounts/preset-support-d'}</span></span>
                            <i class="bi bi-check-circle-fill sa-preset-check" aria-hidden="true"></i>
                        </button>
                        <button type="button" class="sa-preset" data-action="sa-preset" data-preset="custom" aria-pressed="false">
                            <span class="sa-preset-ico"><i class="bi bi-sliders"></i></span>
                            <span class="sa-preset-text"><span class="sa-preset-name">{lang key='website/sub-accounts/access-custom'}</span><span class="sa-preset-desc">{lang key='website/sub-accounts/preset-custom-d'}</span></span>
                            <i class="bi bi-check-circle-fill sa-preset-check" aria-hidden="true"></i>
                        </button>
                    </div>

                    <h3 class="sa-modal-section">{lang key='website/sub-accounts/permissions'}</h3>
                    <p class="form-text sa-perm-intro">{lang key='website/sub-accounts/perm-intro'}</p>

                    <div class="sa-perms" data-role="sa-perms" data-sa-presets='{$sa_presets_json nofilter}'>
                        {foreach $sa_perm_groups as $gkey => $g}
                        <section class="sa-perm-group">
                            <div class="sa-perm-group-head">
                                <span class="sa-perm-group-ico"><i class="bi {$g.icon}"></i></span>
                                <span class="sa-perm-group-title">{$g.label}</span>
                                <span class="form-check form-switch sa-switch sa-group-switch">
                                    <input class="form-check-input" type="checkbox" role="switch" id="sa-grp-{$gkey}" data-action="sa-group-toggle" aria-label="{$g.label}">
                                </span>
                            </div>
                            <div class="sa-perm-rows">
                                {foreach $g.perms as $pkey => $p}
                                <label class="sa-perm-row">
                                    <span class="sa-perm-text"><span class="sa-perm-name">{$p.label}</span><span class="sa-perm-desc">{$p.desc}</span></span>
                                    <span class="form-check form-switch sa-switch"><input class="form-check-input" type="checkbox" role="switch" data-perm="{$pkey}"{if !empty($p.requires)} data-perm-requires="{$p.requires}"{/if} aria-label="{$p.label}"></span>
                                </label>
                                {/foreach}
                            </div>
                        </section>
                        {/foreach}
                    </div>
                </div>
                <div class="modal-footer">
                    <p class="sa-perm-warn d-none" data-role="sa-perm-warn"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/sub-accounts/err-no-permission'}</p>
                    <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/sub-accounts/busy-sending'}" data-role="sa-submit"><i class="bi bi-send me-1"></i>{lang key='website/sub-accounts/invite'}</button>
                </div>
            </form>
        </div>
    </div>
</div>
{/block}
