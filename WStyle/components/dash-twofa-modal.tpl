{if $twofa_gate_inline|default:false}
    {assign var='twofa_modal_state' value=($twofa_required && !$twofa_active) ? '2fa-required' : ''}
{else}
    {assign var='twofa_modal_state' value=(empty($verify_modal) && $dashboard_modal) ? $dashboard_modal : ''}
{/if}
{if $twofa_modal_state}
{if $twofa_modal_state == '2fa-required'}
<div class="modal fade dash-modal" id="modal2faRequired" data-dashboard-modal-id="2fa-required" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal2faRequiredTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <span class="dash-modal-ico bg-primary-subtle text-primary-emphasis"><i class="bi bi-shield-lock" aria-hidden="true"></i></span>
                <h2 class="h5 mt-3 mb-2" id="modal2faRequiredTitle">{lang key='website/account/2fa-gate-title'}</h2>
                <p class="text-body-secondary mb-0">{lang key='website/account/2fa-gate-text'}</p>
            </div>
            <div class="modal-footer">
                <a class="btn btn-soft" href="{link route='sign-out'}"><i class="bi bi-box-arrow-right me-1"></i>{lang key='website/account/2fa-gate-logout'}</a>
                {if $twofa_gate_inline|default:false}
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal"><i class="bi bi-shield-lock me-1"></i>{lang key='website/account/2fa-gate-action'}</button>
                {else}
                <a class="btn btn-primary" href="{link route='info'}#two-factor"><i class="bi bi-shield-lock me-1"></i>{lang key='website/account/2fa-gate-action'}</a>
                {/if}
            </div>
        </div>
    </div>
</div>
{else}
<div class="modal fade dash-modal" id="modal2faReminder" data-dashboard-modal-id="2fa-reminder" tabindex="-1" aria-labelledby="modal2faReminderTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <span class="dash-modal-ico bg-info-subtle text-info-emphasis"><i class="bi bi-shield-check" aria-hidden="true"></i></span>
                <h2 class="h5 mt-3 mb-2" id="modal2faReminderTitle">{lang key='website/account/2fa-remind-title'}</h2>
                <p class="text-body-secondary mb-0">{lang key='website/account/2fa-remind-text'}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" data-action="remind-later" data-bs-dismiss="modal">{lang key='website/account/2fa-remind-later'}</button>
                <a class="btn btn-primary" href="{link route='info'}#two-factor"><i class="bi bi-shield-lock me-1"></i>{lang key='website/account/2fa-gate-action'}</a>
            </div>
        </div>
    </div>
</div>
{/if}
{/if}
