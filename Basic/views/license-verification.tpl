{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/license-verification.css'}">
{/block}

{block name=scripts}
<script src="{asset path='js/license-verification.js'}" defer></script>
{/block}

{block name=content}

    <section class="page-hero text-center" data-license-page
             data-txt-lookup-failed="{lang key='website/license/lookup-failed'}"
             data-txt-captcha-required="{lang key='website/license/captcha-required'}">
        <div class="container">
            <h1 class="page-hero-title reveal mb-3">{lang key='website/license/hero-title'}</h1>
            <p class="page-hero-lead text-body-secondary reveal reveal-2 mb-4">{lang key='website/license/hero-lead'}</p>

            <div class="page-hero-search reveal reveal-3">
                <ul class="nav nav-pills justify-content-center gap-1 mb-3" role="tablist">
                    <li class="nav-item" role="presentation"><button class="nav-link active" id="lv-tab-domain" data-bs-toggle="tab" data-bs-target="#lv-pane-domain" type="button" role="tab" aria-controls="lv-pane-domain" aria-selected="true"><i class="bi bi-globe2 me-1"></i>{lang key='website/license/tab-domain'}</button></li>
                    <li class="nav-item" role="presentation"><button class="nav-link" id="lv-tab-ip" data-bs-toggle="tab" data-bs-target="#lv-pane-ip" type="button" role="tab" aria-controls="lv-pane-ip" aria-selected="false"><i class="bi bi-hdd-network me-1"></i>{lang key='website/license/tab-ip'}</button></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="lv-pane-domain" role="tabpanel" aria-labelledby="lv-tab-domain" tabindex="0">
                        <form action="{link route='license'}" method="post" novalidate data-lv-form data-lv-type="domain">
                            <div class="domain-search">
                                <label for="lv-domain" class="visually-hidden">{lang key='website/license/domain-label'}</label>
                                <input type="text" class="form-control" id="lv-domain" name="q" placeholder="example.com" autocomplete="off" autocapitalize="off" spellcheck="false">
                                <button class="btn btn-primary" type="submit"><i class="bi bi-shield-check me-1"></i>{lang key='website/license/check-button'}</button>
                            </div>
                            <div class="lv-formnote mt-2 text-start">
                                <span class="fs-7 text-body-secondary" data-role="lv-hint">{lang key='website/license/domain-hint'}</span>
                                <span class="fs-7 text-danger d-none" data-role="lv-error"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/license/domain-error'}</span>
                            </div>
                            {csrf form='license-verify'}
                            {captcha area='software-license'}
                        </form>
                    </div>
                    <div class="tab-pane fade" id="lv-pane-ip" role="tabpanel" aria-labelledby="lv-tab-ip" tabindex="0">
                        <form action="{link route='license'}" method="post" novalidate data-lv-form data-lv-type="ip">
                            <div class="domain-search">
                                <label for="lv-ip" class="visually-hidden">{lang key='website/license/ip-label'}</label>
                                <input type="text" class="form-control num-tabular" id="lv-ip" name="q" placeholder="203.0.113.10" autocomplete="off" spellcheck="false">
                                <button class="btn btn-primary" type="submit"><i class="bi bi-shield-check me-1"></i>{lang key='website/license/check-button'}</button>
                            </div>
                            <div class="lv-formnote mt-2 text-start">
                                <span class="fs-7 text-body-secondary" data-role="lv-hint">{lang key='website/license/ip-hint'}</span>
                                <span class="fs-7 text-danger d-none" data-role="lv-error"><i class="bi bi-exclamation-circle me-1"></i>{lang key='website/license/ip-error'}</span>
                            </div>
                            {csrf form='license-verify'}
                            {captcha area='software-license'}
                        </form>
                    </div>
                </div>

                <div class="wui-collapse" id="lv-result">
                    <div class="wui-collapse-inner">
                        <div class="pt-3 text-start">

                            <div class="card lv-result-card d-none" data-role="lv-loading" aria-hidden="true">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-center gap-3 mb-3">
                                        <span class="basic-skeleton lv-skeleton-disc"></span>
                                        <span class="basic-skeleton d-block w-50"></span>
                                    </div>
                                    <span class="basic-skeleton d-block w-100 mb-2"></span>
                                    <span class="basic-skeleton d-block w-75 mb-2"></span>
                                    <span class="basic-skeleton d-block w-50"></span>
                                </div>
                            </div>

                            <div class="card lv-result-card lv-valid d-none" data-role="lv-valid">
                                <div class="card-body p-4">
                                    <div class="lv-result-head">
                                        <span class="lv-result-ico lv-ico-success"><i class="bi bi-patch-check-fill"></i></span>
                                        <div class="lv-result-headings">
                                            <span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/license/valid-badge'}</span>
                                            <h2 class="h5 mb-1 mt-2" data-role="lv-title" data-txt-domain="{lang key='website/license/valid-title-domain'}" data-txt-ip="{lang key='website/license/valid-title-ip'}">{lang key='website/license/valid-title-domain'}</h2>
                                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/license/confirmed-for'} <strong class="num-tabular" data-role="lv-subject">example.com</strong>.</p>
                                        </div>
                                    </div>
                                    <dl class="lv-detail-grid mt-4 mb-0">
                                        <div class="lv-detail">
                                            <dt>{lang key='website/license/detail-product'}</dt>
                                            <dd data-role="lv-product">—</dd>
                                        </div>
                                        <div class="lv-detail">
                                            <dt>{lang key='website/license/detail-type'}</dt>
                                            <dd data-role="lv-type">—</dd>
                                        </div>
                                        <div class="lv-detail">
                                            <dt>{lang key='website/license/detail-domain'}</dt>
                                            <dd class="num-tabular" data-role="lv-licensed-domain">—</dd>
                                        </div>
                                        <div class="lv-detail">
                                            <dt>{lang key='website/license/detail-ip'}</dt>
                                            <dd class="num-tabular" data-role="lv-licensed-ip">—</dd>
                                        </div>
                                        <div class="lv-detail">
                                            <dt>{lang key='website/license/detail-status'}</dt>
                                            <dd><span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-check-circle me-1"></i>{lang key='website/license/status-active'}</span></dd>
                                        </div>
                                        <div class="lv-detail">
                                            <dt>{lang key='website/license/detail-valid-until'}</dt>
                                            <dd class="num-tabular" data-role="lv-valid-until">—</dd>
                                        </div>
                                    </dl>
                                </div>
                            </div>

                            <div class="card lv-result-card lv-invalid d-none" data-role="lv-invalid">
                                <div class="card-body p-4">
                                    <div class="lv-result-head">
                                        <span class="lv-result-ico lv-ico-danger"><i class="bi bi-shield-fill-exclamation"></i></span>
                                        <div class="lv-result-headings">
                                            <span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/license/invalid-badge'}</span>
                                            <h2 class="h5 mb-1 mt-2" data-role="lv-title" data-txt-domain="{lang key='website/license/invalid-title-domain'}" data-txt-ip="{lang key='website/license/invalid-title-ip'}">{lang key='website/license/invalid-title-domain'}</h2>
                                            <p class="fs-7 text-body-secondary mb-0">{lang key='website/license/not-found-for'} <strong class="num-tabular" data-role="lv-subject">example.com</strong>.</p>
                                        </div>
                                    </div>
                                    <div class="mt-4">
                                        <button type="button" class="btn btn-outline-danger" data-action="lv-report"><i class="bi bi-flag me-1"></i>{lang key='website/license/report-button'}</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="container pb-5">
        <div class="text-center mb-4 mb-lg-5">
            <h2 class="h3 mb-2">{lang key='website/license/how-title'}</h2>
            <p class="lv-lead text-body-secondary mx-auto mb-0">{lang key='website/license/how-lead'}</p>
        </div>

        <ol class="lv-steps row g-4 g-lg-5 list-unstyled mb-0">
            <li class="col-12 col-md-4">
                <div class="lv-step">
                    <span class="lv-step-num">1</span>
                    <h3 class="lv-step-title">{lang key='website/license/step1-title'}</h3>
                    <p class="lv-step-text">{lang key='website/license/step1-text'}</p>
                </div>
            </li>
            <li class="col-12 col-md-4">
                <div class="lv-step">
                    <span class="lv-step-num">2</span>
                    <h3 class="lv-step-title">{lang key='website/license/step2-title'}</h3>
                    <p class="lv-step-text">{lang key='website/license/step2-text'}</p>
                </div>
            </li>
            <li class="col-12 col-md-4">
                <div class="lv-step">
                    <span class="lv-step-num">3</span>
                    <h3 class="lv-step-title">{lang key='website/license/step3-title'}</h3>
                    <p class="lv-step-text">{lang key='website/license/step3-text'}</p>
                </div>
            </li>
        </ol>

        <aside class="lv-notice mt-4 mt-lg-5">
            <span class="lv-notice-ico"><i class="bi bi-shield-lock"></i></span>
            <div class="lv-notice-body">
                <h2 class="h5 mb-2">{lang key='website/license/notice-title'}</h2>
                <p class="lv-notice-text mb-0">{lang key='website/license/notice-text'}</p>
            </div>
            <button type="button" class="btn btn-primary lv-notice-cta" data-action="lv-report"><i class="bi bi-flag me-1"></i>{lang key='website/license/report-button'}</button>
        </aside>
    </section>

{/block}

{block name=body_end}
<div class="modal fade" id="lvReportModal" tabindex="-1" aria-labelledby="lvReportModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-icon modal-icon--warning"><i class="bi bi-flag-fill"></i></span>
                <div class="modal-titles">
                    <h2 class="modal-title h5" id="lvReportModalTitle">{lang key='website/license/report-title'}</h2>
                    <p class="modal-subtitle">{lang key='website/license/report-subtitle'}</p>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{lang key='website/license/report-done-button'}"></button>
            </div>
            <div class="modal-body p-4">

                <form action="{link route='license'}" method="post" novalidate data-lv-report-form>
                    <div data-lv-report-step="form">
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <label for="lvr-subject" class="form-label">{lang key='website/license/report-subject'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control num-tabular" id="lvr-subject" name="subject" placeholder="{lang key='website/license/report-subject-ph'}" autocomplete="off" spellcheck="false" required>
                                <div class="invalid-feedback">{lang key='website/license/report-subject-error'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="lvr-email" class="form-label">{lang key='website/license/report-email'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="email" class="form-control" id="lvr-email" name="email" placeholder="{lang key='website/license/report-email-ph'}" autocomplete="email" required>
                                <div class="invalid-feedback">{lang key='website/license/report-email-error'}</div>
                            </div>
                            <div class="col-12">
                                <label for="lvr-details" class="form-label">{lang key='website/license/report-details'}</label>
                                <textarea class="form-control" id="lvr-details" name="details" rows="3" placeholder="{lang key='website/license/report-details-ph'}"></textarea>
                            </div>
                            <div class="col-12">
                                <label for="lvr-evidence" class="form-label">{lang key='website/license/report-evidence'} <span class="fs-8 text-body-secondary fw-normal">{lang key='website/license/report-optional'}</span></label>
                                <div class="file-upload file-upload-compact" data-file-upload>
                                    <label class="file-upload-drop" for="lvr-evidence">
                                        <input type="file" id="lvr-evidence" name="evidence" class="visually-hidden" accept=".pdf,.jpg,.jpeg,.png" data-max-mb="10">
                                        <span class="icon-disc"><i class="bi bi-cloud-arrow-up"></i></span>
                                        <span><span class="fw-semibold">{lang key='website/license/report-browse'}</span> {lang key='website/license/report-drop'}</span>
                                        <span class="fs-8">{lang key='website/license/report-file-note'}</span>
                                    </label>
                                    <ul class="file-upload-list" data-role="file-list"></ul>
                                </div>
                            </div>
                        </div>
                        <p class="form-text mt-3"><i class="bi bi-shield-check me-1"></i>{lang key='website/license/report-privacy'}</p>
                        <div class="d-flex flex-wrap align-items-center justify-content-end gap-3 border-top pt-3 mt-3">
                            {captcha area='software-license' class='mb-0'}
                            <button class="btn btn-primary" type="submit" data-busy-text="{lang key='website/license/report-submitting'}"><i class="bi bi-flag me-1"></i>{lang key='website/license/report-submit'}</button>
                        </div>
                        {csrf form='license-report'}
                    </div>

                    <div class="d-none text-center py-3" data-lv-report-step="done">
                        <span class="lv-report-done-ico"><i class="bi bi-check-circle"></i></span>
                        <h3 class="h5 mt-3 mb-2">{lang key='website/license/report-done-title'}</h3>
                        <p class="text-body-secondary mb-4">{lang key='website/license/report-done-pre'} <strong data-role="lv-report-email">you@example.com</strong> {lang key='website/license/report-done-post'}</p>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal"><i class="bi bi-check2 me-1"></i>{lang key='website/license/report-done-button'}</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
{/block}
