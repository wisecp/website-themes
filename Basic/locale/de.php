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
    'name'        => 'Basic',
    'description' => "WISECPs Standard-Theme. Ein responsives, auf Bootstrap 5 basierendes Theme mit hellem und dunklem Modus sowie RTL-Unterst\xc3\xbctzung. F\xc3\xbcr alle, die eine klare, einfache Oberfl\xc3\xa4che w\xc3\xbcnschen.",

    'grp_topbar'           => "Ank\xc3\xbcndigungsleiste",
    'set_topbar_enabled'      => "Ank\xc3\xbcndigungsleiste anzeigen",
    'set_topbar_enabled_desc' => "Zeigt oberhalb der Kopfzeile eine schmale Leiste f\xc3\xbcr Kontaktinformationen, Aktionen oder Hinweise an.",
    'set_topbar_text'         => "Ank\xc3\xbcndigungstext",
    'set_topbar_text_desc'    => "Wird in der Leiste oberhalb der Kopfzeile angezeigt. HTML- und Smarty-Tags werden unterst\xc3\xbctzt; Skripte, Formulare und Event-Handler werden beim Speichern entfernt.",

    'grp_appearance'      => 'Darstellung',
    'set_primary_color'   => "Prim\xc3\xa4rfarbe",
    'set_secondary_color' => "Sekund\xc3\xa4rfarbe",
    'set_text_color'      => 'Textfarbe',

    'grp_checkout'              => 'Bestellabschluss',
    'set_checkout_sidebar'      => "Layout der Bestell\xc3\xbcbersicht",
    'set_checkout_sidebar_desc' => "Legt fest, wo die Bestell\xc3\xbcbersicht auf den Konfigurations-, Warenkorb- und Bestellabschlussseiten erscheint.",
    'opt_checkout_rail'         => 'Leiste (fixiertes Seitenpanel)',
    'opt_checkout_card'         => 'Karte (Spalte innerhalb der Seite)',
    'opt_checkout_stack'        => 'Stapel (einzelne Spalte und untere Leiste)',

    'grp_dashboard'               => "Kunden\xc3\xbcbersicht",
    'set_dashboard_layout'        => "Layout der Kunden\xc3\xbcbersicht",
    'set_dashboard_layout_desc'   => "Legt fest, wie die Kunden\xc3\xbcbersicht angeordnet ist: als modernes Layout mit einem hervorgehobenen Befehlsbereich oder als klassisches Layout mit einer linken Kontoleiste.",
    'opt_dash_hero'               => 'Modern (Hero)',
    'opt_dash_standard'           => 'Klassisch (Standard)',

    'grp_popup'              => 'Pop-up-Fenster',
    'set_popup_enabled'      => 'Pop-up-Fenster anzeigen',
    'set_popup_enabled_desc' => "Zeigt abh\xc3\xa4ngig von der gew\xc3\xa4hlten H\xc3\xa4ufigkeit nach einer Verz\xc3\xb6gerung ein Pop-up-Fenster \xc3\xbcber der Website an.",
    'set_popup_content'      => 'Pop-up-Inhalt',
    'set_popup_content_desc' => "HTML- und Smarty-Tags werden unterst\xc3\xbctzt; Skripte, Formulare und Event-Handler werden beim Speichern entfernt.",
    'set_popup_width'        => 'Breite (px)',
    'set_popup_height'       => "H\xc3\xb6he (px)",
    'set_popup_frequency'    => "H\xc3\xa4ufigkeit",
    'opt_popup_once'         => 'Einmal pro Besucher',
    'opt_popup_daily'        => "Einmal t\xc3\xa4glich",
    'opt_popup_always'       => 'Bei jedem Seitenaufruf',
    'set_popup_delay'        => "Verz\xc3\xb6gerung (Sekunden)",
    'set_popup_delay_desc'   => 'Das Pop-up-Fenster erscheint so viele Sekunden nach dem Laden der Seite.',

    'cz_title'           => 'Theme-Vorschau',
    'cz_subtitle'        => "Wird in Ihrem Browser gespeichert; die Theme-Dateien bleiben unver\xc3\xa4ndert.",
    'cz_theme'           => 'Theme',
    'cz_soon'            => "Demn\xc3\xa4chst",
    'cz_layout'          => 'Layout',
    'cz_dashboard'       => "Kunden\xc3\xbcbersicht",
    'cz_hero'            => 'Hero',
    'cz_standard'        => 'Standard',
    'cz_checkout'        => 'Bestellabschluss',
    'cz_rail'            => 'Leiste',
    'cz_card'            => 'Karte',
    'cz_stack'           => 'Stapel',
    'cz_appearance'      => 'Darstellung',
    'cz_brand_logo'      => 'Markenlogo',
    'cz_logo_upload'     => 'Ihr Logo hochladen',
    'cz_logo_hint'       => 'Die vorherrschenden Markenfarben werden automatisch angewendet.',
    'cz_logo_remove'     => 'Logo entfernen',
    'cz_colors'          => 'Farben',
    'cz_primary'         => "Prim\xc3\xa4r",
    'cz_secondary'       => "Sekund\xc3\xa4r",
    'cz_text'            => 'Text',
    'cz_text_note'       => '(heller Modus)',
    'cz_pick_primary'    => "Prim\xc3\xa4rfarbe ausw\xc3\xa4hlen",
    'cz_pick_secondary'  => "Sekund\xc3\xa4rfarbe ausw\xc3\xa4hlen",
    'cz_pick_text'       => "Textfarbe ausw\xc3\xa4hlen",
    'cz_typography'      => 'Typografie',
    'cz_font_family'     => 'Schriftfamilie',
    'cz_reset'           => "Auf Standardwerte zur\xc3\xbccksetzen",
    'cz_close'           => "Panel schlie\xc3\x9fen",
    'cz_toast_extracted' => "Markenfarben aus Ihrem Logo \xc3\xbcbernommen.",
    'cz_toast_reset'     => "Theme-Vorschau auf Standardwerte zur\xc3\xbcckgesetzt.",
    'cz_nudge_dashboard' => "Andere Kunden\xc3\xbcbersicht ausprobieren",
    'cz_nudge_checkout'  => 'Anderes Bestellabschlusslayout ausprobieren',
    'cz_nudge_explore'   => 'Theme-Optionen entdecken',
];
