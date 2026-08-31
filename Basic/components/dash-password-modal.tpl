{if empty($verify_modal) && $dashboard_modal == 'password-required'}
<div class="modal fade dash-modal" id="modalPasswordRequired" data-dashboard-modal-id="password-required" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalPasswordRequiredTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <span class="dash-modal-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-key" aria-hidden="true"></i></span>
                <h2 class="h5 mt-3 mb-2" id="modalPasswordRequiredTitle">{lang key='website/account/password-gate-title'}</h2>
                <p class="text-body-secondary mb-0">{lang key='website/account/password-gate-text'}</p>
            </div>
            <div class="modal-footer">
                <a class="btn btn-soft" href="{link route='sign-out'}"><i class="bi bi-box-arrow-right me-1"></i>{lang key='website/account/2fa-gate-logout'}</a>
                <a class="btn btn-primary" href="{link route='info'}#security"><i class="bi bi-key me-1"></i>{lang key='website/account/password-gate-action'}</a>
            </div>
        </div>
    </div>
</div>
{/if}
