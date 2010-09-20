<?php
# Mantis - a php based bugtracking system

# Copyright (C) 2000 - 2002  Kenzaburo Ito - kenito@300baud.org
# Copyright (C) 2002 - 2007  Mantis Team   - mantisbt-dev@lists.sourceforge.net

# Mantis is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# Mantis is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Mantis.  If not, see <http://www.gnu.org/licenses/>.

	#------------------------------
	#   $Revision: 2643 $
	#     $Author: al $    
	#       $Date: 2009-06-18 19:06:27 -0400 (Thu, 18 Jun 2009) $                                              
	#------------------------------

	require_once( 'core.php' );

	# lost password feature disabled or reset password via email disabled -> stop here!
	if( OFF == config_get( 'lost_password_feature' ) ||
		OFF == config_get( 'send_reset_password' )  ||
	 	OFF == config_get( 'enable_email_notification' ) ) {
		trigger_error( ERROR_LOST_PASSWORD_NOT_ENABLED, ERROR );
	}

	html_page_top1();
	html_page_top2a();

?>

<h2><?php echo lang_get( 'lost_password_title' ); ?></h2>

<div class="quick-summary">
<?php
	print_login_link();
	PRINT '<br />';
	print_signup_link();
?>
</div>

<div id="lost_password_form">
<form name="lost_password_form" method="post" action="lost_pwd.php">
<table>

<?php
	$t_allow_passwd = helper_call_custom_function( 'auth_can_change_password', array() );
  	if ( $t_allow_passwd ) {
?>

<tr>
	<td width="150px" style="text-align:right;">
		<strong><?php echo lang_get( 'username' ) ?>:</strong>
	</td>
	<td>
		<input type="text" name="username" size="20" maxlength="32" />
	</td>
</tr>
<tr>
	<td style="text-align:right;">
		<strong><?php echo lang_get( 'email' ) ?>:</strong>
	</td>
	<td>
		<?php print_email_input( 'email', '' ) ?>
	</td>
</tr>
<tr>
	<td  colspan="2" style="width:200px">
		<p><?php echo lang_get( 'lost_password_info' ) ?></p>
	</td>
</tr>
<tr>
	<td class="buttons"></td>
	<td class="buttons">
		<input type="submit" class="button" value="<?php echo lang_get( 'submit_button' ) ?>" />
	</td>
</tr>
<?php
  } else {
?>
<tr>
	<td colspan="2">
		<p><?php echo lang_get( 'no_password_request' ) ?></p>
	</td>
</tr>
<?php
  }
?>

</table>
</form>
</div>

<!-- Autofocus JS -->
<?php if ( ON == config_get( 'use_javascript' ) ) { ?>
<script type="text/javascript" language="JavaScript">
<!--
	window.document.lost_password_form.username.focus();
// -->
</script>
<?php } ?>


<?php html_page_bottom1a( __FILE__ ); ?>
