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
	<link rel="stylesheet" type="text/css" href="<?php tpl::urlFile('bugtracker/bugtracker.css') ?>" />
	<script type="text/javascript" src="<?php tpl::url('themes') ?>common/js/common.js"></script>
	<?php tpl::headExtra() ?>
	<?php headJsIe() ?>
	<?php # Open/close filtres sur l'accueil
	if ($bt_mode == 'default') : ?>
	<script type="text/javascript">
	//<![CDATA[
	chainHandler(window,'onload',function() {
		if (!document.getElementById) { return; }
		
		openClose('filtersBox',<?php bugtracker::filterBoxStatus() ?>,'');
	});
	//]]>
	</script>
	<?php endif; ?>
	<?php # Open/close commentaires
	if ($bt_mode == 'bug' && bugtracker::openComments()) : ?>
	<script type="text/javascript">
	//<![CDATA[
	chainHandler(window,'onload',function() {
		if (!document.getElementById) { return; }
		
		openClose('commentsBox',-1,'');
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
			<h2 id="bugsTitle"><span><?php tpl::lang('Bugtracker') ?></span></h2>
			<div class="box">
				<div class="inbox">
					<ul id="bugtrackerMenu">
					<?php /* Affichage du lien "Liste" */
					bugtracker::homeLink(
						'<li><a href="%s" id="btHomeLink">%s</a></li>',
						'<li><a href="%s" id="btHomeLinkActif"><strong>%s</strong></a></li>' ) ?>

					<?php /* Affichage du lien "Ajouter un bug" */
					bugtracker::addLink(
						'<li><a href="%s" id="btAddLink">%s</a></li>',
						'<li><a href="%s" id="btAddLinkActif"><strong>%s</strong></a></li>' ) ?>
					</ul>
				</div>
			</div>
		</div>
		
	<?php /* Formulaire d'ajout de bug */
	if ($bt_mode == 'ajouter') :
		require dirname(__FILE__).'/form_add.php';
		
	/* Formulaire de modification d'un bug */
	elseif ($bt_mode == 'bug') :
		require dirname(__FILE__).'/viewbug.php';
		
	/* Liste des bugs */
	elseif ($bt_mode == 'default') :
		require dirname(__FILE__).'/list.php';
	
	endif; ?>

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
