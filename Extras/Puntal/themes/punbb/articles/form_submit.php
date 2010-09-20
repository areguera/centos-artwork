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
				<?php articles::errors('<ul>%s</ul>', '<li>%s</li>') ?>
			</div>
		</div>
	</div>
	<?php endif; 
	/* Fin affichage erreurs */ ?>

	<div class="block">
		<h2 id="articleSubmit"><span><?php tpl::lang('Submit an article') ?></span></h2>
		<div class="box">
			<form action="<?php articles::submitUrl() ?>" method="post">
			<div class="inform">
				<fieldset><legend><?php tpl::lang('Submit an article') ?></legend>
					<div class="infldset txtarea">
						
						<p class="field"><label for="p_title"><?php tpl::lang('Article title') ?></label>
						<input type="text" name="p_title" id="p_title" class="longinput" size="80" maxlength="70" value="<?php articles::formValue('p_title') ?>" /></p>
						
						<p class="field"><label for="p_cat"><?php tpl::lang('Article category') ?></label>
						<?php articles::selectCat('p_cat') ?></p>
						
						<p class="field"><label for="p_content"><?php tpl::lang('Article content') ?></label>
						<textarea name="p_content" id="p_content" cols="55" rows="10" ><?php articles::formValue('p_content') ?></textarea></p>
<?php 
require_once PT_INC_PATH.'libs/puntoolbar_smilies.php'; 
$ptb = new puntoolbarSmilies($puntal);
echo $ptb->generatePtb('p_content');
?>							
					</div>
				</fieldset>
			</div>
			<p><input type="hidden" name="form_sent" value="1" />
			<input type="submit" name="submit" class="submit" value="<?php tpl::lang('Submit') ?>" />
			<input type="hidden" name="ptkn" value="<?php echo tpl::pTkn(); ?>" /></p>
			</form>
		</div>
	</div>
