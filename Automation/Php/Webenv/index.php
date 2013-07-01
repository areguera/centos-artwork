<?php

/***
 * Includes.
 * ------------------------------------
 */

require_once('config.php');
require_once(ABSPATH . 'admin/includes/functions/auth.php');
check_useraccess();
require_once(ABSPATH . 'includes/functions/html.php');
require_once(ABSPATH . 'includes/translations/'.LANGUAGE.'.php'); 
require_once(ABSPATH . 'admin/includes/classes/ldap.php');
require_once(ABSPATH . 'admin/includes/classes/db_postgresql.php');
require_once(ABSPATH . 'admin/includes/functions/categories.php');

/***
 * Template index.
 * ------------------------------------
 */

echo get_html_header();
echo get_html_content();
echo get_html_footer();
?>
