{if $cat}<span class="badge blog-cat-badge">{if $cat.icon.type == 'image'}<img src="{$cat.icon.value}" alt="" class="me-1">{else}<i class="{$cat.icon.value} me-1"></i>{/if}{$cat.title}</span>{/if}
