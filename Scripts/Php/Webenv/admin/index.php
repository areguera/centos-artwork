<?php

    require_once('../config.php');
    require_once(ABSPATH . 'admin/includes/functions/auth.php');
    check_adminaccess();
    check_useraccess();
    require_once(ABSPATH . 'includes/translations/'.LANGUAGE.'.php');
    require_once(ABSPATH . 'admin/includes/classes/ldap.php');
    require_once(ABSPATH . 'admin/includes/classes/db_postgresql.php');
    require_once(ABSPATH . 'admin/includes/functions/categories.php');
    require_once(ABSPATH . 'admin/includes/functions/users.php');
    require_once(ABSPATH . 'admin/includes/functions/url.php');
    require_once(ABSPATH . 'admin/includes/functions/links.php');
    require_once(ABSPATH . 'admin/includes/functions/html.php');

    // Header template
    include("header.php");

    // Content template
    include("content.php");

    // Footer template
    include("footer.php");

?>
