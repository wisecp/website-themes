{if ($bg.video|default:'') || ($bg.image|default:'')}
    {if $bg.video|default:''}
    <video class="band-bg-media" autoplay muted loop playsinline preload="none"{if $bg.image} poster="{$bg.image}"{/if} aria-hidden="true">
        <source src="{$bg.video}" type="video/mp4">
    </video>
    {else}
    <img class="band-bg-media" src="{$bg.image}" alt="" loading="lazy">
    {/if}
    <span class="band-bg-scrim" aria-hidden="true"></span>
{/if}
