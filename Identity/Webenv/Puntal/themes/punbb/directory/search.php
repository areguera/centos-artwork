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

		<h2><span>Recherche sur l'annuaire</span></h2>
		<?php dcSearchString('<p>Résultats de votre recherche de <em>%s</em>.</p>'); ?>
	
			<?php /* Si il y a des liens a afficher */
			if ($liens != false && !$liens->isEmpty()) : ?>
			
				<?php /* Boucle sur la liste des liens */
				while ($liens->fetch()) : ?>
				
					<h3 class="website"><span><a href="<?php dir::linkGo() ?>"<?php dir::linkHrefLang() ?>><?php dirLinkName() ?></a></span></h3>
					<?php dir::linkDesc() ?>
					<ul>
						<li><?php dir::linkNbClik() ?></li>
						<li>Adresse : <?php dir::linkUrl() ?></li>
						<li>Rubrique : <?php dir::linkCat() ?></li>
						<?php dir::linkPr('<li>Google PageRank : %s</li>'); ?>
					</ul>
					
				<?php endwhile; /* Fin de la boucle sur les liens */
			else : ?>
			
			<p>Aucun résultats.</p>
			
			<?php endif; ?>
