<?php
/***********************************************************************

  Copyright (C) 2005-2007 Vincent Garnier and contributors. All rights
  reserved.
  
  This file is part of Puntal 2.

  Puntal 2 is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published
  by the Free Software Foundation; either version 2 of the License,
  or (at your option) any later version.

  Puntal 2 is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  MA  02111-1307  USA

************************************************************************/?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php tpl::lang('lang_iso_code') ?>" 
lang="<?php tpl::lang('lang_iso_code') ?>" dir="<?php tpl::lang('lang_direction') ?>">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=<?php tpl::lang('lang_encoding') ?>" />
	<title><?php tpl::headTitlePage() ?></title>
	<link rel="stylesheet" type="text/css" href="<?php tpl::url('forums') ?>style/<?php tpl::user('style') ?>.css" />
	<link rel="stylesheet" type="text/css" href="<?php tpl::url('template') ?>style.css" />
	<link rel="stylesheet" type="text/css" href="<?php tpl::urlFile('news/news.css') ?>" />
	<?php news::headRss() ?>
	<script type="text/javascript" src="<?php tpl::url('themes') ?>common/js/common.js"></script>
	<?php tpl::headExtra() ?>
	<?php headJsIe() ?>
</head>
<body>

<div id="punwrap">
<div class="pun">

<?php # debut de page commun (fichier _top.php)
tpl::top() ?>

<div id="puntal_main">
	<div id="puntal_content">	
		<?php # On met le bloc edito ici et on désactive la fonctionnalité afficher/masquer
		tpl::bloc('edito') ?>
		
		<?php # Si nous somme en mode statique
		if (news::isStatic()) : ?>
			<?php news::getStaticNews('<p>%s</p>') ?>
		
		<?php # Sinon nous sommes en mode dynamique
		else : ?>
		<?php # Boucle sur les news
		while ($news->fetch()) : ?>
		<div class="block">
		
			<h2 class="news"><span><a href="<?php tpl::url('forums') ?>viewtopic.php?id=<?php news::tid() ?>" title="<?php tpl::lang('Read') ?> <?php news::title() ?>"><?php news::title() ?></a></span></h2>
			<div class="box">
				<div class="inbox">
					<?php news::avatar() ?>
					<?php news::message() ?>
					<p class="infos clearb">
						<?php tpl::lang('Written by') ?> <a href="<?php tpl::url('forums') ?>profile.php?id=<?php news::uid() ?>" title="<?php tpl::lang('See profile of') ?> <?php news::author() ?>"><?php news::author() ?></a> <?php tpl::lang('on') ?> <?php news::date() ?> <?php tpl::lang('in') ?> <a href="<?php tpl::url('forums') ?>viewforum.php?id=<?php news::forumId() ?>"><?php news::forumName() ?></a>
						<br />
						<a href="<?php tpl::url('forums') ?>viewtopic.php?id=<?php news::tid() ?>&amp;action=new" title="<?php tpl::lang('See comments of') ?> <?php news::title() ?>"><?php news::comments() ?></a>
						 | <a href="<?php tpl::url('forums') ?>viewtopic.php?id=<?php news::tid() ?>"><?php news::reads() ?></a></p>
				</div>
			</div>
		</div>
		<?php endwhile; ?>
		<?php endif; ?>
		
	</div>
</div>

<div id="puntal_sidebar">
<?php tpl::blocsNav() ?>
<?php tpl::blocsExtra() ?>

<?php /* Vous pouvez aussi placer les blocs individuellement */
/* 
<?php tpl::bloc('classic_menu') ?>
<?php tpl::bloc('modules_list') ?>
<?php tpl::bloc('calendar') ?>
<?php tpl::bloc('custom_menu') ?>
<?php tpl::bloc('custom_bloc') ?>
<?php tpl::bloc('custom_menu_bis') ?>
<?php tpl::bloc('custom_bloc_bis') ?>
<?php tpl::bloc('downloads') ?>
<?php tpl::bloc('top_downloads') ?>
<?php tpl::bloc('login') ?>
<?php tpl::bloc('recent_topics') ?>
<?php tpl::bloc('active_topics') ?>
<?php tpl::bloc('lang_switcher') ?>
<?php tpl::bloc('style_switcher') ?>
<?php tpl::bloc('online') ?>
<?php tpl::bloc('online_today') ?>
<?php tpl::bloc('stats') ?>
<?php tpl::bloc('top_posters') ?>
<?php tpl::bloc('archives') ?>
<?php tpl::bloc('rssreader') ?>
*/
?>

</div>
<div class="clearer"></div>

<?php # fin de page commun (fichier _bottom.php)
tpl::bottom() ?>

</div>
</div>

</body>
</html>
