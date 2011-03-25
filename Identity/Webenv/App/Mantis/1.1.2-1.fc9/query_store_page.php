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
?>
<?php
	require_once( 'core.php' );
	$t_core_path = config_get( 'core_path' );

	require_once( $t_core_path.'compress_api.php' );
	require_once( $t_core_path.'filter_api.php' );
	require_once( $t_core_path.'current_user_api.php' );
	require_once( $t_core_path.'bug_api.php' );
	require_once( $t_core_path.'string_api.php' );
	require_once( $t_core_path.'date_api.php' );

	auth_ensure_user_authenticated();

	compress_enable();

	html_page_top1();
	html_page_top2();

	$t_query_to_store = filter_db_get_filter( gpc_get_cookie( config_get( 'view_all_cookie' ), '' ) );
	$t_query_arr = filter_db_get_available_queries();

	# Let's just see if any of the current filters are the
	# same as the one we're about the try and save
	foreach( $t_query_arr as $t_id => $t_name ) {
		if ( filter_db_get_filter( $t_id ) == $t_query_to_store ) {
			print '<p class="lmtxt red">' . lang_get( 'query_exists' ) . ' (' . $t_name . ')</p>';
		}
	}

	# Check for an error
	$t_error_msg = strip_tags( gpc_get_string( 'error_msg', null ) );
	if ( $t_error_msg != null ) {
		print '<div id="message" class="red">';
		print "<p> $t_error_msg </p>";
		print '</div>';
	}

?>
	<br />
	<div align="center">

	<form method="post" action="query_store.php">
	<table class="border_black">
	<tr class="title">
		<td class="form-title" colspan="2"><?php print lang_get( 'save_query' ); ?></td>
	</tr>
	<tr class="row-2">

		<td class="category"> <?php print lang_get( 'query_name' ) . ': '; ?></td>
		<td>
		<input type="text" name="query_name" />
		<br />
		<?php
		if ( access_has_project_level( config_get( 'stored_query_create_shared_threshold' ) ) ) {
			print '<label title="' . lang_get( 'make_public' ) . '">';
			print '<input type="checkbox" name="is_public" value="on" /> ';
			print lang_get( 'make_public' );
			print '</label>';
		}
		?>

		<label title="<?php echo lang_get( 'all_projects' ); ?>">	
		<input type="checkbox" name="all_projects" value="on" <?php check_checked( ALL_PROJECTS == helper_get_current_project() ) ?> >
		<?php print lang_get( 'all_projects' ); ?>
		</label>
		</td>
	<tr class="row-1">
	<td></td>
	<td>
		<input type="submit" class="button" value="<?php print lang_get( 'save_query' ); ?>" />
	</td>
	</tr>
	</table>
	</form>

	<br />

	<form action="view_all_bug_page.php">
	<input type="submit" class="button" value="<?php print lang_get( 'go_back' ); ?>" />
	</form>

<?php
	echo '</div>';
	html_page_bottom1( __FILE__ );
?>
