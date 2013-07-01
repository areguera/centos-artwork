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

<div class="blocktable">
	<h2 id="articlesCat"><span><?php articles::catName() ?></span></h2>
	<div class="box">
		<div class="inbox">
			<table cellspacing="0">
			<thead>
				<tr>
					<th class="tcl" scope="col"><?php tpl::lang('Title') ?></th>
					<th class="tc2" scope="col"><?php tpl::lang('Date') ?></th>
					<?php if (articles::articlesOpenComment()) : ?>
					<th class="tcr" scope="col"><?php tpl::lang('Discuss') ?></th>
					<?php endif; ?>
				</tr>
			</thead>
			<tbody>
			<?php # boucle sur la liste de d'articles
			while ($article_list->fetch()) : ?>
 				<tr>
					<td class="tcl"><a href="<?php articles::listUrl() ?>"><?php articles::listTitle() ?></a></td>
					<td class="tc2"><?php articles::listDate() ?></td>
					<?php if (articles::articlesOpenComment()) : ?>
					<td class="tcr"><?php articles::listNumComment() ?></td>
					<?php endif; ?>
				</tr>
			<?php endwhile; ?>
			</tbody>
			</table>

		</div>
	</div>
</div>