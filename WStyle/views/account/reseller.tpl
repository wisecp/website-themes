{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/reseller.css'}">
    <script src="{asset path='js/list.js'}" defer></script>
{/block}

{block name=scripts}
    <script src="{asset path='js/reseller.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-5">
    <div class="container">

        <div class="list-pagehead">
            <div>
                <nav aria-label="{lang key='website/reseller/breadcrumb-aria'}">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                        <li class="breadcrumb-item active" aria-current="page">{lang key='website/reseller/title'}</li>
                    </ol>
                </nav>
                <h1 class="list-title">{lang key='website/reseller/title'}</h1>
            </div>
            <div class="rs-head-actions nav" aria-label="{lang key='website/reseller/views-aria'}">
                <button class="btn btn-soft btn-sm fw-semibold d-none active" id="rs-tab-dashboard" data-bs-toggle="tab" data-bs-target="#rs-pane-dashboard" type="button" role="tab" aria-controls="rs-pane-dashboard" aria-selected="true" data-rs-trigger="dashboard"><i class="bi bi-chevron-double-left me-1"></i>{lang key='website/index/subnav-dashboard'}</button>
                <button class="btn btn-soft btn-sm fw-semibold" id="rs-tab-rates" data-bs-toggle="tab" data-bs-target="#rs-pane-rates" type="button" role="tab" aria-controls="rs-pane-rates" aria-selected="false" data-rs-trigger="rates"><i class="bi bi-info-circle me-1"></i>{lang key='website/reseller/rates-conditions'}</button>
                <a class="btn btn-soft btn-sm fw-semibold" href="{$api_link}"><i class="bi bi-code-slash me-1"></i>{lang key='website/reseller/api-access'}</a>
            </div>
        </div>

        <div class="tab-content mt-4">

            <div class="tab-pane fade show active" id="rs-pane-dashboard" role="tabpanel" aria-labelledby="rs-tab-dashboard" tabindex="0">

                {hook name='ui:client.reseller_dashboard.top'}

                <div class="rs-kpis mb-4">
                    <div class="rs-kpi">
                        <i class="bi bi-cart-check rs-kpi-watermark text-primary-emphasis" aria-hidden="true"></i>
                        <div class="rs-kpi-top">
                            <span class="rs-kpi-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-cart-check"></i></span>
                            <span class="rs-kpi-label">{lang key='website/reseller/kpi-sales-today'}</span>
                        </div>
                        <span class="rs-kpi-value num-tabular">{$kpis.sales_today}</span>
                        <div class="rs-kpi-foot">
                            <span class="rs-kpi-foot-label">{lang key='website/reseller/kpi-sales-total'}</span>
                            <span class="rs-kpi-foot-value num-tabular">{$kpis.sales_total}</span>
                        </div>
                    </div>
                    <div class="rs-kpi">
                        <i class="bi bi-bag rs-kpi-watermark text-info-emphasis" aria-hidden="true"></i>
                        <div class="rs-kpi-top">
                            <span class="rs-kpi-ico bg-info-subtle text-info-emphasis"><i class="bi bi-bag"></i></span>
                            <span class="rs-kpi-label">{lang key='website/reseller/kpi-orders-today'}</span>
                        </div>
                        <span class="rs-kpi-value num-tabular">{$kpis.orders_today}</span>
                        <div class="rs-kpi-foot">
                            <span class="rs-kpi-foot-label">{lang key='website/reseller/kpi-orders-total'}</span>
                            <span class="rs-kpi-foot-value num-tabular">{$kpis.orders_total}</span>
                        </div>
                    </div>
                    <div class="rs-kpi">
                        <i class="bi bi-percent rs-kpi-watermark text-success-emphasis" aria-hidden="true"></i>
                        <div class="rs-kpi-top">
                            <span class="rs-kpi-ico bg-success-subtle text-success-emphasis"><i class="bi bi-percent"></i></span>
                            <span class="rs-kpi-label">{lang key='website/reseller/kpi-discount-today'}</span>
                        </div>
                        <span class="rs-kpi-value num-tabular">{$kpis.discount_today}</span>
                        <div class="rs-kpi-foot">
                            <span class="rs-kpi-foot-label">{lang key='website/reseller/kpi-discount-total'}</span>
                            <span class="rs-kpi-foot-value num-tabular">{$kpis.discount_total}</span>
                        </div>
                    </div>
                </div>

                <div class="rs-list-head">
                    <h2 class="rs-list-title">{lang key='website/reseller/orders-title'}</h2>
                    <p class="text-body-secondary fs-7 mb-0">{lang key='website/reseller/orders-subtitle'}</p>
                </div>

                {if $orders}
                <div class="list-toolbar mt-3">
                    <div class="list-search input-group">
                        <label class="input-group-text" for="list-search"><i class="bi bi-search"></i></label>
                        <input type="search" autocomplete="off" class="form-control" id="list-search" placeholder="{lang key='website/reseller/search-ph'}" aria-label="{lang key='website/reseller/search-ph'}">
                    </div>
                    <div class="list-controls">
                        <label for="list-status" class="form-label mb-0 list-control-label">{lang key='website/reseller/status-label'}</label>
                        <select class="form-select w-auto" id="list-status" aria-label="{lang key='website/reseller/status-label'}">
                            <option value="">{lang key='website/reseller/status-all'}</option>
                            <option value="active">{lang key='website/reseller/st-active'}</option>
                            <option value="pending">{lang key='website/reseller/st-pending'}</option>
                            <option value="closed">{lang key='website/reseller/status-closed'}</option>
                        </select>
                        <label for="list-sort" class="form-label mb-0 list-control-label">{lang key='website/reseller/sort-label'}</label>
                        <select class="form-select w-auto" id="list-sort" aria-label="{lang key='website/reseller/sort-label'}">
                            <option value="created">{lang key='website/reseller/sort-recent'}</option>
                            <option value="status">{lang key='website/reseller/sort-default'}</option>
                            <option value="price-desc">{lang key='website/reseller/sort-amount-desc'}</option>
                            <option value="price-asc">{lang key='website/reseller/sort-amount-asc'}</option>
                        </select>
                    </div>
                </div>

                <div class="list-rows" data-noun="orders" data-today="{$today_ymd}"
                    data-txt-count="{lang key='website/index/list-count'}"
                    data-txt-nores="{lang key='website/index/list-nores'}"
                    data-txt-noun="{lang key='website/reseller/noun'}">
                    {foreach $orders as $o}
                    <article class="list-item" data-status="{$o.seg}" data-name="{$o.name|lower}" data-search="{$o.search}" data-price="{$o.amount_raw}" data-due="{$o.due_ts}" data-start="{$o.ordered_ts}">
                        <span class="list-ico"><i class="bi {$o.icon}"></i></span>
                        <div class="list-main">
                            <div class="list-head">
                                <a class="list-name" href="{$o.invoice_link}">{$o.name}</a>
                                <span class="badge {$o.badge.class}"><i class="bi {$o.badge.icon} me-1"></i>{$o.badge.label}</span>
                            </div>
                            <div class="list-meta">
                                <span class="list-orderid num-tabular">{$o.order_no}</span>
                                {if $o.has_discount}<span class="list-chip"><i class="bi bi-percent"></i>{$o.rate_num}% {lang key='website/reseller/off'}</span>{/if}
                                {if $o.ordered}<span class="list-ident">{lang key='website/reseller/ordered'} {$o.ordered}</span>{/if}
                            </div>
                        </div>
                        <div class="list-side">
                            <div class="list-due">
                                {if $o.due}<span class="list-due-date num-tabular">{$o.due}</span>
                                {elseif $o.closed}<span class="list-due-none">{lang key='website/reseller/ended'}</span>{/if}
                            </div>
                            <div class="list-price">
                                <span class="list-amount num-tabular">{$o.amount}</span>
                                {if $o.cycle_label}<span class="list-cycle">{$o.cycle_label}</span>{/if}
                            </div>
                            <div class="list-actions">
                                <a class="btn btn-soft btn-sm list-manage" href="{$o.invoice_link}"><i class="bi bi-receipt me-1"></i>{lang key='website/reseller/action-invoice'}</a>
                            </div>
                        </div>
                    </article>
                    {/foreach}

                    <div class="list-empty wstyle-empty-state d-none" data-role="empty">
                        <i class="bi bi-inbox" aria-hidden="true"></i>
                        <span class="fw-semibold">{lang key='website/reseller/nores-title'}</span>
                        <span class="fs-7">{lang key='website/reseller/nores-text'}</span>
                        <button type="button" class="btn btn-soft btn-sm mt-1" data-action="list-clear"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/reseller/clear-filters'}</button>
                    </div>
                </div>

                <div class="list-foot">
                    <div class="list-foot-info">
                        <div class="list-perpage">
                            <label for="list-perpage" class="list-control-label mb-0">{lang key='website/index/list-perpage'}</label>
                            <select class="form-select form-select-sm w-auto" id="list-perpage" aria-label="{lang key='website/index/list-perpage'}">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select>
                        </div>
                        <p class="list-count num-tabular mb-0" data-role="count" aria-live="polite"></p>
                    </div>
                    <nav class="list-pagination" aria-label="{lang key='website/reseller/pagination-aria'}" data-role="pagination"><ul class="pagination pagination-sm m-0"></ul></nav>
                </div>
                {else}
                <div class="wstyle-empty-state mt-3">
                    <i class="bi bi-bag" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/reseller/empty-title'}</span>
                    <span class="fs-7">{lang key='website/reseller/empty-text'}</span>
                    <a class="btn btn-primary btn-sm mt-1" href="{link route='home'}"><i class="bi bi-bag me-1"></i>{lang key='website/reseller/browse-products'}</a>
                </div>
                {/if}
            </div>

            <div class="tab-pane fade" id="rs-pane-rates" role="tabpanel" aria-labelledby="rs-tab-rates" tabindex="0">

                <p class="text-body-secondary mb-4">{lang key='website/reseller/rates-intro'}</p>

                {if $tiers}
                <div class="card rs-card mb-4">
                    <div class="card-body p-4">
                        <div class="d-flex flex-wrap align-items-end justify-content-between gap-3 mb-3">
                            <div>
                                <h3 class="h5 mb-1">{lang key='website/reseller/rates-by-product'}</h3>
                                <p class="text-body-secondary fs-7 mb-0">{lang key='website/reseller/rates-by-product-note'}</p>
                            </div>
                            <select class="form-select rs-product-select" id="rs-product" aria-label="{lang key='website/reseller/product-aria'}" data-action="rs-product">
                                {foreach $tiers as $t}
                                <option value="{$t.key}"{if $t@first} selected{/if}>{$t.full_name}</option>
                                {/foreach}
                            </select>
                        </div>

                        {foreach $tiers as $t}
                        <div class="rs-tier-table{if !$t@first} d-none{/if}" data-rs-tiers="{$t.key}">
                            <div class="rs-tier-row rs-tier-head">
                                <span>{lang key='website/reseller/tier-head-services'}</span>
                                <span class="rs-tier-rate">{lang key='website/reseller/tier-head-discount'}</span>
                            </div>
                            {foreach $t.items as $it}
                            <div class="rs-tier-row{if $it.current} is-current{/if}">
                                <span class="rs-tier-range num-tabular">{$it.from} - {$it.to}{if $it.current}<span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/reseller/your-tier'}</span>{/if}</span>
                                <span class="rs-tier-rate num-tabular">{$it.rate}%</span>
                            </div>
                            {/foreach}
                        </div>
                        {/foreach}
                    </div>
                </div>
                {/if}

                <div class="card rs-card">
                    <div class="card-body p-4">
                        <h3 class="h5 mb-3">{lang key='website/reseller/how-title'}</h3>
                        <div class="row g-4">
                            <div class="col-md-6 col-xl-4">
                                <div class="rs-feature">
                                    <span class="icon-disc"><i class="bi bi-lightning-charge"></i></span>
                                    <div>
                                        <h4 class="h6 mb-1">{lang key='website/reseller/feat-auto-title'}</h4>
                                        <p class="text-body-secondary fs-7 mb-0">{lang key='website/reseller/feat-auto-text'}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <div class="rs-feature">
                                    <span class="icon-disc"><i class="bi bi-graph-up-arrow"></i></span>
                                    <div>
                                        <h4 class="h6 mb-1">{lang key='website/reseller/feat-grow-title'}</h4>
                                        <p class="text-body-secondary fs-7 mb-0">{lang key='website/reseller/feat-grow-text'}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <div class="rs-feature">
                                    <span class="icon-disc"><i class="bi bi-bar-chart-line"></i></span>
                                    <div>
                                        <h4 class="h6 mb-1">{lang key='website/reseller/feat-visibility-title'}</h4>
                                        <p class="text-body-secondary fs-7 mb-0">{lang key='website/reseller/feat-visibility-text'}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <div class="rs-feature">
                                    <span class="icon-disc"><i class="bi bi-code-slash"></i></span>
                                    <div>
                                        <h4 class="h6 mb-1">{lang key='website/reseller/feat-api-title'}</h4>
                                        <p class="text-body-secondary fs-7 mb-0">{lang key='website/reseller/feat-api-text'}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-4">
                                <div class="rs-feature">
                                    <span class="icon-disc"><i class="bi bi-headset"></i></span>
                                    <div>
                                        <h4 class="h6 mb-1">{lang key='website/reseller/feat-help-title'}</h4>
                                        <p class="text-body-secondary fs-7 mb-0">{lang key='website/reseller/feat-help-text'}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
{/block}
