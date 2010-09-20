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


<?php /* Si il y a des articles a afficher */
if (!$article_list->isEmpty()) : ?>
	
	<h3 id="articlesTitle"><span><?php tpl::lang('On articles') ?></span></h3>
	
	<?php # boucle sur la liste de d'articles
	while ($article_list->fetch()) : ?>
	
		<h4><span><a href="<?php articles::listUrl() ?>"><?php articles::listTitle() ?></a></span></h4>
		<div class="articleContent">
			<?php tpl::truncate_html(articles::listContent(true), 300, 
			'<a href="'.articles::listUrl(true).'">'.tpl::lang('Read more',true).'</a>'); ?>
		</div>
		
	<?php /* Fin de la boucle sur les articles */ 
	endwhile; ?>
<br/>
<?php endif; ?>