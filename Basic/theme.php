<?php
/**
 * WISECP · Web Hosting Billing and Digital Services Platform
 *
 * Copyright (c) WISECP LLC — All rights reserved.
 * Unlicensed copying, distribution or use is prohibited.
 *
 * Terms of service: https://wisecp.com/terms-of-service
 */
return [
    'meta'     => [
        'name'        => 'Basic',
        'version'     => '1.0.0',
        'author'      => 'WISECP',
        'website'     => 'https://www.wisecp.com',
        'image'       => 'cover.png',
        'description' => '',
        'signup_minimal' => false,
        'dashboard_due_soon_alert' => false,
    ],
    'update-url' => '',
    'engine'   => 'smarty',
    'settings' => [
        'groups' => [
            'topbar'     => ['label' => 'grp_topbar', 'icon' => 'bi-megaphone'],
            'appearance' => ['label' => 'grp_appearance', 'icon' => 'bi-palette'],
            'checkout'   => ['label' => 'grp_checkout', 'icon' => 'bi-cart3'],
            'dashboard'  => ['label' => 'grp_dashboard', 'icon' => 'bi-grid-1x2'],
            'popup'      => ['label' => 'grp_popup', 'icon' => 'bi-window-stack'],
        ],
        'fields'  => [
            'topbar_enabled' => [
                'type'    => 'switch',
                'group'   => 'topbar',
                'label'   => 'set_topbar_enabled',
                'desc'    => 'set_topbar_enabled_desc',
                'default' => false,
            ],
            'topbar_text' => [
                'type'      => 'textarea',
                'group'     => 'topbar',
                'label'     => 'set_topbar_text',
                'desc'      => 'set_topbar_text_desc',
                'default'   => '{if $contact_email}<a class="topbar-link" href="mailto:{$contact_email}"><i class="bi bi-envelope me-1"></i>{$contact_email}</a>{/if} {if $contact_phone}<a class="topbar-link" href="tel:{$contact_phone}"><i class="bi bi-telephone me-1"></i>{$contact_phone}</a>{/if} <span class="topbar-promo ms-auto"><i class="bi bi-stars me-1"></i>.com domains $5.99 - limited time</span>',
                'multilang' => true,
                'html'      => true,
                'rows'      => 3,
                'depends'   => ['topbar_enabled' => true],
            ],
            'primary_color' => [
                'type'      => 'color',
                'group'     => 'appearance',
                'label'     => 'set_primary_color',
                'default'   => '#095174',
                'from_logo' => 0,
            ],
            'secondary_color' => [
                'type'      => 'color',
                'group'     => 'appearance',
                'label'     => 'set_secondary_color',
                'default'   => '#0d9488',
                'from_logo' => 1,
            ],
            'text_color' => [
                'type'    => 'color',
                'group'   => 'appearance',
                'label'   => 'set_text_color',
                'default' => '#607d8b',
            ],
            'checkout_sidebar' => [
                'type'    => 'select',
                'group'   => 'checkout',
                'label'   => 'set_checkout_sidebar',
                'desc'    => 'set_checkout_sidebar_desc',
                'options' => [
                    'rail'  => 'opt_checkout_rail',
                    'card'  => 'opt_checkout_card',
                    'stack' => 'opt_checkout_stack',
                ],
                'default' => 'rail',
            ],
            'dashboard_layout' => [
                'type'    => 'select',
                'group'   => 'dashboard',
                'label'   => 'set_dashboard_layout',
                'desc'    => 'set_dashboard_layout_desc',
                'options' => [
                    'hero'     => 'opt_dash_hero',
                    'standard' => 'opt_dash_standard',
                ],
                'default' => 'hero',
            ],
            'popup_enabled' => [
                'type'    => 'switch',
                'group'   => 'popup',
                'label'   => 'set_popup_enabled',
                'desc'    => 'set_popup_enabled_desc',
                'default' => false,
            ],
            'popup_content' => [
                'type'      => 'textarea',
                'group'     => 'popup',
                'label'     => 'set_popup_content',
                'desc'      => 'set_popup_content_desc',
                'default'   => '',
                'multilang' => true,
                'html'      => true,
                'rows'      => 5,
                'depends'   => ['popup_enabled' => true],
            ],
            'popup_width' => [
                'type'    => 'number',
                'group'   => 'popup',
                'label'   => 'set_popup_width',
                'default' => 500,
                'depends' => ['popup_enabled' => true],
            ],
            'popup_height' => [
                'type'    => 'number',
                'group'   => 'popup',
                'label'   => 'set_popup_height',
                'default' => 400,
                'depends' => ['popup_enabled' => true],
            ],
            'popup_frequency' => [
                'type'    => 'select',
                'group'   => 'popup',
                'label'   => 'set_popup_frequency',
                'options' => [
                    'once'   => 'opt_popup_once',
                    'daily'  => 'opt_popup_daily',
                    'always' => 'opt_popup_always',
                ],
                'default' => 'once',
                'depends' => ['popup_enabled' => true],
            ],
            'popup_delay' => [
                'type'    => 'number',
                'group'   => 'popup',
                'label'   => 'set_popup_delay',
                'desc'    => 'set_popup_delay_desc',
                'default' => 3,
                'depends' => ['popup_enabled' => true],
            ],
        ],
    ],
];
