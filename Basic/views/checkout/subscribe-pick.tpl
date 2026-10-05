<div class="text-start" data-sub-pick data-currency="{$sub_currency}">
    <div class="d-grid gap-2" data-role="subpick-step1">
        <button type="button" class="btn btn-primary btn-lg" data-role="subpick-start">{lang key='website/checkout/subscribe-start'}<i class="bi bi-arrow-right ms-2"></i></button>
        <button type="button" class="btn btn-soft btn-lg" data-role="subpick-once">{lang key='website/checkout/subscribe-once'}</button>
        {if $sub_single}
        <div class="fs-8 text-body-secondary text-center">
            <span class="fw-semibold">{$sub_rows[0].name}</span>{if $sub_rows[0].ident && $sub_rows[0].ident != $sub_rows[0].name} · <span class="num-tabular">{$sub_rows[0].ident}</span>{/if}<br>
            {lang key='website/checkout/subscribe-then'}: <span class="num-tabular">{$sub_rows[0].renew_fmt} / {$sub_rows[0].cycle_label}</span>{if $sub_rows[0].start} · {lang key='website/checkout/subscribe-starts'} <span class="num-tabular">{$sub_rows[0].start}</span>{/if}
        </div>
        {/if}
    </div>

    {if !$sub_single}
    <div class="d-none" data-role="subpick-step2">
        <span class="form-label d-block mb-2">{lang key='website/checkout/subscribe-which'}</span>
        <div class="d-grid gap-2">
            {foreach $sub_rows as $row}
            <label class="option-card option-card-toggle d-flex align-items-center gap-3{if $row.is_addon} ms-4{/if}">
                <span class="option-media">{if $row.is_addon}<i class="bi bi-plus-square"></i>{elseif $row.icon.kind == 'logo'}<img src="{$row.icon.src}" alt="">{else}<i class="{$row.icon.class|default:'bi bi-box'}"></i>{/if}</span>
                <span class="me-auto">
                    <span class="fw-semibold d-block">{$row.name}</span>
                    <span class="fs-8 text-body-secondary">{if $row.ident && $row.ident != $row.name}<span class="num-tabular">{$row.ident}</span> · {/if}{$row.cycle_label} · {$row.renew_fmt}{if $row.start} · {lang key='website/checkout/subscribe-starts'} <span class="num-tabular">{$row.start}</span>{/if}</span>
                </span>
                <input class="form-check-input flex-shrink-0" type="checkbox" value="1" data-sub-line data-ref="{$row.ref}" data-cycle="{$row.cycle}" data-cycle-label="{$row.cycle_label}" data-renew="{$row.renew|string_format:"%.2f"}" data-start="{$row.start}">
            </label>
            {/foreach}
        </div>
        <p class="fs-8 text-body-secondary mt-2 mb-0"><i class="bi bi-info-circle me-1"></i>{lang key='website/checkout/subscribe-mixed'}</p>
        <div class="border rounded-3 p-3 mt-3">
            <div class="d-flex justify-content-between fs-7"><span>{lang key='website/checkout/subscribe-due'}</span><span class="num-tabular fw-semibold">{$sub_amount_fmt}</span></div>
            <div class="d-flex justify-content-between fs-7 mt-1"><span>{lang key='website/checkout/subscribe-then'}</span><span class="num-tabular fw-semibold" data-role="subpick-then">&mdash;</span></div>
        </div>
        <div class="d-flex gap-2 mt-3">
            <button type="button" class="btn btn-soft" data-role="subpick-back"><i class="bi bi-arrow-left me-1"></i>{lang key='website/checkout/subscribe-back'}</button>
            <button type="button" class="btn btn-primary flex-grow-1" data-role="subpick-continue" disabled>{lang key='website/checkout/subscribe-start'}<i class="bi bi-arrow-right ms-2"></i></button>
        </div>
    </div>
    {/if}

    <script>
    (function () {
        var root = document.currentScript && document.currentScript.closest('[data-sub-pick]');
        if (!root || root.dataset.bound) return;
        root.dataset.bound = '1';
        var single = {if $sub_single}true{else}false{/if};
        var singleRef = {if $sub_single}{$sub_rows[0].ref|json_encode nofilter}{else}''{/if};
        var q = function (r) { return root.querySelector('[data-role="subpick-' + r + '"]'); };
        var money = function (n) {
            return (window.WCPTheme && WCPTheme.formatMoney)
                ? WCPTheme.formatMoney(n, { currency: root.dataset.currency })
                : n.toFixed(2);
        };

        function setBusy(btn, on) {
            if (!btn) return;
            if (on) {
                btn.dataset.restore = btn.innerHTML;
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1" aria-hidden="true"></span>' + (btn.textContent || '').trim();
            } else if (btn.dataset.restore != null) {
                btn.innerHTML = btn.dataset.restore;
                btn.disabled = false;
                delete btn.dataset.restore;
            }
        }

        function submitPick(mode, refs, btn) {
            var form = root.closest('form');
            var host = typeof window.wcpPreparePane === 'function';

            if (!form || !host) {
                setBusy(btn, true);
                var post = document.createElement('form');
                post.method = 'post';
                post.action = location.href;
                post.className = 'd-none';
                [['sub_pick_mode', mode], ['sub_pick_refs', refs.join(',')]].forEach(function (pair) {
                    var el = document.createElement('input');
                    el.type = 'hidden'; el.name = pair[0]; el.value = pair[1];
                    post.appendChild(el);
                });
                document.body.appendChild(post);
                post.submit();
                return;
            }

            ['sub_pick_mode', 'sub_pick_refs'].forEach(function (name) {
                var el = form.querySelector('input[name="' + name + '"]');
                if (!el) { el = document.createElement('input'); el.type = 'hidden'; el.name = name; form.appendChild(el); }
                el.value = name === 'sub_pick_mode' ? mode : refs.join(',');
            });

            setBusy(btn, true);
            var release = function () { setBusy(btn, false); };
            var done = window.wcpPreparePane();
            if (done && typeof done.then === 'function') done.then(release, release);
            else release();
        }

        q('once').addEventListener('click', function () { submitPick('once', [], this); });

        q('start').addEventListener('click', function () {
            if (single) { submitPick('subscribe', [singleRef], this); return; }
            q('step1').classList.add('d-none');
            q('step2').classList.remove('d-none');
        });

        if (!single) {
            function syncPicks() {
                var boxes = Array.prototype.slice.call(root.querySelectorAll('[data-sub-line]'));
                var picked = boxes.filter(function (b) { return b.checked; });
                var lock = picked.length ? picked[0].dataset.cycle : '';
                var lockStart = picked.length ? (picked[0].dataset.start || '') : '';
                var sum = 0;
                boxes.forEach(function (b) {
                    var off = lock !== '' && (b.dataset.cycle !== lock || (b.dataset.start || '') !== lockStart);
                    b.disabled = off;
                    var card = b.closest('label');
                    if (card) card.classList.toggle('opacity-50', off);
                });
                picked.forEach(function (b) { sum += parseFloat(b.dataset.renew || '0'); });
                var thenEl = q('then');
                if (thenEl) thenEl.textContent = picked.length ? money(sum) + ' / ' + (picked[0].dataset.cycleLabel || lock) : '—';
                q('continue').disabled = !picked.length;
            }
            root.addEventListener('change', function (e) {
                if (e.target && e.target.matches('[data-sub-line]')) syncPicks();
            });
            q('back').addEventListener('click', function () {
                q('step2').classList.add('d-none');
                q('step1').classList.remove('d-none');
            });
            q('continue').addEventListener('click', function () {
                var picked = Array.prototype.slice.call(root.querySelectorAll('[data-sub-line]:checked'));
                if (!picked.length) return;
                submitPick('subscribe', picked.map(function (b) { return b.dataset.ref; }), this);
            });
        }
    })();
    </script>
</div>
