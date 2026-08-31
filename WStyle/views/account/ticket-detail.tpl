{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/support-tickets.css'}">
    <link rel="stylesheet" href="{asset path='css/ticket-create.css'}">
    <link rel="stylesheet" href="{asset path='css/ticket-detail.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/ticket-detail.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-5">
    <div class="container"
         data-ticket-detail
         data-post-url="{link route='tickets'}"
         data-ticket-id="{$ticket.id}"{if $is_guest}
         data-guest="1"
         data-token="{$guest_token}"{/if}
         data-status="{$ticket.status}"
         data-last-reply-id="{$last_reply_id}"
         data-poll-interval="20000"
         data-txt-fail="{lang key='website/tickets/detail/err-generic'}"
         data-txt-attach-total="{lang key='website/tickets/error-attach-total'}"
         data-txt-sent="{lang key='website/tickets/detail/reply-sent'}"
         data-txt-closed="{lang key='website/tickets/closed'}"
         data-txt-close-fail="{lang key='website/tickets/err-generic'}"
         data-txt-reopened="{lang key='website/tickets/detail/reopened'}"
         data-txt-new-reply="{lang key='website/tickets/detail/new-reply'}"
         data-st-answered="{lang key='website/tickets/st-answered'}"
         data-st-awaiting="{lang key='website/tickets/st-awaiting'}"
         data-st-inprogress="{lang key='website/tickets/st-inprogress'}"
         data-st-closed="{lang key='website/tickets/st-closed'}"
         data-st-open="{lang key='website/tickets/st-open'}"
         data-by-support="{lang key='website/tickets/by-support'}"
         data-by-you="{lang key='website/tickets/by-you'}"
         data-rate-1="{lang key='website/tickets/rate-cap-1'}"
         data-rate-2="{lang key='website/tickets/rate-cap-2'}"
         data-rate-3="{lang key='website/tickets/rate-cap-3'}"
         data-rate-4="{lang key='website/tickets/rate-cap-4'}"
         data-rate-5="{lang key='website/tickets/rate-cap-5'}"
         data-txt-rate-thanks="{lang key='website/tickets/detail/rate-thanks'}"
         data-txt-rate-agent="{lang key='website/tickets/detail/agent'}"
         data-review-min="{$review.min_rating}"
         data-ticket-rating="{$ticket.rating}"
         data-access-groups="{$access_groups_json}">

        {if !$is_guest}
        <span class="d-none" data-token-close>{csrf form='ticket-close'}</span>
        <span class="d-none" data-token-reopen>{csrf form='ticket-reopen'}</span>
        <span class="d-none" data-token-rate>{csrf form='ticket-rate'}</span>
        {/if}

        <div class="td-head">
            <nav aria-label="{lang key='website/tickets/breadcrumb-aria'}">
                <ol class="breadcrumb mb-2">
                    {if $is_guest}
                    <li class="breadcrumb-item"><a href="{link route='home'}">{lang key='website/index/breadcrumb-home'}</a></li>
                    {else}
                    <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                    <li class="breadcrumb-item"><a href="{$tickets_link}">{lang key='website/tickets/title'}</a></li>
                    {/if}
                    <li class="breadcrumb-item active" aria-current="page">#{$ticket.ref}</li>
                </ol>
            </nav>
            <div class="td-head-row">
                <div class="td-head-lead">
                    <span class="td-head-icon"><i class="{$ticket.dept_icon}"></i></span>
                    <div class="td-head-main">
                        <div class="td-subject-row">
                            <h1 class="td-subject">{$ticket.subject}</h1>
                            {if $ticket.status == 'answered'}<span class="badge bg-success-subtle text-success-emphasis td-status" data-role="ticket-status"><i class="bi bi-chat-left-text me-1"></i>{lang key='website/tickets/st-answered'}</span>
                            {elseif $ticket.status == 'awaiting'}<span class="badge bg-warning-subtle text-warning-emphasis td-status" data-role="ticket-status"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/tickets/st-awaiting'}</span>
                            {elseif $ticket.status == 'inprogress'}<span class="badge bg-info-subtle text-info-emphasis td-status" data-role="ticket-status"><i class="bi bi-gear-fill wcp-status-spin me-1"></i>{lang key='website/tickets/st-inprogress'}</span>
                            {elseif $ticket.status == 'closed'}<span class="badge bg-secondary-subtle text-secondary-emphasis td-status" data-role="ticket-status"><i class="bi bi-lock me-1"></i>{lang key='website/tickets/st-closed'}</span>
                            {else}<span class="badge bg-primary-subtle text-primary-emphasis td-status" data-role="ticket-status"><i class="bi bi-envelope-open me-1"></i>{lang key='website/tickets/st-open'}</span>{/if}
                        </div>
                    </div>
                </div>
                <div class="td-head-actions" data-role="ticket-actions">
                    {if !$is_guest && !$ticket.locked}
                    <button class="btn btn-soft" type="button" data-role="close-btn"{if $ticket.closed} hidden{/if} data-bs-toggle="modal" data-bs-target="#closeTicketModal" data-ticket="#{$ticket.ref}" data-ticket-id="{$ticket.id}"><i class="bi bi-lock me-1"></i>{lang key='website/tickets/close'}</button>
                    <button class="btn btn-soft" type="button" data-role="reopen-btn"{if !$ticket.closed} hidden{/if} data-action="reopen-ticket"><i class="bi bi-arrow-clockwise me-1"></i>{lang key='website/tickets/reopen'}</button>
                    {/if}
                    {hook name='ui:client.ticket_detail.actions'}
                </div>
            </div>
        </div>


        <div class="row g-4">
            <div class="col-lg-8">
                {if $ticket.locked}
                <div class="ticket-closed-note" data-locked-note>
                    <span class="ticket-closed-ico"><i class="bi bi-lock-fill"></i></span>
                    <div class="me-auto">
                        <span class="fw-semibold d-block">{lang key='website/tickets/detail/locked-title'}</span>
                        <span class="fs-8 text-body-secondary">{lang key='website/tickets/detail/locked-text'}</span>
                    </div>
                    <a class="btn btn-primary btn-sm" href="{$new_ticket_link}"><i class="bi bi-plus-lg me-1"></i>{lang key='website/tickets/detail/new-ticket'}</a>
                </div>
                {else}
                <div class="ticket-reply-slot{if $ticket.closed} d-none{/if}" data-reply-slot>
                    <div class="ticket-reply" data-reply>
                        <button type="button" class="ticket-reply-toggle collapsed" data-wui-toggle data-wui-target="#tdReplyBody" aria-expanded="false" aria-controls="tdReplyBody">
                            <span class="ticket-reply-toggle-ico"><i class="bi bi-reply"></i></span>
                            <span class="me-auto">{lang key='website/tickets/detail/post-reply'}</span>
                            <i class="bi bi-chevron-down wui-collapse-caret"></i>
                        </button>
                        <div class="wui-collapse" id="tdReplyBody">
                            <div class="wui-collapse-inner">
                                <form action="{$post_url}" method="post" enctype="multipart/form-data" novalidate data-reply-form>
                                    <input type="hidden" name="id" value="{$ticket.id}">
                                    {if $is_guest}<input type="hidden" name="access_token" value="{$guest_token}">{/if}

                                    {hook name='ui:client.ticket_detail.reply_form.top'}

                                    <div class="composer" data-composer>
                                        <label for="td-message" class="visually-hidden">{lang key='website/tickets/detail/reply-label'}</label>
                                        <textarea class="form-control composer-input" id="td-message" name="message" rows="5" placeholder="{lang key='website/tickets/detail/reply-ph'}" required></textarea>
                                        <label class="composer-bar">
                                            <span class="composer-bar-text">
                                                <span class="fw-semibold">{lang key='website/tickets/create/encrypt'}</span>
                                                <span class="composer-bar-hint">{lang key='website/tickets/create/encrypt-hint'}</span>
                                            </span>
                                            <span class="composer-lock"><i class="bi bi-shield-lock"></i></span>
                                            <input class="form-check-input visually-hidden" type="checkbox" id="td-encrypt" name="encrypt_message" value="1" aria-label="{lang key='website/tickets/create/encrypt'}">
                                        </label>
                                    </div>
                                    <div class="invalid-feedback" data-role="reply-error">{lang key='website/tickets/detail/err-message'}</div>

                                    <div class="wui-collapse" id="tdKbSuggest" data-kb-suggest>
                                        <div class="wui-collapse-inner">
                                            <div class="pt-3">
                                                <div class="kb-suggest">
                                                    <div class="kb-suggest-head" id="tdKbSuggestHead"><i class="bi bi-lightbulb" aria-hidden="true"></i><span>{lang key='website/tickets/detail/kb-head'}</span></div>
                                                    <ul class="kb-suggest-list" data-role="kb-list" aria-labelledby="tdKbSuggestHead"></ul>
                                                    <span class="visually-hidden" data-role="kb-status" aria-live="polite" aria-atomic="true"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    {if $access_groups}
                                    <div class="mt-3" data-access-block>
                                        <button type="button" class="cred-toggle collapsed" data-wui-toggle data-wui-target="#tdAccess" aria-expanded="false" aria-controls="tdAccess">
                                            <span class="cred-toggle-ico"><i class="bi bi-key"></i></span>
                                            <span class="cred-toggle-text">{lang key='website/tickets/detail/cred-add'} <span class="text-body-secondary fw-normal">{lang key='website/tickets/detail/cred-optional'}</span></span>
                                            <i class="bi bi-chevron-down wui-collapse-caret"></i>
                                        </button>
                                        <div class="wui-collapse" id="tdAccess">
                                            <div class="wui-collapse-inner">
                                                <div class="cred-panel">
                                                    <p class="cred-secure"><i class="bi bi-shield-lock"></i><span>{lang key='website/tickets/detail/cred-secure'}</span></p>
                                                    <div class="cred-list" data-cred-list></div>
                                                    <button type="button" class="cred-add" data-action="cred-add"><i class="bi bi-plus-lg me-1"></i>{lang key='website/tickets/detail/cred-add-another'}</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <template data-cred-template>
                                        <div class="cred-item" data-cred-item>
                                            <div class="cred-head">
                                                <span class="cred-ico" data-cred-ico><i class="bi bi-key"></i></span>
                                                <select class="form-select form-select-sm cred-type" data-cred-group aria-label="{lang key='website/tickets/detail/cred-group-label'}">
                                                    <option value="">{lang key='website/tickets/detail/cred-select-group'}</option>
                                                    {foreach $access_groups as $g}<option value="{$g.id}" data-icon="{$g.icon}">{$g.name}</option>{/foreach}
                                                </select>
                                                <button type="button" class="btn btn-ghost btn-sm cred-remove" data-action="cred-remove" data-bs-toggle="tooltip" title="{lang key='website/tickets/detail/cred-remove'}" aria-label="{lang key='website/tickets/detail/cred-remove'}"><i class="bi bi-x-lg"></i></button>
                                            </div>
                                            <div class="cred-fields row g-3 pt-3" data-access-fields></div>
                                        </div>
                                    </template>
                                    {/if}

                                    <div class="mt-3">
                                        <div class="file-upload file-upload-compact" data-file-upload>
                                            <label class="file-upload-drop" for="td-attachments">
                                                <input type="file" id="td-attachments" name="attachments[]" class="visually-hidden" accept="{$attach_accept}" data-max-mb="{$attach_max_mb}" data-max-post="{$attach_max_post}" multiple>
                                                <span class="icon-disc"><i class="bi bi-paperclip"></i></span>
                                                <span><span class="fw-semibold">{lang key='website/tickets/create/browse'}</span> {lang key='website/tickets/detail/attach-drop'}</span>
                                                <span class="fs-8">{lang key='website/tickets/create/attach-hint' p1=$attach_max_mb}</span>
                                            </label>
                                            <ul class="file-upload-list" data-role="file-list"></ul>
                                        </div>
                                    </div>

                                    {hook name='ui:client.ticket_detail.reply_form.bottom'}

                                    <div class="wui-collapse" data-role="tr-alert">
                                        <div class="wui-collapse-inner">
                                            <div class="pt-3">
                                                <div class="auth-alert auth-alert-danger" role="alert" aria-live="assertive">
                                                    <i class="bi bi-exclamation-triangle-fill"></i>
                                                    <span></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mt-3 pt-3 border-top">
                                        <p class="fs-8 text-body-secondary mb-0 me-auto"><i class="bi bi-clock-history me-1"></i>{lang key='website/tickets/detail/reply-note'}</p>
                                        {if $is_guest}{captcha area='ticket-reply'}{else}{captcha area='ticket-reply' tray='tdCaptcha'}{/if}
                                        <button class="btn btn-primary" type="submit" data-reply-submit data-busy="{lang key='website/tickets/detail/sending'}"><i class="bi bi-send me-1"></i>{lang key='website/tickets/detail/send'}</button>
                                    </div>

                                    {if $is_guest}{csrf form='ticket-guest-reply'}{else}{csrf form='ticket-reply'}{/if}
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="ticket-reply-sent d-none" data-reply-sent>
                        <span class="ticket-reply-sent-ico"><i class="bi bi-check-circle"></i></span>
                        <h2 class="ticket-reply-sent-title">{lang key='website/tickets/detail/sent-title'}</h2>
                        <p class="ticket-reply-sent-text">{lang key='website/tickets/detail/sent-text'}</p>
                        <button type="button" class="btn btn-soft btn-sm" data-action="reply-again"><i class="bi bi-reply me-1"></i>{lang key='website/tickets/detail/reply-again'}</button>
                    </div>
                </div>
                <div class="ticket-closed-note{if !$ticket.closed} d-none{/if}" data-closed-note>
                    <span class="ticket-closed-ico"><i class="bi bi-lock"></i></span>
                    <div class="me-auto">
                        <span class="fw-semibold d-block">{lang key='website/tickets/detail/closed-title'}</span>
                        <span class="fs-8 text-body-secondary">{lang key='website/tickets/detail/closed-text'}</span>
                    </div>
                    <button class="btn btn-soft btn-sm" type="button" data-action="reopen-ticket"><i class="bi bi-arrow-clockwise me-1"></i>{lang key='website/tickets/detail/reopen-ticket'}</button>
                </div>
                {/if}

                <span class="visually-hidden" data-role="thread-status" aria-live="polite" aria-atomic="true"></span>
                <div class="ticket-thread" data-ticket-thread data-last-reply-id="{$last_reply_id}">
                    {hook name='ui:client.ticket_detail.thread.top'}
                    {foreach $thread as $r}{include file='views/account/ticket-msg.tpl' r=$r}{/foreach}
                    {hook name='ui:client.ticket_detail.thread.bottom'}
                </div>
            </div>

            <div class="col-lg-4">
                <aside class="ticket-aside">
                    {hook name='ui:client.ticket_detail.sidebar.top'}
                    <div class="card">
                        <div class="card-body p-4">
                            <h2 class="h6 fw-semibold mb-3">{lang key='website/tickets/detail/details-title'}</h2>
                            <dl class="ticket-info">
                                <div class="ticket-info-row">
                                    <dt>{lang key='website/tickets/status-label'}</dt>
                                    <dd>
                                        {if $ticket.status == 'answered'}<span class="badge bg-success-subtle text-success-emphasis" data-role="ticket-status-side"><i class="bi bi-chat-left-text me-1"></i>{lang key='website/tickets/st-answered'}</span>
                                        {elseif $ticket.status == 'awaiting'}<span class="badge bg-warning-subtle text-warning-emphasis" data-role="ticket-status-side"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/tickets/st-awaiting'}</span>
                                        {elseif $ticket.status == 'inprogress'}<span class="badge bg-info-subtle text-info-emphasis" data-role="ticket-status-side"><i class="bi bi-gear-fill wcp-status-spin me-1"></i>{lang key='website/tickets/st-inprogress'}</span>
                                        {elseif $ticket.status == 'closed'}<span class="badge bg-secondary-subtle text-secondary-emphasis" data-role="ticket-status-side"><i class="bi bi-lock me-1"></i>{lang key='website/tickets/st-closed'}</span>
                                        {else}<span class="badge bg-primary-subtle text-primary-emphasis" data-role="ticket-status-side"><i class="bi bi-envelope-open me-1"></i>{lang key='website/tickets/st-open'}</span>{/if}
                                    </dd>
                                </div>
                                {if $ticket.dept}
                                <div class="ticket-info-row">
                                    <dt>{lang key='website/tickets/dept-label'}</dt>
                                    <dd>{$ticket.dept}</dd>
                                </div>
                                {/if}
                                <div class="ticket-info-row">
                                    <dt>{lang key='website/tickets/detail/priority'}</dt>
                                    <dd><span class="ticket-prio{if $ticket.priority.urgent} ticket-prio-urgent{/if}"><i class="{$ticket.priority.icon} me-1"></i>{$ticket.priority.label}</span></dd>
                                </div>
                                <div class="ticket-info-row">
                                    <dt>{lang key='website/tickets/detail/opened'}</dt>
                                    <dd class="num-tabular">{$ticket.opened}</dd>
                                </div>
                                <div class="ticket-info-row">
                                    <dt>{lang key='website/tickets/detail/last-reply'}</dt>
                                    <dd data-role="last-reply">{$ticket.last_ago} &middot; {$ticket.last_by}</dd>
                                </div>
                                {if $related_service}
                                <div class="ticket-info-row">
                                    <dt>{lang key='website/tickets/detail/related-service'}</dt>
                                    <dd class="ticket-related"><a href="{$related_service.link}"><i class="{$related_service.icon} me-1"></i>{$related_service.name}</a><span class="badge bg-{$related_service.variant}-subtle text-{$related_service.variant}-emphasis ms-2 flex-shrink-0"><i class="{$related_service.status_icon} me-1"></i>{$related_service.status_label}</span></dd>
                                </div>
                                {/if}
                            </dl>
                        </div>
                    </div>

                    {if !$is_guest && $support_pin}
                    <div class="card">
                        <div class="card-body p-4">
                            <h2 class="h6 fw-semibold mb-1">{lang key='website/tickets/detail/verify-title'}</h2>
                            <p class="fs-8 text-body-secondary mb-3">{lang key='website/tickets/detail/verify-text'}</p>
                            <div class="support-pin w-100" data-support-pin data-pin-url="{link route='tickets'}"{if $can_regen_pin} data-pin-token="{$pin_token}"{/if}>
                                <span class="support-pin-label" data-bs-toggle="tooltip" title="{lang key='website/tickets/pin-tip'}"><i class="bi bi-shield-lock" aria-hidden="true"></i>{lang key='website/tickets/pin-label'}</span>
                                <span class="support-pin-value num-tabular" data-role="pin-value">{$support_pin}</span>
                                <button class="btn btn-ghost btn-sm support-pin-btn ms-auto" type="button" data-action="copy-pin" data-bs-toggle="tooltip" title="{lang key='website/tickets/pin-copy'}" aria-label="{lang key='website/tickets/pin-copy'}"><i class="bi bi-clipboard"></i></button>
                                {if $can_regen_pin}
                                <button class="btn btn-ghost btn-sm support-pin-btn" type="button" data-action="regenerate-pin" data-bs-toggle="tooltip" title="{lang key='website/tickets/pin-regenerate'}" aria-label="{lang key='website/tickets/pin-regenerate'}"><i class="bi bi-arrow-clockwise"></i></button>
                                {/if}
                            </div>
                        </div>
                    </div>
                    {/if}

                    <div class="card">
                        <div class="card-body p-4">
                            <h2 class="h6 fw-semibold mb-1">{lang key='website/tickets/detail/selfhelp-title'}</h2>
                            <p class="fs-8 text-body-secondary mb-3">{lang key='website/tickets/detail/selfhelp-text'}</p>
                            <a class="btn btn-soft btn-sm w-100" href="{$kbase_link}" target="_blank" rel="noopener"><i class="bi bi-journal-text me-1"></i>{lang key='website/tickets/detail/selfhelp-cta'}</a>
                        </div>
                    </div>
                    {hook name='ui:client.ticket_detail.sidebar.bottom'}
                </aside>
            </div>
        </div>

    </div>
</section>
{/block}

{block name=body_end}
<div class="ticket-lightbox" data-role="ticket-lightbox" hidden>
    <button type="button" class="ticket-lightbox-close" data-action="ticket-zoom-close" aria-label="{lang key='website/tickets/detail/lightbox-close'}"><i class="bi bi-x-lg"></i></button>
    <figure class="ticket-lightbox-figure">
        <img data-role="ticket-lightbox-img" src="" alt="">
        <figcaption class="ticket-lightbox-cap" data-role="ticket-lightbox-cap"></figcaption>
    </figure>
</div>

{if !$is_guest}
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
{/if}

{if $review.enabled}
<div class="modal fade" id="replyThanksModal" tabindex="-1" aria-labelledby="replyThanksTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon"><i class="bi bi-chat-heart"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="replyThanksTitle">{lang key='website/tickets/detail/thanks-title'}</h2>
                    <p class="modal-subtitle" data-role="reply-rating-author">{lang key='website/tickets/detail/agent'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/tickets/close-modal'}"></button>
            </div>
            <div class="modal-body text-center px-4 py-4">
                <div class="review-prompt" style="--review-brand:{$review.color}">
                    <p class="review-lead">{lang key='website/tickets/review-lead'}</p>
                    <a class="review-card" href="{$review.url}" target="_blank" rel="noopener"><span class="review-card-invite">{lang key='website/tickets/review-card-invite'}</span><span class="review-card-brand"><span class="review-card-mark">{$review.mark nofilter}</span><span class="review-card-name">{$review.label}</span></span></a>
                    <p class="review-text">{lang key='website/tickets/review-text' platform=$review.label}</p>
                    <a class="btn review-cta fw-semibold w-100" href="{$review.url}" target="_blank" rel="noopener"><i class="bi bi-star-fill me-1"></i>{lang key='website/tickets/review-cta' platform=$review.label}</a>
                </div>
            </div>
        </div>
    </div>
</div>
{/if}
{/block}
