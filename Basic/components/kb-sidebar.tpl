<aside class="col-12 col-lg-3">
    <button class="btn btn-soft d-lg-none kb-sidebar-toggle" type="button" data-bs-toggle="offcanvas" data-bs-target="#kbSidebarNav" aria-controls="kbSidebarNav"><i class="bi bi-list me-2"></i>{lang key='website/knowledgebase/sidebar-toggle'}</button>
    <div class="offcanvas-lg offcanvas-start kb-sidebar-offcanvas" tabindex="-1" id="kbSidebarNav" aria-labelledby="kbSidebarNavTitle">
        <div class="offcanvas-header d-lg-none">
            <h2 class="offcanvas-title h6 mb-0" id="kbSidebarNavTitle">{lang key='website/knowledgebase/sidebar-toggle'}</h2>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#kbSidebarNav" aria-label="{lang key='website/knowledgebase/sidebar-drawer-close'}"></button>
        </div>
        <div class="offcanvas-body">
    <nav class="kb-sidebar" aria-label="{lang key='website/knowledgebase/sidebar-nav-label'}">
        {hook name='ui:client.kb_sidebar.top'}
        <form class="kb-sidebar-search" action="{$kb_link}" method="get" role="search">
            <div class="kb-filter">
                <i class="bi bi-search kb-filter-icon" aria-hidden="true"></i>
                <label for="kb-sidebar-q" class="visually-hidden">{lang key='website/knowledgebase/search-label'}</label>
                <input type="search" class="form-control" id="kb-sidebar-q" name="q" placeholder="{lang key='website/knowledgebase/sidebar-search-placeholder'}" autocomplete="off">
            </div>
        </form>
        {assign var=kb_open value=$open_ids|default:$active_ids}
        <div class="kb-cat-accordion" id="kbCatAccordion">
            {if $popular}
            <div class="kb-cat-item">
                <button type="button" class="kb-cat-head" data-wui-toggle data-wui-target="#kbcat-popular" data-wui-parent="#kbCatAccordion" aria-expanded="false" aria-controls="kbcat-popular"><span class="kb-sidebar-ico"><i class="bi bi-fire"></i></span><span class="kb-sidebar-name">{lang key='website/knowledgebase/sidebar-popular'}</span><i class="bi bi-chevron-down wui-collapse-caret kb-cat-caret"></i></button>
                <div class="wui-collapse" id="kbcat-popular" data-wui-parent="#kbCatAccordion">
                    <div class="wui-collapse-inner">
                        <ul class="kb-subcat-list">
                            {foreach $popular as $art}
                            <li><a class="kb-subcat-link{if $art.id == $active_article} is-current{/if}" href="{$art.link}"{if $art.id == $active_article} aria-current="page"{/if}>{$art.title}</a></li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
            {/if}
            {foreach $tree as $top}
            <div class="kb-cat-item{if in_array($top.id, $active_ids)} is-active{/if}">
                <button type="button" class="kb-cat-head" data-wui-toggle data-wui-target="#kbcat-{$top.id}" data-wui-parent="#kbCatAccordion" aria-expanded="{if in_array($top.id, $kb_open)}true{else}false{/if}" aria-controls="kbcat-{$top.id}"><span class="kb-sidebar-ico"><i class="{if $top.icon}{$top.icon}{else}bi bi-journal-text{/if}"></i></span><span class="kb-sidebar-name">{$top.title}</span>{if $top.count}<span class="kb-sidebar-count">{$top.count}</span>{/if}<i class="bi bi-chevron-down wui-collapse-caret kb-cat-caret"></i></button>
                <div class="wui-collapse{if in_array($top.id, $kb_open)} wui-show{/if}" id="kbcat-{$top.id}" data-wui-parent="#kbCatAccordion">
                    <div class="wui-collapse-inner">
                        <ul class="kb-subcat-list">
                            {foreach $top.articles as $art}
                            <li><a class="kb-subcat-link{if $art.id == $active_article} is-current{/if}" href="{$art.link}"{if $art.id == $active_article} aria-current="page"{/if}>{$art.title}</a></li>
                            {/foreach}
                            {foreach $top.subcategories as $sub}
                            <li>
                                <button type="button" class="kb-subcat-head" data-wui-toggle data-wui-target="#kbsub-{$sub.id}" data-wui-parent="#kbcat-{$top.id}" aria-expanded="{if in_array($sub.id, $kb_open)}true{else}false{/if}" aria-controls="kbsub-{$sub.id}"><span class="kb-subcat-name">{$sub.title}</span><i class="bi bi-chevron-down wui-collapse-caret kb-cat-caret"></i></button>
                                <div class="wui-collapse{if in_array($sub.id, $kb_open)} wui-show{/if}" id="kbsub-{$sub.id}" data-wui-parent="#kbcat-{$top.id}">
                                    <div class="wui-collapse-inner">
                                        <ul class="kb-subcat-list">
                                            {foreach $sub.articles as $art}
                                            <li><a class="kb-subcat-link{if $art.id == $active_article} is-current{/if}" href="{$art.link}"{if $art.id == $active_article} aria-current="page"{/if}>{$art.title}</a></li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
        {hook name='ui:client.kb_sidebar.bottom'}
    </nav>
        </div>
    </div>
</aside>
