{if $featured_software.items|default:false}
<section class="py-5" data-reveal>
    <div class="container">
        <div class="section-head">
            <span class="eyebrow">{lang key='home_software_eyebrow'}</span>
            <h2 class="tracking-tight">{$featured_software.title}</h2>
            {if $featured_software.description}<p class="section-lead">{$featured_software.description}</p>{/if}
        </div>
        <div class="row g-3">
            {foreach $featured_software.items as $sw}
            <div class="col-md-4">
                <div class="card hover-lift h-100 sw-card">
                    <div class="position-relative">
                        <a class="card-img-top sw-thumb ratio ratio-16x9 d-block" href="{$sw.link}" aria-label="{$sw.title}">
                            {if $sw.image}<img src="{$sw.image}" alt="" class="object-fit-cover" loading="lazy">{/if}
                        </a>
                        {if $sw.new}<span class="badge bg-info-subtle text-info-emphasis position-absolute top-0 start-0 m-2"><i class="bi bi-stars me-1"></i>{lang key='home_software_new'}</span>{/if}
                    </div>
                    <div class="card-body d-flex flex-column gap-2">
                        <h3 class="h6 mb-0"><a class="text-decoration-none" href="{$sw.link}">{$sw.title}</a></h3>
                        {if $sw.tags}<span class="fs-8 text-body-secondary"><i class="bi bi-code-slash me-1"></i>{$sw.tags}</span>{/if}
                        <div class="mt-auto pt-2 d-flex align-items-center justify-content-between border-top">
                            {if $sw.category}<span class="fs-8 text-body-secondary"><i class="bi bi-tag me-1"></i>{$sw.category}</span>{/if}
                            {if $sw.price}<span class="fw-bold num-tabular">{$sw.price}<span class="fs-8 text-body-secondary fw-normal">/{lang key='date/cycles-short/monthly'}</span></span>{/if}
                        </div>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
        <div class="text-center mt-4">
            <a class="link-arrow fs-7" href="{link route='softwares'}">{lang key='home_software_browse'}<i class="bi bi-arrow-right"></i></a>
        </div>
    </div>
</section>
{/if}
