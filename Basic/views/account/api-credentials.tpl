{extends file='layouts/default.tpl'}

{block name=head}
    <link rel="stylesheet" href="{asset path='css/api-credentials.css'}">
    <link rel="stylesheet" href="{asset path='css/libs/wcp-table/table.css'}">
{/block}

{block name=scripts}
    <script src="{asset path='js/libs/wcp-table/table.js'}" defer></script>
    <script src="{asset path='js/api-credentials.js'}" defer></script>
{/block}

{block name=content}
<section class="pt-4 pb-5" data-apik-page data-apik-url="{link route='api'}"
         data-txt-perm-1="{lang key='website/api/permission-1'}"
         data-txt-perms-n="{lang key='website/api/permissions-n'}"
         data-txt-created-now="{lang key='website/api/created-just-now'}"
         data-txt-never-used="{lang key='website/api/never-used'}"
         data-txt-st-active="{lang key='website/api/st-active'}"
         data-txt-st-revoked="{lang key='website/api/st-revoked'}"
         data-txt-revoked-on="{lang key='website/api/revoked-on'}"
         data-txt-ip-restricted="{lang key='website/api/ip-restricted'}"
         data-txt-edit="{lang key='website/api/act-edit'}"
         data-txt-regenerate="{lang key='website/api/act-regenerate'}"
         data-txt-revoke="{lang key='website/api/act-revoke'}"
         data-txt-delete="{lang key='website/api/act-delete'}"
         data-txt-more-actions="{lang key='website/api/more-actions'}"
         data-txt-copied="{lang key='website/api/copied'}"
         data-txt-cancel="{lang key='website/api/cancel'}"
         data-txt-create-title="{lang key='website/api/modal-create-title'}"
         data-txt-create-sub="{lang key='website/api/modal-create-sub'}"
         data-txt-create-btn="{lang key='website/api/create'}"
         data-txt-creating="{lang key='website/api/busy-creating'}"
         data-txt-edit-title="{lang key='website/api/modal-edit-title'}"
         data-txt-edit-sub="{lang key='website/api/modal-edit-sub'}"
         data-txt-save-btn="{lang key='website/api/save'}"
         data-txt-saving="{lang key='website/api/busy-saving'}"
         data-txt-regen-title="{lang key='website/api/confirm-regenerate-title'}"
         data-txt-regen-msg="{lang key='website/api/confirm-regenerate-msg' attr=1}"
         data-txt-revoke-title="{lang key='website/api/confirm-revoke-title'}"
         data-txt-revoke-msg="{lang key='website/api/confirm-revoke-msg' attr=1}"
         data-txt-delete-title="{lang key='website/api/confirm-delete-title'}"
         data-txt-delete-msg="{lang key='website/api/confirm-delete-msg' attr=1}"
         data-txt-delete-ok="{lang key='website/api/confirm-delete-ok'}"
         data-txt-log-error="{lang key='website/api/log-error'}"
         data-txt-log-resp="{lang key='website/api/log-resp-body'}">
    <div class="container">
        {csrf form='api-credentials'}

            <nav aria-label="{lang key='website/api/breadcrumb-aria'}">
                <ol class="breadcrumb mb-1">
                    <li class="breadcrumb-item"><a href="{link route='my-account'}">{lang key='website/index/subnav-dashboard'}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">{lang key='website/api/title'}</li>
                </ol>
            </nav>
            <div class="apik-pagehead">
                <div class="apik-pagehead-start">
                    <h1 class="list-title mb-0">{lang key='website/api/title'}</h1>
                    <a class="btn btn-soft btn-sm apik-doc-btn" href="{$apik_docs_url}" target="_blank" rel="noopener"><i class="bi bi-journal-code me-1"></i>{lang key='website/api/docs'}</a>
                </div>
                <div class="apik-pagehead-end">
                    <button type="button" class="btn btn-primary" data-action="apik-create"><i class="bi bi-plus-lg me-1"></i>{lang key='website/api/create'}</button>
                </div>
            </div>

            <ul class="nav apik-tabs" role="tablist" data-basic-tabs="api-credentials">
                <li class="nav-item" role="presentation"><button class="nav-link active" id="apik-tab-keys-btn" data-bs-toggle="tab" data-bs-target="#apik-tab-keys" type="button" role="tab" aria-controls="apik-tab-keys" aria-selected="true"><i class="bi bi-key me-2"></i>{lang key='website/api/tab-keys'}</button></li>
                <li class="nav-item" role="presentation"><button class="nav-link" id="apik-tab-logs-btn" data-bs-toggle="tab" data-bs-target="#apik-tab-logs" type="button" role="tab" aria-controls="apik-tab-logs" aria-selected="false"><i class="bi bi-clock-history me-2"></i>{lang key='website/api/tab-logs'}</button></li>
            </ul>

            <div class="tab-content">
            <div class="tab-pane fade show active" id="apik-tab-keys" role="tabpanel" aria-labelledby="apik-tab-keys-btn" tabindex="0">

            <div class="apik-note">
                <i class="bi bi-info-circle" aria-hidden="true"></i>
                <p>{lang key='website/api/note'}</p>
            </div>

            <div class="apik-list" data-role="apik-list">

                {foreach $apik_keys as $k}
                <article class="apik-key{if $k.status == 'revoked'} apik-key-revoked{/if}" data-key-id="{$k.id}" data-key-name="{$k.name|escape}" data-key-status="{$k.status}" data-key-perms="{$k.perms_count}" data-perms="{$k.perms_attr}"{if $k.ips} data-ips="{$k.ips|escape}"{/if}>
                    <span class="apik-key-ico"><i class="bi bi-key-fill"></i></span>
                    <div class="apik-key-main">
                        <div class="apik-key-head">
                            <span class="apik-key-name">{$k.name}</span>
                            {if $k.status == 'active'}<span class="badge bg-success-subtle text-success-emphasis" data-role="apik-status"><i class="bi bi-check-circle me-1"></i>{lang key='website/api/st-active'}</span>
                            {else}<span class="badge bg-secondary-subtle text-secondary-emphasis" data-role="apik-status"><i class="bi bi-x-circle me-1"></i>{lang key='website/api/st-revoked'}</span>{/if}
                        </div>
                        <div class="apik-key-meta">
                            {if $k.status == 'active'}
                            <span class="apik-key-token">
                                <i class="bi bi-key apik-key-token-ico" aria-hidden="true"></i>
                                <span class="apik-key-token-value num-tabular" data-role="apik-token">{$k.secret_masked}</span>
                            </span>
                            {else}
                            <span class="apik-key-token apik-key-token-static"><i class="bi bi-key apik-key-token-ico" aria-hidden="true"></i><span class="apik-key-token-value num-tabular" data-role="apik-token">{$k.secret_masked}</span></span>
                            {/if}
                            <span class="list-chip" data-role="apik-perm-chip"><i class="bi bi-shield-check"></i>{if $k.perms_count == 1}{lang key='website/api/permission-1'}{else}{lang key='website/api/permissions-n' count=$k.perms_count}{/if}</span>
                            {if $k.ip_restricted}<span class="list-chip apik-key-iprestrict"><i class="bi bi-hdd-network"></i>{lang key='website/api/ip-restricted'}</span>{/if}
                        </div>
                        <div class="apik-key-sub">
                            <span class="apik-key-dim" data-role="apik-created"><i class="bi bi-calendar3"></i>{lang key='website/api/created' date=$k.created_label}</span>
                            {if $k.status == 'revoked'}<span class="apik-key-dim" data-role="apik-used"><i class="bi bi-slash-circle"></i>{lang key='website/api/revoked-on' date=$k.revoked_label}</span>
                            {elseif $k.last_used}<span class="apik-key-dim" data-role="apik-used"><i class="bi bi-clock-history"></i>{lang key='website/api/last-used' ago=$k.last_used}</span>
                            {else}<span class="apik-key-dim" data-role="apik-used"><i class="bi bi-clock-history"></i>{lang key='website/api/never-used'}</span>{/if}
                        </div>
                    </div>
                    <div class="apik-key-actions list-actions">
                        {if $k.status == 'active'}
                        <button type="button" class="btn btn-soft btn-sm" data-action="apik-edit" data-key-id="{$k.id}"><i class="bi bi-sliders me-1"></i>{lang key='website/api/act-edit'}</button>
                        <div class="dropdown">
                            <button type="button" class="btn btn-soft btn-sm apik-kebab" data-bs-toggle="dropdown" aria-expanded="false" aria-label="{lang key='website/api/more-actions' name=$k.name}"><i class="bi bi-three-dots"></i></button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><button type="button" class="dropdown-item" data-action="apik-regenerate" data-key-id="{$k.id}" data-key-name="{$k.name|escape}"><i class="bi bi-arrow-repeat"></i>{lang key='website/api/act-regenerate'}</button></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><button type="button" class="dropdown-item text-danger" data-action="apik-revoke" data-key-id="{$k.id}" data-key-name="{$k.name|escape}"><i class="bi bi-x-circle"></i>{lang key='website/api/act-revoke'}</button></li>
                            </ul>
                        </div>
                        {else}
                        <button type="button" class="btn btn-soft btn-sm apik-delete-btn" data-action="apik-delete" data-key-id="{$k.id}" data-key-name="{$k.name|escape}"><i class="bi bi-trash3 me-1"></i>{lang key='website/api/act-delete'}</button>
                        {/if}
                    </div>
                </article>
                {/foreach}

                <div class="basic-empty-state apik-empty{if $apik_keys} d-none{/if}" data-role="apik-empty">
                    <i class="bi bi-key" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/api/empty-title'}</span>
                    <span class="fs-7">{lang key='website/api/empty-text'}</span>
                    <button type="button" class="btn btn-primary mt-1" data-action="apik-create"><i class="bi bi-plus-lg me-1"></i>{lang key='website/api/empty-cta'}</button>
                </div>

            </div>

            </div>

            <div class="tab-pane fade" id="apik-tab-logs" role="tabpanel" aria-labelledby="apik-tab-logs-btn" tabindex="0">
                <div class="apik-note">
                    <i class="bi bi-clock-history" aria-hidden="true"></i>
                    <p>{lang key='website/api/logs-note'}</p>
                </div>

                {if $apik_logs}
                <div class="wcp-table" data-name="api-logs" id="apik-logs">
                    <div class="wcp-table-header">
                        <div class="apik-logs-search">
                            <i class="bi bi-search" aria-hidden="true"></i>
                            <input type="search" class="form-control form-control-sm wcp-search-input" placeholder="{lang key='website/api/logs-search-ph'}" aria-label="{lang key='website/api/logs-search-aria'}" autocomplete="off">
                        </div>
                        <select class="form-select form-select-sm apik-logs-filter" data-table-filter="api-logs" data-filter-column="status" aria-label="{lang key='website/api/th-status'}">
                            <option value="">{lang key='website/api/logs-all-statuses'}</option>
                            <option value="success">{lang key='website/api/logs-success'}</option>
                            <option value="client-error">{lang key='website/api/logs-client-error'}</option>
                            <option value="server-error">{lang key='website/api/logs-server-error'}</option>
                        </select>
                        <select class="form-select form-select-sm apik-logs-filter" data-table-filter="api-logs" data-filter-column="method" aria-label="{lang key='website/api/th-method'}">
                            <option value="">{lang key='website/api/logs-all-methods'}</option>
                            <option value="GET">GET</option>
                            <option value="POST">POST</option>
                            <option value="PUT">PUT</option>
                            <option value="PATCH">PATCH</option>
                            <option value="DELETE">DELETE</option>
                        </select>
                        <select class="form-select form-select-sm apik-logs-filter" data-table-filter="api-logs" data-filter-column="key" aria-label="{lang key='website/api/th-key'}">
                            <option value="">{lang key='website/api/logs-all-keys'}</option>
                            {foreach $apik_keys as $k}<option value="key_{$k.id}">{$k.name}</option>{/foreach}
                        </select>
                        <label class="wcp-entries-label fs-8 text-body-secondary mb-0">
                            <select class="form-select form-select-sm wcp-entries-select" aria-label="{lang key='website/api/logs-per-page-aria'}">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="-1">All</option>
                            </select>
                            {lang key='website/api/logs-per-page'}
                        </label>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle apik-logs-table mb-0">
                            <thead>
                                <tr>
                                    <th scope="col" data-sortable="desc" data-column="time">{lang key='website/api/th-time'}</th>
                                    <th scope="col" data-sortable="true" data-column="method">{lang key='website/api/th-method'}</th>
                                    <th scope="col" data-sortable="true" data-column="endpoint">{lang key='website/api/th-endpoint'}</th>
                                    <th scope="col" data-sortable="true" data-column="status">{lang key='website/api/th-status'}</th>
                                    <th scope="col" class="text-end" data-sortable="true" data-column="duration">{lang key='website/api/th-duration'}</th>
                                    <th scope="col" data-sortable="true" data-column="ip">{lang key='website/api/th-ip'}</th>
                                    <th scope="col" data-sortable="true" data-column="key">{lang key='website/api/th-key'}</th>
                                    <th scope="col"><span class="visually-hidden">{lang key='website/api/th-details'}</span></th>
                                </tr>
                            </thead>
                            <tbody class="wcp-table-body">
                                {foreach $apik_logs as $log}
                                <tr data-filter-status="{$log.filter}" data-filter-method="{$log.method}" data-filter-key="key_{$log.key_id}" data-id="{$log.id}" data-dt="{$log.dt_plain}" data-method="{$log.method}" data-endpoint="{$log.endpoint|escape}" data-scope="{$log.scope|escape}" data-code="{$log.code}" data-statustext="{$log.statustext}" data-duration="{$log.duration}" data-ip="{$log.ip|escape}" data-keyname="{$log.keyname|escape}" data-reqheaders="{$log.reqheaders|escape}" data-params="{$log.params|escape}" data-response="{$log.response|escape}" data-error="{$log.error|escape}">
                                    <td data-column="time" data-value="{$log.sort}" class="num-tabular">{$log.dt nofilter}</td>
                                    <td data-column="method" data-value="{$log.method}"><span class="apik-method apik-method-{$log.method|lower}">{$log.method}</span></td>
                                    <td data-column="endpoint"><span class="apik-log-ep">{$log.endpoint}</span></td>
                                    <td data-column="status" data-value="{$log.code}"><span class="badge bg-{$log.tone}-subtle text-{$log.tone}-emphasis"><i class="bi {if $log.tone == 'danger'}bi-x-octagon{elseif $log.tone == 'warning'}bi-exclamation-triangle{else}bi-check-circle{/if} me-1"></i>{$log.code}</span></td>
                                    <td data-column="duration" data-value="{$log.duration}" class="text-end num-tabular">{$log.duration} ms</td>
                                    <td data-column="ip" class="num-tabular">{$log.ip}</td>
                                    <td data-column="key">{$log.keyname}</td>
                                    <td class="text-end"><button type="button" class="btn btn-ghost btn-sm" data-action="log-view" data-bs-toggle="tooltip" title="{lang key='website/api/view-details'}" aria-label="{lang key='website/api/view-details'}"><i class="bi bi-eye"></i></button></td>
                                </tr>
                                {/foreach}
                            </tbody>
                            <tbody class="wcp-table-loader-body d-none">
                                <tr><td colspan="8" class="text-center py-4"><span class="wcp-table-loader spinner-border spinner-border-sm text-secondary" role="status" aria-hidden="true"></span></td></tr>
                            </tbody>
                            <tbody class="wcp-table-no-result-body d-none">
                                <tr><td colspan="8"><div class="wcp-table-no-result basic-empty-state py-4"><i class="bi bi-inbox" aria-hidden="true"></i><span class="fw-semibold">{lang key='website/api/logs-empty-title'}</span><span class="fs-7">{lang key='website/api/logs-empty-text'}</span></div></td></tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="wcp-table-footer">
                        <div class="wcp-table-info fs-8 text-body-secondary" data-msg1="No requests out of _MAX_" data-msg2="(filtered from _MAX_ total)" data-msg3="Showing _START_-_END_ of _TOTAL_ requests"></div>
                        <nav class="wcp-table-pagination" aria-label="{lang key='website/api/log-pages-aria'}"></nav>
                    </div>
                </div>
                {else}
                <div class="basic-empty-state apik-empty">
                    <i class="bi bi-inbox" aria-hidden="true"></i>
                    <span class="fw-semibold">{lang key='website/api/logs-none-title'}</span>
                    <span class="fs-7">{lang key='website/api/logs-none-text'}</span>
                </div>
                {/if}
            </div>

            </div>

            {hook name='ui:client.api_credentials.after'}

        </div>
    </section>
{/block}

{block name=body_end}
<div class="modal fade" id="apik-modal" tabindex="-1" aria-labelledby="apik-modal-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon modal-icon--primary" data-role="apik-modal-ico"><i class="bi bi-key"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="apik-modal-title" data-role="apik-modal-title">{lang key='website/api/modal-create-title'}</h2>
                    <p class="modal-subtitle" data-role="apik-modal-sub">{lang key='website/api/modal-create-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/api/close'}"></button>
            </div>
            <form id="apik-form" novalidate>
                <div class="modal-body">
                    <div class="row g-4">
                        <div class="col-12 col-lg-4 apik-id-col">
                            <div class="mb-3">
                                <label for="apik-name" class="form-label">{lang key='website/api/name'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="apik-name" name="name" autocomplete="off" placeholder="{lang key='website/api/name-ph'}" required>
                                <div class="invalid-feedback">{lang key='website/api/err-name-empty'}</div>
                            </div>
                            <div class="apik-ips-field">
                                <label for="apik-ips" class="form-label">{lang key='website/api/ips'} <span class="text-body-secondary fw-normal">{lang key='website/api/optional'}</span></label>
                                <textarea class="form-control apik-ips" id="apik-ips" name="allowed_ips" rows="6" placeholder="{lang key='website/api/ips-ph'}" autocomplete="off" spellcheck="false"></textarea>
                                <div class="form-text"><i class="bi bi-shield-lock me-1"></i>{lang key='website/api/ips-help'}</div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-8 apik-perm-col">
                            <h3 class="apik-modal-section">{lang key='website/api/permissions'}</h3>

                            <div class="apik-perm" data-role="apik-perm">
                        <div class="apik-perm-top">
                            <label class="apik-fullaccess">
                                <input type="checkbox" class="form-check-input" data-role="apik-fullaccess">
                                <span class="apik-fullaccess-text"><i class="bi bi-shield-lock"></i>{lang key='website/api/full-access'}</span>
                            </label>
                            <span class="apik-perm-summary"><span class="fw-semibold num-tabular" data-role="apik-sel-count">0</span> {lang key='website/api/perm-summary'} <span class="num-tabular" data-role="apik-total">0</span> {lang key='website/api/perm-selected'}</span>
                        </div>
                        <div class="apik-perm-search">
                            <i class="bi bi-search" aria-hidden="true"></i>
                            <input type="search" class="form-control" data-role="apik-search" placeholder="{lang key='website/api/perm-search-ph'}" autocomplete="off" aria-label="{lang key='website/api/perm-search-aria'}">
                        </div>
                        <div class="apik-perm-body">
                            <div class="apik-perm-cats" role="tablist" aria-orientation="vertical" aria-label="{lang key='website/api/perm-cats-aria'}" data-role="apik-cats">
                        {foreach $apik_catalog as $slug => $cat}
                        <button type="button" class="apik-cat{if $cat@first} is-active{/if}" data-cat="{$slug}" id="apik-cat-{$slug}" role="tab" aria-selected="{if $cat@first}true{else}false{/if}" aria-controls="apik-pane-{$slug}">
                            <span class="apik-cat-label">{$cat.label}</span>
                            <span class="apik-cat-count d-none" data-role="apik-cat-count">0</span>
                        </button>
                        {/foreach}
                            </div>
                            <div class="apik-perm-detail-col">
                                <div class="apik-perm-detail-head">
                                    <label class="apik-selall">
                                        <input type="checkbox" class="form-check-input" data-role="apik-selall">
                                        <span>{lang key='website/api/select-all-in'} <span data-role="apik-selall-cat"></span></span>
                                    </label>
                                </div>
                                <div class="apik-perm-detail" data-role="apik-detail">
                        {foreach $apik_catalog as $slug => $cat}
                        <div class="apik-ep-pane{if !$cat@first} d-none{/if}" data-cat-pane="{$slug}" id="apik-pane-{$slug}" role="tabpanel" aria-labelledby="apik-cat-{$slug}">
                            <div class="apik-ep-grid">
                                {foreach $cat.perms as $scope => $p}
                                <div class="apik-ep" data-handler="{$p.name|escape}">
                                    <label class="apik-ep-label">
                                        <input type="checkbox" class="form-check-input" data-perm="{$scope}">
                                        {if $p.method}<span class="apik-ep-method apik-m-{$p.method_class}">{$p.method}</span>{/if}
                                        <span class="apik-ep-name"><span class="apik-ep-path">{if $p.path}{$p.path}{else}{$p.name}{/if}</span></span>
                                    </label>
                                    <a class="apik-ep-info" href="{$apik_docs_url}" target="_blank" rel="noopener" data-bs-toggle="tooltip" title="{$p.desc}" aria-label="{lang key='website/api/perm-doc' name=$p.name}"><i class="bi bi-info-circle"></i></a>
                                </div>
                                {/foreach}
                            </div>
                        </div>
                        {/foreach}
                                    <p class="apik-perm-noresult d-none" data-role="apik-noresult"><i class="bi bi-search me-1"></i>{lang key='website/api/no-perm-match'}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <p class="apik-perm-warn d-none" data-role="apik-perm-warn"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/api/err-no-permission'}</p>
                    <button type="submit" class="btn btn-primary" data-busy-text="{lang key='website/api/busy-creating'}" data-role="apik-submit"><i class="bi bi-plus-lg me-1"></i>{lang key='website/api/create'}</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="apik-log-modal" tabindex="-1" aria-labelledby="apik-log-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon modal-icon--primary"><i class="bi bi-arrow-left-right"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5 apik-log-modal-title" id="apik-log-title"><span data-role="log-method-chip"></span><span data-role="log-endpoint"></span></h2>
                    <p class="modal-subtitle" data-role="log-sub"></p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/api/close'}"></button>
            </div>
            <div class="modal-body">
                <div class="apik-log-summary">
                    <div class="apik-log-field">
                        <span class="apik-log-field-key"><i class="bi bi-activity"></i>{lang key='website/api/log-status'}</span>
                        <span class="apik-log-field-val" data-role="log-status"></span>
                    </div>
                    <div class="apik-log-field">
                        <span class="apik-log-field-key"><i class="bi bi-stopwatch"></i>{lang key='website/api/log-duration'}</span>
                        <span class="apik-log-field-val num-tabular" data-role="log-duration"></span>
                    </div>
                    <div class="apik-log-field">
                        <span class="apik-log-field-key"><i class="bi bi-hdd-network"></i>{lang key='website/api/log-ip'}</span>
                        <span class="apik-log-field-val num-tabular" data-role="log-ip"></span>
                    </div>
                    <div class="apik-log-field">
                        <span class="apik-log-field-key"><i class="bi bi-key"></i>{lang key='website/api/log-key'}</span>
                        <span class="apik-log-field-val" data-role="log-key"></span>
                    </div>
                    <div class="apik-log-field apik-log-field-wide">
                        <span class="apik-log-field-key"><i class="bi bi-hash"></i>{lang key='website/api/log-request-id'}</span>
                        <span class="apik-log-field-idrow">
                            <span class="apik-log-field-val num-tabular" data-role="log-id"></span>
                            <button type="button" class="apik-log-id-copy" data-action="log-copy-id" data-bs-toggle="tooltip" title="{lang key='website/api/log-copy-id'}" aria-label="{lang key='website/api/log-copy-id'}"><i class="bi bi-clipboard"></i></button>
                        </span>
                    </div>
                </div>
                <h3 class="apik-modal-section" data-role="log-reqh-head">Request Headers</h3>
                <div class="apik-log-headers" data-role="log-req-headers"></div>
                <h3 class="apik-modal-section">{lang key='website/api/log-req-body'}</h3>
                <pre class="apik-log-code" data-role="log-request"></pre>
                <h3 class="apik-modal-section" data-role="log-resp-head">{lang key='website/api/log-resp-body'}</h3>
                <pre class="apik-log-code" data-role="log-response"></pre>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="apik-created-modal" tabindex="-1" aria-labelledby="apik-created-title" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon modal-icon--success"><i class="bi bi-check-lg"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="apik-created-title">{lang key='website/api/created-title'}</h2>
                    <p class="modal-subtitle">{lang key='website/api/created-sub'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/api/close'}"></button>
            </div>
            <div class="modal-body">
                <label class="form-label" for="apik-created-value">{lang key='website/api/created-label'}</label>
                <div class="apik-created-key">
                    <span class="apik-created-key-val num-tabular" id="apik-created-value" data-role="created-key" tabindex="0"></span>
                    <button type="button" class="btn btn-soft apik-copy-btn" data-action="apik-copy-created" data-bs-toggle="tooltip" title="{lang key='website/api/copy'}"><i class="bi bi-clipboard"></i><span data-role="created-copy-label">{lang key='website/api/copy'}</span></button>
                </div>
                <p class="apik-created-hint"><i class="bi bi-shield-check me-1"></i>{lang key='website/api/created-hint'}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal"><i class="bi bi-check-lg me-1"></i>{lang key='website/api/done'}</button>
            </div>
        </div>
    </div>
</div>
{/block}
