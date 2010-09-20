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

	$t_core_path = config_get( 'core_path' );

	auth_reauthenticate();
	form_security_validate( 'manage_proj_subproj_add' );

	$f_project_id    = gpc_get_int( 'project_id' );
	$f_subproject_id = gpc_get_int( 'subproject_id' );

	access_ensure_project_level( config_get( 'manage_project_threshold' ), $f_project_id );

	project_ensure_exists( $f_project_id );
	project_ensure_exists( $f_subproject_id );
	
	if ( $f_project_id == $f_subproject_id ) {
		trigger_error( ERROR_GENERIC, ERROR );
	}
	project_hierarchy_add( $f_subproject_id, $f_project_id );

	$t_redirect_url = 'manage_proj_edit_page.php?project_id=' . $f_project_id;

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
