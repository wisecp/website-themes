<div class="d-flex align-items-center gap-3 p-3 rounded border bg-success-subtle" data-signedin-panel>
    <i class="bi bi-person-check-fill fs-2 text-success-emphasis lh-1" aria-hidden="true"></i>
    <span class="me-auto">
        <span class="fw-semibold d-block">{lang key='website/checkout/signed-in'}</span>
        <span class="fs-8 text-body-secondary fw-semibold" data-role="signedin-email">{$account_email}</span>
        {if !empty($ordering_for)}
        <span class="fs-8 fw-semibold d-block mt-1 text-warning-emphasis"><i class="bi bi-people-fill me-1"></i>{lang key='website/checkout/ordering-for' account=$ordering_for.name}</span>
        {/if}
    </span>
    <a class="btn btn-outline-success btn-sm" href="{link route='sign-out'}"><i class="bi bi-box-arrow-right me-1"></i>{lang key='website/checkout/log-out'}</a>
</div>
