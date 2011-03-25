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


<?php /* Si il y a des downloads a afficher */
if (!$downloads_list->isEmpty()) : ?>
	
	<h3 id="downloadsTitle"><span><?php tpl::lang('On downloads') ?></span></h3>
	
	<?php # boucle sur la liste de d'downloads
	while ($downloads_list->fetch()) : ?>
	
		<h4><span><a href="<?php download::listUrl() ?>"><?php download::listTitle() ?></a></span></h4>
		<div class="downloadsContent"><?php download::listContent() ?></div>
		
	<?php /* Fin de la boucle sur les downloads */ 
	endwhile; ?>

<br/>    
<?php endif; ?>