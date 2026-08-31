<div class="{$wrapclass}">
    <button class="{$toggleclass}" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"{if $arialabel|default:''} aria-label="{$arialabel}"{/if}>{if $icoclass|default:''}<span class="{$icoclass}"><i class="bi {$icon|default:'bi-globe2'}"></i></span>{else}<i class="bi {$icon|default:'bi-globe2'} me-1"></i>{/if}{if $labelclass|default:''}<span class="{$labelclass}">{/if}<span>{$selected_lang_key|default:'EN'}</span><span class="opacity-50 mx-1">·</span><span>{$selected_currency_code|default:'USD'}</span>{if $labelclass|default:''}</span>{/if}{if $caret|default:false}<i class="bi bi-chevron-up ms-1 locale-caret"></i>{/if}</button>
    <div class="{$menuclass}">
        <ul class="nav nav-pills nav-fill locale-tabs" role="tablist">
            <li class="nav-item" role="presentation"><button class="nav-link active" id="locale-lang-tab{$idsuffix}" data-bs-toggle="tab" data-bs-target="#locale-lang{$idsuffix}" type="button" role="tab" aria-controls="locale-lang{$idsuffix}" aria-selected="true">{lang key='website/index/locale-tab-language'}</button></li>
            <li class="nav-item" role="presentation"><button class="nav-link" id="locale-cur-tab{$idsuffix}" data-bs-toggle="tab" data-bs-target="#locale-cur{$idsuffix}" type="button" role="tab" aria-controls="locale-cur{$idsuffix}" aria-selected="false">{lang key='website/index/locale-tab-currency'}</button></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade show active" id="locale-lang{$idsuffix}" role="tabpanel" aria-labelledby="locale-lang-tab{$idsuffix}" tabindex="0">
                <label for="locale-lang-search{$idsuffix}" class="visually-hidden">{lang key='website/index/locale-lang-search-label'}</label>
                <input type="search" class="form-control form-control-sm locale-search" id="locale-lang-search{$idsuffix}" placeholder="{lang key='website/index/locale-search-placeholder'}" data-role="locale-search" autocomplete="off">
                <div class="locale-list">
                    {foreach $lang_list as $l}
                    <a class="dropdown-item{if $l.selected} active{/if}" href="{$l.link}">{$l.name}<i class="bi bi-check2"></i></a>
                    {/foreach}
                </div>
            </div>
            <div class="tab-pane fade" id="locale-cur{$idsuffix}" role="tabpanel" aria-labelledby="locale-cur-tab{$idsuffix}" tabindex="0">
                <label for="locale-cur-search{$idsuffix}" class="visually-hidden">{lang key='website/index/locale-cur-search-label'}</label>
                <input type="search" class="form-control form-control-sm locale-search" id="locale-cur-search{$idsuffix}" placeholder="{lang key='website/index/locale-search-placeholder'}" data-role="locale-search" autocomplete="off">
                <div class="locale-list">
                    {foreach $currencies as $c}
                    <a class="dropdown-item{if $c.id == $selected_currency} active{/if}" href="?currency={$c.code}">{$c.code} - {$c.name}<i class="bi bi-check2"></i></a>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>
