<div class="col-12" data-sub-card="{$s.id}">
    <div class="card">
        <div class="card-body">
            <div class="d-flex align-items-center justify-content-between gap-2 mb-3">
                <div class="d-flex align-items-center gap-2">
                    <span class="fw-semibold">{$s.gateway}</span>
                    <span data-role="sub-status">
                    {if $s.status == 'active'}
                    <span class="badge bg-success-subtle text-success-emphasis"><i class="bi bi-arrow-repeat me-1"></i>{lang key='website/invoices/subs-st-active'}</span>
                    {elseif $s.status == 'suspended'}
                    <span class="badge bg-warning-subtle text-warning-emphasis"><i class="bi bi-pause-circle me-1"></i>{lang key='website/invoices/subs-st-suspended'}</span>
                    {elseif $s.status == 'expired'}
                    <span class="badge bg-danger-subtle text-danger-emphasis"><i class="bi bi-calendar-x me-1"></i>{lang key='website/invoices/subs-st-expired'}</span>
                    {else}
                    <span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-x-circle me-1"></i>{lang key='website/invoices/subs-st-cancelled'}</span>
                    {/if}
                    </span>
                </div>
                {if $s.can_cancel}
                <button type="button" class="btn btn-soft btn-sm text-danger" data-action="sub-cancel" data-id="{$s.id}" data-gateway="{$s.gateway}"><i class="bi bi-x-circle me-1"></i>{lang key='website/invoices/subs-cancel-btn'}</button>
                {/if}
            </div>

            <dl class="row fs-7 mb-2">
                {if $s.cycle}
                <dt class="col-5 col-md-3 col-xl-2 text-body-secondary fw-normal">{lang key='website/invoices/subs-f-cycle'}</dt>
                <dd class="col-7 col-md-9 col-xl-10 mb-1">{$s.cycle}</dd>
                {/if}
                <dt class="col-5 col-md-3 col-xl-2 text-body-secondary fw-normal">{lang key='website/invoices/subs-f-next'}</dt>
                <dd class="col-7 col-md-9 col-xl-10 mb-1"><strong class="num-tabular" data-role="sub-next-fee">{$s.next_fee}</strong>{if $s.next_date} · <span class="num-tabular">{$s.next_date}</span>{/if}</dd>
                {if $s.last_date}
                <dt class="col-5 col-md-3 col-xl-2 text-body-secondary fw-normal">{lang key='website/invoices/subs-f-last'}</dt>
                <dd class="col-7 col-md-9 col-xl-10 mb-1"><span class="num-tabular">{$s.last_date}</span></dd>
                {/if}
            </dl>

            {if $s.members}
            <div class="fs-7 text-body-secondary mb-1">{lang key='website/invoices/subs-f-members'}</div>
            <div class="d-flex flex-column border-top">
                {foreach $s.members as $m}
                <div class="d-flex align-items-center justify-content-between gap-2 py-2 border-bottom" data-member-row="{$m.type}-{$m.id}">
                    <div class="d-flex align-items-center gap-2 min-w-0">
                        <span class="list-ico flex-shrink-0{if $m.icon.kind == 'logo'} has-logo{/if}">{if $m.icon.kind == 'logo'}<img src="{$m.icon.src}" alt="">{else}<i class="{$m.icon.class|default:'bi bi-box-seam'}"></i>{/if}</span>
                        <div class="min-w-0">
                            <div class="d-flex align-items-center gap-2">
                                {if $m.link}<a class="text-decoration-none text-truncate fw-semibold" href="{$m.link}">{$m.name}</a>{else}<span class="text-truncate fw-semibold">{$m.name}</span>{/if}
                                {if $m.type == 'addon'}<span class="badge bg-secondary-subtle text-secondary-emphasis"><i class="bi bi-puzzle me-1"></i>{lang key='website/invoices/subs-member-addon'}</span>{/if}
                            </div>
                            {if $m.ident || $m.group}
                            <div class="d-flex align-items-center flex-wrap gap-2 mt-1">
                                {if $m.ident}<span class="fs-8 text-body-secondary text-truncate">{$m.ident}</span>{/if}
                                {if $m.group}<span class="list-chip"><i class="{$m.type_icon}"></i>{$m.group}</span>{/if}
                            </div>
                            {/if}
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-3 flex-shrink-0">
                        {if $m.fee}<strong class="num-tabular fs-7">{$m.fee}</strong>{/if}
                        {if $s.can_remove}
                        <button type="button" class="btn btn-soft btn-sm" data-action="sub-remove-member" data-type="{$m.type}" data-member-id="{$m.id}" data-name="{$m.name}" data-bs-toggle="tooltip" title="{lang key='website/invoices/subs-remove-btn'}"><i class="bi bi-box-arrow-right"></i></button>
                        {/if}
                    </div>
                </div>
                {/foreach}
            </div>
            {/if}
        </div>
    </div>
</div>
