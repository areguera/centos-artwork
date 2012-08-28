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
	if (calendar::hasErrors()) : ?>
	<div id="posterror" class="block">
		<h2><span><?php tpl::lang('Error') ?></span></h2>
		<div class="box">
			<div class="inbox">
				<p><?php echo tpl::lang('Post errors info') ?></p>
				<?php calendar::error('<ul>%s</ul>', '<li><strong>%s</strong></li>'); ?>
			</div>
		</div>
	</div>
<?php endif; ?>

<?php /* Si nous voulons la prévisualisation */
	if (calendar::onPreview()) : ?>

<div id="postpreview" class="blockpost">
	<h2><span><?php calendar::previewValue('req_subject') ?></span></h2>
	<div class="box">
		<div class="inbox">
			<div class="postright">
				<div class="postmsg">
					<?php calendar::previewValue('req_message') ?>
				</div>
			</div>
		</div>
	</div>
</div>

<?php  endif; ?>

	<div class="blockform">
		<h2 id="articleSubmit"><span><?php tpl::lang('Add event to calendar') ?></span></h2>
		<div class="box">
			<form action="<?php calendar::url('add') ?>" method="post">
<?php if (calendar::isCalendarCategory()) : ?>
				<div class="inform">
					<fieldset>
						<legend><?php calendar::calCategory(); ?></legend>
							<p class="field"><label for="req_cal_category"><?php calendar::calCategory(); ?></label>
							<select class="category" name="req_cal_category" id="req_cal_category">
								<option value="">&nbsp;</option> 
								<?php calendar::selectCalendarCategoryOption('<option value="%s">%s</option>'); ?>
							</select>							
							</p>
					</fieldset>
				</div>							
<?php endif; ?>			
				<div class="inform">
					<fieldset>
						<legend><?php tpl::lang('Date'); ?></legend>
						<div class="infldset">
							<p class="field">
							<select class="calendar" name="event_annee" tabindex="<?php echo calendar::curIndex();?>"> 
								<?php calendar::selectOption('<option value="%s" selected="selected">%s</option>','<option value="%s">%s</option>','year'); ?>
							</select>
							
							<select class="calendar" name="event_mois" tabindex="<?php echo calendar::curIndex(); ?>"> 
								<?php calendar::selectOption('<option value="%s" selected="selected">%s</option>','<option value="%s">%s</option>','month'); ?>
							</select>
							
							<select class="calendar" name="event_jour" tabindex="<?php echo calendar::curIndex(); ?>">
								<?php calendar::selectOption('<option value="%s" selected="selected">%s</option>','<option value="%s">%s</option>','day'); ?>	
							</select>
							</p>
						</div>
					</fieldset>
				</div>
				<div class="inform">
					<fieldset>
						<legend><?php tpl::lang('Event'); ?></legend>
						<div class="infldset txtarea">
<?php if (calendar::isGuest()) : ?>
							<p class="field"><label for="req_username"><?php tpl::lang('Guest name') ?></label>
							<input type="text" name="req_username" id="req_username" class="longinput" size="80" maxlength="70" value="" tabindex="<?php echo calendar::curIndex(); ?>" /></p>
							
							<p class="field"><label for="req_email"><?php tpl::lang('E-mail') ?></label>
							<input type="text" name="req_email" id="req_email" class="longinput" size="80" maxlength="70" value="" tabindex="<?php echo calendar::curIndex(); ?>" /></p>
							
							<div class="clearer"></div>
<?php endif; ?>
<?php if (calendar::isCategory()) : ?>
							<p class="field"><label for="req_category"><?php tpl::lang('Category') ?></label>
							<select class="category" name="req_category" id="req_category">
								<option value="">&nbsp;</option> 
								<?php calendar::selectCategoryOption('<option value="%s" selected="selected">%s</option>','<option value="%s">%s</option>'); ?>
							</select>							
							</p>
<?php endif; ?>
							<p class="field"><label for="req_subject"><?php tpl::lang('Subject') ?></label>
							<input type="text" name="req_subject" id="req_subject" class="longinput" size="80" maxlength="70" value="<?php calendar::formSubject(); ?>" tabindex="<?php echo calendar::curIndex(); ?>" /></p>
							
							<p class="field"><label for="req_message"><?php tpl::lang('Message') ?></label>
							<textarea name="req_message" id="req_message" cols="55" rows="10" tabindex="<?php echo calendar::curIndex(); ?>"><?php calendar::formMessage();?></textarea></p>
<?php 
require_once PT_INC_PATH.'libs/puntoolbar_smilies.php'; 
$ptb = new puntoolbarSmilies($puntal);
echo $ptb->generatePtb('req_message');
?>	
							<ul class="bblinks">
								<li><a href="help.php#bbcode" onclick="window.open(this.href); return false;"><?php tpl::lang('BBCode') ?></a>: <?php echo ($puntal->pun_config['p_message_bbcode'] == '1') ? __('Enabled') : __('Disabled'); ?></li>
								<li><a href="help.php#img" onclick="window.open(this.href); return false;"><?php tpl::lang('img tag') ?></a>: <?php echo ($puntal->pun_config['p_message_img_tag'] == '1') ? __('Enabled') : __('Disabled'); ?></li>
								<li><a href="help.php#smilies" onclick="window.open(this.href); return false;"><?php tpl::lang('Smilies') ?></a>: <?php echo ($puntal->pun_config['o_smilies'] == '1') ? __('Enabled') : __('Disabled'); ?></li>
							</ul>
						</div>
					</fieldset>
				</div>					
<?php
// If we have to post new topic
if (pt_mod_calendar_forum_id > 0) : ?>
	<?php if (!calendar::isGuest()) : ?>
			<div class="inform">
				<fieldset>
					<legend><?php tpl::lang('Options') ?></legend>
					<div class="infldset">
						<div class="rbox">
	
		<?php if (calendar::smilies()) : ?>
			<label><input type="checkbox" name="hide_smilies" value="1" tabindex="<?php calendar::curIndex(); ?>" <?php calendar::checked('hide_smilies');?> /> <?php tpl::lang('Hide smilies'); ?></label>
		<?php endif; ?>
		<?php if (calendar::subscriptions()) : ?>
			<label><input type="checkbox" name="subscribe" value="1" tabindex="<?php calendar::curIndex(); ?>" <?php calendar::checked('subscribe'); ?> /> <?php tpl::lang('Subscribe'); ?></label>
		<?php endif; ?>
	
						</div>
					</div>
				</fieldset>
			</div>
	<?php endif; ?>			
<?php  endif; ?>	
			<p><input type="hidden" name="form_sent" value="1" />
			<input type="hidden" name="form_user" value="<?php echo calendar::formUser(); ?>"/>
			<input class="submit" type="submit" value=" <?php tpl::lang('Add'); ?> " />
			<input type="hidden" name="ptkn" value="<?php echo tpl::pTkn(); ?>" />
			<input class="submit" type="submit" name="preview" value="<?php tpl::lang('Preview') ?>" /></p>
		</form>
	</div>
</div>