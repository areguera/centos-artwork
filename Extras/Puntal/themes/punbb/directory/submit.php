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
		<h2 class="directory"><span><?php tpl::lang('Directory') ?></span></h2>
		<div class="box">
			<div class="inbox">
				<?php dir::menu('<ul id="dirMenu">%s</ul>', '<li><a href="%s">%s</a></li>', '<li class="active"><a href="%s">%s</a></li>') ?>
			<p><?php tpl::lang('This page enables you to submit a website has to add to the directory.') ?></p>
			</div>
		</div>
	</div>

	<?php /* Si nous avons des erreurs, alors on les affiches */
	if (dir::hasErrors()) : ?>
	
	<div id="posterror" class="block">
		<h2><span><?php tpl::lang('Error') ?></span></h2>
		<div class="box">
			<div class="inbox">
				<?php dir::errors() ?>
			</div>
		</div>
	</div>
	<?php endif; 
	/* Fin affichage erreurs */ ?>
	
	<div class="block">
		<h2 class="addLink"><span><?php tpl::lang('Submit a website') ?></span></h2>
		<div class="box">
			<form action="<?php dir::dirAddUrl(); ?>" method="post">
			<div class="inform">
				<fieldset><legend><?php tpl::lang('Submit a website') ?></legend>
					<div class="infldset txtarea">
			
						<p class="field"><label for="l_cat"><?php tpl::lang('Category') ?></label>
						<?php dir::selectCat('l_cat') ?></p>
					
						<p class="field"><label for="l_titre"><?php tpl::lang('Website name') ?></label>
						<input type="text" class="longinput" size="80" maxlength="255" name="l_titre" id="l_titre" value="<?php dir::formValue('l_titre') ?>" /></p>
						
						<p class="field"><label for="l_href"><?php tpl::lang('<acronym title="Uniform Resource Locator">URL</acronym>') ?></label>
						<input type="text" class="longinput" size="80" maxlength="70" name="l_href" id="l_href" value="<?php dir::formValue('l_href') ?>"  /></p>
						
						<p class="field"><label for="l_desc"><?php tpl::lang('Description') ?></label>
						<textarea name="l_desc" id="l_desc" rows="5" cols="55" ><?php dir::formValue('l_desc') ?></textarea></p>
<?php 
require_once PT_INC_PATH.'libs/puntoolbar_smilies.php'; 
$ptb = new puntoolbarSmilies($puntal);
echo $ptb->generatePtb('l_desc');
?>											
						<p class="field"><label for="l_lang"><?php tpl::lang('Website language') ?></label>
						<input type="text" size="5" name="l_lang" id="l_lang" maxlength="5" value="<?php dir::formValue('l_lang') ?>" /></p>
						
					</div>
				</fieldset>
			</div>
			<p><input type="hidden" name="form_sent" value="1" />
			<input type="hidden" name="ptkn" value="<?php echo tpl::pTkn(); ?>" />
			<input type="submit" name="submit" class="submit" value="<?php tpl::lang('Submit') ?>" /></p>
			</form>
		</div>
	</div>
