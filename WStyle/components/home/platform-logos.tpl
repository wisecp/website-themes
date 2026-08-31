{if $platform_logos.items|default:false}
<section class="py-5 bg-surface" data-reveal>
    <div class="container">
        <h2 class="visually-hidden">{lang key='home_platforms_heading'}</h2>
        <div class="brand-dock">
            <div class="brand-track">
                <div class="brand-set brand-strip">
                    {foreach $platform_logos.items as $logo}
                    <span class="brand-item"><img class="brand-logo" src="{$logo.url}" alt="{$logo.name}" loading="lazy"></span>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</section>
{/if}
