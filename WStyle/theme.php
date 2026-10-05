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
        'name'        => 'WStyle',
        'version'     => '0.1.0',
        'author'      => 'WISECP',
        'website'     => 'https://www.wisecp.com',
        'image'       => 'cover.png',
        'description' => '',
        'signup_minimal' => false,
        'dashboard_due_soon_alert' => false,
    ],
    'update-url' => '',
    'engine'   => 'smarty',
    'status'   => 'ready',
    'settings' => [
        'groups' => [
            'appearance' => ['label' => 'grp_appearance', 'icon' => 'bi-palette'],
            'footer'     => ['label' => 'grp_footer', 'icon' => 'bi-layout-text-window-reverse'],
            'checkout'   => ['label' => 'grp_checkout', 'icon' => 'bi-cart3'],
            'dashboard'  => ['label' => 'grp_dashboard', 'icon' => 'bi-grid-1x2'],
            'popup'      => ['label' => 'grp_popup', 'icon' => 'bi-window-stack'],
        ],
        'fields'  => [
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
            'content_width' => [
                'type'    => 'select',
                'group'   => 'appearance',
                'label'   => 'set_content_width',
                'desc'    => 'set_content_width_desc',
                'options' => [
                    'standard' => 'opt_width_standard',
                    'wide'     => 'opt_width_wide',
                    'wider'    => 'opt_width_wider',
                ],
                'default' => 'standard',
            ],
            'default_mode' => [
                'type'    => 'select',
                'group'   => 'appearance',
                'label'   => 'set_default_mode',
                'desc'    => 'set_default_mode_desc',
                'options' => [
                    'light' => 'opt_mode_light',
                    'dark'  => 'opt_mode_dark',
                    'auto'  => 'opt_mode_auto',
                ],
                'default' => 'light',
            ],
            'status_url' => [
                'type'    => 'text',
                'group'   => 'footer',
                'label'   => 'set_status_url',
                'desc'    => 'set_status_url_desc',
                'default' => '',
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
        ],
    ],
];
