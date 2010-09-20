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
	# $Revision: 2643 $
	#   $Author: al $
	#     $Date: 2009-06-18 19:06:27 -0400 (Thu, 18 Jun 2009) $
	#------------------------------

	require_once( 'core.php' );

	# Check for invalid access to signup page
	if ( OFF == config_get( 'allow_signup' ) ) {

		print_header_redirect( 'login_page.php' );

	}

	html_page_top1();

	html_page_top2a();

	$t_key = mt_rand( 0,99999 );
?>

<h2><?php echo lang_get( 'signup_title' ); ?></h2>

<div class="quick-summary">

<?php

	print_login_link();
	PRINT '<br />';

	print_lost_password_link();

?>

</div>

<div id="signup_form">

	<form name="signup_form" method="post" action="signup.php">

		<?php echo form_security_field( 'signup' ); ?>

		<table>

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
<?php
	$t_allow_passwd = helper_call_custom_function( 'auth_can_change_password', array() );

	if( ON == config_get( 'signup_use_captcha' ) && get_gd_version() > 0 && ( true == $t_allow_passwd ) ) {

			# captcha image requires GD library and related option to ON
?>

			<tr>

				<td style="text-align:right;">

					<strong><?php echo lang_get( 'signup_captcha_request' ) ?>:</strong>

				</td>

				<td>

					<?php print_captcha_input( 'captcha', '' ) ?>

					<br />

					<img src="make_captcha_img.php?public_key=<?php echo $t_key ?>" style="margin-top: 5px;">

					<input type="hidden" name="public_key" value="<?php echo $t_key ?>">
		
				</td>

			</tr>

<?php
	}

	if( false == $t_allow_passwd ) {
?>

			<tr>

				<td colspan="2" >

					<p class="lmtxt red"><?php echo lang_get( 'no_password_request' ) ?></p>

				</td>

			</tr>
<?php
	}
?>

			<tr>

				<td colspan="2"  style="width:200px">

					<?php echo lang_get( 'signup_info' ) ?>

				</td>

			</tr>

			<tr>

				<td class="buttons"></td>

				<td class="buttons">

					<input type="submit" class="button" value="<?php echo lang_get( 'signup_button' ) ?>" />

				</td>

			</tr>

		</table>

	</form>

</div>

<!-- Autofocus JS -->
<?php if ( ON == config_get( 'use_javascript' ) ) { ?>

<script type="text/javascript" language="JavaScript">
<!--
	window.document.signup_form.username.focus();
// -->
</script>

<?php } ?>


<?php html_page_bottom1a( __FILE__ ); ?>
