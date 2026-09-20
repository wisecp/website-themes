{extends file='layouts/checkout.tpl'}


{block name=head}
    <link rel="stylesheet" href="{asset path='css/configure.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/configure-addon.js'}" defer></script>
{/block}

{block name=body_class}{if !$addon_services} checkout-shell-centered{/if}{/block}

{block name=content}

    {if !$addon_services}
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-8">
                <div class="card">
                    <div class="card-body p-4">
                        <div class="config-section-head">
                            <span class="icon-disc"><i class="bi bi-puzzle"></i></span>
                            <div>
                                <h1 class="h5 fw-semibold mb-1">{$addon.name}</h1>
                                {if $addon.description || $addon.store_url|default:''}<p class="fs-8 text-body-secondary mb-0">{if $addon.description}{$addon.description nofilter}{/if}{if $addon.store_url|default:''} <a class="addon-store-link" href="{$addon.store_url}" target="_blank" rel="noopener">{lang key='website/configure/addons/details'}</a>{/if}</p>{/if}
                            </div>
                        </div>
                        <div class="alert alert-info d-flex align-items-center gap-2 mb-3" role="alert">
                            <i class="bi bi-info-circle" aria-hidden="true"></i>
                            <span>{lang key='website/configure/addon/no-service'}</span>
                        </div>
                        <p class="fs-8 text-body-secondary">{lang key='website/configure/addon/no-service-note'}</p>
                        <a class="btn btn-primary btn-sm" href="{$services_link}">{lang key='website/configure/addon/goto-services'}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {else}

    <form id="configure-addon-form" action="{link route='cart'}" method="post" enctype="multipart/form-data" novalidate
        data-addon-configure
        data-currency="{$currency}"
        data-cart-link="{$cart_link}"
        data-show-by-pp="{if $addon.show_by_pp}1{else}0{/if}"
        data-txt-failed="{lang key='website/configure/addon/failed'}"
        data-txt-pick-service="{lang key='website/configure/addon/pick-service'}"
        data-txt-pick-option="{lang key='website/configure/addon/pick-option'}"
        data-txt-adding="{lang key='website/configure/adding-to-cart'}">

        <input type="hidden" name="operation" value="add_service_addon">
        <input type="hidden" name="addon_id" value="{$addon.id}">
        {csrf form='services'}

        <div class="checkout-split">
            <div class="checkout-split-main">
                <div class="checkout-split-main-inner">

                    <div class="card mb-3">
                        <div class="card-body p-4">
                            <div class="config-section-head">
                                <span class="icon-disc">{if $addon.icon}{if $addon.icon.type == 'image'}<img src="{$addon.icon.value}" alt="">{else}<i class="{$addon.icon.value}"></i>{/if}{else}<i class="bi bi-puzzle"></i>{/if}</span>
                                <div>
                                    <h1 class="h6 fw-semibold mb-1">{$addon.name}</h1>
                                    {if $addon.description || $addon.store_url|default:''}<p class="fs-8 text-body-secondary mb-0">{if $addon.description}{$addon.description nofilter}{/if}{if $addon.store_url|default:''} <a class="addon-store-link" href="{$addon.store_url}" target="_blank" rel="noopener">{lang key='website/configure/addons/details'}</a>{/if}</p>{/if}
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mb-3">
                        <div class="card-body p-4">
                            <div class="config-section-head">
                                <span class="icon-disc"><i class="bi bi-box-seam"></i></span>
                                <div>
                                    <h2 class="h6 fw-semibold">{lang key='website/configure/addon/service-title'}</h2>
                                    <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/addon/service-subtitle'}</p>
                                </div>
                            </div>
                            <div class="d-grid gap-2">
                                {foreach $addon_services as $service}
                                <label class="option-card option-card-radio">
                                    <input class="form-check-input" type="radio" name="service_id" value="{$service.id}" data-cycle="{$service.cycle}" data-label="{$service.name}" required{if $service@first} checked{/if}>
                                    <span class="d-flex align-items-center gap-3">
                                        <span class="me-auto">
                                            <span class="fw-semibold d-block">{$service.name}</span>
                                            <span class="fs-8 text-body-secondary">{if $service.domain}{$service.domain} · {/if}{$service.product_title}{if $service.cycle_label} · {$service.cycle_label}{/if}{if $service.duedate} · {lang key='website/configure/addon/due'} {$service.duedate}{/if}</span>
                                        </span>
                                        {if $service.upgrade}<span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-arrow-up-circle me-1"></i>{lang key='website/configure/addon/upgrade'}</span>{/if}
                                    </span>
                                </label>
                                {/foreach}
                            </div>
                        </div>
                    </div>

                    <div class="card mb-3">
                        <div class="card-body p-4">
                            <div class="config-section-head">
                                <span class="icon-disc"><i class="bi bi-sliders"></i></span>
                                <div>
                                    <h2 class="h6 fw-semibold">{lang key='website/configure/addon/option-title'}</h2>
                                    <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/addon/option-subtitle'}</p>
                                </div>
                            </div>
                            <div class="{if $addon.list_template == 1}option-grid{else}d-grid gap-2{/if}">
                                {foreach $addon_options as $opt}
                                {if $addon.list_template == 1}
                                <label class="option-card option-card-radio option-card-sm" data-option-cell>
                                    <input class="form-check-input" type="radio" name="option_id" value="{$opt.id}" data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-cycle-label="{$opt.cycle_label}" data-label="{$opt.name}" required{if $opt@first} checked{/if}>
                                    <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                                    {if $opt.description}<span class="fs-8 text-body-secondary d-block my-1">{$opt.description nofilter}</span>{/if}
                                    <span class="price-chip">{if $opt.free}{lang key='website/configure/addons/free'}{else}{$opt.amount_fmt}{/if}</span>
                                </label>
                                {else}
                                <div data-option-cell>
                                    <label class="option-card option-card-radio">
                                        <input class="form-check-input" type="radio" name="option_id" value="{$opt.id}" data-amount="{$opt.amount}" data-cycle="{$opt.cycle}" data-cycle-label="{$opt.cycle_label}" data-label="{$opt.name}" required{if $opt@first} checked{/if}>
                                        <span class="d-flex align-items-center gap-3">
                                            {if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}
                                            <span class="me-auto"><span class="fw-semibold d-block">{$opt.name}</span>{if $opt.description}<span class="fs-8 text-body-secondary">{$opt.description nofilter}</span>{/if}</span>
                                            <span class="price-chip">{if $opt.free}{lang key='website/configure/addons/free'}{else}{$opt.amount_fmt}{/if}</span>
                                        </span>
                                    </label>
                                </div>
                                {/if}
                                {/foreach}
                            </div>
                            <div class="alert alert-warning d-flex align-items-center gap-2 mt-3 mb-0 d-none" role="alert" data-role="addon-no-option">
                                <i class="bi bi-exclamation-triangle" aria-hidden="true"></i>
                                <span>{lang key='website/configure/addon/no-option'}</span>
                            </div>

                            {if $addon.type == 'quantity'}
                            <div class="range-field mt-3">
                                <label class="form-label" for="addon-qty">{lang key='website/configure/addon/quantity'}</label>
                                <div class="d-flex align-items-center gap-3">
                                    <input type="range" class="form-range" id="addon-qty" name="quantity" min="{$addon.min}" max="{$addon.max}" step="{$addon.step}" value="{$addon.min}" data-addon-qty>
                                    <span class="fw-semibold num-tabular" data-role="addon-qty-value">{$addon.min}</span>
                                </div>
                            </div>
                            {else}
                            <input type="hidden" name="quantity" value="1">
                            {/if}
                        </div>
                    </div>

                    {if $requirements}
                    <div class="card mb-3">
                        <div class="card-body p-4">
                            <div class="config-section-head">
                                <span class="icon-disc"><i class="bi bi-ui-checks"></i></span>
                                <div>
                                    <h2 class="h6 fw-semibold">{lang key='website/configure/configuration/title'}</h2>
                                    <p class="fs-8 text-body-secondary mb-0">{lang key='website/configure/configuration/subtitle'}</p>
                                </div>
                            </div>
                            {foreach $requirements as $req}
                            <div class="addon-group">
                                {if $req.type == 'input' || $req.type == 'password' || $req.type == 'textarea' || $req.type == 'file'}
                                <label for="cfg-req-{$req.id}" class="form-label d-flex align-items-center gap-2">{if $req.icon}<span class="label-media">{if $req.icon.type == 'image'}<img src="{$req.icon.value}" alt="">{else}<i class="{$req.icon.value}"></i>{/if}</span>{/if}{$req.name}{if $req.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                {if $req.type == 'textarea'}
                                <textarea class="form-control" id="cfg-req-{$req.id}" name="requirements[{$req.id}]" rows="3" autocomplete="off"{if $req.required} required{/if}></textarea>
                                {elseif $req.type == 'file'}
                                <div class="file-upload" data-file-upload data-txt-bad-type="{lang key='website/configure/configuration/file-bad-type'}" data-txt-too-large="{lang key='website/configure/configuration/file-too-large'}">
                                    <label class="file-upload-drop" for="cfg-req-{$req.id}">
                                        <input type="file" id="cfg-req-{$req.id}" name="requirements[{$req.id}]" class="visually-hidden"{if $req.allowed_ext} accept="{$req.allowed_ext}"{/if}{if $req.max_file_size} data-max-mb="{$req.max_file_size}"{/if}{if $req.required} required{/if}>
                                        <span class="icon-disc"><i class="bi bi-cloud-arrow-up"></i></span>
                                        <span><span class="fw-semibold">{lang key='website/configure/configuration/browse'}</span> {lang key='website/configure/configuration/drop'}</span>
                                        <span class="fs-8">{if $req.allowed_ext}{$req.allowed_ext}{/if}{if $req.allowed_ext && $req.max_file_size} · {/if}{if $req.max_file_size}{lang key='website/configure/configuration/file-max'} {$req.max_file_size} MB{/if}</span>
                                    </label>
                                    <ul class="file-upload-list" data-role="file-list"></ul>
                                </div>
                                {elseif $req.type == 'password'}
                                <div class="input-group">
                                    <input type="password" class="form-control" id="cfg-req-{$req.id}" name="requirements[{$req.id}]" autocomplete="off"{if $req.required} required{/if}>
                                    <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/configure/configuration/show'}"><i class="bi bi-eye"></i></button>
                                </div>
                                {else}
                                <input type="text" class="form-control" id="cfg-req-{$req.id}" name="requirements[{$req.id}]" autocomplete="off"{if $req.required} required{/if}>
                                {/if}
                                {if $req.description}<div class="form-text">{$req.description nofilter}</div>{/if}
                                {if $req.required}<div class="invalid-feedback">{lang key='website/configure/configuration/required'}</div>{/if}

                                {elseif $req.type == 'select'}
                                <label for="cfg-req-{$req.id}" class="form-label d-flex align-items-center gap-2">{if $req.icon}<span class="label-media">{if $req.icon.type == 'image'}<img src="{$req.icon.value}" alt="">{else}<i class="{$req.icon.value}"></i>{/if}</span>{/if}{$req.name}{if $req.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</label>
                                <select class="form-select" id="cfg-req-{$req.id}" name="requirements[{$req.id}]"{if $req.required} required{/if}>
                                    {if !$req.required}<option value="" selected>{lang key='website/configure/configuration/select'}</option>{/if}
                                    {foreach $req.groups as $grp}{if $grp.multi}<optgroup label="{$grp.name}">{foreach $grp.options as $opt}<option value="{$opt.id}"{if $opt.selected} selected{/if}>{$opt.label}</option>{/foreach}</optgroup>{else}{foreach $grp.options as $opt}<option value="{$opt.id}"{if $opt.selected} selected{/if}>{$opt.name}</option>{/foreach}{/if}{/foreach}
                                </select>
                                {if $req.description}<div class="form-text">{$req.description nofilter}</div>{/if}
                                {if $req.required}<div class="invalid-feedback">{lang key='website/configure/configuration/required-select'}</div>{/if}

                                {elseif $req.type == 'radio'}
                                <span class="form-label d-flex align-items-center gap-2">{if $req.icon}<span class="label-media">{if $req.icon.type == 'image'}<img src="{$req.icon.value}" alt="">{else}<i class="{$req.icon.value}"></i>{/if}</span>{/if}{$req.name}{if $req.required} <span class="text-danger" aria-hidden="true">*</span>{/if}</span>
                                {if $req.description}<span class="fs-8 text-body-secondary d-block mb-2">{$req.description nofilter}</span>{/if}
                                {* Grouped choices: family card (no input) + version grid below the row, same as configure.tpl *}
                                <div class="{if $req.list_template == 1}option-grid{else}d-grid gap-2{/if}" data-req-choices="{$req.id}">
                                    {foreach $req.groups as $grp}
                                    {if $grp.multi}
                                    <div class="option-card option-card-radio{if $req.list_template == 1} option-card-sm{/if}{if $grp.selected} option-card-active{/if}" data-req-family="{$req.id}-{$grp@index}" role="button" tabindex="0" aria-expanded="{if $grp.selected}true{else}false{/if}" aria-controls="cfg-req-{$req.id}-family-{$grp@index}">
                                        <span class="d-flex align-items-center gap-{if $req.list_template == 1}2{else}3{/if}">{if $grp.icon}<span class="option-media">{if $grp.icon.type == 'image'}<img src="{$grp.icon.value}" alt="">{else}<i class="{$grp.icon.value}"></i>{/if}</span>{/if}<span class="me-auto"><span class="fw-semibold d-block">{$grp.name}</span><span class="fs-8 text-body-secondary">{lang key='website/configure/configuration/group-versions' count=$grp.options|count}</span></span></span>
                                    </div>
                                    {else}
                                    {foreach $grp.options as $opt}
                                    {if $req.list_template == 1}
                                    <label class="option-card option-card-radio option-card-sm">
                                        <input class="form-check-input" type="radio" name="requirements[{$req.id}]" value="{$opt.id}"{if $opt.selected} checked{/if}{if $req.required} required{/if}>
                                        <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                                        {if $opt.description}<span class="fs-8 text-body-secondary d-block mt-1">{$opt.description nofilter}</span>{/if}
                                    </label>
                                    {else}
                                    <label class="option-card option-card-radio">
                                        <input class="form-check-input" type="radio" name="requirements[{$req.id}]" value="{$opt.id}"{if $opt.selected} checked{/if}{if $req.required} required{/if}>
                                        <span class="d-flex align-items-center gap-3">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="me-auto"><span class="fw-semibold d-block">{$opt.name}</span>{if $opt.description}<span class="fs-8 text-body-secondary">{$opt.description nofilter}</span>{/if}</span></span>
                                    </label>
                                    {/if}
                                    {/foreach}
                                    {/if}
                                    {/foreach}
                                </div>
                                {foreach $req.groups as $grp}{if $grp.multi}
                                <div class="option-versions{if !$grp.selected} d-none{/if}" id="cfg-req-{$req.id}-family-{$grp@index}" data-req-versions="{$req.id}-{$grp@index}">
                                    <span class="fs-8 text-body-secondary d-block mb-2">{lang key='website/configure/configuration/group-pick' group=$grp.name}</span>
                                    <div class="option-grid">
                                        {foreach $grp.options as $opt}
                                        <label class="option-card option-card-radio option-card-sm">
                                            <input class="form-check-input" type="radio" name="requirements[{$req.id}]" value="{$opt.id}"{if $opt.selected} checked{/if}{if $req.required} required{/if}>
                                            <span class="fw-semibold">{$opt.label}</span>
                                            {if $opt.description}<span class="fs-8 text-body-secondary d-block mt-1">{$opt.description nofilter}</span>{/if}
                                        </label>
                                        {/foreach}
                                    </div>
                                </div>
                                {/if}{/foreach}

                                {elseif $req.type == 'checkbox'}
                                <span class="fw-semibold d-flex align-items-center gap-2">{if $req.icon}<span class="label-media">{if $req.icon.type == 'image'}<img src="{$req.icon.value}" alt="">{else}<i class="{$req.icon.value}"></i>{/if}</span>{/if}{$req.name}</span>
                                {if $req.description}<span class="fs-8 text-body-secondary d-block mb-2">{$req.description nofilter}</span>{/if}
                                <div class="{if $req.list_template == 1}option-grid{else}d-grid gap-2{/if}">
                                    {foreach $req.options as $opt}
                                    {if $req.list_template == 1}
                                    <label class="option-card option-card-toggle option-card-sm">
                                        <input class="form-check-input" type="checkbox" name="requirements[{$req.id}][]" value="{$opt.id}"{if $opt.selected} checked{/if}>
                                        <span class="d-flex align-items-center gap-2">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="fw-semibold">{$opt.name}</span></span>
                                        {if $opt.description}<span class="fs-8 text-body-secondary d-block mt-1">{$opt.description nofilter}</span>{/if}
                                    </label>
                                    {else}
                                    <label class="option-card option-card-toggle">
                                        <input class="form-check-input" type="checkbox" name="requirements[{$req.id}][]" value="{$opt.id}"{if $opt.selected} checked{/if}>
                                        <span class="d-flex align-items-center gap-3">{if $opt.icon}<span class="option-media">{if $opt.icon.type == 'image'}<img src="{$opt.icon.value}" alt="">{else}<i class="{$opt.icon.value}"></i>{/if}</span>{/if}<span class="me-auto"><span class="fw-semibold d-block">{$opt.name}</span>{if $opt.description}<span class="fs-8 text-body-secondary">{$opt.description nofilter}</span>{/if}</span></span>
                                    </label>
                                    {/if}
                                    {/foreach}
                                </div>
                                {/if}
                            </div>
                            {/foreach}
                        </div>
                    </div>
                    {/if}
                </div>
            </div>

            <aside class="checkout-split-aside">
                <div class="checkout-split-aside-inner">
                    <div class="order-summary">
                        <div class="card-body p-4">
                            <h2 class="h6 fw-semibold mb-3">{lang key='website/configure/order-summary'}</h2>

                            <div class="order-summary-line">
                                <span class="summary-label">{$addon.name}<span class="summary-sub d-block" data-role="sum-option">—</span></span>
                                <span class="summary-value num-tabular" data-role="sum-line">—</span>
                            </div>
                            <div class="order-summary-line summary-addon">
                                <span class="summary-label">{lang key='website/configure/addon/sum-service'}</span>
                                <span class="summary-value" data-role="sum-service">—</span>
                            </div>
                            <div class="order-summary-line summary-addon" data-role="sum-qty-row" hidden>
                                <span class="summary-label">{lang key='website/configure/addon/quantity'}</span>
                                <span class="summary-value num-tabular" data-role="sum-qty">1</span>
                            </div>

                            <hr class="my-3">
                            <div class="order-summary-line order-summary-total mb-0">
                                <span class="summary-label">{lang key='website/configure/total-due'}</span>
                                <span class="summary-value num-tabular" data-role="sum-total">—</span>
                            </div>
                            <p class="fs-8 text-body-secondary mt-1 mb-3">{lang key='website/configure/addon/prorate-note'}</p>

                            <div class="alert alert-danger d-flex align-items-center gap-2 d-none" role="alert" data-role="addon-error">
                                <i class="bi bi-exclamation-circle" aria-hidden="true"></i>
                                <span data-role="addon-error-text"></span>
                            </div>

                            <div class="d-grid gap-2">
                                <button class="btn btn-primary" type="submit" form="configure-addon-form" data-role="addon-submit"><span data-role="addon-submit-label">{lang key='website/configure/addon/submit'}</span><i class="bi bi-arrow-right ms-2" aria-hidden="true"></i></button>
                                <a class="btn btn-soft btn-sm" href="{$services_link}">{lang key='website/configure/addon/cancel'}</a>
                            </div>
                        </div>
                    </div>
                </div>
            </aside>
        </div>
    </form>
    {/if}

{/block}
