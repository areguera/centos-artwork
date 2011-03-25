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

<?php # Liste des téléchargements populaires
if (pt_mod_downloads_popular_dl) : ?>	

	<div class="block">
		<h2 class="popDls"><span><?php tpl::lang('Most popular downloads') ?></span></h2>
		<div class="box">
		<table class="download" id="popDls" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<th class="tcl" scope="col"><?php tpl::lang('Title') ?></th>
					<th class="tc2" scope="col"><?php tpl::lang('Number of downloads') ?></th>
					<th class="tcr" scope="col"><?php tpl::lang('Date') ?></th>				
				</tr>
			</thead>
			<tbody>
			<?php while ($download_popular->fetch()) : ?>
			<tr>
				<td class="tcl"><h3 class="dlTitle"><span><a href="<?php download::popularDownloadsListURL() ?>"><?php download::popularDownloadsListTitle() ?></a></span></h3></td>
				<td class="tc2"><?php download::popularDownloadsListCount() ?></td>
				<td class="tcr"><?php download::popularDownloadsListDate() ?></td>
			</tr>
			<?php endwhile; ?>
			</tbody>
		</table>
		</div>
	</div>
	
<?php endif; ?>

<?php # Liste des derniers téléchargements ajoutés
if (pt_mod_downloads_last_dl) : ?>	
								
	<div class="block">
		<h2 class="lastDls"><span><?php tpl::lang('Last downloads added') ?></span></h2>
		<div class="box">
			<table class="download" id="lastDls" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<th class="tcl" scope="col"><?php tpl::lang('Title') ?></th>				
					<th class="tcr" scope="col"><?php tpl::lang('Date') ?></th>						
				</tr>
			</thead>
			<tbody>
			<?php while ($download_last->fetch()) : ?>
			<tr>
				<td class="tcl"><h3 class="dlTitle"><span><a href="<?php download::lastDownloadsListURL() ?>"><?php download::lastDownloadsListTitle() ?></a></span></h3></td>
				<td class="tcr"><?php download::lastDownloadsListDate() ?></td>
			</tr>
			<?php endwhile; ?>
			</tbody>
			</table>
		</div>
	</div>
	
<?php endif; ?>
