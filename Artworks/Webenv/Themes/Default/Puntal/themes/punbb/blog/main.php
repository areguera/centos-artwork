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
	<?php blog::dcHeadLinks(); ?>
	<link rel="alternate" type="application/rss+xml" title="RSS" href="<?php blog::dcInfo('rss'); ?>" />
	<link rel="alternate" type="application/atom+xml" title="Atom" href="<?php blog::dcInfo('atom'); ?>" />
	<title><?php blog::dcSinglePostTitle('%s - '); blog::dcSingleCatTitle('%s - ');
	blog::dcSingleMonthTitle('%s - '); blog::dcCustomTitle('%s - '); tpl::infos(); ?></title>
	<link rel="stylesheet" type="text/css" href="<?php tpl::url('forums') ?>style/<?php tpl::user('style') ?>.css" />
	<link rel="stylesheet" type="text/css" href="<?php tpl::url('template') ?>style.css" />
	<link rel="stylesheet" type="text/css" href="<?php tpl::urlFile('blog/blog.css') ?>" />

	<?php blog::dcPostTrackbackAutoDiscovery(); ?>

	</head>
<body>

<div id="punwrap">
<div class="pun">

<?php # debut de page commun (fichier _top.php)
tpl::top() ?>

<div id="puntal_main">
	<div id="puntal_content">
	
	<?php if ($err_msg != '') : /* Si on a une quelconque erreur, on l'affiche */?>
		<div class="block">
			<h2><span><?php tpl::lang('Blog') ?></span></h2>
			<div class="box">
				<div class="inbox">
					<p><strong><?php tpl::lang('Error') ?></strong></p>
					<?php echo $err_msg; ?>
				</div>
			</div>
		</div>
	
	<?php elseif ($preview) : /* Si on demande la prévisualisation d'un commentaire */?>
		<h3><?php tpl::lang('Comment') ?> <?php blog::dcPostTitle(); ?></h3>
		<div id="comment-preview">
			<blockquote>
			<?php blog::dcCommentPreview(); ?>
			</blockquote>
		</div>
		
		<?php include dirname(__FILE__).'/form.php'; ?>
		
	<?php elseif ($mode != 'post') : /* Si aucune erreur et mode != post on affiche une liste de billets */?>		
		<?php include dirname(__FILE__).'/list.php'; ?>
		
	<?php else : /* Sinon, mode = post, donc billet unique (avec commentaires et tout le reste)*/?>
		<?php include dirname(__FILE__).'/post.php'; ?>
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
