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
			<h2 id="bugsFilter"><span><a href="#" onclick="openClose('filtersBox',0,''); return false;"><?php tpl::lang('Filters') ?></a></span></h2>
			<div class="box" id="filtersBox">			
				<form action="<?php bugtracker::url('bugtracker') ?>" method="post">
					<div class="inform">
						<fieldset>
							<legend><?php tpl::lang('Options of display') ?></legend>
							<div class="infldset">
								<p class="field"><label for="severity"><?php tpl::lang('Severity') ?></label>
								<select name="severity" id="severity">
								<?php bugtracker::severityOptions('<option value="%s"%s>%s</option>',true) ?>
								</select></p>
								
								<p class="field"><label for="status"><?php tpl::lang('Status') ?></label>
								<select name="status" id="status">
								<?php bugtracker::statusOptions() ?>
								</select></p>								
							</div>	
						</fieldset>
					</div>
					<p><input type="hidden" name="filters" value="1" />
					<input type="submit" class="submit" value="<?php tpl::lang('Display') ?>" /></p>
				</form>
			</div>
		</div>

		<div class="linkst">
			<div class="inbox">
				<p class="pagelink"><?php bugtracker::getPagesLinks() ?></p>
			</div>
		</div>
		
		<div class="block">
			<h2 id="bugsList"><span><?php tpl::lang('Bugs list') ?></span></h2>
			<div class="box">
				<div class="inbox">
				<?php bugtracker::getBugsTable() ?>
				</div>
			</div>
		</div>
		
		<div class="linksb">
			<div class="inbox">
				<p class="pagelink"><?php bugtracker::getPagesLinks() ?></p>
			</div>
		</div>
