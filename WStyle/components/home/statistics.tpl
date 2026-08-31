{if $statistics.items|default:false}
<section class="stat-band chrome-dark py-5{if $statistics.background.image || $statistics.background.video} has-band-bg{/if}" data-reveal>
    {include file='components/band-bg.tpl' bg=$statistics.background}
    <div class="container">
        <div class="stat-deck">
            <div class="stat-deck-grid">
                {foreach $statistics.items as $stat}
                <div class="stat-cell">
                    <i class="{$stat.icon} stat-watermark" aria-hidden="true"></i>
                    <span class="stat-ico"><i class="{$stat.icon}"></i></span>
                    <span class="stat-value num-tabular d-block" data-count="{$stat.number}">{$stat.number|number_format:0:".":","}</span>
                    <span class="stat-label d-block">{$stat.title}</span>
                </div>
                {/foreach}
            </div>
        </div>
    </div>
</section>
{/if}
