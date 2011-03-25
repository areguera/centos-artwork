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

	<?php /* Si nous avons des erreurs, alors on les affiches */
	if (bugtracker::hasErrors()) : ?>
	
	<div id="posterror" class="block">
		<h2><span><?php tpl::lang('Error') ?></span></h2>
		<div class="box">
			<div class="inbox">
				<?php bugtracker::errors('<ul>%s</ul>', '<li>%s</li>') ?>
			</div>
		</div>
	</div>
	<?php endif; 
	/* Fin affichage erreurs */ ?>

	<?php /* Si nous voulons la prévisualisation */
	if (bugtracker::onPreview()) : ?>
	
	<div class="block">
		<h2><span><?php bugtracker::previewValue('title') ?></span></h2>
		<div class="box">
			<div class="inbox">
				<?php bugtracker::previewValue('desc') ?>
			</div>
		</div>
	</div>
	<?php endif; 
	/* Fin affichage prévisualisation */ ?>

	<div class="block">
		<h2 id="bugAdd"><span><?php tpl::lang('Add a bug') ?></span></h2>
		<div class="box">
			<form action="<?php bugtracker::url('add') ?>" method="post">
			<div class="inform">
				<fieldset><legend><?php tpl::lang('New bug') ?></legend>
					<div class="infldset txtarea">
											
						<?php if (tpl::user('is_guest',true)) : ?>
						<p class="field"><label for="req_username"><?php tpl::lang('Guest name') ?></label>
						<input type="text" name="req_username" value="<?php bugtracker::formValue('req_username') ?>" size="25" maxlength="25" /></p>
						
						<p class="field"><label for="req_email"><?php tpl::lang('E-mail') ?></label>
						<input type="text" name="req_email" id="req_email" value="<?php bugtracker::formValue('req_email') ?>" size="50" maxlength="50" /></p>
						<?php endif; ?>
											
						<p class="field"><label for="neo_bug"><?php tpl::lang('Bug title') ?></label>
						<input class="longinput" name="neo_bug" id="neo_bug" value="<?php bugtracker::formValue('neo_bug') ?>" size="80" maxlength="70" type="text" /></p>
						
						<div class="two-cols">
							<p class="col field">
								<label><?php bugtracker::componentLabel() ?></label>
								<select name="neo_component" id="neo_component">
									<?php bugtracker::componentOptions('<option value="%s"%s>%s</option>') ?>
								</select>											
							</p>
									
							<p class="col field"><label for="neo_severity"><?php tpl::lang('Severity') ?></label>
							<select name="neo_severity" id="neo_severity">
								<?php bugtracker::severityOptions('<option value="%s"%s>%s</option>') ?>
							</select></p>
						</div>
														
						<p class="field"><label for="neo_version"><?php tpl::lang('Version') ?></label>
						<select name="neo_version" id="neo_version">
							<?php bugtracker::versionsOptions('<option value="%s"%s>%s</option>') ?>
						</select></p>
						
						<p class="field"><label for="neo_desc"><?php tpl::lang('Bug description') ?></label>
						<textarea name="neo_desc" id="neo_desc" rows="5" cols="55"><?php bugtracker::formValue('neo_desc') ?></textarea></p>
<?php 
require_once PT_INC_PATH.'libs/puntoolbar_smilies.php'; 
$ptb = new puntoolbarSmilies($puntal);
echo $ptb->generatePtb('neo_desc');
?>	
					</div>
				</fieldset>
			</div>
			<p><input type="hidden" name="form_sent" value="1" />
			<input type="submit" name="submit" class="submit" value="<?php tpl::lang('Add') ?>" /> 
			<input type="submit" name="preview" class="submit" value="<?php tpl::lang('Preview') ?>" />
			<input type="hidden" name="ptkn" value="<?php echo tpl::pTkn(); ?>" /> 
			<a href="javascript:history.go(-1)"><?php tpl::lang('Go back') ?></a></p>
			</form>
		</div>
	</div>
