{if $cookie_notice}
<div class="cookie-notice" data-cookie-notice data-cookie-url="{$cookie_notice.url}" data-cookie-token="{$cookie_notice.token}"{if !$cookie_notice.needs_prompt} hidden{/if}>
    <div class="cookie-notice-card">
        <p class="cookie-notice-text">
            {$cookie_notice.text}
            {if $cookie_notice.policy_link}<a href="{$cookie_notice.policy_link}">{$cookie_notice.policy_label}</a>{/if}
        </p>

        <div class="wui-collapse" id="cookie-prefs" data-cookie-prefs>
            <div class="wui-collapse-inner">
                <div class="cookie-notice-cats">
                    <span class="cookie-notice-cats-title">{$cookie_notice.prefs_title}</span>
                    {foreach $cookie_notice.categories as $cat}
                    <label class="cookie-cat">
                        <input type="checkbox" class="cookie-cat-input" value="{$cat.key}"{if $cat.granted} checked{/if}{if $cat.locked} disabled{/if}>
                        <span class="cookie-cat-body">
                            <span class="cookie-cat-name">{$cat.label}</span>
                            <span class="cookie-cat-desc">{$cat.desc}</span>
                        </span>
                    </label>
                    {/foreach}
                </div>
            </div>
        </div>

        <div class="cookie-notice-acts">
            <button type="button" class="cookie-btn cookie-btn-solid" data-cookie-action="accept">{$cookie_notice.accept}</button>
            <button type="button" class="cookie-btn cookie-btn-ghost" data-cookie-action="reject">{$cookie_notice.reject}</button>
            <button type="button" class="cookie-btn cookie-btn-bare" data-cookie-action="prefs" aria-expanded="false" aria-controls="cookie-prefs">{$cookie_notice.prefs}</button>
            <button type="button" class="cookie-btn cookie-btn-solid" data-cookie-action="save" hidden>{$cookie_notice.save}</button>
        </div>
    </div>
</div>
{/if}
