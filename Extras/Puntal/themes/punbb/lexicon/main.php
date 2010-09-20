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
	<link rel="stylesheet" type="text/css" href="<?php tpl::urlFile('lexicon/lexicon.css') ?>" />
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
	
	<div class="block">
		<h2 class="lexiconTitle"><span><?php tpl::lang('Lexicon') ?></span></h2>
		<div class="box">
			<p>
			<?php /* Affichage du nombre total de mot dans le lexique */
			lexique::totalWords('<span id="lexTotalWords">%s</span>') ?>

			<?php /* Affichage du nombre total de mot � valider */
			lexique::totalToValidateWords('<span id="lexTotalToValidateWords">%s</span>') ?>


			<?php /* Affichage du lien "Ajouter un mot" */
			lexique::addLink(
				' - <a href="%s" id="lexAddLink">%s</a>',
				' - <a href="%s" id="lexAddLinkActif"><strong>%s</strong></a>' ) ?>
				
			<?php /* Affichage du lien "Liste de validation" */
			lexique::validateLink(
				' - <a href="%s" id="lexValidateLink">%s</a>', 
				' - <a href="%s" id="lexValidateLinkActif"><strong>%s</strong></a>' ) ?>
				
			<?php /* Affichage du lien "Liste compl�te" */
			lexique::allLink(
				' - <a href="%s" id="lexAllLink">%s</a>', 
				' - <a href="%s" id="lexAllLinkActif"><strong>%s</strong></a>' ) ?>
			</p>
			<p id="letter_list">
			<?php /* Affichage de la liste des lettres */
			lexique::letters(
				'<a href="%s">%s</a>', 
				'<a href="%s" class="cur_letter"><strong>%s</strong></a>', 
				' - ') ?>
			</p>
		</div>
	</div>

	<?php /* Formulaire d'ajout de mot */
	if ($lexique_mode == 'ajouter') :
		require dirname(__FILE__).'/form_add.php';
		
	/* Formulaire de modification d'un mot */
	elseif ($lexique_mode == 'modifier') :
		require dirname(__FILE__).'/form_edit.php';
		
	/* Liste compl�te */
	elseif ($lexique_mode == 'tous') :
		require dirname(__FILE__).'/list_all.php';
		
	/* Liste des mots � valider */
	elseif ($lexique_mode == 'valider') :
		require dirname(__FILE__).'/list_validate.php';
		
	/* Liste des mots d'une lettre donn�e */
	elseif ($lexique_mode == 'lettre') :
		require dirname(__FILE__).'/list_letter.php';
	
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
