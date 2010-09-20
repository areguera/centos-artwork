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
?>

<?php blog::dcCommentFormError('<div class="errorBox"><p><strong>'.tpl::lang('Error', true).'</strong></p>%s</div>'); ?>
<?php blog::dcCommentFormMsg('<p class="msg"><strong>%s</strong></p>'); ?>

<form action="<?php blog::dcPostUrl(); ?>" method="post" id="comment-form">
	<div class="inform">
	<fieldset>
		<p class="field"><label for="c_nom"><?php tpl::lang('Name') ?></label>
		<input name="c_nom" id="c_nom" type="text" size="30" maxlength="255"
		value="<?php blog::dcCommentFormValue('c_nom'); ?>" />
		</p>
	
		<p class="field"><label for="c_mail"><?php tpl::lang('Email') ?> (<?php tpl::lang('optional') ?>)</label>
		<input name="c_mail" id="c_mail" type="text" size="30" maxlength="255"
		value="<?php blog::dcCommentFormValue('c_mail'); ?>" />
		</p>
	
		<p class="field"><label for="c_site"><?php tpl::lang('Website') ?> (<?php tpl::lang('optional') ?>)</label>
		<input name="c_site" id="c_site" type="text" size="30" maxlength="255"
		value="<?php blog::dcCommentFormValue('c_site'); ?>" />
		</p>
		
		<p class="field"><label for="c_content"><?php tpl::lang('Comment') ?></label>
		<textarea name="c_content" id="c_content" cols="35" rows="7"><?php
		blog::dcCommentFormValue('c_content');
		?></textarea>
		</p>
<?php 
require_once PT_INC_PATH.'libs/puntoolbar_smilies.php'; 
$ptb = new puntoolbarSmilies($puntal);
echo $ptb->generatePtb('c_content');
?>	</fieldset>
	
	<p class="form-help"><?php tpl::lang('HTML code in the comment will be displayed like text, Internet addresses will be converted automatically.') ?></p>
    <div class="inform">
    	<fieldset>
        <legend><?php blog::blogCaptchaLabel() ;?></legend>
        <p><label><strong><?php echo blog::blogCaptchaQuestion(); ?></strong><br />
        <input name="captcha" id="captcha" type="text" size="5" maxlength="10" />
        <input name="captcha_q" value="<?php echo blog::blogCaptchaEncoded() ?>" type="hidden" /><br /></label></p>
        </fieldset>
    </div>	
	<fieldset>	
		<p><input type="checkbox" id="c_remember" name="c_remember" />
		<label for="c_remember"><?php tpl::lang('Remenber my informations') ?></label></p>
		
		<p><input type="submit" class="submit" name="preview" value="<?php tpl::lang('Preview') ?>" />
		<input type="submit" class="submit" value="<?php tpl::lang('Add') ?>" />
		<input type="hidden" name="redir" value="<?php blog::dcCommentFormRedir(); ?>" />
		<input type="hidden" name="ptkn" value="<?php echo tpl::pTkn(); ?>" /></p>		
	</fieldset>
	</div>
</form>
