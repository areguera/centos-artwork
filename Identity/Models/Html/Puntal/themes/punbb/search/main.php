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
	<?php # si nous avons des résultats à afficher
	if ($search_mode == 'results') : ?>
		<div class="block">
			<h2 class="news"><span><?php tpl::lang('Search results') ?></span></h2>
			<div class="box">
				<div class="inbox">
				<?php search::searchResultsTtl() ?>				
				<?php search::results() ?>
				</div>
			</div>
		</div>
	<?php # sinon nous sommes sur le formulaire 
	else : ?>
		<div class="block">
			<h2 id="searchTitle"><label for="q"><span><?php tpl::lang('Search') ?></span></label></h2>
			<form action="<?php search::url() ?>" method="get">
			<div class="box">
				<div class="inbox">
					<p class="field"><input type="text" id="q" name="q" maxlength="255" value="" /></p>
					<p><input type="submit" class="submit" value="<?php tpl::lang('Ok') ?>" /></p>
				</div>
			</div>
			</form>
		</div>
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
