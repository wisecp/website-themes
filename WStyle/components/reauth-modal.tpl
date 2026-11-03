<div class="modal fade dash-modal" id="reauth-modal" data-reauth-url="{link route='info'}" data-txt-code-intro="{lang key='website/account/2fa-disable-code-intro' attr=1}" data-txt-send-intro="{lang key='website/account/2fa-disable-send-intro' attr=1}" data-txt-code-sent="{lang key='website/account/2fa-disable-code-sent' attr=1}" data-txt-resend-in="{lang key='website/account/resend-in' attr=1}" data-txt-busy="{lang key='website/account/busy-generic' attr=1}" data-txt-failed="{lang key='website/account/reauth-failed' attr=1}" data-txt-locked="{lang key='website/account/reauth-locked' attr=1}" data-bs-backdrop="static" tabindex="-1" aria-labelledby="reauth-modal-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form id="reauth-form" novalidate>
                {csrf form='reauth'}
                <div class="modal-body text-center p-5 pb-4">
                    <span class="dash-modal-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-shield-lock" aria-hidden="true"></i></span>
                    <h2 class="h5 mt-3 mb-2" id="reauth-modal-title">{lang key='website/account/reauth-title'}</h2>
                    <p class="text-body-secondary mb-3">{lang key='website/account/reauth-sub'}</p>
                    <div class="text-start d-none" data-role="reauth-step-password">
                        <label class="form-label" for="reauth-password">{lang key='website/account/reauth-password'}</label>
                        <input type="password" class="form-control" id="reauth-password" name="password" autocomplete="current-password">
                        <p class="fs-8 text-body-secondary mt-2 mb-0 d-none" data-role="reauth-switch-code"><button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none" data-action="reauth-use-code">{lang key='website/account/2fa-use-code'}</button></p>
                    </div>
                    <div class="text-start d-none" data-role="reauth-step-code">
                        <p class="fs-7 text-body-secondary text-center mb-3" data-role="reauth-code-intro"></p>
                        <div class="d-none" data-role="reauth-code-field">
                            <label class="form-label" for="reauth-code">{lang key='website/account/verification-code'}</label>
                            <input type="text" class="form-control text-center num-tabular" id="reauth-code" name="code" inputmode="numeric" maxlength="6" autocomplete="one-time-code">
                        </div>
                        <p class="fs-8 text-body-secondary text-center mt-2 mb-0">
                            <button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none d-none" data-action="reauth-send-code" data-role="reauth-resend">{lang key='website/account/2fa-resend'}</button>
                            <button type="button" class="btn btn-link btn-sm p-0 fs-8 text-decoration-none d-none ms-2" data-action="reauth-use-password" data-role="reauth-switch-password">{lang key='website/account/reauth-use-password'}</button>
                        </p>
                    </div>
                    <p class="fs-7 text-body-secondary mb-0 d-none" data-role="reauth-step-none">{lang key='website/account/reauth-no-password'}</p>
                    <p class="fs-7 text-danger mt-3 mb-0 d-none" data-role="reauth-error" role="alert"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-soft" data-bs-dismiss="modal">{lang key='website/account/cancel'}</button>
                    <a class="btn btn-primary d-none" data-role="reauth-set-password" href="{link route='sign-forget'}"><i class="bi bi-key me-1"></i>{lang key='website/account/reauth-set-password'}</a>
                    <button type="button" class="btn btn-primary d-none" data-action="reauth-send-code" data-role="reauth-send" data-busy-text="{lang key='website/account/sending'}"><i class="bi bi-send me-1"></i>{lang key='website/account/2fa-send-code'}</button>
                    <button type="submit" class="btn btn-primary d-none" data-role="reauth-confirm" data-busy-text="{lang key='website/account/busy-generic'}"><i class="bi bi-shield-check me-1"></i>{lang key='website/account/reauth-confirm'}</button>
                </div>
            </form>
        </div>
    </div>
</div>
