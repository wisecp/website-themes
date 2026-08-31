{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/knowledgebase.css'}">
<link rel="stylesheet" href="{asset path='css/about.css'}">
{/block}

{block name=content}

    <section class="page-hero text-center">
        <div class="container">
            <h1 class="page-hero-title reveal mb-0">{$page.title}</h1>
        </div>
    </section>

    <section class="container py-4 py-lg-5">
        <div class="row g-4 g-lg-5">

            {if $show_sidebar && ($siblings|@count) > 1}
            <div class="col-lg-3">
                <nav class="about-nav" aria-label="{if $is_contract}{lang key='website/page/sidebar-contracts'}{else}{lang key='website/page/sidebar-pages'}{/if}">
                    {foreach $siblings as $s}
                    <a class="about-nav-link{if $s.id == $page.id} active{/if}" href="{$s.link}"{if $s.id == $page.id} aria-current="page"{/if}>{$s.title}</a>
                    {/foreach}
                </nav>
            </div>
            <div class="col-lg-9">
            {else}
            <div class="col-12">
            {/if}
                <div class="kb-prose">{if $page.content}{content var=$page.content}{else}<p class="text-body-secondary mb-0">{lang key='website/page/no-content'}</p>{/if}</div>
            </div>

            {hook name='ui:client.content_page.content.after'}

        </div>
    </section>

    {if !$is_contract}
    {include file='components/cta-band.tpl'
        cta_title_key='website/page/cta-title'
        cta_text_key='website/page/cta-lead'
        cta_primary_key='website/page/cta-primary'
        cta_secondary_key='website/page/cta-secondary'}
    {/if}

{/block}
