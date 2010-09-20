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
	<link rel="stylesheet" type="text/css" href="<?php tpl::urlFile('articles/articles.css') ?>" />
	<?php articles::headRss() ?>
	<script type="text/javascript" src="<?php tpl::url('themes') ?>common/js/common.js"></script>
	<?php tpl::headExtra() ?>
	<?php headJsIe() ?>
	<?php # si nous visionnons un article qui as des commentaires
	if ($articles_mode == 'article' && articles::articleOpenComments()) : ?>
	<script type="text/javascript">
	//<![CDATA[\n
		chainHandler(window,'onload',function() {
			if (!document.getElementById) { return; }
			
			openClose('commentsBox',-1,'<?php tpl::url('template') ?>articles/img/comments_');
		});
		//]]>
	</script>
	<?php endif; ?>
	</head>
<body>

<div id="punwrap">
<div class="pun">

<?php # debut de page commun (fichier _top.php)
tpl::top() ?>

<div id="puntal_main">
	<div id="puntal_content">
	
		<div class="block">
			<h2 id="articlesTitle"><span><?php tpl::lang('Articles') ?></span></h2>
			<div class="box">
				<div class="inbox" id="catBox">
					<?php articles::mainMenu('<ul>%s</ul>', '<li>%s</li>', '<li class="current">%s</li>') ?>
					<?php articles::catDesc() ?>
				</div>
				<?php # si on est sur la vue d'un article on affiche la liste des autres articles
				if ($articles_mode == 'article') : ?>
				<div class="inbox">
					<p><?php articles::otherArticles() ?></p>
					<?php articles::articlesList('<ul>%s</ul>', '<li>%s</li>'); ?>
				</div>
				<?php endif; ?>
			</div>
		</div>


		<?php # Si nous somme en mode statique
		if ($articles_mode == 'article_static') : ?>
			<?php articles::getStaticArticles('<p>%s</p>'); ?>
					
		<?php # si on est sur l'accueil, on utilise le fichier home.php
		elseif ($articles_mode == 'home') : ?>
			<?php require dirname(__FILE__).'/home.php'; ?>
		
		<?php # si on est sur la vue d'une catégorie, on utilise cat.php
		elseif ($articles_mode == 'cat') : ?>
			<?php require dirname(__FILE__).'/cat.php'; ?>
		
		<?php #si on est sur la vue d'un article, on utilise article.php
		elseif ($articles_mode == 'article_dynamic') : ?>
			<?php require dirname(__FILE__).'/article.php'; ?>
		
		<?php # si on est sur la page de soumission d'article
		elseif ($articles_mode == 'submit') : ?>
			<?php require dirname(__FILE__).'/form_submit.php'; ?>
		
		<?php endif; ?>
	</div>
</div>

<div id="puntal_sidebar">
<?php tpl::blocsNav() ?>
<?php tpl::blocsExtra() ?>
</div>
<div class="clearer"></div>

<?php # fin de page commun (fichier _bottom.php)
tpl::bottom() ?>

</div>
</div>

</body>
</html>
