{extends file='layouts/default.tpl'}

{block name=head}
    <script src="{asset path='js/list.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-4 pt-lg-4 pb-lg-5">
    <div class="container list-page">

        <div class="list-pagehead">
            <div>
                <nav aria-label="{lang key='website/invoices/breadcrumb-aria'}">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                        <li class="breadcrumb-item active" aria-current="page">{lang key='website/invoices/title'}</li>
                    </ol>
                </nav>
                <h1 class="list-title">{lang key='website/invoices/title'}</h1>
            </div>
            <div class="d-flex flex-wrap gap-2 list-headactions">
                <a class="btn btn-soft btn-sm" href="{link route='invoice-subscriptions'}"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/invoices/subs-title'}</a>
                <a class="btn btn-soft btn-sm" href="{$billing_profiles_link}"><i class="bi bi-person-vcard me-1"></i>{lang key='website/invoices/billing-profiles'}</a>
                <a class="btn btn-soft btn-sm" href="{$saved_cards_link}"><i class="bi bi-credit-card-2-back me-1"></i>{lang key='website/invoices/saved-cards'}</a>
                {if $outstanding.show}
                <a class="btn btn-soft btn-sm fw-semibold list-order" href="{link route='bulk-pay'}"><i class="bi bi-credit-card me-1"></i>{lang key='website/invoices/pay-all'}</a>
                {/if}
            </div>
        </div>

        {hook name='ui:client.invoice_list.top'}

        {if $has_invoices}
        <div class="list-summary" role="group" aria-label="{lang key='website/invoices/tiles-aria'}">
            <button type="button" class="list-tile list-tile-primary is-active" data-seg="all" aria-pressed="true">
                <i class="bi bi-receipt list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-receipt"></i></span>
                <span>
                    <span class="list-tile-figure">
                        <span class="list-tile-value num-tabular">{$tiles.all.count}</span>
                        <span class="list-tile-sub num-tabular">{$tiles.all.sum_fmt}</span>
                    </span>
                    <span class="list-tile-label d-block">{lang key='website/invoices/tile-total'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-success" data-seg="paid" aria-pressed="false">
                <i class="bi bi-check-circle list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-check-circle"></i></span>
                <span>
                    <span class="list-tile-figure">
                        <span class="list-tile-value num-tabular">{$tiles.paid.count}</span>
                        <span class="list-tile-sub num-tabular">{$tiles.paid.sum_fmt}</span>
                    </span>
                    <span class="list-tile-label d-block">{lang key='website/invoices/st-paid'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-warning" data-seg="unpaid" aria-pressed="false">
                <i class="bi bi-hourglass-split list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-hourglass-split"></i></span>
                <span>
                    <span class="list-tile-figure">
                        <span class="list-tile-value num-tabular">{$tiles.unpaid.count}</span>
                        <span class="list-tile-sub num-tabular">{$tiles.unpaid.sum_fmt}</span>
                    </span>
                    <span class="list-tile-label d-block">{lang key='website/invoices/st-unpaid'}</span>
                </span>
            </button>
            <button type="button" class="list-tile list-tile-danger" data-seg="overdue" aria-pressed="false">
                <i class="bi bi-exclamation-circle list-tile-watermark" aria-hidden="true"></i>
                <span class="list-tile-ico"><i class="bi bi-exclamation-circle"></i></span>
                <span>
                    <span class="list-tile-figure">
                        <span class="list-tile-value num-tabular">{$tiles.overdue.count}</span>
                        <span class="list-tile-sub num-tabular">{$tiles.overdue.sum_fmt}</span>
                    </span>
                    <span class="list-tile-label d-block">{lang key='website/invoices/st-overdue'}</span>
                </span>
            </button>
        </div>

        {if $outstanding.show}
        <div class="list-attention" role="region" aria-label="{lang key='website/invoices/outstanding-aria'}">
            <div class="list-alert list-alert-warning" data-alert-id="invoices-outstanding">
                <i class="bi bi-cash-coin list-alert-ico" aria-hidden="true"></i>
                <div class="list-alert-body">{$outstanding.text nofilter}</div>
                <a class="btn btn-sm btn-outline-warning" href="{link route='bulk-pay'}"><i class="bi bi-credit-card me-1"></i>{lang key='website/invoices/pay-now'}</a>
                <button type="button" class="basic-alert-close" data-action="dismiss-alert" aria-label="{lang key='website/invoices/dismiss'}"><i class="bi bi-x-lg" aria-hidden="true"></i></button>
            </div>
        </div>
        {/if}

        <div class="list-toolbar">
            <div class="list-search input-group">
                <label class="input-group-text" for="list-search"><i class="bi bi-search"></i></label>
                <input type="search" autocomplete="off" name="q" data-lpignore="true" data-1p-ignore data-form-type="other" class="form-control" id="list-search" placeholder="{lang key='website/invoices/search-ph'}" aria-label="{lang key='website/invoices/search-ph'}">
            </div>
            <div class="list-controls">
                <label for="list-status" class="form-label mb-0 list-control-label">{lang key='website/invoices/status-label'}</label>
                <select class="form-select w-auto" id="list-status" aria-label="{lang key='website/invoices/status-label'}">
                    <option value="">{lang key='website/invoices/status-all'}</option>
                    <option value="overdue">{lang key='website/invoices/st-overdue'}</option>
                    <option value="unpaid">{lang key='website/invoices/st-unpaid'}</option>
                    <option value="paid">{lang key='website/invoices/st-paid'}</option>
                    <option value="waiting">{lang key='website/invoices/st-waiting'}</option>
                    <option value="refunded">{lang key='website/invoices/st-refunded'}</option>
                    <option value="cancelled">{lang key='website/invoices/st-cancelled'}</option>
                </select>
                <label for="list-sort" class="form-label mb-0 list-control-label">{lang key='website/invoices/sort-label'}</label>
                <select class="form-select w-auto" id="list-sort" aria-label="{lang key='website/invoices/sort-label'}">
                    <option value="status">{lang key='website/invoices/sort-default'}</option>
                    <option value="created">{lang key='website/invoices/sort-newest'}</option>
                    <option value="due">{lang key='website/invoices/sort-due'}</option>
                    <option value="price-desc">{lang key='website/invoices/sort-price-desc'}</option>
                    <option value="price-asc">{lang key='website/invoices/sort-price-asc'}</option>
                </select>
            </div>
        </div>

        {hook name='ui:client.invoice_list.toolbar'}

        <div class="list-rows" data-noun="invoices" data-today="{$today_ymd}"{if $table_ajax} data-ajax="{$table_ajax}"{/if}
            data-txt-count="{lang key='website/index/list-count'}"
            data-txt-nores="{lang key='website/index/list-nores'}"
            data-txt-noun="{lang key='website/invoices/noun'}">
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
                <span class="fw-semibold">{lang key='website/invoices/nores-title'}</span>
                <span class="fs-7">{lang key='website/invoices/nores-text'}</span>
                <button type="button" class="btn btn-soft btn-sm mt-1" data-action="list-clear"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/invoices/clear-filters'}</button>
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
            <nav class="list-pagination" aria-label="{lang key='website/invoices/pagination-aria'}" data-role="pagination"><ul class="pagination pagination-sm m-0"></ul></nav>
        </div>
        {else}
        <div class="basic-empty-state is-page">
            <i class="bi bi-receipt" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/invoices/empty-title'}</span>
            <span class="fs-7">{lang key='website/invoices/empty-text'}</span>
            <a class="btn btn-primary btn-sm mt-1" href="{link route='home'}"><i class="bi bi-bag me-1"></i>{lang key='website/invoices/browse-products'}</a>
        </div>
        {/if}

    </div>
</section>
{/block}
