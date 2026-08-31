{extends file='layouts/default.tpl'}

{block name=head}<link rel="stylesheet" href="{asset path='css/index.css'}">{/block}

{block name=content}

    <section class="hero text-center">
        <div class="container">
            <h1 class="hero-title reveal mb-3">{lang key='website/index/hero-title'}</h1>
            <p class="hero-lead text-body-secondary reveal reveal-2 mb-4">{lang key='website/index/hero-lead'}</p>

            {if $visibility_domain}
            <form class="hero-search reveal reveal-3 mb-3" action="{link route='domain'}" method="get">
                <div class="domain-search">
                    <label for="domain-query" class="visually-hidden">{lang key='website/index/hero-search-label'}</label>
                    <input type="text" class="form-control" id="domain-query" name="domain" placeholder="{lang key='website/index/hero-search-placeholder'}" autocomplete="off" required>
                    <button class="btn btn-primary" type="submit"><i class="bi bi-search me-1"></i>{lang key='website/index/hero-search-button'}</button>
                </div>
            </form>

            {if $spotlight_tlds}
            <div class="d-flex flex-wrap justify-content-center gap-2 reveal reveal-4 mb-4">
                {foreach $spotlight_tlds as $tld}
                <a class="tld-chip" href="{$tld.link}"><span class="tld-name">.{$tld.name}</span><span class="tld-price num-tabular">{$tld.price}</span>{if $tld.was}<span class="tld-was num-tabular fs-8">{$tld.was}</span>{/if}</a>
                {/foreach}
            </div>
            {/if}
            {/if}

            <div class="d-flex flex-wrap justify-content-center gap-4 fs-8 text-body-secondary reveal reveal-5">
                <span><i class="bi bi-shield-check me-1 text-success"></i>{lang key='website/index/hero-trust-moneyback'}</span>
                <span><i class="bi bi-activity me-1 text-success"></i>{lang key='website/index/hero-trust-uptime'}</span>
                <span><i class="bi bi-check2-circle me-1 text-success"></i>{lang key='website/index/hero-trust-cancel'}</span>
            </div>
        </div>
    </section>

    {hook name='ui:client.home.hero.after'}

    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="eyebrow">{lang key='website/index/products-eyebrow'}</span>
                <h2 class="tracking-tight mt-1 mb-2">{lang key='website/index/products-heading'}</h2>
                <p class="text-body-secondary mb-0">{lang key='website/index/products-subtitle'}</p>
            </div>
            <div class="row g-3 justify-content-center">
                {foreach $product_cards as $card}
                <div class="col-md-6 col-xl-3">
                    <a class="product-card hover-lift" href="{$card.link}">
                        <span class="icon-disc">{if $card.icon.type == 'image'}<img src="{$card.icon.value}" alt="">{else}<i class="{$card.icon.value}"></i>{/if}</span>
                        <span class="h5 mb-0">{$card.title}</span>
                        {if $card.subtitle}<span class="fs-7 text-body-secondary">{$card.subtitle}</span>{/if}
                        {if $card.price}<span class="product-price">{lang key='website/index/card-price-from'} <strong class="num-tabular">{$card.price}</strong></span>{/if}
                        <span class="link-arrow fs-7">{lang key='website/index/card-explore-plans'}<i class="bi bi-arrow-right"></i></span>
                    </a>
                </div>
                {/foreach}
            </div>
        </div>
    </section>

    {if $feature_blocks}
    <section class="py-5 border-top border-bottom">
        <div class="container">
            {assign var=fb_count value=$feature_blocks|@count}
            {assign var=fb_rest value=$fb_count % 4}
            {assign var=fb_pad value=$fb_rest ? 4 - $fb_rest : 0}
            {assign var=fb_pad_start value=($fb_pad - ($fb_pad % 2)) / 2}
            {assign var=fb_pad_end value=$fb_pad - $fb_pad_start}
            {assign var=fb_last_row value=$fb_count - ($fb_rest ? $fb_rest : 4)}
            <div class="row g-0 justify-content-center feature-band">
                {foreach $feature_blocks as $fb}
                {if $fb@index == $fb_last_row}{for $p=1 to $fb_pad_start}
                <div class="col-md-6 col-xl-3 feature-cell is-pad" aria-hidden="true"></div>
                {/for}{/if}
                <div class="col-md-6 col-xl-3 feature-cell">
                    <div class="feature-item">
                        <span class="icon-disc"><i class="{$fb.icon}"></i></span>
                        <div>
                            <h3 class="h6 mb-1">{$fb.title}</h3>
                            {if $fb.description}<p class="fs-7 text-body-secondary mb-0">{$fb.description}</p>{/if}
                        </div>
                    </div>
                </div>
                {/foreach}
                {for $p=1 to $fb_pad_end}
                <div class="col-md-6 col-xl-3 feature-cell is-pad" aria-hidden="true"></div>
                {/for}
            </div>
        </div>
    </section>
    {/if}

    {if $news_posts}
    <section class="py-5">
        <div class="container">
            <div class="d-flex flex-wrap align-items-end justify-content-between gap-2 mb-4">
                <div>
                    <span class="eyebrow">{lang key='website/index/home-news-eyebrow'}</span>
                    <h2 class="tracking-tight mt-1 mb-0">{lang key='website/index/home-news-heading'}</h2>
                </div>
                <a class="link-arrow fs-7" href="{link route='news'}">{lang key='website/index/home-news-view-all'}<i class="bi bi-arrow-right"></i></a>
            </div>
            <div class="row g-3">
                {foreach $news_posts as $news}
                <div class="col-md-4">
                    <a class="news-card hover-lift" href="{$news.link}">
                        <span class="news-date num-tabular">{$news.date}</span>
                        <span class="news-title">{$news.title}</span>
                        {if $news.summary}<span class="fs-7 text-body-secondary">{$news.summary}</span>{/if}
                    </a>
                </div>
                {/foreach}
            </div>
        </div>
    </section>
    {/if}

    {hook name='ui:client.home.sections.end'}

    {include file='components/cta-band.tpl'
        cta_title_key='website/index/cta-title'
        cta_text_key='website/index/cta-text'
        cta_primary_key='website/index/cta-get-started'
        cta_secondary_key='website/index/cta-talk-sales'}

{/block}
