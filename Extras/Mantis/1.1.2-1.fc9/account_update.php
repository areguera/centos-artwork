<?php
# Mantis - a php based bugtracking system

# Copyright (C) 2000 - 2002  Kenzaburo Ito - kenito@300baud.org
# Copyright (C) 2002 - 2008  Mantis Team   - mantisbt-dev@lists.sourceforge.net

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

	# This page updates a user's information
	# If an account is protected then changes are forbidden
	# The page gets redirected back to account_page.php

	require_once( 'core.php' );

	$t_core_path = config_get( 'core_path' );

	require_once( $t_core_path.'email_api.php' );

	form_security_validate('account_update');

	auth_ensure_user_authenticated();

	current_user_ensure_unprotected();

	$f_email           	= gpc_get_string( 'email', '' );
	$f_realname        	= gpc_get_string( 'realname', '' );
	$f_password        	= gpc_get_string( 'password', '' );
	$f_password_confirm	= gpc_get_string( 'password_confirm', '' );

	$f_email = email_append_domain( $f_email );

	email_ensure_not_disposable( $f_email );

	# get the user id once, so that if we decide in the future to enable this for
	# admins / managers to change details of other users.
	$t_user_id = auth_get_current_user_id();

	$t_redirect = 'account_page.php';

	$t_email_updated = false;
	$t_password_updated = false;
	$t_realname_updated = false;

	# @@@ Listing what fields were updated is not standard behaviour of Mantis
	#     it also complicates the code.

	if ( $f_email != user_get_email( $t_user_id ) ) {
		user_set_email( $t_user_id, $f_email );
		$t_email_updated = true;
	}

	if ( $f_realname != user_get_field( $t_user_id, 'realname' ) ) {
		# checks for problems with realnames
		$t_username = user_get_field( $t_user_id, 'username' );
		switch ( user_is_realname_unique( $t_username, $f_realname ) ) {
			case 1:
				break;
			case 0:
			default:
				trigger_error( ERROR_USER_REAL_MATCH_USER, ERROR );
				break;
		}
		user_set_realname( $t_user_id, $f_realname );
		$t_realname_updated = true;
	}

	# Update password if the two match and are not empty
	if ( !is_blank( $f_password ) ) {
		if ( $f_password != $f_password_confirm ) {
			trigger_error( ERROR_USER_CREATE_PASSWORD_MISMATCH, ERROR );
		} else {
			if ( !auth_does_password_match( $t_user_id, $f_password ) ) {
				user_set_password( $t_user_id, $f_password );
				$t_password_updated = true;
			}
		}
	}

	html_page_top1();
	html_meta_redirect( $t_redirect );
	html_page_top2();

	echo '<div id="message" class="green">';

	if ( $t_email_updated ) {
		echo '<p>' . lang_get( 'email_updated' ) . '</p>';
	}

	if ( $t_password_updated ) {
		echo '<p>' . lang_get( 'password_updated' ) . '</p>';
	}

	if ( $t_realname_updated ) {
		echo '<p>' . lang_get( 'realname_updated' ) . '</p>';
	}

	echo '<p>' . lang_get( 'operation_successful' ) . '</p>';
	print_bracket_link( $t_redirect, lang_get( 'proceed' ) );
	echo '</div>';
	html_page_bottom1( __FILE__ );
?>
