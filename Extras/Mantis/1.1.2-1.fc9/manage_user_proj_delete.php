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

	# helper_ensure_post();

	auth_reauthenticate();

	$f_project_id = gpc_get_int( 'project_id' );
	$f_user_id = gpc_get_int( 'user_id' );

	access_ensure_project_level( config_get( 'project_user_threshold' ), $f_project_id );

	$t_project_name = project_get_name( $f_project_id );

	# Confirm with the user
	helper_ensure_confirmed( lang_get( 'remove_user_sure_msg' ) .
		'<br/>' . lang_get( 'project_name' ) . ': ' . $t_project_name,
		lang_get( 'remove_user_button' ) );

	$result = project_remove_user( $f_project_id, $f_user_id );

	$t_redirect_url = 'manage_user_edit_page.php?user_id=' .$f_user_id;

	html_page_top1();
	html_meta_redirect( $t_redirect_url );
	html_page_top2();
?>

<div id="message" class="green">
<?php
	echo '<p>' . lang_get( 'operation_successful' ) . '</p>';

	print_bracket_link( $t_redirect_url, lang_get( 'proceed' ) );
?>
</div>

<?php html_page_bottom1( __FILE__ ) ?>
