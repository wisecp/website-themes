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
