<div data-domain-settings class="{if !($ds.visible|default:false)}d-none{/if}">
    {if $ds.hr|default:true}<hr class="my-4">{/if}
    <div class="addon-group">
        <span class="fw-semibold d-flex align-items-center gap-2"><span class="label-media"><i class="bi bi-hdd-network"></i></span>{lang key='website/configure/domain/ns-title'}</span>
        <span class="fs-8 text-body-secondary d-block mb-2">{lang key='website/configure/domain/ns-subtitle'}</span>
        <div class="row g-2">
            <div class="col-sm-6">
                <label class="option-card option-card-radio option-card-sm h-100">
                    <input class="form-check-input" type="radio" name="ns_mode" value="default"{if ($ds.ns_mode|default:'default') != 'custom'} checked{/if}>
                    <span class="d-flex align-items-center gap-2"><span class="option-media"><i class="bi bi-hdd-network"></i></span><span class="fw-semibold">{lang key='website/configure/domain/ns-default'}</span></span>
                    <span class="fs-8 text-body-secondary d-block mt-1">{lang key='website/configure/domain/ns-default-desc'}</span>
                </label>
            </div>
            <div class="col-sm-6">
                <label class="option-card option-card-radio option-card-sm h-100">
                    <input class="form-check-input" type="radio" name="ns_mode" value="custom"{if ($ds.ns_mode|default:'default') == 'custom'} checked{/if}>
                    <span class="d-flex align-items-center gap-2"><span class="option-media"><i class="bi bi-sliders2"></i></span><span class="fw-semibold">{lang key='website/configure/domain/ns-custom'}</span></span>
                    <span class="fs-8 text-body-secondary d-block mt-1">{lang key='website/configure/domain/ns-custom-desc'}</span>
                </label>
            </div>
        </div>
        <div class="wui-collapse" id="cfgCustomNs"><div class="wui-collapse-inner">
            <div class="pt-3">
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label for="cfg-ns1" class="form-label">{lang key='website/configure/domain/ns1-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                        <input type="text" class="form-control" id="cfg-ns1" name="ns1" placeholder="ns1.example.com" autocomplete="off" value="{$ds.ns1|default:''}" required>
                        <div class="invalid-feedback">{lang key='website/configure/domain/ns1-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="cfg-ns2" class="form-label">{lang key='website/configure/domain/ns2-label'} <span class="text-danger" aria-hidden="true">*</span></label>
                        <input type="text" class="form-control" id="cfg-ns2" name="ns2" placeholder="ns2.example.com" autocomplete="off" value="{$ds.ns2|default:''}" required>
                        <div class="invalid-feedback">{lang key='website/configure/domain/ns2-invalid'}</div>
                    </div>
                    <div class="col-sm-6">
                        <label for="cfg-ns3" class="form-label">{lang key='website/configure/domain/ns3-label'} <span class="text-body-secondary fw-normal fs-8">{lang key='website/configure/domain/ns-optional'}</span></label>
                        <input type="text" class="form-control" id="cfg-ns3" name="ns3" placeholder="ns3.example.com" autocomplete="off" value="{$ds.ns3|default:''}">
                    </div>
                    <div class="col-sm-6">
                        <label for="cfg-ns4" class="form-label">{lang key='website/configure/domain/ns4-label'} <span class="text-body-secondary fw-normal fs-8">{lang key='website/configure/domain/ns-optional'}</span></label>
                        <input type="text" class="form-control" id="cfg-ns4" name="ns4" placeholder="ns4.example.com" autocomplete="off" value="{$ds.ns4|default:''}">
                    </div>
                </div>
            </div>
        </div></div>
    </div>

    <div class="addon-group" data-domain-addons>
        <span class="fw-semibold d-flex align-items-center gap-2"><span class="label-media"><i class="bi bi-puzzle"></i></span>{lang key='website/configure/domain/addons-title'}</span>
        <span class="fs-8 text-body-secondary d-block mb-2">{lang key='website/configure/domain/addons-subtitle'}</span>
        <div class="d-grid gap-2">
            <label class="option-card option-card-toggle d-none" data-addon-type="whois_privacy">
                <span class="option-media"><i class="bi bi-shield-lock"></i></span>
                <span class="option-toggle-body">
                    <span class="fw-semibold d-block">{lang key='website/configure/domain/addon-whois'}</span>
                    <span class="fs-8 text-body-secondary">{lang key='website/configure/domain/addon-whois-desc'}</span>
                </span>
                <span class="price-chip" data-role="addon-chip"></span>
                <span class="form-check form-switch mb-0">
                    <input class="form-check-input" type="checkbox" role="switch" name="whois_privacy" value="1" data-label="{lang key='website/configure/domain/addon-whois'}">
                </span>
            </label>
            <label class="option-card option-card-toggle d-none" data-addon-type="dns_manage">
                <span class="option-media"><i class="bi bi-diagram-3"></i></span>
                <span class="option-toggle-body">
                    <span class="fw-semibold d-block">{lang key='website/configure/domain/addon-dns'}</span>
                    <span class="fs-8 text-body-secondary">{lang key='website/configure/domain/addon-dns-desc'}</span>
                </span>
                <span class="price-chip" data-role="addon-chip"></span>
                <span class="form-check form-switch mb-0">
                    <input class="form-check-input" type="checkbox" role="switch" name="dns_manage" value="1" data-label="{lang key='website/configure/domain/addon-dns'}">
                </span>
            </label>
            <label class="option-card option-card-toggle d-none" data-addon-type="forwarding">
                <span class="option-media"><i class="bi bi-signpost-split"></i></span>
                <span class="option-toggle-body">
                    <span class="fw-semibold d-block">{lang key='website/configure/domain/addon-forwarding'}</span>
                    <span class="fs-8 text-body-secondary">{lang key='website/configure/domain/addon-forwarding-desc'}</span>
                </span>
                <span class="price-chip" data-role="addon-chip"></span>
                <span class="form-check form-switch mb-0">
                    <input class="form-check-input" type="checkbox" role="switch" name="forwarding" value="1" data-label="{lang key='website/configure/domain/addon-forwarding'}">
                </span>
            </label>
        </div>
    </div>

    <div class="addon-group">
        <span class="fw-semibold d-flex align-items-center gap-2"><span class="label-media"><i class="bi bi-person-vcard"></i></span>{lang key='website/configure/domain/contacts-title'}</span>
        <span class="fs-8 text-body-secondary d-block mb-2">{lang key='website/configure/domain/contacts-subtitle'}</span>
        <ul class="nav nav-pills cfg-contact-pills" role="tablist">
            {foreach ['registrant', 'administrative', 'technical', 'billing'] as $ct}
            <li class="nav-item" role="presentation"><button class="nav-link{if $ct@first} active{/if}" id="cfg-wc-{$ct}-tab" data-bs-toggle="tab" data-bs-target="#cfg-wcp-{$ct}" type="button" role="tab" aria-controls="cfg-wcp-{$ct}" aria-selected="{if $ct@first}true{else}false{/if}">{lang key="website/domains/whois-role-{$ct}"}</button></li>
            {/foreach}
        </ul>
        <div class="tab-content pt-3">
            {foreach ['registrant', 'administrative', 'technical', 'billing'] as $ct}
            {$sel = $ds.contacts[$ct]|default:[]}
            {$sel_mode = $sel.mode|default:''}
            {$sel_pid = $sel.profile_id|default:0}
            {if $sel_mode == ''}
                {if $ct == 'registrant'}
                    {if ($whois_default_profile|default:0) > 0}{$sel_mode = 'profile'}{$sel_pid = $whois_default_profile}{else}{$sel_mode = 'default'}{/if}
                {else}
                    {$sel_mode = 'same'}
                {/if}
            {/if}
            <div class="tab-pane fade{if $ct@first} show active{/if}" id="cfg-wcp-{$ct}" role="tabpanel" aria-labelledby="cfg-wc-{$ct}-tab" tabindex="0">
                <select class="form-select" id="cfg-wc-{$ct}" name="wc[{$ct}][choice]" data-wc-select="{$ct}" aria-label="{lang key="website/domains/whois-role-{$ct}"}">
                    {if $ct != 'registrant'}<option value="same"{if $sel_mode == 'same'} selected{/if}>{lang key='website/configure/domain/contact-same'}</option>{/if}
                    <option value="default"{if $sel_mode == 'default'} selected{/if}>{lang key='website/configure/domain/contact-account'}</option>
                    {foreach $whois_profiles|default:[] as $wp}
                    <option value="profile-{$wp.id}"{if $sel_mode == 'profile' && $sel_pid == $wp.id} selected{/if}>{$wp.name}</option>
                    {/foreach}
                    <option value="custom"{if $sel_mode == 'custom'} selected{/if}>{lang key='website/configure/domain/contact-custom'}</option>
                </select>
                <div class="wui-collapse" id="cfgWc{$ct}"><div class="wui-collapse-inner">
                    <div class="pt-3">
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <label for="cfg-wc-{$ct}-first" class="form-label">{lang key='website/configure/domain/reg-first'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="cfg-wc-{$ct}-first" name="wc[{$ct}][first_name]" autocomplete="off" value="{$sel.first_name|default:''}" required>
                                <div class="invalid-feedback">{lang key='website/configure/domain/reg-first-invalid'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="cfg-wc-{$ct}-last" class="form-label">{lang key='website/configure/domain/reg-last'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="cfg-wc-{$ct}-last" name="wc[{$ct}][last_name]" autocomplete="off" value="{$sel.last_name|default:''}" required>
                                <div class="invalid-feedback">{lang key='website/configure/domain/reg-last-invalid'}</div>
                            </div>
                            <div class="col-12">
                                <label for="cfg-wc-{$ct}-org" class="form-label">{lang key='website/configure/domain/reg-org'} <span class="text-body-secondary fw-normal fs-8">{lang key='website/configure/domain/ns-optional'}</span></label>
                                <input type="text" class="form-control" id="cfg-wc-{$ct}-org" name="wc[{$ct}][organization]" autocomplete="off" value="{$sel.organization|default:''}">
                            </div>
                            <div class="col-sm-6">
                                <label for="cfg-wc-{$ct}-email" class="form-label">{lang key='website/configure/domain/reg-email'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="email" class="form-control" id="cfg-wc-{$ct}-email" name="wc[{$ct}][email]" autocomplete="off" value="{$sel.email|default:''}" required>
                                <div class="invalid-feedback">{lang key='website/configure/domain/reg-email-invalid'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="cfg-wc-{$ct}-phone" class="form-label d-block">{lang key='website/configure/domain/reg-phone'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="tel" class="form-control w-100" id="cfg-wc-{$ct}-phone" name="wc[{$ct}][phone]" autocomplete="off" value="{$sel.phone|default:''}" data-wc-phone required>
                            </div>
                            <div class="col-12">
                                <label for="cfg-wc-{$ct}-address" class="form-label">{lang key='website/configure/domain/reg-address'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="cfg-wc-{$ct}-address" name="wc[{$ct}][address]" autocomplete="off" value="{$sel.address|default:''}" required>
                                <div class="invalid-feedback">{lang key='website/configure/domain/reg-address-invalid'}</div>
                            </div>
                            <div class="col-sm-5">
                                <label for="cfg-wc-{$ct}-city" class="form-label">{lang key='website/configure/domain/reg-city'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="cfg-wc-{$ct}-city" name="wc[{$ct}][city]" autocomplete="off" value="{$sel.city|default:''}" required>
                                <div class="invalid-feedback">{lang key='website/configure/domain/reg-city-invalid'}</div>
                            </div>
                            <div class="col-sm-4">
                                <label for="cfg-wc-{$ct}-state" class="form-label">{lang key='website/configure/domain/reg-state'} <span class="text-body-secondary fw-normal fs-8">{lang key='website/configure/domain/ns-optional'}</span></label>
                                <input type="text" class="form-control" id="cfg-wc-{$ct}-state" name="wc[{$ct}][state]" autocomplete="off" value="{$sel.state|default:''}">
                            </div>
                            <div class="col-sm-3">
                                <label for="cfg-wc-{$ct}-zip" class="form-label">{lang key='website/configure/domain/reg-zip'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <input type="text" class="form-control" id="cfg-wc-{$ct}-zip" name="wc[{$ct}][zip]" autocomplete="off" value="{$sel.zip|default:''}" required>
                                <div class="invalid-feedback">{lang key='website/configure/domain/reg-zip-invalid'}</div>
                            </div>
                            <div class="col-sm-6">
                                <label for="cfg-wc-{$ct}-country" class="form-label">{lang key='website/configure/domain/reg-country'} <span class="text-danger" aria-hidden="true">*</span></label>
                                <select class="form-select" id="cfg-wc-{$ct}-country" name="wc[{$ct}][country]" data-wstyle-select data-flag-select required>
                                    {foreach $countries as $c}
                                    <option value="{$c.a2_iso}"{if ($sel.country|default:'') == $c.a2_iso} selected{/if}>{$c.name}</option>
                                    {/foreach}
                                </select>
                                <div class="invalid-feedback">{lang key='website/configure/domain/reg-country-invalid'}</div>
                            </div>
                        </div>
                    </div>
                </div></div>
            </div>
            {/foreach}
        </div>
    </div>

    <div class="addon-group d-none" data-domain-requirements>
        <span class="fw-semibold d-flex align-items-center gap-2"><span class="label-media"><i class="bi bi-clipboard-check"></i></span>{lang key='website/configure/domain/req-title'}</span>
        <span class="fs-8 text-body-secondary d-block mb-2">{lang key='website/configure/domain/req-subtitle-1'} <span class="fw-semibold" data-role="req-tld"></span> {lang key='website/configure/domain/req-subtitle-2'}</span>
        <div class="row g-3" data-role="req-fields"></div>
    </div>
</div>
