{if $feature_blocks}
<section class="py-5 border-top" data-reveal>
    <div class="container">
        <div class="section-head">
            <span class="eyebrow">{lang key='home_why_eyebrow'}</span>
            <h2 class="tracking-tight">{if $feature_heading.title|default:''}{$feature_heading.title}{else}{lang key='home_why_title'}{/if}</h2>
            <p class="section-lead">{if $feature_heading.description|default:''}{$feature_heading.description}{else}{lang key='home_why_lead'}{/if}</p>
        </div>
        <div class="row g-4 why-grid">
            {foreach $feature_blocks as $fb}
            <div class="col-md-6 col-xl-4">
                <div class="why-card hover-lift">
                    <span class="icon-disc why-card-ico"><i class="{$fb.icon}"></i></span>
                    <h3 class="h5 mb-2">{$fb.title}</h3>
                    {if $fb.description}<p class="fs-7 text-body-secondary mb-0">{$fb.description}</p>{/if}
                </div>
            </div>
            {/foreach}
        </div>
    </div>
</section>
{/if}
