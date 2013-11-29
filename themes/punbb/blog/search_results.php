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

************************************************************************/

/*
	Original file by Olivier Meunier and contributors from 
	DotClear project. http://www.dotclear.net/
*/

if (!$blog_entries->isEmpty()) : ?>
<h3 id="blogTitle"><span><?php tpl::lang('On blog') ?></span></h3>

<!-- Boucle sur la liste de billets -->
<?php while ($blog_entries->fetch()) : ?>
	
	<h4 id="p<?php blog::dcPostID(); ?>" class="post-title"><span><a
	href="<?php blog::dcPostURL(); ?>"><?php blog::dcPostTitle(); ?></a></span></h4>
	
	<p class="post-info"><?php tpl::lang('By') ?> <?php blog::dcPostAuthor(); ?>,
	<?php blog::dcPostDate(); ?> <?php blog::dcPostTime(); ?>
	<span>::</span> <a href="<?php blog::dcPostCatURL(); ?>"><?php blog::dcPostCatTitle(); ?></a>
	</p>
	
	<div class="post-content" <?php blog::dcPostLang(); ?>>
		<?php blog::dcPostAbstract('%s','<p><a href="%s" title="Lire %s">Lire la suite</a></p>'); ?>
	</div>
	
	<p class="post-info-co"><a href="<?php blog::dcPostURL(); ?>#co"
	title="<?php tpl::lang('comments for:') ?> <?php blog::dcPostTitle(); ?>"><?php
	blog::dcPostNbComments('aucun commentaire','un commentaire','%s commentaires');
	?></a>
	<span>::</span> <a href="<?php blog::dcPostURL(); ?>#tb"
	title="<?php tpl::lang('trackbacks for:') ?> <?php blog::dcPostTitle(); ?>"><?php
	blog::dcPostNbTrackbacks();
	?></a></p>

<?php endwhile; ?>
<br/>
<?php endif; ?>