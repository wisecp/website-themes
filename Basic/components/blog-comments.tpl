{if $comments_enabled}
<section class="blog-comments">
    <h2 class="h4 blog-comments-title"><i class="bi bi-chat-square-text me-2"></i>{lang key='website/articles/comments-title'}<span class="blog-comments-count num-tabular" data-role="comment-count">{$comment_count}</span></h2>
    <div class="blog-comments-embed" data-comments data-owner-id="{$comment_owner_id}" data-post-action="{$comment_post_action}" data-can-comment="{if $can_comment}1{else}0{/if}" data-is-admin="{if $is_admin}1{else}0{/if}" data-login-url="{link route='sign-in'}" data-register-url="{link route='sign-up'}" data-reply-label="{lang key='website/articles/comment-replies-label'}" data-now-label="{lang key='website/articles/comment-just-now'}" data-commenter-avatar="{$commenter_avatar|default:''}" data-commenter-full="{$commenter_full|default:''}" data-commenter-initial="{$commenter_initial|default:''}" data-mod-i18n="{$comment_mod_i18n|default:'{}'}">
        <ul class="blog-comment-list" data-role="comment-list">
            {foreach $comments as $c}{include file='components/blog-comment-item.tpl' c=$c is_reply=false is_admin=$is_admin can_comment=$can_comment comment_owner_id=$comment_owner_id}{/foreach}
        </ul>

        <div class="blog-comment-empty basic-empty-state{if $comments} d-none{/if}" data-role="comment-empty">
            <i class="bi bi-chat-square-text" aria-hidden="true"></i>
            <p class="fw-semibold mb-1">{lang key='website/articles/comments-empty-title'}</p>
            <p class="fs-7 mb-0">{lang key='website/articles/comments-empty-text'}</p>
        </div>

        <div class="blog-comments-loadmore{if !$comments_has_more} d-none{/if}" data-role="comments-more">
            <button type="button" class="btn btn-soft btn-sm" data-action="load-comments" data-start="{$comments_next}"><i class="bi bi-arrow-down-circle me-1"></i>{lang key='website/articles/comments-load-more'}</button>
        </div>

        {if $can_comment}
        <form class="blog-comment-form" data-blog-comment-form action="{$comment_post_action}" method="post" novalidate>
            {if $commenter_avatar}<button type="button" class="blog-comment-avatar blog-comment-avatar-toggle" data-role="avatar-toggle" data-hidden="0" aria-pressed="false" title="{lang key='website/articles/comment-hide-avatar'}"><img src="{$commenter_avatar}" alt=""><span class="blog-comment-avatar-off"><i class="bi bi-eye-slash-fill"></i></span></button>{else}<span class="blog-comment-avatar"><i class="bi bi-person"></i></span>{/if}
            <div class="blog-comment-compose">
                <div class="blog-comment-identity">
                    <label class="blog-comment-identity-label" for="blog-comment-as">{lang key='website/articles/comment-as'}</label>
                    <select class="form-select form-select-sm blog-comment-identity-select" id="blog-comment-as" name="identity" data-role="comment-identity">
                        <option value="full" selected>{$commenter_full}</option>
                        <option value="initial">{$commenter_initial}</option>
                        {if $is_admin}<option value="staff">{lang key='website/articles/comment-staff-name'}</option>{/if}
                    </select>
                </div>
                <label for="blog-comment-text" class="visually-hidden">{lang key='website/articles/comment-add'}</label>
                <textarea class="form-control" id="blog-comment-text" name="message" rows="3" placeholder="{lang key='website/articles/comment-placeholder'}" data-role="comment-input"></textarea>
                <div class="blog-comment-notice" data-role="comment-notice" role="status" aria-live="polite">
                    <i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i>
                    <span data-role="comment-notice-text"></span>
                </div>
                <div class="blog-comment-form-foot">
                    {csrf form='blog-comment'}
                    <button type="submit" class="btn btn-primary btn-sm ms-sm-auto"><i class="bi bi-send me-1"></i>{lang key='website/articles/comment-post'}</button>
                </div>
                <small class="blog-comment-form-note fs-7 text-body-secondary">{lang key='website/articles/comment-note'}</small>
            </div>
        </form>
        {elseif $comment_guest}
        <form class="blog-comment-form" data-blog-comment-form data-guest="1" action="{$comment_post_action}" method="post" novalidate>
            <span class="blog-comment-avatar"><i class="bi bi-person"></i></span>
            <div class="blog-comment-compose">
                <div class="blog-comment-guest-fields d-sm-flex gap-2 mb-2">
                    <input type="text" class="form-control form-control-sm" name="name" placeholder="{lang key='website/articles/comment-guest-name-ph'}" autocomplete="name" data-role="guest-name" aria-label="{lang key='website/articles/comment-guest-name'}">
                    <input type="email" class="form-control form-control-sm" name="email" placeholder="{lang key='website/articles/comment-guest-email-ph'}" autocomplete="email" data-role="guest-email" aria-label="{lang key='website/articles/comment-guest-email'}">
                </div>
                <label for="blog-comment-text" class="visually-hidden">{lang key='website/articles/comment-add'}</label>
                <textarea class="form-control" id="blog-comment-text" name="message" rows="3" placeholder="{lang key='website/articles/comment-placeholder'}" data-role="comment-input"></textarea>
                {captcha area='blog-comment'}
                <div class="blog-comment-notice" data-role="comment-notice" role="status" aria-live="polite">
                    <i class="bi bi-exclamation-triangle-fill" aria-hidden="true"></i>
                    <span data-role="comment-notice-text"></span>
                </div>
                <div class="blog-comment-form-foot">
                    {csrf form='blog-comment'}
                    <button type="submit" class="btn btn-primary btn-sm ms-sm-auto"><i class="bi bi-send me-1"></i>{lang key='website/articles/comment-post'}</button>
                </div>
                <small class="blog-comment-form-note fs-7 text-body-secondary">{lang key='website/articles/comment-guest-note'}</small>
            </div>
        </form>
        {else}
        <div class="blog-comment-gate" data-comment-state="login">
            <span class="blog-comment-gate-ico"><i class="bi bi-chat-square-text"></i></span>
            <div class="blog-comment-gate-main">
                <span class="blog-comment-gate-title">{lang key='website/articles/comments-gate-title'}</span>
                <p class="blog-comment-gate-text">{lang key='website/articles/comments-gate-login-text'}</p>
            </div>
            <div class="blog-comment-gate-actions">
                <a class="btn btn-soft btn-sm" href="{link route='sign-in'}"><i class="bi bi-box-arrow-in-right me-1"></i>{lang key='website/articles/comments-login'}</a>
                <a class="btn btn-primary btn-sm" href="{link route='sign-up'}"><i class="bi bi-person-plus me-1"></i>{lang key='website/articles/comments-signup'}</a>
            </div>
        </div>
        {/if}
    </div>
</section>
{/if}
