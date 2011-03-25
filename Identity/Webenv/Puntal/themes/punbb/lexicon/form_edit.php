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
	if (!empty($errors)) : ?>
	
	<div id="posterror" class="block">
		<h2><span><?php tpl::lang('Error') ?></span></h2>
		<div class="box">
			<div class="inbox">
				<?php lexique::errors('<ul>%s</ul>', '<li>%s</li>') ?>
			</div>
		</div>
	</div>
	<?php endif; 
	/* Fin affichage erreurs */ ?>

	<div class="blockform">
		<h2 class="lexiconEdit"><span><?php tpl::lang('Edit a word') ?></span></h2>
		<div class="box">
			<form action="<?php lexique::editFormAction() ?>" method="post">
			<div class="inform">
				<fieldset><legend><?php tpl::lang('Edit a word') ?></legend>
					<div class="infldset txtarea">
						
						<p class="field"><label for="p_mot"><?php tpl::lang('Word') ?></label>
						<input class="longinput" name="p_mot" id="p_mot" value="<?php lexique::formValue('p_mot') ?>" size="80" maxlength="70" type="text" /></p>
						
						<p class="field"><label for="p_def"><?php tpl::lang('Definition') ?></label>
						<textarea name="p_def" id="p_def" rows="5" cols="55"><?php lexique::formValue('p_def') ?></textarea></p>
<?php 
require_once PT_INC_PATH.'libs/puntoolbar_smilies.php'; 
$ptb = new puntoolbarSmilies($puntal);
echo $ptb->generatePtb('p_def');
?>						
						<p class="field"><label for="p_ex"><?php tpl::lang('Example') ?></label>
						<textarea name="p_ex" id="p_ex" rows="5" cols="55"><?php lexique::formValue('p_ex') ?></textarea></p>
<?php 
require_once PT_INC_PATH.'libs/puntoolbar_smilies.php'; 
$ptb = new puntoolbarSmilies($puntal);
echo $ptb->generatePtb('p_ex');
?>						
					</div>
				</fieldset>
			</div>
			<p><input type="hidden" name="form_sent" value="1" />
			<input type="hidden" name="ptkn" value="<?php echo tpl::pTkn(); ?>" />
			<input name="submit" type="submit" class="submit" value="<?php tpl::lang('Edit') ?>" />
			<a href="javascript:history.go(-1)"><?php tpl::lang('Go back') ?></a></p>
			</form>
		</div>
	</div>
