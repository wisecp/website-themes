<div class="tab-pane fade" id="{$transfer.pane_id}" role="tabpanel" aria-labelledby="{$transfer.pane_id}-tab" tabindex="0" data-transfer-mode="lite" data-service-transfer
     data-service-id="{$transfer.service_id}"
     data-transfer-url="{$transfer.url}"
     data-txt-starting="{lang key='website/services/service-transfer/js-starting'}"
     data-txt-sending="{lang key='website/services/service-transfer/js-sending'}"
     data-txt-cancel-title="{lang key='website/services/service-transfer/js-cancel-title'}"
     data-txt-cancel-msg="{lang key='website/services/service-transfer/js-cancel-msg'}"
     data-txt-cancel-action="{lang key='website/services/service-transfer/js-cancel-action'}"
     data-txt-cancel-btn="{lang key='website/services/service-transfer/js-cancel-btn'}">
    {if $transfer.pending}
    <section class="sd-panel" data-transfer-state="pending">
        <div class="sd-panel-head">
            <h2 class="sd-panel-title"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/services/service-transfer/pending-title'}</h2>
        </div>
        <div class="sd-tr-status">
            <span class="sd-tr-status-ico"><i class="bi bi-hourglass-split"></i></span>
            <div class="sd-tr-status-body">
                <span class="sd-tr-status-title">{lang key='website/services/service-transfer/pending-progress'}
                    <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/services/service-transfer/pending-badge'}</span>
                </span>
                <span class="sd-tr-status-desc">{lang key='website/services/service-transfer/pending-desc'}</span>
            </div>
        </div>
        <div class="sd-party-grid">
            <div class="sd-party">
                <div class="sd-party-head"><span class="sd-party-avatar">{lang key='website/services/service-transfer/party-you'}</span><div class="sd-party-id"><span class="sd-party-role">{lang key='website/services/service-transfer/party-current'}</span><span class="sd-party-email">{$transfer.pending.from_email}</span></div></div>
                <div class="sd-party-foot"><span class="fs-7 text-body-secondary">{lang key='website/services/service-transfer/verification'}</span><span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/services/service-transfer/verified'}</span></div>
            </div>
            <span class="sd-party-arrow" aria-hidden="true"><i class="bi bi-arrow-left-right"></i></span>
            <div class="sd-party">
                <div class="sd-party-head"><span class="sd-party-avatar">{$transfer.pending.to_initials}</span><div class="sd-party-id"><span class="sd-party-role">{lang key='website/services/service-transfer/party-new'}</span><span class="sd-party-email" data-role="sd-tr-new-email">{$transfer.pending.to_email}</span></div></div>
                <div class="sd-party-foot"><span class="fs-7 text-body-secondary">{lang key='website/services/service-transfer/verification'}</span><span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-clock me-1"></i>{lang key='website/services/service-transfer/pending-label'}</span></div>
            </div>
        </div>
        <div class="sd-tr-foot"><i class="bi bi-info-circle me-1"></i>{lang key='website/services/service-transfer/pending-foot'}</div>
        {csrf form='service-transfer'}
        <div class="d-flex flex-wrap justify-content-end gap-2 sd-cancel-actions">
            <button type="button" class="btn btn-soft" data-action="resend-transfer-verification"><i class="bi bi-envelope me-1"></i>{lang key='website/services/service-transfer/resend'}</button>
            <button type="button" class="btn btn-outline-danger" data-action="cancel-transfer"><i class="bi bi-x-circle me-1"></i>{lang key='website/services/service-transfer/cancel'}</button>
        </div>
    </section>
    {elseif $transfer.can_start}
    <section class="sd-panel" data-transfer-state="start">
        <div class="sd-panel-head">
            <h2 class="sd-panel-title"><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/services/service-transfer/start-title'}</h2>
            <span class="fs-7 text-body-secondary">{lang key='website/services/service-transfer/start-sub'}</span>
        </div>
        <ol class="sd-tr-steps">
            <li class="sd-tr-step"><span class="sd-tr-step-num" aria-hidden="true"></span><span class="sd-tr-step-body"><span class="sd-tr-step-title">{lang key='website/services/service-transfer/step1-title'}</span><span class="sd-tr-step-desc">{lang key='website/services/service-transfer/step1-desc'}</span></span></li>
            <li class="sd-tr-step"><span class="sd-tr-step-num" aria-hidden="true"></span><span class="sd-tr-step-body"><span class="sd-tr-step-title">{lang key='website/services/service-transfer/step2-title'}</span><span class="sd-tr-step-desc">{lang key='website/services/service-transfer/step2-desc'}</span></span></li>
            <li class="sd-tr-step"><span class="sd-tr-step-num" aria-hidden="true"></span><span class="sd-tr-step-body"><span class="sd-tr-step-title">{lang key='website/services/service-transfer/step3-title'}</span><span class="sd-tr-step-desc">{lang key='website/services/service-transfer/step3-desc'}</span></span></li>
        </ol>
        <div class="mb-3">
            <label class="form-label" for="sd-tr-email">{lang key='website/services/service-transfer/email-label'} <span class="text-danger">*</span></label>
            <input type="email" class="form-control" id="sd-tr-email" placeholder="owner@example.com" autocomplete="off" spellcheck="false">
            <div class="form-text"><i class="bi bi-info-circle me-1"></i>{lang key='website/services/service-transfer/email-hint'}</div>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" id="sd-tr-consent">
            <label class="form-check-label" for="sd-tr-consent">{lang key='website/services/service-transfer/consent'}</label>
        </div>
        <div class="wui-collapse" id="sd-tr-confirm">
            <div class="wui-collapse-inner">
                <div class="pt-3">
                    <label class="form-label" for="sd-tr-password">{lang key='website/services/service-transfer/password-label'}</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="sd-tr-password" autocomplete="current-password" placeholder="{lang key='website/services/service-transfer/password-ph'}">
                        <button class="btn btn-soft" type="button" data-action="password-toggle" data-bs-toggle="tooltip" title="{lang key='website/services/service-transfer/password-toggle'}"><i class="bi bi-eye"></i></button>
                    </div>
                    <div class="form-text"><i class="bi bi-shield-check me-1"></i>{lang key='website/services/service-transfer/password-hint'}</div>
                </div>
            </div>
        </div>
        {csrf form='service-transfer'}
        <div class="d-flex flex-wrap justify-content-end gap-2 mt-3">
            <button type="button" class="btn btn-primary" data-action="start-transfer" disabled><i class="bi bi-arrow-left-right me-1"></i>{lang key='website/services/service-transfer/start-btn'}</button>
        </div>
    </section>
    {else}
    <section class="sd-panel">
        <div class="wstyle-empty-state">
            <i class="bi bi-slash-circle" aria-hidden="true"></i>
            <span class="fw-semibold">{lang key='website/services/service-transfer/limit-title'}</span>
            <span class="fs-7">{lang key='website/services/service-transfer/limit-desc'}</span>
        </div>
    </section>
    {/if}
</div>
