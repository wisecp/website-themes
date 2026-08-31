{if !empty($verify_modal)}
<div class="modal fade dash-modal" id="modalVerifyAccount" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalVerifyAccountTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <span class="dash-modal-ico bg-warning-subtle text-warning-emphasis"><i class="bi {if $verify_modal.variant == 'email'}bi-envelope-exclamation{elseif $verify_modal.variant == 'phone'}bi-phone{else}bi-patch-exclamation{/if}" aria-hidden="true"></i></span>
                <h2 class="h5 mt-3 mb-2" id="modalVerifyAccountTitle">{$verify_modal.title}</h2>
                <p class="text-body-secondary mb-0">{$verify_modal.body}</p>
            </div>
            <div class="modal-footer">
                <a class="btn btn-soft" href="{$verify_modal.logout}"><i class="bi bi-box-arrow-right me-1"></i>{lang key='website/dashboard/verify-modal-logout'}</a>
                <a class="btn btn-primary" href="{$verify_modal.link}"><i class="bi bi-patch-check me-1"></i>{lang key='website/dashboard/verify-modal-cta'}</a>
            </div>
        </div>
    </div>
</div>
{literal}<script>document.addEventListener('DOMContentLoaded',function(){var m=document.getElementById('modalVerifyAccount');if(m&&window.bootstrap){bootstrap.Modal.getOrCreateInstance(m).show();}});</script>{/literal}
{/if}
