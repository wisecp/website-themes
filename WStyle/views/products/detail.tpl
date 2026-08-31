{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/software.css'}">
{/block}

{block name=scripts}<script src="{asset path='js/software-detail.js'}" defer></script>{/block}

{block name=body_class}chrome-overlay{/block}

{block name=content}

    {capture assign=sw_store_txt}{lang key='website/products/software-breadcrumb'}{/capture}
    {include file='partials/page-hero.tpl'
        title=$product.title
        lead=$product.tagline
        crumbs=[['title' => $sw_store_txt, 'url' => $breadcrumb_root], ['title' => $product.title, 'url' => '']]
        badges=$product.category ? [['icon' => 'bi bi-tag', 'text' => $product.category]] : []}

    <section class="py-5" data-reveal>
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="sw-gallery mb-4" data-role="gallery">
                        <div class="sw-gallery-viewport rounded-3" data-role="gallery-viewport" tabindex="0" role="group" aria-roledescription="carousel" aria-label="{$product.title|escape}">
                            <div class="sw-gallery-track" data-role="gallery-track">
                                {if $gallery}
                                {foreach $gallery as $g}
                                <div class="sw-gallery-slide"><img src="{$g.url}" alt="{$g.alt|escape}" draggable="false"{if !$g@first} loading="lazy"{/if}></div>
                                {/foreach}
                                {else}
                                <div class="sw-gallery-slide"><span class="d-flex align-items-center justify-content-center w-100 ratio ratio-16x9 bg-body-tertiary text-body-secondary"><i class="bi bi-box-seam" style="font-size:3rem"></i></span></div>
                                {/if}
                            </div>
                            <button class="sw-gallery-arrow sw-gallery-prev" type="button" data-action="gallery-prev" aria-label="{lang key='website/products/detail-gallery-prev'}"><i class="bi bi-chevron-left"></i></button>
                            <button class="sw-gallery-arrow sw-gallery-next" type="button" data-action="gallery-next" aria-label="{lang key='website/products/detail-gallery-next'}"><i class="bi bi-chevron-right"></i></button>
                            {if $gallery}<span class="sw-gallery-zoom"><i class="bi bi-arrows-fullscreen"></i>{lang key='website/products/detail-gallery-zoom'}</span>{/if}
                            <span class="sw-gallery-counter num-tabular" data-role="gallery-counter">1 / {if $gallery}{$gallery|@count}{else}1{/if}</span>
                        </div>
                        {if $gallery && $gallery|@count > 1}
                        <ul class="nav sw-gallery-thumbs gap-2 mt-2" role="tablist" aria-label="{lang key='website/products/detail-gallery-thumbs'}" data-role="gallery-thumbs">
                            {foreach $gallery as $g}
                            <li class="nav-item" role="presentation"><button class="nav-link{if $g@first} active{/if}" type="button" data-action="gallery-go" data-index="{$g@index}" aria-label="{$g@iteration}"><img src="{$g.url}" alt="" draggable="false"{if !$g@first} loading="lazy"{/if}></button></li>
                            {/foreach}
                        </ul>
                        {/if}
                    </div>

                    {hook name='ui:client.product_detail.gallery.after'}

                    <ul class="nav nav-pills gap-1 mb-3" role="tablist">
                        <li class="nav-item" role="presentation"><button class="nav-link active" id="sw-description-tab" data-bs-toggle="tab" data-bs-target="#sw-description" type="button" role="tab" aria-controls="sw-description" aria-selected="true"><i class="bi bi-info-circle me-1"></i>{lang key='website/products/detail-tab-description'}</button></li>
                        {if $included}<li class="nav-item" role="presentation"><button class="nav-link" id="sw-features-tab" data-bs-toggle="tab" data-bs-target="#sw-features" type="button" role="tab" aria-controls="sw-features" aria-selected="false"><i class="bi bi-list-check me-1"></i>{lang key='website/products/detail-tab-included'}</button></li>{/if}
                        {if $installation}<li class="nav-item" role="presentation"><button class="nav-link" id="sw-installation-tab" data-bs-toggle="tab" data-bs-target="#sw-installation" type="button" role="tab" aria-controls="sw-installation" aria-selected="false"><i class="bi bi-box-arrow-in-down me-1"></i>{lang key='website/products/detail-tab-installation'}</button></li>{/if}
                        {if $versions}<li class="nav-item" role="presentation"><button class="nav-link" id="sw-versions-tab" data-bs-toggle="tab" data-bs-target="#sw-versions" type="button" role="tab" aria-controls="sw-versions" aria-selected="false"><i class="bi bi-clock-history me-1"></i>{lang key='website/products/detail-tab-versions'}</button></li>{/if}
                        {if $faq}<li class="nav-item" role="presentation"><button class="nav-link" id="sw-faq-tab" data-bs-toggle="tab" data-bs-target="#sw-faq" type="button" role="tab" aria-controls="sw-faq" aria-selected="false"><i class="bi bi-question-circle me-1"></i>{lang key='website/products/detail-tab-faq'}</button></li>{/if}
                        {hook name='ui:client.product_detail.tabs.end'}
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="sw-description" role="tabpanel" aria-labelledby="sw-description-tab" tabindex="0">
                            <div class="card">
                                <div class="card-body p-4 fs-7">
                                    {if $product.content}{$product.content nofilter}{else}<p class="text-body-secondary mb-0">{lang key='website/products/detail-no-description'}</p>{/if}
                                </div>
                            </div>
                        </div>
                        {if $included}
                        <div class="tab-pane fade" id="sw-features" role="tabpanel" aria-labelledby="sw-features-tab" tabindex="0">
                            <div class="card">
                                <div class="card-body p-4">
                                    <div class="row g-3">
                                        {foreach $included as $f}
                                        <div class="col-md-6 d-flex align-items-start gap-2"><i class="bi bi-check2-circle text-success"></i><span class="fs-7">{$f}</span></div>
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/if}
                        {if $installation}
                        <div class="tab-pane fade" id="sw-installation" role="tabpanel" aria-labelledby="sw-installation-tab" tabindex="0">
                            <div class="card"><div class="card-body p-4 fs-7">{$installation nofilter}</div></div>
                        </div>
                        {/if}
                        {if $versions}
                        <div class="tab-pane fade" id="sw-versions" role="tabpanel" aria-labelledby="sw-versions-tab" tabindex="0">
                            <div class="card"><div class="card-body p-4 fs-7">{$versions nofilter}</div></div>
                        </div>
                        {/if}
                        {if $faq}
                        <div class="tab-pane fade" id="sw-faq" role="tabpanel" aria-labelledby="sw-faq-tab" tabindex="0">
                            <div class="accordion page-faq" id="software-faq">
                                {foreach $faq as $i => $f}
                                <div class="accordion-item">
                                    <h3 class="accordion-header">
                                        <button class="accordion-button fw-semibold{if $i > 0} collapsed{/if}" type="button" data-wui-toggle data-wui-target="#swfaq-{$i}" aria-expanded="{if $i == 0}true{else}false{/if}" aria-controls="swfaq-{$i}">{$f.title}</button>
                                    </h3>
                                    <div id="swfaq-{$i}" class="wui-collapse{if $i == 0} wui-show{/if}" data-wui-parent="#software-faq"><div class="wui-collapse-inner">
                                        <div class="accordion-body">{$f.description nofilter}</div>
                                    </div></div>
                                </div>
                                {/foreach}
                            </div>
                        </div>
                        {/if}
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="d-flex flex-column gap-4">
                        {hook name='ui:client.product_detail.purchase.before'}

                        <div class="card plan-card">
                            <div class="card-body p-4 d-flex flex-column gap-3">
                                <div>
                                    <h2 class="h4 mb-2">{$product.title}</h2>
                                    {if $product.category}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-tag me-1"></i>{$product.category}</span>{/if}
                                </div>
                                {if $included}<ul class="plan-features fs-7 mb-0">{foreach $included as $f}{if $f@iteration <= 3}<li><i class="bi bi-check2"></i>{$f}</li>{/if}{/foreach}</ul>{/if}
                                {if $prices}
                                <div class="plan-price price-band">
                                    <div><span class="price-now num-tabular">{$prices[0].display}</span><span class="fs-7 text-body-secondary"> {$prices[0].label}</span></div>
                                    {if $prices|@count > 1}
                                    <button class="btn btn-link btn-sm p-0 mt-1 fs-8 fw-semibold text-decoration-none billing-compare collapsed" type="button" data-wui-toggle data-wui-target="#planBilling" aria-expanded="false">{lang key='website/products/detail-compare-billing'}<i class="bi bi-chevron-down ms-1"></i></button>
                                    <div class="wui-collapse" id="planBilling"><div class="wui-collapse-inner">
                                        <div class="table-responsive mt-2">
                                            <table class="table table-sm align-middle plan-billing-table fs-8 mb-0">
                                                <thead><tr><th scope="col">{lang key='website/products/detail-billing-cycle'}</th><th scope="col" class="text-end">{lang key='website/products/detail-billing-total'}</th></tr></thead>
                                                <tbody>
                                                    {foreach $prices as $pr}
                                                    <tr><td>{$pr.label}</td><td class="num-tabular text-end">{$pr.display}</td></tr>
                                                    {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
                                    </div></div>
                                    {/if}
                                </div>
                                {/if}
                                <div class="d-grid gap-2">
                                    {if $product.in_stock}<a class="btn btn-primary" href="{$order_link}"><i class="bi bi-cart-plus me-1"></i>{lang key='website/products/detail-add-to-cart'}</a>{else}<button class="btn btn-secondary" type="button" disabled><i class="bi bi-x-circle me-1"></i>{lang key='website/products/detail-out-of-stock'}</button>{/if}
                                    {if $demo_link || $demo_admin_link}
                                    <div class="d-flex gap-2">
                                        {if $demo_link}<a class="btn btn-soft flex-fill" href="{$demo_link}" target="_blank" rel="noopener"><i class="bi bi-eye me-1"></i>{lang key='website/products/detail-live-demo'}</a>{/if}
                                        {if $demo_admin_link}<a class="btn btn-soft flex-fill" href="{$demo_admin_link}" target="_blank" rel="noopener"><i class="bi bi-speedometer2 me-1"></i>{lang key='website/products/detail-admin-demo'}</a>{/if}
                                    </div>
                                    {/if}
                                </div>
                                <div class="d-flex flex-wrap gap-3 fs-8 text-body-secondary">
                                    <span><i class="bi bi-eye me-1"></i><span class="num-tabular">{$views|number_format:0:'.':','}</span> {lang key='website/products/detail-views'}</span>
                                </div>
                            </div>
                        </div>
                        {hook name='ui:client.product_detail.purchase.after'}
                        {if $details}
                        <div class="card">
                            <div class="card-header fw-semibold"><i class="bi bi-info-circle me-1"></i>{lang key='website/products/detail-product-details'}</div>
                            <div class="table-responsive">
                                <table class="table align-middle fs-7 mb-0">
                                    <tbody>
                                        {foreach $details as $d}
                                        <tr><th scope="row" class="fw-semibold">{$d.label}</th><td>{$d.value}</td></tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        {/if}
                        {if $requirements}
                        <div class="card">
                            <div class="card-header fw-semibold"><i class="bi bi-cpu me-1"></i>{lang key='website/products/detail-tab-requirements'}</div>
                            <div class="card-body p-4 fs-7">{$requirements nofilter}</div>
                        </div>
                        {/if}
                        {if $tags}
                        <div class="card">
                            <div class="card-header fw-semibold"><i class="bi bi-tags me-1"></i>{lang key='website/products/detail-tags'}</div>
                            <div class="card-body d-flex flex-wrap gap-2">
                                {foreach $tags as $t}<span class="plan-chip"><i class="bi bi-tag"></i>{$t}</span>{/foreach}
                            </div>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </section>

    {if $other_products}
    <section class="py-5 bg-surface" data-reveal>
        <div class="container">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h2 class="tracking-tight mb-0">{lang key='website/products/detail-other-products'}</h2>
                <a class="link-arrow fs-7" href="{$breadcrumb_root}">{lang key='website/products/detail-browse-all'}<i class="bi bi-arrow-right"></i></a>
            </div>
            <div class="plan-grid">
                {foreach $other_products as $p}
                <div>
                    <div class="card hover-lift h-100 sw-card">
                        <div class="position-relative">
                            <a class="card-img-top sw-thumb ratio ratio-16x9 d-block" href="{$p.link}" aria-label="{$p.title|escape}">
                                {if $p.image}<img src="{$p.image}" alt="" class="object-fit-cover" loading="lazy">{else}<span class="d-flex align-items-center justify-content-center h-100 w-100 text-body-secondary bg-body-tertiary"><i class="bi bi-box-seam fs-1"></i></span>{/if}
                            </a>
                            {if $p.popular}<span class="badge bg-success-subtle text-success-emphasis position-absolute top-0 start-0 m-2"><i class="bi bi-fire me-1"></i>{lang key='website/products/software-badge-popular'}</span>{/if}
                        </div>
                        <div class="card-body d-flex flex-column gap-2">
                            <h3 class="h6 mb-0"><a class="text-decoration-none" href="{$p.link}">{$p.title}</a></h3>
                            <div class="mt-auto pt-2 d-flex align-items-center justify-content-between border-top">
                                {if $p.category}<span class="fs-8 text-body-secondary"><i class="bi bi-tag me-1"></i>{$p.category}</span>{/if}
                                {if $p.price}<span class="fw-bold num-tabular">{$p.price.display}<span class="fs-8 text-body-secondary fw-normal"> {$p.price.label}</span></span>{/if}
                            </div>
                        </div>
                    </div>
                </div>
                {/foreach}
            </div>
        </div>
    </section>
    {/if}

{/block}

{block name=body_end}
{if $gallery}
<div class="sw-lightbox" data-role="lightbox" role="dialog" aria-modal="true" aria-label="{lang key='website/products/detail-gallery-viewer'}" hidden>
    <button class="sw-lightbox-close" type="button" data-action="lightbox-close" aria-label="{lang key='website/products/detail-gallery-close'}"><i class="bi bi-x-lg"></i></button>
    <button class="sw-lightbox-nav sw-lightbox-prev" type="button" data-action="lightbox-prev" aria-label="{lang key='website/products/detail-gallery-prev'}"><i class="bi bi-chevron-left"></i></button>
    <figure class="sw-lightbox-figure"><img src="" alt="" data-role="lightbox-img" draggable="false"></figure>
    <button class="sw-lightbox-nav sw-lightbox-next" type="button" data-action="lightbox-next" aria-label="{lang key='website/products/detail-gallery-next'}"><i class="bi bi-chevron-right"></i></button>
    <span class="sw-lightbox-counter num-tabular" data-role="lightbox-counter">1 / {$gallery|@count}</span>
</div>
{/if}
{/block}
