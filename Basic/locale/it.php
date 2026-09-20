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
    'description' => 'Il tema predefinito di WISECP. Un tema responsive basato su Bootstrap 5, con modalità chiara e scura e supporto RTL. Pensato per chi desidera un\'interfaccia semplice e ordinata.',

    'grp_topbar'           => 'Barra degli annunci',
    'set_topbar_enabled'      => 'Mostra barra degli annunci',
    'set_topbar_enabled_desc' => 'Mostra una barra sottile sopra l\'intestazione con contatti, promozioni o avvisi.',
    'set_topbar_text'         => 'Testo dell\'annuncio',
    'set_topbar_text_desc'    => 'Mostrato nella barra sopra l\'intestazione. Sono supportati HTML e tag Smarty; script, moduli e gestori di eventi vengono rimossi al salvataggio.',

    'grp_appearance'      => 'Aspetto',
    'set_primary_color'   => 'Colore principale',
    'set_secondary_color' => 'Colore secondario',
    'set_text_color'      => 'Colore del testo',

    'grp_checkout'              => 'Checkout',
    'set_checkout_sidebar'      => 'Layout del riepilogo ordine',
    'set_checkout_sidebar_desc' => 'Definisce dove appare il riepilogo ordine nelle pagine di configurazione, carrello e checkout.',
    'opt_checkout_rail'         => 'Laterale (pannello fisso)',
    'opt_checkout_card'         => 'Scheda (colonna nella pagina)',
    'opt_checkout_stack'        => 'Colonna unica con barra inferiore',

    'grp_dashboard'               => 'Dashboard cliente',
    'set_dashboard_layout'        => 'Layout della dashboard',
    'set_dashboard_layout_desc'   => 'Definisce la disposizione della dashboard cliente: il layout moderno con una fascia principale di comandi oppure quello classico con il pannello account a sinistra.',
    'opt_dash_hero'               => 'Moderno (Hero)',
    'opt_dash_standard'           => 'Classico (Standard)',

    'grp_popup'              => 'Finestra popup',
    'set_popup_enabled'      => 'Mostra finestra popup',
    'set_popup_enabled_desc' => 'Mostra una finestra popup sul sito dopo un ritardo, in base alla frequenza scelta.',
    'set_popup_content'      => 'Contenuto del popup',
    'set_popup_content_desc' => 'Sono supportati HTML e tag Smarty; script, moduli e gestori di eventi vengono rimossi al salvataggio.',
    'set_popup_width'        => 'Larghezza (px)',
    'set_popup_height'       => 'Altezza (px)',
    'set_popup_frequency'    => 'Frequenza',
    'opt_popup_once'         => 'Una volta per visitatore',
    'opt_popup_daily'        => 'Una volta al giorno',
    'opt_popup_always'       => 'A ogni caricamento della pagina',
    'set_popup_delay'        => 'Ritardo (secondi)',
    'set_popup_delay_desc'   => 'Il popup appare dopo il numero di secondi indicato dal caricamento della pagina.',

    'cz_title'           => 'Anteprima del tema',
    'cz_subtitle'        => 'Salvata nel browser; i file del tema restano invariati.',
    'cz_theme'           => 'Tema',
    'cz_soon'            => 'In arrivo',
    'cz_layout'          => 'Layout',
    'cz_dashboard'       => 'Dashboard',
    'cz_hero'            => 'Moderna',
    'cz_standard'        => 'Classica',
    'cz_checkout'        => 'Checkout',
    'cz_rail'            => 'Laterale',
    'cz_card'            => 'Scheda',
    'cz_stack'           => 'Colonna',
    'cz_appearance'      => 'Aspetto',
    'cz_brand_logo'      => 'Logo del marchio',
    'cz_logo_upload'     => 'Carica il tuo logo',
    'cz_logo_hint'       => 'I colori dominanti del marchio vengono applicati automaticamente.',
    'cz_logo_remove'     => 'Rimuovi logo',
    'cz_colors'          => 'Colori',
    'cz_primary'         => 'Principale',
    'cz_secondary'       => 'Secondario',
    'cz_text'            => 'Testo',
    'cz_text_note'       => '(modalità chiara)',
    'cz_pick_primary'    => 'Scegli il colore principale',
    'cz_pick_secondary'  => 'Scegli il colore secondario',
    'cz_pick_text'       => 'Scegli il colore del testo',
    'cz_typography'      => 'Tipografia',
    'cz_font_family'     => 'Famiglia di caratteri',
    'cz_reset'           => 'Ripristina valori predefiniti',
    'cz_close'           => 'Chiudi pannello',
    'cz_toast_extracted' => 'Colori del marchio estratti dal logo.',
    'cz_toast_reset'     => 'Anteprima del tema ripristinata ai valori predefiniti.',
    'cz_nudge_dashboard' => 'Prova un altro layout della dashboard',
    'cz_nudge_checkout'  => 'Prova un altro layout di checkout',
    'cz_nudge_explore'   => 'Esplora le opzioni del tema',
];
