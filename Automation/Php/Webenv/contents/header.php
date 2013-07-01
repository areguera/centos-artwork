<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title><?php echo HTML_TITLE ?></title>
    <link rel="stylesheet" type="text/css" charset="utf-8" media="all" href="contents/style.css">
</head>

<body>
<div id="header">

    <div class="adminlinks"> 
<!--
        <div class="googlecontent">
            <img src="http://localhost/googleads.png" alt="">
        </div>
-->
        <?php echo get_html_searchform(); ?>
    </div>
    <div id="logo">
        <a href="">
        <img src="contents/images/logo.png" alt="">
        <span class="logo_text"><?php echo ucfirst(translate( LANGUAGE ))?></span>
        </a>
    </div> 

    <div class="pageline_dark"> </div>
        <a href=""><img class="rss" src="contents/images/rss.png" alt="rss"></a>
        <?php echo get_html_mainlinks(); ?>
    </div>

