<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<?php
    $htmlblock = array('<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">',
                       '<head>',
                       '<meta http-equiv="content-type" content="text/html; charset=UTF-8">',
                       '<title>newbb to phpbb :: Migrating Xoops+CBB(newbb) to phpBB</title>',
                       '<link rel="stylesheet" href="style.css" type="text/css" media="screen" />',
                       '</head>',
                       '<body>',
                       '<div id="header">',
                       '<h1>newbb to phpbb</h1>',
                       '<p class="description">Migrating from Xoops+CBB(newbb) to phpBB+LDAP</p>');

                       # Navigation bar
                       $htmlblock = array_merge($htmlblock, $html->get_navibar());

                       array_push($htmlblock, '<div class="pageline">','</div>');
                       array_push($htmlblock, '</div>');

                       // Where am I in the migration process ?
                       if ( ! isset($_GET['p'] ) )
                       {
                       $htmlblock = array_merge($htmlblock, $html->get_stepPosition());
                       } 

                       array_push($htmlblock,'<div id="page">');
?>
