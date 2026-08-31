{if $announcements}
<div class="d-none" aria-hidden="true" data-announce-src>
    {foreach $announcements as $a}{if $a.popup|default:false}
    <div class="announcement announcement-{$a.type}" data-announcement data-announcement-auto data-alert-id="announce-{$a.id}">
        <span class="announcement-ico"><i class="bi {$a.icon}"></i></span>
        <span class="announcement-title">{$a.title}</span>
        {if $a.message}<template data-announcement-content><p>{$a.message}</p></template>{/if}
    </div>
    {/if}{/foreach}
</div>
<div class="modal fade" id="announcementModal" tabindex="-1" aria-labelledby="announcementModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon" data-role="announcement-modal-ico"><i class="bi bi-megaphone"></i></span>
                <div class="modal-titles"><h2 class="modal-title h5" id="announcementModalTitle" data-role="announcement-modal-title">{lang key='website/tickets/announce-title'}</h2></div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/tickets/close-modal'}"></button>
            </div>
            <div class="modal-body" data-role="announcement-modal-body"></div>
            <div class="modal-footer"><button type="button" class="btn btn-primary" data-bs-dismiss="modal"><i class="bi bi-check-lg me-1"></i>{lang key='website/tickets/got-it'}</button></div>
        </div>
    </div>
</div>
{/if}
