{if $setting.topbar_enabled}
<div class="topbar fs-8">
    <div class="container d-flex align-items-center gap-4 py-1">
        {if $setting.topbar_text}{content var=$setting.topbar_text}{/if}
        {hook name='ui:client.topbar.end'}
    </div>
</div>
{/if}
