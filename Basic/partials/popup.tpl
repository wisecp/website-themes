{if $setting.popup_enabled && $setting.popup_content}
<div class="modal fade" id="themePopup" tabindex="-1" aria-hidden="true"
     data-popup-frequency="{$setting.popup_frequency|default:'once'}"
     data-popup-delay="{$setting.popup_delay|default:0}">
    <div class="modal-dialog modal-dialog-centered" style="max-width:{$setting.popup_width|default:500}px;">
        <div class="modal-content border-0 shadow" style="min-height:{$setting.popup_height|default:400}px;">
            <button type="button" class="btn-close position-absolute end-0 top-0 m-3" style="z-index:5;" data-bs-dismiss="modal" aria-label="Close"></button>
            <div class="modal-body p-4">{content var=$setting.popup_content}</div>
        </div>
    </div>
</div>
<script>{literal}
document.addEventListener('DOMContentLoaded', function () {
    var el = document.getElementById('themePopup');
    if (!el || typeof bootstrap === 'undefined') return;
    var freq  = el.getAttribute('data-popup-frequency') || 'once';
    var delay = parseInt(el.getAttribute('data-popup-delay'), 10) || 0;
    var key   = 'basic-popup-seen';
    function shouldShow() {
        if (freq === 'always') return true;
        var last = localStorage.getItem(key);
        if (freq === 'daily') return last !== new Date().toDateString();
        return !last; 
    }
    if (!shouldShow()) return;
    setTimeout(function () {
        new bootstrap.Modal(el).show();
        localStorage.setItem(key, freq === 'daily' ? new Date().toDateString() : '1');
    }, delay * 1000);
});
{/literal}</script>
{/if}
