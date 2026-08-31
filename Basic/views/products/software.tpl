{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/software.css'}">
<script src="{asset path='js/software.js'}" defer></script>
{/block}

{block name=content}

    <section class="page-hero text-center">
        <div class="container">
            {if $category}
            <h1 class="page-hero-title reveal mb-3">{$category.title}</h1>
            {if $category.sub_title}<p class="page-hero-lead text-body-secondary reveal reveal-2 mb-4">{$category.sub_title}</p>{/if}
            {else}
            <h1 class="page-hero-title reveal mb-3">{lang key='website/products/software-hero-title'}</h1>
            <p class="page-hero-lead text-body-secondary reveal reveal-2 mb-4">{lang key='website/products/software-hero-lead'}</p>
            {/if}
            <div class="d-flex flex-wrap justify-content-center gap-4 fs-8 text-body-secondary reveal reveal-3">
                <span><i class="bi bi-credit-card me-1 text-success"></i>{lang key='website/products/software-hero-badge-billing'}</span>
                <span><i class="bi bi-eye me-1 text-success"></i>{lang key='website/products/software-hero-badge-demo'}</span>
                <span><i class="bi bi-arrow-repeat me-1 text-success"></i>{lang key='website/products/software-hero-badge-updates'}</span>
            </div>
        </div>
    </section>

    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <aside class="col-lg-3">
                    <div class="card">
                        <div class="card-header fw-semibold"><i class="bi bi-funnel me-1"></i>{lang key='website/products/software-filter-heading'}</div>
                        <div class="list-group list-group-flush" data-role="software-filters">
                            <a class="list-group-item list-group-item-action d-flex align-items-center justify-content-between{if !$category} active{/if}" href="{link route='softwares'}"><span><i class="bi bi-grid me-2"></i>{lang key='website/products/software-filter-all'}</span><span class="fs-8 num-tabular sw-count">{$total_count}</span></a>
                            {foreach $filters as $f}
                            <a class="list-group-item list-group-item-action d-flex align-items-center justify-content-between{if $f.active} active{/if}" href="{$f.link}"><span>{if $f.icon.type == 'image'}<img src="{$f.icon.value}" alt="" class="me-2" style="width:1em;height:1em;object-fit:contain">{else}<i class="{$f.icon.value} me-2"></i>{/if}{$f.title}</span><span class="fs-8 num-tabular sw-count">{$f.count}</span></a>
                            {/foreach}
                        </div>
                    </div>
                </aside>
                <div class="col-lg-9">
                    <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                        <span class="fs-7 text-body-secondary" data-role="software-count" data-count-template="{lang key='website/products/software-count'}">{lang key='website/products/software-count' visible=$list_count total=$list_count}</span>
                        <div class="d-flex flex-wrap flex-sm-nowrap align-items-center gap-2 ms-auto">
                            <div class="software-search">
                                <label for="software-search" class="visually-hidden">{lang key='website/products/software-search-label'}</label>
                                <input type="search" class="form-control form-control-sm" id="software-search" placeholder="{lang key='website/products/software-search-placeholder'}" data-role="software-search" autocomplete="off">
                            </div>
                            <label for="software-sort" class="visually-hidden">{lang key='website/products/software-sort-label'}</label>
                            <select class="form-select form-select-sm w-auto flex-shrink-0" id="software-sort" data-role="software-sort">
                                <option value="featured" selected>{lang key='website/products/software-sort-featured'}</option>
                                <option value="price-asc">{lang key='website/products/software-sort-price-asc'}</option>
                                <option value="price-desc">{lang key='website/products/software-sort-price-desc'}</option>
                                <option value="name">{lang key='website/products/software-sort-name'}</option>
                            </select>
                        </div>
                    </div>

                    {if $products}
                    <div class="plan-grid" data-role="software-grid" data-page-size="{$page_size}">
                        {foreach $products as $p}
                        <div data-category="{$p.category_id}" data-price="{if $p.price}{$p.price.amount}{else}0{/if}" data-name="{$p.title|escape}">
                            <div class="card hover-lift h-100 sw-card">
                                <div class="position-relative">
                                    <a class="card-img-top sw-thumb ratio ratio-16x9 d-block" href="{$p.link}" aria-label="{$p.title|escape}">
                                        {if $p.image}<img src="{$p.image}" alt="" class="object-fit-cover" loading="lazy">{else}<span class="d-flex align-items-center justify-content-center h-100 w-100 text-body-secondary bg-body-tertiary"><i class="bi bi-box-seam fs-1"></i></span>{/if}
                                    </a>
                                    {if $p.popular}<span class="badge bg-success-subtle text-success-emphasis position-absolute top-0 start-0 m-2"><i class="bi bi-fire me-1"></i>{lang key='website/products/software-badge-popular'}</span>{/if}
                                </div>
                                <div class="card-body d-flex flex-column gap-2">
                                    <h4 class="h6 mb-0"><a class="text-decoration-none" href="{$p.link}">{$p.title}</a></h4>
                                    {if $p.tags}<span class="fs-8 text-body-secondary"><i class="bi bi-code-slash me-1"></i>{$p.tags}</span>{/if}
                                    {if $p.category}<span class="fs-8 text-body-secondary">{lang key='website/products/software-category-label'} <span class="fw-semibold">{$p.category}</span></span>{/if}
                                    <div class="mt-auto pt-2 d-flex align-items-center justify-content-between border-top">
                                        <span class="fs-8"><span class="text-warning" aria-hidden="true"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i></span><span class="text-body-secondary ms-1 num-tabular">5.0</span></span>
                                        {if $p.price}<span class="fw-bold num-tabular">{$p.price.display}<span class="fs-8 text-body-secondary fw-normal"> {$p.price.cycle}</span></span>{/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/foreach}
                    </div>

                    {hook name='ui:client.software_store.grid.after'}

                    <div class="list-foot mt-4" data-role="software-foot">
                        <nav class="list-pagination d-none" aria-label="{lang key='website/products/software-pagination-label'}" data-role="software-pagination">
                            <ul class="pagination pagination-sm m-0"></ul>
                        </nav>
                    </div>

                    <div class="card d-none" data-role="software-empty">
                        <div class="card-body basic-empty-state">
                            <i class="bi bi-search"></i>
                            <p class="mb-0">{lang key='website/products/software-empty'}</p>
                            <button class="btn btn-soft btn-sm" type="button" data-action="software-clear"><i class="bi bi-x-lg me-1"></i>{lang key='website/products/software-clear'}</button>
                        </div>
                    </div>
                    <p class="fs-8 text-body-secondary mt-3 mb-0">{lang key='website/products/software-prices-note' currency=$selected_currency_code}</p>
                    {else}
                    <div class="card">
                        <div class="card-body basic-empty-state">
                            {if $category && $category.icon.type == 'image'}<img src="{$category.icon.value}" alt="" style="width:2.5rem;height:2.5rem;object-fit:contain;opacity:.5">
                            {elseif $category}<i class="{$category.icon.value}"></i>
                            {else}<i class="bi bi-box-seam"></i>{/if}
                            <p class="mb-0">{lang key='website/products/software-store-empty'}</p>
                        </div>
                    </div>
                    {/if}
                </div>
            </div>
        </div>
    </section>

    {if $category && $category.content}
    <section class="py-5 border-top border-bottom">
        <div class="container">
            <div class="category-content">{content var=$category.content}</div>
        </div>
    </section>
    {/if}

    <section class="pb-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="eyebrow">{lang key='website/products/software-included-eyebrow'}</span>
                <h2 class="tracking-tight mt-1 mb-2">{lang key='website/products/software-included-heading'}</h2>
                <p class="text-body-secondary mb-0">{lang key='website/products/software-included-subtitle'}</p>
            </div>
            <div class="row g-3">
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-code-slash"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/products/software-included-1-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/products/software-included-1-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-eye"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/products/software-included-2-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/products/software-included-2-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-arrow-repeat"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/products/software-included-3-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/products/software-included-3-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="bi bi-life-preserver"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{lang key='website/products/software-included-4-title'}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{lang key='website/products/software-included-4-desc'}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    {include file='components/cta-band.tpl'
        cta_title_key='website/products/category-cta-title'
        cta_text_key='website/products/category-cta-text'
        cta_primary_key='website/products/category-cta-primary'
        cta_secondary_key='website/products/category-cta-secondary'}

{/block}
