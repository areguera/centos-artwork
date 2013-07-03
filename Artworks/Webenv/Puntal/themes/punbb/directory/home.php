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

	<div class="block">
		<h2 class="directory"><span><?php tpl::lang('Directory') ?></span></h2>
		<div class="box">
			<div class="inbox">
				<?php dir::menu('<ul id="dirMenu">%s</ul>', '<li><a href="%s">%s</a></li>', '<li class="active"><a href="%s">%s</a></li>') ?>
				<p><?php tpl::lang('You will find here a selection of links towards websites.') ?></p>
				<p class="dirIntro"><?php dir::nombreLiens() ?>  <?php dir::nombreCategories() ?></p>
			
	<?php /* Affiche une sélection de sites */ dir::selection(
	/* le bloc si il y a des liens : */ '</div>
				</div>
			</div>
			<div class="block" id="selected_links">
				<h2><span>'.tpl::lang('Selected website(s)',true).'</span></h2>
				<div class="box">
					<div class="inbox">%s</div>
				</div>
			</div>
			<div class="block">
				<h2 class="catTitle"><span>'.tpl::lang('Categories',true).'</span></h2>
				<div class="box">
					<div class="inbox">',
	/* le bloc si il y a pas de lien */ '</div>
				</div>
			</div>
			<div class="block">
				<h2 class="catTitle"><span>'.tpl::lang('Categories',true).'</span></h2>
				<div class="box">
					<div class="inbox">',
	/* un item : */ '<h3 class="website">%s</h3>%s', 
	/* nombre de liens à afficher : */ '2' ,
	/* option de tri */ 'random'
	) ?>
	
			<?php # Si il y a des catégorie à afficher
			if (!$cats->isEmpty()) : ?>
				<ul class="cats">
				<?php  /* Boucle sur la liste des rubriques */
				while ($cats->fetch()) : ?>
					
					<li><a href="<?php dir::catUrl() ?>"><?php dir::catName() ?></a> <?php dir::catNumLink() ?>
					<?php dir::subCat('<ul class="subcats">%s</ul>', '<li><a href="%s">%s</a>&nbsp;(%s)</li>') ?></li>
					
				<?php endwhile; /* Fin de la boucle sur les rubriques */ ?>
				</ul>
				<div class="clearer"></div>
			<?php endif; ?>
			</div>
		</div>
	</div>
	