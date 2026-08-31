{extends file='layouts/default.tpl'}

{block name=content}
<section class="pt-4 pb-5">
    <div class="container">
        <h1 class="list-title mb-4">{$addon_title}</h1>
        <div class="addon-page">{$addon_content nofilter}</div>
        {hook name='ui:client.addon_page.after'}
    </div>
</section>
{/block}
