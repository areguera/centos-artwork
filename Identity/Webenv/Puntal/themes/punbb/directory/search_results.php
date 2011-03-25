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


<?php /* Si il y a des liens a afficher */
if (!$liens->isEmpty()) : ?>
	
	<h3 class="directory"><span><?php tpl::lang('On directory') ?></span></h3>
	
	<?php /* Boucle sur la liste des sites */
	while ($liens->fetch()) : ?>
		<div class="links">
			<h4 class="website"><span><a href="<?php dir::linkGo() ?>"<?php dir::linkHrefLang() ?>><?php dir::linkName() ?></a></span></h4>
			<?php dir::linkDesc(); ?>
			<ul>
				<li><?php dir::linkNbClik() ?></li>
				<li><?php tpl::lang('Address:') ?> <?php dir::linkUrl() ?></li>
				<?php dir::linkPr('<li>%s %s</li>'); ?>
			</ul>
		</div>	
	<?php /* Fin de la boucle sur les sites */ endwhile; ?>
<br/>
<?php endif; ?>