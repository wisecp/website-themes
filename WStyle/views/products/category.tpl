{extends file='layouts/default.tpl'}

{block name=head}
<link rel="stylesheet" href="{asset path='css/category-server.css'}">
{/block}

{block name=body_class}chrome-overlay{/block}

{block name=content}

    {assign var=hero_badges value=$show_trust ? $trust_badges : []}
    {include file='partials/page-hero.tpl'
        title=$hero_title|default:$category.title
        lead=$hero_lead|default:$category.sub_title
        crumbs=$breadcrumb
        badges=$hero_badges}

{if $mode == 'tabs'}
    <section class="py-5" data-billing="{$default_cycle}" data-currency="{$selected_currency_code}" data-price-mode="{$price_mode}" data-save-text="{lang key='website/products/category-save'}" data-reveal>
        <div class="container">
            <div class="section-head">
                <span class="eyebrow">{$plans_eyebrow}</span>
                <h2 class="tracking-tight">{$plans_heading}</h2>
                <p class="section-lead">{$plans_subtitle}</p>
            </div>

            <div class="d-flex flex-wrap justify-content-center justify-content-lg-between align-items-center gap-3 mb-2">
                <ul class="nav nav-pills gap-1 mb-0" role="tablist">
                    {foreach $tabs as $tab}
                    <li class="nav-item" role="presentation"><button class="nav-link{if $tab.active} active{/if}" id="tab-{$tab.id}" data-bs-toggle="tab" data-bs-target="#pane-{$tab.id}" data-tab-url="{$tab.url}" data-meta-title="{$tab.meta.title}" data-meta-desc="{$tab.meta.description}" data-meta-keys="{$tab.meta.keywords}" data-tab-hero-title="{$tab.title}" data-tab-hero-lead="{$tab.sub_title}" data-tab-hero-bg="{$tab.header_background}" type="button" role="tab" aria-controls="pane-{$tab.id}" aria-selected="{if $tab.active}true{else}false{/if}">{if $tab.icon.type == 'image'}<img src="{$tab.icon.value}" alt="" class="me-1" style="height:1em;vertical-align:-0.125em">{else}<i class="{$tab.icon.value} me-1"></i>{/if}{$tab.title}</button></li>
                    {/foreach}
                </ul>
                {if $billing_cycles|@count > 1}
                <div class="billing-toggle" data-billing-toggle role="group" aria-label="{lang key='website/products/category-billing-cycle'}">
                    {foreach $billing_cycles as $c}
                    <button class="billing-option{if $c.key == $default_cycle} active{/if}" type="button" data-action="set-billing" data-cycle="{$c.key}">{$c.label}</button>
                    {/foreach}
                </div>
                {/if}
            </div>

            {hook name='ui:client.catalog.plans.before'}

            <div class="tab-content">
                {foreach $tabs as $tab}
                <div class="tab-pane fade{if $tab.active} show active{/if}" id="pane-{$tab.id}" role="tabpanel" aria-labelledby="tab-{$tab.id}" tabindex="0">
                    {if $tab.plans}
                    {if ($tab.layout|default:'grid') == 'rows'}
                    {include file='components/plan-rows.tpl' plans=$tab.plans}
                    {else}
                    {include file='components/plan-grid.tpl' plans=$tab.plans}
                    {/if}
                    {else}
                    <div class="wcp-empty-state text-center py-5">
                        <span class="icon-disc d-inline-flex mb-3"><i class="bi bi-box-seam"></i></span>
                        <p class="text-body-secondary mb-0">{lang key='website/products/no-content'}</p>
                    </div>
                    {/if}
                </div>
                {/foreach}
            </div>

            {hook name='ui:client.catalog.plans.after'}

            <p class="fs-8 text-body-secondary text-center mt-3 mb-0">{lang key='website/products/category-prices-in'} <span data-role="currency-label">{$selected_currency_code}</span>{if $prices_note}. {$prices_note}{/if}</p>
        </div>
    </section>

    {if $show_extras && $included}
    <section class="band-dark chrome-dark py-5" data-reveal>
        <div class="container">
            <div class="section-head">
                <span class="eyebrow">{$included.eyebrow}</span>
                <h2 class="tracking-tight">{$included.heading}</h2>
                <p class="section-lead">{$included.subtitle}</p>
            </div>
            <div class="row g-3">
                {foreach $included.items as $item}
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="{$item.icon}"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{$item.title}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{$item.desc}</p>
                            </div>
                        </div>
                    </div>
                </div>
                {/foreach}
            </div>
        </div>
    </section>
    {/if}

    {if $has_content}
    <section class="py-5 bg-surface" data-reveal>
        <div class="container">
            {foreach $tabs as $tab}
            {if $tab.content}<div class="category-content" data-tab-content="{$tab.id}"{if !$tab.active} hidden{/if}>{content var=$tab.content}</div>{/if}
            {/foreach}
        </div>
    </section>
    {/if}

    {if $has_faq}
    <section class="py-5{if !$has_content} bg-surface{/if}" data-reveal>
        <div class="container">
            <div class="row g-4 g-lg-5">
                <div class="col-lg-4">
                    <div class="section-head section-head-start mb-3">
                        <span class="eyebrow">{lang key='website/products/category-faq-eyebrow'}</span>
                        <h2 class="tracking-tight">{lang key='website/products/category-faq-heading'}</h2>
                    </div>
                    <a class="link-arrow fs-7" href="{link route='kbase'}">{lang key='website/products/category-faq-kb'}<i class="bi bi-arrow-right"></i></a>
                </div>
                <div class="col-lg-8">
                    {foreach $tabs as $tab}
                    {if $tab.faq}<div data-tab-faq="{$tab.id}"{if !$tab.active} hidden{/if}>
                        <div class="accordion" id="category-faq-{$tab.id}">
                            {foreach $tab.faq as $i => $f}
                            <div class="accordion-item">
                                <h3 class="accordion-header">
                                    <button class="accordion-button fw-semibold{if $i > 0} collapsed{/if}" type="button" data-wui-toggle data-wui-target="#faq-{$tab.id}-{$i}" aria-expanded="{if $i == 0}true{else}false{/if}" aria-controls="faq-{$tab.id}-{$i}">{$f.title}</button>
                                </h3>
                                <div id="faq-{$tab.id}-{$i}" class="wui-collapse{if $i == 0} wui-show{/if}" data-wui-parent="#category-faq-{$tab.id}"><div class="wui-collapse-inner">
                                    <div class="accordion-body">{$f.description nofilter}</div>
                                </div></div>
                            </div>
                            {/foreach}
                        </div>
                    </div>{/if}
                    {/foreach}
                </div>
            </div>
        </div>
    </section>
    {/if}

{else}
    {if $cards}
    <section class="{if $is_top}py-5{else}pt-3 pb-5{/if}" data-reveal>
        <div class="container">
            {if $is_top}
            <div class="section-head">
                <span class="eyebrow">{lang key='website/products/category-server-hub-eyebrow'}</span>
                <h2 class="tracking-tight">{lang key='website/products/category-server-hub-heading'}</h2>
                <p class="section-lead">{lang key='website/products/category-server-hub-subtitle'}</p>
            </div>
            {/if}
            <div class="cat-hub" aria-label="{lang key='website/products/category-server-cats-aria'}">
                {foreach $cards as $card}
                <a class="cat-card" href="{$card.url}">
                    <span class="icon-disc">{if $card.icon.type == 'image'}<img src="{$card.icon.value}" alt="" style="width:1.1rem;height:1.1rem;object-fit:contain">{else}<i class="{$card.icon.value}"></i>{/if}</span>
                    <span class="cat-card-body">
                        <span class="cat-card-title">{$card.title}</span>
                        {if $card.desc}<span class="cat-card-desc">{$card.desc}</span>{/if}
                    </span>
                    {if $card.from}<span class="cat-card-price"><span class="cat-card-price-from">{lang key='website/products/category-from'}</span><span class="cat-card-price-now"><span class="cat-card-price-amount num-tabular">{$card.from}</span><span class="cat-card-price-cycle">{lang key='website/products/category-per-month'}</span></span></span>{/if}
                    <i class="bi bi-chevron-right cat-card-chevron" aria-hidden="true"></i>
                </a>
                {/foreach}
            </div>
        </div>
    </section>
    {/if}

    {if $plans}
    <section class="{if $is_top}py-5 border-top{else}pt-3 pb-5{/if}" data-billing="{$default_cycle}" data-currency="{$selected_currency_code}" data-price-mode="{$price_mode}" data-save-text="{lang key='website/products/category-save'}" data-reveal>
        <div class="container">
            <div class="section-head">
                {if $is_top}
                <span class="eyebrow">{lang key='website/products/category-cloud-eyebrow'}</span>
                <h2 class="tracking-tight">{lang key='website/products/category-cloud-heading'}</h2>
                <p class="section-lead">{lang key='website/products/category-cloud-subtitle'}</p>
                {else}
                <span class="eyebrow">{lang key='website/products/category-plans-eyebrow'}</span>
                <h2 class="tracking-tight">{lang key='website/products/category-server-plans-heading'}</h2>
                {/if}
            </div>

            {if $billing_cycles|@count > 1}
            <div class="d-flex justify-content-center justify-content-lg-end mb-2">
                <div class="billing-toggle" data-billing-toggle role="group" aria-label="{lang key='website/products/category-billing-cycle'}">
                    {foreach $billing_cycles as $c}
                    <button class="billing-option{if $c.key == $default_cycle} active{/if}" type="button" data-action="set-billing" data-cycle="{$c.key}">{$c.label}</button>
                    {/foreach}
                </div>
            </div>
            {/if}

            {hook name='ui:client.catalog.plans.before'}

            {if $layout == 'rows'}
            {include file='components/plan-rows.tpl' plans=$plans}
            {else}
            {include file='components/plan-grid.tpl' plans=$plans}
            {/if}

            {hook name='ui:client.catalog.plans.after'}

            <p class="fs-8 text-body-secondary text-center mt-3 mb-0">{lang key='website/products/category-prices-in'} <span data-role="currency-label">{$selected_currency_code}</span>{if $prices_note}. {$prices_note}{/if}</p>
        </div>
    </section>
    {/if}

    {if $show_extras && $included}
    <section class="band-dark chrome-dark py-5" data-reveal>
        <div class="container">
            <div class="section-head">
                <span class="eyebrow">{$included.eyebrow}</span>
                <h2 class="tracking-tight">{$included.heading}</h2>
                <p class="section-lead">{$included.subtitle}</p>
            </div>
            <div class="row g-3">
                {foreach $included.items as $item}
                <div class="col-md-6 col-xl-3">
                    <div class="card h-100">
                        <div class="card-body d-flex align-items-start gap-3">
                            <span class="icon-disc"><i class="{$item.icon}"></i></span>
                            <div>
                                <h3 class="h6 mb-1">{$item.title}</h3>
                                <p class="fs-7 text-body-secondary mb-0">{$item.desc}</p>
                            </div>
                        </div>
                    </div>
                </div>
                {/foreach}
            </div>
        </div>
    </section>
    {/if}

    {if $faq}
    <section class="py-5 bg-surface" data-reveal>
        <div class="container">
            <div class="row g-4 g-lg-5">
                <div class="col-lg-4">
                    <div class="section-head section-head-start mb-3">
                        <span class="eyebrow">{lang key='website/products/category-faq-eyebrow'}</span>
                        <h2 class="tracking-tight">{lang key='website/products/category-faq-heading'}</h2>
                    </div>
                    <a class="link-arrow fs-7" href="{link route='kbase'}">{lang key='website/products/category-faq-kb'}<i class="bi bi-arrow-right"></i></a>
                </div>
                <div class="col-lg-8">
                    <div class="accordion" id="category-faq">
                        {foreach $faq as $i => $f}
                        <div class="accordion-item">
                            <h3 class="accordion-header">
                                <button class="accordion-button fw-semibold{if $i > 0} collapsed{/if}" type="button" data-wui-toggle data-wui-target="#faq-{$i}" aria-expanded="{if $i == 0}true{else}false{/if}" aria-controls="faq-{$i}">{$f.title}</button>
                            </h3>
                            <div id="faq-{$i}" class="wui-collapse{if $i == 0} wui-show{/if}" data-wui-parent="#category-faq"><div class="wui-collapse-inner">
                                <div class="accordion-body">{$f.description nofilter}</div>
                            </div></div>
                        </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    </section>
    {/if}
{/if}

{/block}

{block name=scripts}
{if $mode == 'tabs'}
{literal}
<script>
  (function() {
    function init() {
      var tabBtns = document.querySelectorAll('[data-bs-toggle="tab"][data-bs-target^="#pane-"]');
      function syncTab(id) {
        document.querySelectorAll("[data-tab-content],[data-tab-faq]").forEach(function(el) {
          var t = el.getAttribute("data-tab-content") || el.getAttribute("data-tab-faq");
          el.hidden = t !== id;
        });
      }
      function tabPath(btn) {
        try {
          return new URL(btn.getAttribute("data-tab-url"), location.origin).pathname;
        } catch (e) {
          return null;
        }
      }
      var hero = document.querySelector(".page-hero");
      function applyHero(btn) {
        if (!hero) return;
        var title = btn.getAttribute("data-tab-hero-title") || "", lead = btn.getAttribute("data-tab-hero-lead") || "", bg = btn.getAttribute("data-tab-hero-bg") || "", h1 = hero.querySelector(".page-hero-title"), p = hero.querySelector(".page-hero-lead"), img = hero.querySelector(".page-hero-media"), scrim = hero.querySelector(".page-hero-scrim");
        if (h1 && title) h1.textContent = title;
        if (!p && lead && h1) {
          p = document.createElement("p");
          p.className = "page-hero-lead reveal reveal-2 mb-0";
          h1.insertAdjacentElement("afterend", p);
        }
        if (p) {
          p.textContent = lead;
          p.hidden = !lead;
        }
        if (bg) {
          if (!img) {
            img = document.createElement("img");
            img.className = "page-hero-media";
            img.alt = "";
            hero.insertBefore(img, hero.firstChild);
          }
          if (!scrim) {
            scrim = document.createElement("span");
            scrim.className = "page-hero-scrim";
            scrim.setAttribute("aria-hidden", "true");
            hero.insertBefore(scrim, img.nextSibling);
          }
          if (img.getAttribute("src") !== bg) img.setAttribute("src", bg);
          hero.classList.remove("page-hero-plain");
        } else {
          if (img) img.remove();
          if (scrim) scrim.remove();
          hero.classList.add("page-hero-plain");
        }
      }
      function upsertMeta(attr, name, value) {
        if (value == null) return;
        var el = document.head.querySelector("meta[" + attr + '="' + name + '"]');
        if (!el) {
          el = document.createElement("meta");
          el.setAttribute(attr, name);
          document.head.appendChild(el);
        }
        el.setAttribute("content", value);
      }
      function metaContent(attr, name) {
        var el = document.head.querySelector("meta[" + attr + '="' + name + '"]');
        return el ? el.getAttribute("content") || "" : "";
      }
      var headLayout = (function() {
        var bare = metaContent("property", "og:title"), at = bare ? document.title.indexOf(bare) : -1;
        return at < 0 ? null : [document.title.slice(0, at), document.title.slice(at + bare.length)];
      })();
      function applyMeta(btn) {
        var t = btn.getAttribute("data-meta-title"), d = btn.getAttribute("data-meta-desc"), k = btn.getAttribute("data-meta-keys"), u = btn.getAttribute("data-tab-url"), head = btn.getAttribute("data-head-title");
        if (head) document.title = head;
        else if (t) document.title = headLayout ? headLayout[0] + t + headLayout[1] : t;
        upsertMeta("name", "description", d);
        upsertMeta("name", "keywords", k);
        upsertMeta("property", "og:title", t);
        upsertMeta("property", "og:description", d);
        upsertMeta("property", "og:url", u);
        upsertMeta("name", "twitter:title", t);
        upsertMeta("name", "twitter:description", d);
        if (u) {
          var c = document.head.querySelector('link[rel="canonical"]');
          if (!c) {
            c = document.createElement("link");
            c.setAttribute("rel", "canonical");
            document.head.appendChild(c);
          }
          c.setAttribute("href", u);
        }
      }
      var home = null, homeTab = null, atHome = false, quiet = false;
      if (!Array.prototype.some.call(tabBtns, function(b) {
        return tabPath(b) === location.pathname;
      })) {
        var homeH1 = hero ? hero.querySelector(".page-hero-title") : null, homeLead = hero ? hero.querySelector(".page-hero-lead") : null, homeImg = hero ? hero.querySelector(".page-hero-media") : null, can = document.head.querySelector('link[rel="canonical"]'), own = {
          "data-tab-hero-title": homeH1 ? homeH1.textContent : "",
          "data-tab-hero-lead": homeLead && !homeLead.hidden ? homeLead.textContent : "",
          "data-tab-hero-bg": homeImg ? homeImg.getAttribute("src") || "" : "",
          "data-head-title": document.title,
          "data-meta-title": metaContent("property", "og:title"),
          "data-meta-desc": metaContent("name", "description"),
          "data-meta-keys": metaContent("name", "keywords"),
          "data-tab-url": can ? can.getAttribute("href") : location.href
        };
        home = { getAttribute: function(n) {
          return own[n] == null ? null : own[n];
        } };
        homeTab = document.querySelector('[data-bs-toggle="tab"][data-bs-target^="#pane-"].active');
        atHome = true;
      }
      function openTab(btn) {
        atHome = false;
        applyHero(btn);
        applyMeta(btn);
        var path = tabPath(btn);
        if (path && path !== location.pathname) history.pushState(null, "", btn.getAttribute("data-tab-url"));
      }
      tabBtns.forEach(function(b) {
        b.addEventListener("shown.bs.tab", function(e) {
          var btn = e.target;
          syncTab(btn.getAttribute("data-bs-target").replace("#pane-", ""));
          if (quiet) return;
          openTab(btn);
        });
        b.addEventListener("click", function() {
          if (atHome && b.classList.contains("active")) openTab(b);
        });
      });
      window.addEventListener("popstate", function() {
        var match = null;
        tabBtns.forEach(function(b) {
          if (tabPath(b) === location.pathname) match = b;
        });
        if (!match && home) {
          if (homeTab && !homeTab.classList.contains("active") && window.bootstrap && bootstrap.Tab) {
            quiet = true;
            bootstrap.Tab.getOrCreateInstance(homeTab).show();
            quiet = false;
          }
          atHome = true;
          applyHero(home);
          applyMeta(home);
          return;
        }
        var target = match || tabBtns[0];
        if (!target) return;
        if (target.classList.contains("active")) {
          if (atHome) openTab(target);
          return;
        }
        if (window.bootstrap && bootstrap.Tab) bootstrap.Tab.getOrCreateInstance(target).show();
      });
    }
    if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
    else init();
  })();
</script>
{/literal}
{/if}
{/block}
