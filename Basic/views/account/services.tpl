{extends file='layouts/default.tpl'}

{block name=head}
    <script src="{asset path='js/list.js'}" defer></script>
{/block}

{block name=scripts}
    <script src="{asset path='js/services.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-4 pt-lg-4 pb-lg-5">
    <div class="container list-page" data-services-page>
        {csrf form='services'}

        <div class="list-pagehead">
            <div>
                <nav aria-label="{lang key='website/services/breadcrumb-aria'}">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                        <li class="breadcrumb-item active" aria-current="page">{lang key='website/services/title'}</li>
                    </ol>
                </nav>
                <h1 class="list-title">{lang key='website/services/title'}</h1>
            </div>
            {if $order_service_link}
            <div class="d-flex flex-wrap gap-2 list-headactions">
                <a class="btn btn-soft btn-sm fw-semibold list-order" href="{$order_service_link}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/services/order-service'}</a>
            </div>
            {/if}
        </div>

        {hook name='ui:client.services_list.top'}

        {if $has_services}
        <div class="list-summary" role="group" aria-label="{lang key='website/services/tiles-aria'}">
            <button type="button" class="list-tile list-tile-primary is-active" data-seg="all" aria-pressed="true">
                <i class="bi bi-hdd-stack list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-hdd-stack"></i></span>
                <span>
                    <span class="list-tile-value num-tabular d-block">{$tiles.total}</span>
                    <span class="list-tile-label d-block">{lang key='website/services/tile-total'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-success" data-seg="active" aria-pressed="false">
                <i class="bi bi-check-circle list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-check-circle"></i></span>
                <span>
                    <span class="list-tile-value num-tabular d-block">{$tiles.active}</span>
                    <span class="list-tile-label d-block">{lang key='website/services/st-active'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-warning" data-seg="due" aria-pressed="false">
                <i class="bi bi-clock-history list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-clock-history"></i></span>
                <span>
                    <span class="list-tile-value num-tabular d-block">{$tiles.due}</span>
                    <span class="list-tile-label d-block">{lang key='website/services/tile-due'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-danger" data-seg="attention" aria-pressed="false">
                <i class="bi bi-exclamation-triangle list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-exclamation-triangle"></i></span>
                <span>
                    <span class="list-tile-value num-tabular d-block">{$tiles.attention}</span>
                    <span class="list-tile-label d-block">{lang key='website/services/tile-attention'}</span>
                </span>
            </button>
        </div>

        {hook name='ui:client.services_list.tiles.after'}

        {if $attention}
        <div class="list-attention" role="region" aria-label="{lang key='website/services/attention-aria'}">
            {foreach $attention as $a}
            <div class="list-alert list-alert-danger" data-alert-id="{$a.id}">
                <i class="{$a.icon} list-alert-ico" aria-hidden="true"></i>
                <div class="list-alert-body"><strong>{$a.name}</strong> {$a.text}</div>
                {if $show_invoices_link}<a class="btn btn-sm btn-outline-danger" href="{$invoices_link}"><i class="bi bi-receipt me-1"></i>{lang key='website/services/view-invoices'}</a>{/if}
                <button type="button" class="basic-alert-close" data-action="dismiss-alert" aria-label="{lang key='website/services/dismiss'}"><i class="bi bi-x-lg" aria-hidden="true"></i></button>
            </div>
            {/foreach}
        </div>
        {/if}

        <div class="list-toolbar">
            <div class="list-search input-group">
                <label class="input-group-text" for="list-search"><i class="bi bi-search"></i></label>
                <input type="search" autocomplete="off" name="q" data-lpignore="true" data-1p-ignore data-form-type="other" class="form-control" id="list-search" placeholder="{lang key='website/services/search-ph'}" aria-label="{lang key='website/services/search-ph'}">
            </div>
            <div class="list-controls">
                <label for="list-type" class="form-label mb-0 list-control-label">{lang key='website/services/type-label'}</label>
                <select class="form-select w-auto" id="list-type" aria-label="{lang key='website/services/type-label'}">
                    <option value="">{lang key='website/services/type-all'}</option>
                    {foreach $types as $g => $label}<option value="{$g}">{$label}</option>{/foreach}
                </select>
                <label for="list-status" class="form-label mb-0 list-control-label">{lang key='website/services/status-label'}</label>
                <select class="form-select w-auto" id="list-status" aria-label="{lang key='website/services/status-label'}">
                    <option value="">{lang key='website/services/status-all'}</option>
                    <option value="active">{lang key='website/services/st-active'}</option>
                    <option value="pending">{lang key='website/services/st-pending'}</option>
                    <option value="suspended">{lang key='website/services/st-suspended'}</option>
                    <option value="expired">{lang key='website/services/st-expired'}</option>
                    <option value="cancelled">{lang key='website/services/st-cancelled'}</option>
                </select>
                <label for="list-sort" class="form-label mb-0 list-control-label">{lang key='website/services/sort-label'}</label>
                <select class="form-select w-auto" id="list-sort" aria-label="{lang key='website/services/sort-label'}">
                    <option value="status">{lang key='website/services/sort-default'}</option>
                    <option value="due">{lang key='website/services/sort-due'}</option>
                    <option value="name">{lang key='website/services/sort-name'}</option>
                    <option value="price-desc">{lang key='website/services/sort-price-desc'}</option>
                    <option value="price-asc">{lang key='website/services/sort-price-asc'}</option>
                    <option value="created">{lang key='website/services/sort-created'}</option>
                </select>
            </div>
        </div>

        <div class="list-rows" data-noun="services" data-today="{$today_ymd}"
            data-op-url="{link route='services'}"{if $table_ajax} data-ajax="{$table_ajax}"{/if}
            data-txt-count="{lang key='website/index/list-count'}"
            data-txt-nores="{lang key='website/index/list-nores'}"
            data-txt-noun="{lang key='website/services/noun'}"
            data-txt-autorenew-on="{lang key='website/services/autorenew-on'}"
            data-txt-autorenew-off="{lang key='website/services/autorenew-off'}">
            <div class="list-skeleton" aria-hidden="true">
                {for $i=1 to 5}
                <div class="list-skel-row">
                    <span class="basic-skeleton list-skel-ico"></span>
                    <div class="list-skel-main"><span class="basic-skeleton list-skel-line is-title"></span><span class="basic-skeleton list-skel-line is-meta"></span></div>
                    <div class="list-skel-side"><span class="basic-skeleton list-skel-line"></span><span class="basic-skeleton list-skel-line is-price"></span><span class="basic-skeleton list-skel-btn"></span></div>
                </div>
                {/for}
            </div>

            {$rows_html nofilter}

            <div class="list-empty basic-empty-state d-none" data-role="empty">
                <i class="bi bi-inbox" aria-hidden="true"></i>
                <span class="fw-semibold">{lang key='website/services/nores-title'}</span>
                <span class="fs-7">{lang key='website/services/nores-text'}</span>
                <button type="button" class="btn btn-soft btn-sm mt-1" data-action="list-clear"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/services/clear-filters'}</button>
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
            <nav class="list-pagination" aria-label="{lang key='website/services/pagination-aria'}" data-role="pagination"><ul class="pagination pagination-sm m-0"></ul></nav>
        </div>
        {if $list_tax_inclusive}<p class="fs-8 text-body-secondary mt-2 mb-0" data-tax-incl>{lang key='website/services/updown/pc-tax-included'}</p>{/if}
        {else}
        <div class="basic-empty-state is-page">
            <i class="bi bi-hdd-stack" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/services/empty-title'}</span>
            <span class="fs-7">{lang key='website/services/empty-text'}</span>
            <a class="btn btn-primary btn-sm mt-1" href="{if $order_service_link}{$order_service_link}{else}{link route='home'}{/if}"><i class="bi bi-bag me-1"></i>{lang key='website/services/browse-products'}</a>
        </div>
        {/if}

    </div>
</section>
{/block}
