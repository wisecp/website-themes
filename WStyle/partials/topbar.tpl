<div class="topbar chrome-dark fs-8">
    <div class="container d-flex align-items-center py-2">
        {if $social_links}
        <div class="d-flex align-items-center gap-1">
            {foreach $social_links as $social}
            <a class="topbar-icon" href="{$social.url}" aria-label="{$social.name}"><i class="{$social.icon}"></i></a>
            {/foreach}
        </div>
        {/if}
        <div class="d-flex align-items-center gap-3 ms-auto">
            {if $contact_phone}
            <a class="topbar-link" href="tel:{$contact_phone|regex_replace:'/[^+0-9]/':''}"><i class="bi bi-telephone me-1"></i><span class="num-tabular">{$contact_phone}</span></a>
            {/if}
            {if $support_enabled|default:false}
            <a class="topbar-link" href="{link route='tickets'}"><i class="bi bi-life-preserver me-1"></i>{lang key='topbar_support'}</a>
            {/if}
            {hook name='ui:client.topbar.end'}
        </div>
    </div>
</div>
