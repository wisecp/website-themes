{if ($setting.content_section_frame|default:'theme') == 'none'}
{if $block.title || $block.description}
<div class="container pt-5">
    <div class="section-head">
        {if $block.title}<h2 class="tracking-tight">{$block.title}</h2>{/if}
        {if $block.description}<p class="section-lead">{$block.description}</p>{/if}
    </div>
</div>
{/if}
{content var=$block.content}
{else}
<section class="py-5 border-top" data-reveal>
    <div class="container">
        {if $block.title || $block.description}
        <div class="section-head">
            {if $block.title}<h2 class="tracking-tight">{$block.title}</h2>{/if}
            {if $block.description}<p class="section-lead">{$block.description}</p>{/if}
        </div>
        {/if}
        {content var=$block.content}
    </div>
</section>
{/if}
