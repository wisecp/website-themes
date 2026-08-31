{if $about_block}
<section class="band-visual chrome-dark py-5" data-reveal>
    {if $about_block.image}<img class="band-media" src="{$about_block.image}" alt="" loading="lazy">{/if}
    <div class="container py-3">
        <div class="row align-items-center g-4">
            <div class="col-lg-8">
                <span class="hero-eyebrow">{lang key='home_about_eyebrow'}</span>
                <h2 class="band-title mt-2 mb-3">{$about_block.title}</h2>
                {if $about_block.description}<p class="band-lead fs-7 mb-0">{$about_block.description}</p>{/if}
            </div>
            {if $about_block.button_name && $about_block.button_link}
            <div class="col-lg-4 text-lg-end">
                <a class="btn btn-light rounded-pill px-4" href="{$about_block.button_link}"{if $about_block.button_target} target="{$about_block.button_target}"{/if}>{$about_block.button_name}</a>
            </div>
            {/if}
        </div>
    </div>
</section>
{/if}
