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
				<ul>
	<?php
				calendar::error('<ul>%s</ul>', '<li><strong>%s</strong></li>');
	?>
				</ul>
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
		<h2><span><?php tpl::lang('Modify the event in the calendar'); ?></span></h2>
		<div class="box">
			<form method="post" action="<?php echo calendar::url('edit') ?>">
<?php if (calendar::isCalendarCategory()) : ?>
				<div class="inform">
					<fieldset>
						<legend><?php calendar::calCategory(); ?></legend>
							<p class="field"><label for="req_cal_category"><?php calendar::calCategory(); ?></label>
							<select class="category" name="req_cal_category" id="req_cal_category">
								<option value="">&nbsp;</option> 
								<?php calendar::selectCalendarCategoryOption('<option value="%s" selected="selected">%s</option>','<option value="%s">%s</option>'); ?>
							</select>							
							</p>
					</fieldset>
				</div>							
<?php endif; ?>						
				<div class="inform">
					<fieldset>
						<legend><?php tpl::lang('Date'); ?></legend>
						<div class="infldset">
							<select name="event_annee" > 
								<?php calendar::selectOption('<option value="%s" selected="selected">%s</option>','<option value="%s">%s</option>','year'); ?>
							</select>
							
							<select name="event_mois" > 
								<?php calendar::selectOption('<option value="%s" selected="selected">%s</option>','<option value="%s">%s</option>','month'); ?>
							</select>
							
							<select name="event_jour" >
								<?php calendar::selectOption('<option value="%s" selected="selected">%s</option>','<option value="%s">%s</option>','day'); ?>	
							</select>
						
						</div>
					</fieldset>
				</div>
				<div class="inform">
					<fieldset>
						<legend><?php tpl::lang('Event'); ?></legend>
						<div class="infldset txtarea">
<?php if (calendar::isGuest()) : ?>
	
						<label class="conl"><strong><?php tpl::lang('Guest name') ?></strong><br /><input type="text" name="req_username" value="<?php calendar::formValue('req_username') ?>" size="25" maxlength="25" /><br /></label>
						<label class="conl"><?php echo calendar::guestEmailLabel() ?><br /><input type="text" name="<?php echo calendar::guestEmailName() ?> ?>" value="<?php calendar::formValue('req_username') ?>" size="50" maxlength="50"  /><br /></label>
						<div class="clearer"></div>
<?php endif; ?>
						<label><strong><?php tpl::lang('Subject') ?></strong><br /><input class="longinput" type="text" name="req_subject" value="<?php calendar::formSubject(); ?>" size="80" maxlength="50" /><br /></label>
						<label><strong><?php tpl::lang('Message') ?></strong><br />
						<textarea id="req_message" name="req_message" rows="20" cols="95"><?php calendar::formMessage();?></textarea><br /></label>
<?php 
require_once PT_INC_PATH.'libs/puntoolbar_smilies.php'; 
$ptb = new puntoolbarSmilies($puntal);
echo $ptb->generatePtb('req_message');
?>						
						<ul class="bblinks">
							<li><a href="<?php echo pt_forum_url; ?>help.php#bbcode" onclick="window.open(this.href); return false;"><?php tpl::lang('BBCode') ?></a>: <?php echo ($puntal->pun_config['p_message_bbcode'] == '1') ? __('Enabled') : __('Disabled'); ?></li>
							<li><a href="<?php echo pt_forum_url; ?>help.php#img" onclick="window.open(this.href); return false;"><?php tpl::lang('img tag') ?></a>: <?php echo ($puntal->pun_config['p_message_img_tag'] == '1') ? __('Enabled') : __('Disabled'); ?></li>
							<li><a href="<?php echo pt_forum_url; ?>help.php#smilies" onclick="window.open(this.href); return false;"><?php tpl::lang('Smilies') ?></a>: <?php echo ($puntal->pun_config['o_smilies'] == '1') ? __('Enabled') : __('Disabled'); ?></li>
						</ul>
						</div>
					</fieldset>
				</div>					

<?php
// If we have to post new topic
if (pt_mod_calendar_forum_id > 0) : ?>

			<div class="inform">
				<fieldset>
					<legend><?php tpl::lang('Options') ?></legend>
					<div class="infldset">
						<div class="rbox">						
	<?php if (!calendar::isGuest()) : ?>

		<?php if ( calendar::smilies() ) : ?>
						<label><input type="checkbox" name="hide_smilies" value="1" <?php calendar::checked('hide_smilies');?> /><?php tpl::lang('Hide smilies'); ?></label>
		<?php endif; ?>
		<?php if ( calendar::subscriptions() ) : ?>
						<label><input type="checkbox" name="subscribe" value="1" <?php calendar::checked('subscribe'); ?> /> <?php tpl::lang('Subscribe'); ?></label>
		<?php endif; ?>
	<?php elseif (calendar::smilies()) : ?>
						<label><input type="checkbox" name="hide_smilies" value="1" <?php calendar::checked('hide_smilies');?> /> <?php tpl::lang('Hide smilies'); ?></label>
		<?php endif; ?>
						<label><input type="checkbox" name="silent" value="1" checked="checked" /> <?php tpl::lang('Silent edit'); ?></label>
						</div>
					</div>
				</fieldset>
			</div>
<?php  endif; ?>	
			<p>
				<input type="hidden" name="event_id" value="<?php echo calendar::eventId(); ?>" />
				<input type="hidden" name="form_sent" value="1" />
				<input type="hidden" name="form_user" value="<?php echo calendar::formUser(); ?>"/>
				<input type="hidden" name="ptkn" value="<?php echo tpl::pTkn(); ?>" />		
			<input type="submit" value=" <?php tpl::lang('Validate'); ?> " /><input type="submit" name="preview" value="<?php tpl::lang('Preview') ?>" /><a href="javascript:history.go(-1)"><?php tpl::lang('Go back') ?></a>
			</p>
		</form>
	</div>
</div>
