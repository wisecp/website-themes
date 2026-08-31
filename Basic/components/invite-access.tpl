<div class="invite-access mb-4">
    <p class="fs-8 text-body-secondary text-uppercase fw-semibold mb-2">{lang key='website/sign/invite-access-title'}</p>
    {if $invite_access_full}
    <span class="badge bg-primary-subtle text-primary-emphasis"><i class="bi bi-shield-lock-fill me-1"></i>{lang key='website/sign/invite-access-full'}</span>
    {elseif $invite_access_labels}
    <div class="d-flex flex-wrap gap-1">
        {foreach $invite_access_labels as $lbl}
        <span class="badge bg-secondary-subtle text-secondary-emphasis">{$lbl}</span>
        {/foreach}
    </div>
    {/if}
</div>
