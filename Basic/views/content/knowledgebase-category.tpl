{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/knowledgebase.css'}">
<script src="{asset path='js/knowledgebase-category.js'}" defer></script>
<script src="{asset path='js/knowledgebase-sidebar.js'}" defer></script>
{/block}

{block name=content}

    <section class="container py-4 py-lg-5">

        <nav aria-label="Breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{$kb_link}">{lang key='website/knowledgebase/breadcrumb-knowledgebase'}</a></li>
                {foreach $breadcrumb as $c name=bc}
                {if $smarty.foreach.bc.last}<li class="breadcrumb-item active" aria-current="page">{$c.title}</li>{else}<li class="breadcrumb-item"><a href="{$c.link}">{$c.title}</a></li>{/if}
                {/foreach}
            </ol>
        </nav>

        <div class="row g-4 g-lg-5">

            {include file='components/kb-sidebar.tpl'}

            <div class="col-12 col-lg-9" data-kb-view="overview">

                <header class="kb-cat-header">
                    <span class="kb-cat-header-ico"><i class="{$cat_icon}"></i></span>
                    <div class="kb-cat-header-text">
                        <h1 class="kb-cat-header-title">{$category.title}</h1>
                        {if $category.sub_title}<p class="kb-cat-header-desc">{$category.sub_title}</p>{/if}
                        <span class="kb-cat-header-count"><i class="bi bi-file-earmark-text me-1"></i>{$cat_count} {lang key='website/knowledgebase/articles-in-category'}</span>
                    </div>
                </header>

                {hook name='ui:client.kb_category.header.after'}

                {if $is_overview}
                <div data-kb-groups>
                    {foreach $groups as $g}
                    <section class="kb-article-group" data-kb-group>
                        {if $g.title}
                        <header class="kb-group-head">
                            <h2 class="kb-section-title kb-group-title"><a href="{$g.link}">{$g.title}</a></h2>
                            {if $g.total > 5}<a class="kb-group-all" href="{$g.link}">{lang key='website/knowledgebase/view-all'} {$g.total}<i class="bi bi-arrow-right"></i></a>{/if}
                        </header>
                        {/if}
                        <div class="kb-article-list">
                            {foreach $g.articles as $a}
                            <a href="{$a.link}" class="kb-article" data-kb-item>
                                <div class="kb-article-body">
                                    <span class="kb-article-title">{$a.title}</span>
                                    <div class="kb-article-meta">{if $a.popular}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-fire me-1"></i>{lang key='website/knowledgebase/badge-popular'}</span>{/if}<span><i class="bi bi-eye me-1"></i>{$a.views_display} {lang key='website/knowledgebase/views'}</span></div>
                                </div>
                                <i class="bi bi-chevron-right kb-article-arrow"></i>
                            </a>
                            {/foreach}
                        </div>
                    </section>
                    {/foreach}
                </div>
                {else}

                {if $flat}
                <div data-kb-groups>
                    <section class="kb-article-group" data-kb-group>
                        <div class="kb-article-list" data-kb-page-size="{$page_size}">
                            {foreach $flat as $a}
                            <a href="{$a.link}" class="kb-article" data-kb-item>
                                <div class="kb-article-body">
                                    <span class="kb-article-title">{$a.title}</span>
                                    <div class="kb-article-meta">{if $a.popular}<span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-fire me-1"></i>{lang key='website/knowledgebase/badge-popular'}</span>{/if}<span><i class="bi bi-eye me-1"></i>{$a.views_display} {lang key='website/knowledgebase/views'}</span></div>
                                </div>
                                <i class="bi bi-chevron-right kb-article-arrow"></i>
                            </a>
                            {/foreach}
                        </div>
                    </section>
                </div>

                <div class="kb-article-list kb-list-skeleton d-none" data-role="kb-list-skeleton" aria-hidden="true">
                    <div class="kb-article"><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                    <div class="kb-article"><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                    <div class="kb-article"><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                    <div class="kb-article"><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                    <div class="kb-article"><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                    <div class="kb-article"><div class="kb-article-body"><span class="basic-skeleton d-block w-75 mb-2"></span><span class="basic-skeleton d-block w-50"></span></div></div>
                </div>

                <nav class="kb-pager d-none" data-kb-pager aria-label="{lang key='website/knowledgebase/pager-label'}"
                        data-txt-showing="{lang key='website/knowledgebase/pager-showing'}"
                        data-txt-prev="{lang key='website/knowledgebase/pager-prev'}"
                        data-txt-next="{lang key='website/knowledgebase/pager-next'}">
                    <span class="kb-pager-info" data-role="kb-pager-info"></span>
                    <ul class="pagination pagination-sm m-0" data-role="kb-pager-pages"></ul>
                </nav>
                {else}
                <div class="basic-empty-state">
                    <i class="bi bi-journal-text" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/knowledgebase/cat-empty-title'}</span>
                    <span class="fs-7">{lang key='website/knowledgebase/cat-empty-text'}</span>
                </div>
                {/if}

                {/if}

                {hook name='ui:client.kb_category.content.bottom'}

            </div>
        </div>

        <div class="kb-help-cta">
            <div class="kb-help-cta-text">
                <div class="kb-help-cta-title">{lang key='website/knowledgebase/help-title'}</div>
                <p class="kb-help-cta-sub">{lang key='website/knowledgebase/help-sub'}</p>
            </div>
            <div class="kb-help-actions">
                <a href="{link route='contact'}" class="btn btn-soft"><i class="bi bi-envelope me-1"></i>{lang key='website/knowledgebase/help-contact'}</a>
                {if $support_enabled}<a href="{link route='ticket-create'}" class="btn btn-primary"><i class="bi bi-life-preserver me-1"></i>{lang key='website/knowledgebase/help-ticket'}</a>{/if}
            </div>
        </div>

    </section>

{/block}
