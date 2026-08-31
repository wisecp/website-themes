<article class="ticket-msg{if $r.is_staff} ticket-msg-staff{/if}" data-reply-id="{$r.id}">
    <span class="ticket-msg-ava">
        {if $r.avatar}<img src="{$r.avatar}" alt="">{else}<span class="ticket-msg-ava-txt">{$r.initials}</span>{/if}
        {if $r.is_staff}<span class="ticket-msg-ava-badge" aria-hidden="true"><i class="bi bi-headset"></i></span>{/if}
    </span>
    <div class="ticket-msg-main">
        <div class="ticket-msg-head">
            <span class="ticket-msg-author">{$r.author}{if $r.is_staff} <span class="badge bg-primary-subtle text-primary-emphasis fw-semibold"><i class="bi bi-patch-check me-1"></i>{lang key='website/tickets/detail/agent'}</span>{elseif $r.is_you} <span class="ticket-msg-role">{lang key='website/tickets/by-you'}</span>{/if}</span>
            <time class="ticket-msg-time" datetime="{$r.datetime}" data-bs-toggle="tooltip" title="{$r.date_full}">{$r.time_ago}</time>
        </div>
        <div class="ticket-msg-text">
            {if $r.is_html}{$r.body nofilter}{else}{foreach $r.paras as $p}<p>{$p nofilter}</p>{/foreach}{/if}
        </div>
        {hook name='ui:client.ticket_message.body.after'}
        {if $r.attachments}
        <div class="ticket-msg-files">
            {foreach $r.attachments as $a}
            {if $a.is_image}
            <button type="button" class="ticket-shot" data-action="ticket-zoom" data-full="{$a.link}" data-name="{$a.name}">
                <img class="ticket-shot-img" src="{$a.link}" alt="{$a.name}">
                <span class="ticket-shot-meta"><i class="bi bi-zoom-in" aria-hidden="true"></i><span class="ticket-shot-name">{$a.name}</span><span class="ticket-shot-size num-tabular">{$a.size}</span></span>
            </button>
            {else}
            <a class="ticket-file" href="{$a.link}" target="_blank" rel="noopener">
                <span class="ticket-file-ico"><i class="bi bi-file-earmark"></i></span>
                <span class="ticket-file-meta">
                    <span class="ticket-file-name">{$a.name}</span>
                    <span class="ticket-file-size num-tabular">{$a.size}</span>
                </span>
                <i class="bi bi-download ticket-file-dl" aria-hidden="true"></i>
            </a>
            {/if}
            {/foreach}
        </div>
        {/if}
        {if $r.credentials}
        <div class="ticket-msg-creds">
            {foreach $r.credentials as $c}
            <div class="ticket-msg-cred">
                <div class="ticket-msg-cred-head"><span class="ticket-msg-cred-ico"><i class="{$c.icon}"></i></span>{$c.group}</div>
                <div class="ticket-msg-cred-body">
                    {foreach $c.items as $it}
                    <div class="ticket-msg-cred-row">
                        <span class="ticket-msg-cred-key">{$it.label}</span>
                        {if $it.secret}
                        <span class="ticket-msg-cred-val" data-cred-secret>
                            <span data-role="cred-mask">&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;</span>
                            <span class="d-none num-tabular" data-role="cred-value">{$it.value}</span>
                        </span>
                        <span class="ticket-msg-cred-actions">
                            <button type="button" class="btn btn-ghost btn-sm p-1 lh-1" data-action="cred-reveal" data-bs-toggle="tooltip" title="{lang key='website/tickets/detail/cred-reveal'}" aria-label="{lang key='website/tickets/detail/cred-reveal'}"><i class="bi bi-eye"></i></button>
                            <button type="button" class="btn btn-ghost btn-sm p-1 lh-1" data-action="cred-copy" data-copy="{$it.value}" data-bs-toggle="tooltip" title="{lang key='website/tickets/detail/cred-copy'}" aria-label="{lang key='website/tickets/detail/cred-copy'}"><i class="bi bi-clipboard"></i></button>
                        </span>
                        {else}
                        <span class="ticket-msg-cred-val"><span class="num-tabular">{$it.value}</span></span>
                        <span class="ticket-msg-cred-actions"><button type="button" class="btn btn-ghost btn-sm p-1 lh-1" data-action="cred-copy" data-copy="{$it.value}" data-bs-toggle="tooltip" title="{lang key='website/tickets/detail/cred-copy'}" aria-label="{lang key='website/tickets/detail/cred-copy'}"><i class="bi bi-clipboard"></i></button></span>
                        {/if}
                    </div>
                    {/foreach}
                </div>
            </div>
            {/foreach}
        </div>
        {/if}
        {if $r.ip}<div class="ticket-msg-ip"><i class="bi bi-hdd-network" aria-hidden="true"></i>{lang key='website/tickets/detail/ip-address'}: <span class="num-tabular">{$r.ip}</span></div>{/if}
        {if $r.is_staff && !$is_guest}
        <div class="ticket-msg-rate{if $r.rating} is-rated{/if}" data-msg-rate>
            <span class="ticket-msg-rate-label">{if $r.rating}<i class="bi bi-check-circle-fill me-1"></i>{lang key='website/tickets/detail/rate-thanks'}{else}{lang key='website/tickets/detail/rate-q'}{/if}</span>
            <span class="ticket-msg-rate-stars" data-role="msg-rate" data-value="{$r.rating}" role="radiogroup" aria-label="{lang key='website/tickets/detail/rate-aria'}">
                <button type="button" class="msg-star{if $r.rating >= 1} is-on{/if}" data-value="1" aria-label="{lang key='website/tickets/rate-1'}"><i class="bi bi-star-fill"></i></button>
                <button type="button" class="msg-star{if $r.rating >= 2} is-on{/if}" data-value="2" aria-label="{lang key='website/tickets/rate-2'}"><i class="bi bi-star-fill"></i></button>
                <button type="button" class="msg-star{if $r.rating >= 3} is-on{/if}" data-value="3" aria-label="{lang key='website/tickets/rate-3'}"><i class="bi bi-star-fill"></i></button>
                <button type="button" class="msg-star{if $r.rating >= 4} is-on{/if}" data-value="4" aria-label="{lang key='website/tickets/rate-4'}"><i class="bi bi-star-fill"></i></button>
                <button type="button" class="msg-star{if $r.rating >= 5} is-on{/if}" data-value="5" aria-label="{lang key='website/tickets/rate-5'}"><i class="bi bi-star-fill"></i></button>
            </span>
        </div>
        {/if}
    </div>
</article>
