<li class="blog-comment{if $c.pinned} blog-comment-pinned{/if}" data-comment-id="{$c.id}" data-status="{$c.status}">
    <span class="blog-comment-avatar">{if $c.avatar}<img src="{$c.avatar}" alt="">{elseif $c.is_staff}<i class="bi bi-headset"></i>{else}<i class="bi bi-person"></i>{/if}</span>
    <div class="blog-comment-body">
        <div class="blog-comment-head">
            <span class="blog-comment-name">{$c.name}{if $c.is_staff}<span class="badge bg-primary-subtle text-primary-emphasis ms-2"><i class="bi bi-patch-check-fill me-1"></i>{lang key='website/articles/comment-author'}</span>{/if}{if $c.status eq 'pending'}<span class="badge bg-warning-subtle text-warning-emphasis ms-2" data-role="pending-badge"><i class="bi bi-hourglass-split me-1"></i>{lang key='website/articles/comment-pending-badge'}</span>{/if}{if $c.pinned}<span class="badge bg-secondary-subtle text-secondary-emphasis ms-2" data-role="pinned-badge"><i class="bi bi-pin-angle-fill me-1"></i>{lang key='website/articles/comment-pinned-badge'}</span>{/if}</span>
            <span class="blog-comment-date num-tabular" data-role="comment-time" data-ts="{$c.ctime_ts}" title="{$c.date_full}">{$c.date_display}</span>
        </div>
        <p class="blog-comment-text" data-role="comment-text">{$c.message_html nofilter}</p>
        <div class="blog-comment-actions">
            <button type="button" class="blog-comment-action blog-comment-helpful{if $c.viewer_helpful} is-active{/if}" data-action="comment-helpful" data-id="{$c.id}" aria-pressed="{if $c.viewer_helpful}true{else}false{/if}"><i class="bi bi-hand-thumbs-up{if $c.viewer_helpful}-fill{/if} me-1"></i>{lang key='website/articles/comment-helpful'} (<span data-role="helpful-count">{$c.helpful}</span>)</button>
            {if $can_comment && !$is_reply}<button type="button" class="blog-comment-action" data-action="comment-reply" data-id="{$c.id}"><i class="bi bi-reply me-1"></i>{lang key='website/articles/comment-reply'}</button>{/if}
            {if $is_admin}<div class="dropdown blog-comment-mod">
                <button class="btn btn-ghost btn-sm blog-comment-mod-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/articles/comment-mod-actions'}"><i class="bi bi-three-dots-vertical"></i></button>
                <ul class="dropdown-menu dropdown-menu-end">
                    {if $c.status neq 'approved'}<li><button class="dropdown-item" type="button" data-action="mod-approve" data-id="{$c.id}"><i class="bi bi-check2-circle"></i>{lang key='website/articles/comment-mod-approve'}</button></li>{/if}
                    <li><button class="dropdown-item" type="button" data-action="mod-edit" data-id="{$c.id}"><i class="bi bi-pencil"></i>{lang key='website/articles/comment-mod-edit'}</button></li>
                    {if !$is_reply}<li><button class="dropdown-item" type="button" data-action="mod-pin" data-id="{$c.id}"><i class="bi bi-pin-angle"></i>{lang key='website/articles/comment-mod-pin'}</button></li>{/if}
                    <li><button class="dropdown-item" type="button" data-action="mod-spam" data-id="{$c.id}"><i class="bi bi-shield-exclamation"></i>{lang key='website/articles/comment-mod-spam'}</button></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><button class="dropdown-item text-danger" type="button" data-action="mod-delete" data-id="{$c.id}"><i class="bi bi-trash3"></i>{lang key='website/articles/comment-mod-delete'}</button></li>
                </ul>
            </div>{/if}
        </div>
        {if !$is_reply && $c.reply_total > 0}
        <button type="button" class="blog-comment-action blog-comment-replies-toggle" data-action="toggle-replies" data-parent-id="{$c.id}" data-loaded="0" aria-expanded="false">
            <i class="bi bi-chevron-down me-1" data-role="toggle-icon"></i><span data-role="reply-count-label">{$c.reply_total}</span>&nbsp;{lang key='website/articles/comment-replies-label'}
        </button>
        <div class="wui-collapse" data-role="replies-collapse">
            <div class="wui-collapse-inner">
                <ul class="blog-comment-list blog-comment-replies" data-role="replies" data-parent-id="{$c.id}"></ul>
                <div class="blog-comment-replies-more d-none" data-role="replies-more"><button type="button" class="btn btn-soft btn-sm" data-action="load-replies" data-parent-id="{$c.id}" data-start="0"><i class="bi bi-arrow-down-circle me-1"></i>{lang key='website/articles/comment-more-replies'}</button></div>
            </div>
        </div>
        {/if}
    </div>
</li>
