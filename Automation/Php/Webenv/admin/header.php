<?php
//--------------------/* Show error if called directly */

    if ( basename($_SERVER['PHP_SELF']) <> 'index.php')
    {
        echo '<h3>Sorry, this page can\'t be served directly. ';
        echo 'Try <a href="index.php">this instead</a>.</h3>';
        exit;
    }
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>Admin :: <?php echo HTML_TITLE ?></title>
    <link rel="stylesheet" type="text/css" charset="utf-8" media="all" href="style.css">
</head>

<body>

<div id="header">

    <div class="adminlinks">

        <?php echo ucfirst($_SESSION['cn']); ?> [ <a href="<?php echo BASEURL ?>"><?php echo ucfirst(translate('go back'))?></a> | <a href="?action=logout"><?php echo ucfirst(translate('logout'))?></a> ]

    </div>

    <div id="logo">

        <img src="<?php echo BASEURL ?>contents/images/logo.png" alt="">
        <span class="logo_text"><?php echo ucfirst(translate( LANGUAGE )) ?></span>

    </div> 



    <div class="pageline_dark"> </div>

    <?php echo show_mainlinks(); ?>

    <?php echo show_sublinks(); ?>

</div>

<div id="content">

    <div class="columnl">

