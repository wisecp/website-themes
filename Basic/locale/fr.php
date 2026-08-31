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
    'description' => 'Thème par défaut de WISECP. Un thème responsive basé sur Bootstrap 5, avec un mode clair et un mode sombre ainsi que la prise en charge RTL. Conçu pour ceux qui souhaitent une interface claire et simple.',

    'grp_topbar'           => 'Barre d\'annonce',
    'set_topbar_enabled'      => 'Afficher la barre d\'annonce',
    'set_topbar_enabled_desc' => 'Affiche un bandeau fin au-dessus de l\'en-tête pour vos coordonnées, vos promotions ou vos annonces.',
    'set_topbar_text'         => 'Texte de l\'annonce',
    'set_topbar_text_desc'    => 'Affiché dans le bandeau au-dessus de l\'en-tête. Les balises HTML et Smarty sont prises en charge ; les scripts, formulaires et gestionnaires d\'événements sont supprimés à l\'enregistrement.',

    'grp_appearance'      => 'Apparence',
    'set_primary_color'   => 'Couleur principale',
    'set_secondary_color' => 'Couleur secondaire',
    'set_text_color'      => 'Couleur du texte',

    'grp_checkout'              => 'Finalisation de la commande',
    'set_checkout_sidebar'      => 'Disposition du récapitulatif de la commande',
    'set_checkout_sidebar_desc' => 'Définit où le récapitulatif de la commande apparaît sur les pages de configuration, de panier et de finalisation de la commande.',
    'opt_checkout_rail'         => 'Rail (panneau latéral fixe)',
    'opt_checkout_card'         => 'Carte (colonne dans la page)',
    'opt_checkout_stack'        => 'Pile (colonne unique + barre inférieure)',

    'grp_dashboard'               => 'Tableau de bord client',
    'set_dashboard_layout'        => 'Disposition du tableau de bord',
    'set_dashboard_layout_desc'   => 'Définit la disposition du tableau de bord client : la disposition moderne avec un bandeau d\'actions principal, ou la disposition classique avec un rail de compte à gauche.',
    'opt_dash_hero'               => 'Moderne (Hero)',
    'opt_dash_standard'           => 'Classique (Standard)',

    'grp_popup'              => 'Fenêtre pop-up',
    'set_popup_enabled'      => 'Afficher la fenêtre pop-up',
    'set_popup_enabled_desc' => 'Affiche une fenêtre pop-up par-dessus le site après un délai, selon la fréquence choisie.',
    'set_popup_content'      => 'Contenu du pop-up',
    'set_popup_content_desc' => 'Les balises HTML et Smarty sont prises en charge ; les scripts, formulaires et gestionnaires d\'événements sont supprimés à l\'enregistrement.',
    'set_popup_width'        => 'Largeur (px)',
    'set_popup_height'       => 'Hauteur (px)',
    'set_popup_frequency'    => 'Fréquence',
    'opt_popup_once'         => 'Une fois par visiteur',
    'opt_popup_daily'        => 'Une fois par jour',
    'opt_popup_always'       => 'À chaque chargement de page',
    'set_popup_delay'        => 'Délai (secondes)',
    'set_popup_delay_desc'   => 'Le pop-up apparaît après ce nombre de secondes une fois la page chargée.',

    'cz_title'           => 'Aperçu du thème',
    'cz_subtitle'        => 'Enregistré dans votre navigateur ; les fichiers du thème restent inchangés.',
    'cz_theme'           => 'Thème',
    'cz_soon'            => 'Bientôt',
    'cz_layout'          => 'Disposition',
    'cz_dashboard'       => 'Tableau de bord',
    'cz_hero'            => 'Hero',
    'cz_standard'        => 'Standard',
    'cz_checkout'        => 'Finalisation',
    'cz_rail'            => 'Rail',
    'cz_card'            => 'Carte',
    'cz_stack'           => 'Pile',
    'cz_appearance'      => 'Apparence',
    'cz_brand_logo'      => 'Logo de la marque',
    'cz_logo_upload'     => 'Téléverser votre logo',
    'cz_logo_hint'       => 'Les couleurs dominantes de la marque sont appliquées automatiquement.',
    'cz_logo_remove'     => 'Retirer le logo',
    'cz_colors'          => 'Couleurs',
    'cz_primary'         => 'Principale',
    'cz_secondary'       => 'Secondaire',
    'cz_text'            => 'Texte',
    'cz_text_note'       => '(mode clair)',
    'cz_pick_primary'    => 'Choisir la couleur principale',
    'cz_pick_secondary'  => 'Choisir la couleur secondaire',
    'cz_pick_text'       => 'Choisir la couleur du texte',
    'cz_typography'      => 'Typographie',
    'cz_font_family'     => 'Famille de polices',
    'cz_reset'           => 'Rétablir les valeurs par défaut',
    'cz_close'           => 'Fermer le panneau',
    'cz_toast_extracted' => 'Couleurs de marque extraites de votre logo.',
    'cz_toast_reset'     => 'Aperçu du thème rétabli aux valeurs par défaut.',
    'cz_nudge_dashboard' => 'Essayer un autre tableau de bord',
    'cz_nudge_checkout'  => 'Essayer une autre disposition de finalisation',
    'cz_nudge_explore'   => 'Découvrir les options du thème',
];
