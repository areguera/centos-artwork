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
	<link rel="stylesheet" type="text/css" href="<?php tpl::urlFile('planet/planet.css') ?>" />    
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
		<?php # boucle sur les feeds
		while ($feeds->fetch()) : ?>
		<div class="block">
			<h2 class="feedTitle"><span><?php planet::titleLink() ?></span></h2>
			<p class="feedInfos"><?php planet::feedTitleLink() ?> <?php tpl::lang('on') ?> <?php planet::date() ?></p>
			<div class="box">
				<div class="inbox">
					<?php planet::description() ?>
					<ul class="feedLinks">
						<li><a href="<?php planet::blinklist() ?>" class="blinklist-link">Blinklist</a></li>
						<li><a href="<?php planet::delicious() ?>" class="delicious-link">Del.icio.us</a> </li>
						<li><a href="<?php planet::digg() ?>" class="digg-link">Digg</a></li>
						<li><a href="<?php planet::furl() ?>" class="furl-link">Furl</a></li>
						<li><a href="<?php planet::magnolia() ?>" class="magnolia-link">Ma.gnolia</a></li>
						<li><a href="<?php planet::newsvine() ?>" class="newsvine-link">Newsvine</a></li>
						<li><a href="<?php planet::spurl() ?>" class="spurl-link">Spurl</a></li>
						<li><a href="<?php planet::technorati() ?>" class="technorati-link">Technorati</a></li>
					</ul>
				</div>
			</div>
		</div>
		<?php endwhile; ?>
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
