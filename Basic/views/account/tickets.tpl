{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/support-tickets.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/list.js'}" defer></script>
    <script src="{asset path='js/support-tickets.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-4 pt-lg-4 pb-lg-5">
    <div class="container list-page" data-tickets-page
         data-close-url="{link route='tickets'}"
         data-txt-closed="{lang key='website/tickets/closed'}"
         data-txt-close-fail="{lang key='website/tickets/err-generic'}"
         data-rate-1="{lang key='website/tickets/rate-cap-1'}"
         data-rate-2="{lang key='website/tickets/rate-cap-2'}"
         data-rate-3="{lang key='website/tickets/rate-cap-3'}"
         data-rate-4="{lang key='website/tickets/rate-cap-4'}"
         data-rate-5="{lang key='website/tickets/rate-cap-5'}"
         data-review-min="{$review.min_rating}"
         data-txt-rate-thanks="{lang key='website/tickets/detail/rate-thanks'}">
        {csrf form='ticket-close'}

        <div class="list-pagehead">
            <div>
                <nav aria-label="{lang key='website/tickets/breadcrumb-aria'}">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                        <li class="breadcrumb-item active" aria-current="page">{lang key='website/tickets/title'}</li>
                    </ol>
                </nav>
                <h1 class="list-title">{lang key='website/tickets/title'}</h1>
            </div>
            <div class="d-flex flex-wrap align-items-center gap-2">
                {if $support_pin}
                <div class="support-pin" data-support-pin data-pin-url="{link route='tickets'}"{if $can_regen_pin} data-pin-token="{$pin_token}"{/if}>
                    <span class="support-pin-label" data-bs-toggle="tooltip" title="{lang key='website/tickets/pin-tip'}"><i class="bi bi-shield-lock" aria-hidden="true"></i>{lang key='website/tickets/pin-label'}</span>
                    <span class="support-pin-value num-tabular" data-role="pin-value">{$support_pin}</span>
                    <button class="btn btn-ghost btn-sm support-pin-btn" type="button" data-action="copy-pin" data-bs-toggle="tooltip" title="{lang key='website/tickets/pin-copy'}" aria-label="{lang key='website/tickets/pin-copy'}"><i class="bi bi-clipboard"></i></button>
                    {if $can_regen_pin}
                    <button class="btn btn-ghost btn-sm support-pin-btn" type="button" data-action="regenerate-pin" data-bs-toggle="tooltip" title="{lang key='website/tickets/pin-regenerate'}" aria-label="{lang key='website/tickets/pin-regenerate'}"><i class="bi bi-arrow-clockwise"></i></button>
                    {/if}
                </div>
                {/if}
                <a class="btn btn-secondary btn-sm fw-semibold list-order" href="{$new_ticket_link}"><i class="bi bi-life-preserver me-1"></i>{lang key='website/tickets/new-ticket'}</a>
                {hook name='ui:client.ticket_list.actions'}
            </div>
        </div>

        {if $announcements}
        <div class="announcements" data-announcements>
            {foreach $announcements as $a}
            <div class="announcement announcement-{$a.type}" data-announcement data-alert-id="announce-{$a.id}">
                <span class="announcement-ico"><i class="bi {$a.icon}" aria-hidden="true"></i></span>
                <div class="announcement-body">
                    <span class="announcement-title">{$a.title}</span>
                    {if $a.message}<p class="announcement-text">{$a.message}</p>{/if}
                </div>
                <div class="announcement-actions">
                    {if $a.message}<button type="button" class="btn btn-sm announcement-more" data-bs-toggle="modal" data-bs-target="#announcementModal">{lang key='website/tickets/read-more'}</button>{/if}
                    <button type="button" class="basic-alert-close" data-action="dismiss-alert" aria-label="{lang key='website/tickets/dismiss'}"><i class="bi bi-x-lg" aria-hidden="true"></i></button>
                </div>
                {if $a.message}<template data-announcement-content><p>{$a.message}</p></template>{/if}
            </div>
            {/foreach}
        </div>
        {/if}

        {hook name='ui:client.ticket_list.before'}

        {if $has_tickets}
        <div class="list-toolbar">
            <div class="list-search input-group">
                <label class="input-group-text" for="list-search"><i class="bi bi-search"></i></label>
                <input type="search" autocomplete="off" name="q" data-lpignore="true" data-1p-ignore data-form-type="other" class="form-control" id="list-search" placeholder="{lang key='website/tickets/search-ph'}" aria-label="{lang key='website/tickets/search-ph'}">
            </div>
            <div class="list-controls">
                <label for="list-type" class="form-label mb-0 list-control-label">{lang key='website/tickets/dept-label'}</label>
                <select class="form-select w-auto" id="list-type" aria-label="{lang key='website/tickets/dept-label'}">
                    <option value="">{lang key='website/tickets/dept-all'}</option>
                    {foreach $departments as $d}<option value="{$d.id}">{$d.name}</option>{/foreach}
                </select>
                <label for="list-status" class="form-label mb-0 list-control-label">{lang key='website/tickets/status-label'}</label>
                <select class="form-select w-auto" id="list-status" aria-label="{lang key='website/tickets/status-label'}">
                    <option value="">{lang key='website/tickets/status-all'}</option>
                    <option value="awaiting">{lang key='website/tickets/st-awaiting'}</option>
                    <option value="inprogress">{lang key='website/tickets/st-inprogress'}</option>
                    <option value="answered">{lang key='website/tickets/st-answered'}</option>
                    <option value="open">{lang key='website/tickets/st-open'}</option>
                    <option value="closed">{lang key='website/tickets/st-closed'}</option>
                </select>
                <label for="list-sort" class="form-label mb-0 list-control-label">{lang key='website/tickets/sort-label'}</label>
                <select class="form-select w-auto" id="list-sort" aria-label="{lang key='website/tickets/sort-label'}">
                    <option value="status">{lang key='website/tickets/sort-default'}</option>
                    <option value="created">{lang key='website/tickets/sort-updated'}</option>
                    <option value="price-asc">{lang key='website/tickets/sort-priority'}</option>
                    <option value="name">{lang key='website/tickets/sort-subject'}</option>
                </select>
            </div>
        </div>

        <div class="list-rows" data-noun="tickets" data-today="{$today_ymd}"{if $table_ajax} data-ajax="{$table_ajax}"{/if}
            data-txt-count="{lang key='website/index/list-count'}"
            data-txt-nores="{lang key='website/index/list-nores'}"
            data-txt-noun="{lang key='website/tickets/noun'}">
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
                <span class="fw-semibold">{lang key='website/tickets/nores-title'}</span>
                <span class="fs-7">{lang key='website/tickets/nores-text'}</span>
                <button type="button" class="btn btn-soft btn-sm mt-1" data-action="list-clear"><i class="bi bi-arrow-counterclockwise me-1"></i>{lang key='website/tickets/clear-filters'}</button>
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
            <nav class="list-pagination" aria-label="{lang key='website/tickets/pagination-aria'}" data-role="pagination"><ul class="pagination pagination-sm m-0"></ul></nav>
        </div>
        {else}
        <div class="basic-empty-state is-page">
            <i class="bi bi-life-preserver" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/tickets/empty-title'}</span>
            <span class="fs-7">{lang key='website/tickets/empty-text'}</span>
            <a class="btn btn-primary btn-sm mt-1" href="{$new_ticket_link}"><i class="bi bi-life-preserver me-1"></i>{lang key='website/tickets/new-ticket'}</a>
        </div>
        {/if}

    </div>
</section>
{/block}

{block name=body_end}
<div class="modal fade" id="closeTicketModal" tabindex="-1" aria-labelledby="closeTicketTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-lock"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="closeTicketTitle">{lang key='website/tickets/close-title'}</h2>
                    <p class="modal-subtitle" data-role="close-ticket"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/tickets/close-modal'}"></button>
            </div>
            <div class="modal-body text-center px-4 py-4">
                <h3 class="h5 mb-2 mt-3">{lang key='website/tickets/close-h'}</h3>
                <p class="text-body-secondary mb-4">{lang key='website/tickets/close-q'}</p>
                <div class="star-rating" data-role="rating" data-value="0" role="radiogroup" aria-label="{lang key='website/tickets/rate-aria'}">
                    <button type="button" class="star-btn" data-value="1" aria-label="{lang key='website/tickets/rate-1'}"><i class="bi bi-star-fill"></i></button>
                    <button type="button" class="star-btn" data-value="2" aria-label="{lang key='website/tickets/rate-2'}"><i class="bi bi-star-fill"></i></button>
                    <button type="button" class="star-btn" data-value="3" aria-label="{lang key='website/tickets/rate-3'}"><i class="bi bi-star-fill"></i></button>
                    <button type="button" class="star-btn" data-value="4" aria-label="{lang key='website/tickets/rate-4'}"><i class="bi bi-star-fill"></i></button>
                    <button type="button" class="star-btn" data-value="5" aria-label="{lang key='website/tickets/rate-5'}"><i class="bi bi-star-fill"></i></button>
                </div>
                <div class="rating-caption" data-role="rating-label">&nbsp;</div>
                {if $review.enabled}
                <div class="wui-collapse" id="reviewPrompt">
                    <div class="wui-collapse-inner">
                        <div class="pt-3">
                            <div class="review-prompt" style="--review-brand:{$review.color}">
                                <a class="review-card" href="{$review.url}" target="_blank" rel="noopener"><span class="review-card-invite">{lang key='website/tickets/review-card-invite'}</span><span class="review-card-brand"><span class="review-card-mark">{$review.mark nofilter}</span><span class="review-card-name">{$review.label}</span></span></a>
                                <p class="review-text">{lang key='website/tickets/review-text' platform=$review.label}</p>
                                <a class="btn review-cta fw-semibold w-100" href="{$review.url}" target="_blank" rel="noopener"><i class="bi bi-star-fill me-1"></i>{lang key='website/tickets/review-cta' platform=$review.label}</a>
                            </div>
                        </div>
                    </div>
                </div>
                {/if}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/tickets/cancel'}</button>
                <button type="button" class="btn btn-primary" data-action="close-ticket-submit"><i class="bi bi-lock me-1"></i>{lang key='website/tickets/close'}</button>
            </div>
        </div>
    </div>
</div>
{/block}
