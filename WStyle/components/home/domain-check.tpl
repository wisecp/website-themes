{if $visibility_domain}
<section class="domain-band py-5" id="find-domain" data-reveal>
    <div class="container">
        <div class="section-head">
            <span class="eyebrow">{lang key='home_domain_eyebrow'}</span>
            <h2 class="tracking-tight">{lang key='home_domain_title'}</h2>
            <p class="section-lead">{lang key='home_domain_lead'}</p>
        </div>
        <form class="domain-band-search mb-4" action="{link route='domain'}" method="get">
            <div class="domain-search">
                <label for="domain-query" class="visually-hidden">{lang key='website/index/hero-search-label'}</label>
                <input type="text" class="form-control" id="domain-query" name="domain" placeholder="{lang key='website/index/hero-search-placeholder'}" autocomplete="off" required>
                <button class="btn btn-primary" type="submit"><i class="bi bi-search me-1"></i>{lang key='website/index/hero-search-button'}</button>
            </div>
        </form>
        {if $spotlight_tlds}
        <div class="tld-row mb-4">
            {foreach $spotlight_tlds as $tld}
            <a class="tld-tile" href="{$tld.link}">
                <span class="tld-tile-head">{if $tld.logo}<img class="tld-logo" src="{$tld.logo}" alt=".{$tld.name}">{else}<span class="tld-name">.{$tld.name}</span>{/if}{if $tld.was}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-tag me-1"></i>{lang key='home_tld_sale'}</span>{/if}</span>
                <span class="tld-tile-price"><span class="tld-price num-tabular">{$tld.price}</span>{if $tld.was}<del class="tld-was num-tabular fs-8">{$tld.was}</del>{/if}</span>
            </a>
            {/foreach}
            <a class="tld-tile tld-tile-more" href="{link route='domain'}">
                <span class="tld-more-count">{lang key='home_tld_more'}</span>
                <span class="link-arrow fs-7">{lang key='home_tld_see_all'}<i class="bi bi-arrow-right"></i></span>
            </a>
        </div>
        {/if}
        <div class="d-flex flex-wrap justify-content-center gap-4 fs-7 text-body-secondary">
            <span><i class="bi bi-shield-check me-1 text-success"></i>{lang key='home_perk_whois'}</span>
            <span><i class="bi bi-diagram-3 me-1 text-success"></i>{lang key='home_perk_dns'}</span>
            <span><i class="bi bi-arrow-return-right me-1 text-success"></i>{lang key='home_perk_forwarding'}</span>
        </div>
    </div>
</section>
{/if}
