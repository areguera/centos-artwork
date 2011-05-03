#!/bin/bash
#
# render.sh -- This function initializes rendition variables and
# actions to centos-art.sh script.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function render {

    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize `--releasever' option. The release version option
    # controls the release number used to produce release-specific
    # content.  By default no release number is used.
    local FLAG_RELEASEVER=''

    # Initialize `--basearch' option. The base architecture option
    # controls the architecture type used to produce
    # architecture-specific content. By default no architecture type
    # is used.
    local FLAG_BASEARCH=''

    # Initialize `--theme-model' option. The theme model option
    # specifies the the theme model name used to produce theme
    # artistic motifs.
    local FLAG_THEME_MODEL='Default'

    # Initialize `--convert' option. The convert option controls
    # whether to convert or not content produced as result of
    # base-rendition. By default there is no content convertion.
    local FLAG_CONVERT=''

    # Initialize `--comment' option. The comment option controls the
    # the text message we annotate in base-rendition output. Notice
    # that the comment will be annotated in those formats that permit
    # such thing (e.g., PNG files).
    local FLAG_COMMENT="`gettext "Created in CentOS Arwork Repository"` ($(cli_printUrl '--projects-artwork'))"

    # Initialize `--sharpen' option. The shapen option adaptively
    # sharpen pixels and increase effect near edges. It might use a
    # Gaussian operator of the given radius and standard deviation
    # (sigma).
    local FLAG_SHARPEN=''

    # Initialize `--group-by' option. The grouped-by option specifies
    # Initialize `--group-by' option. The grouped-by option specifies
    # whether grouping or not content produced by centos-art
    # base-rendition. By default there is no content grouping.
    local FLAG_GROUPED_BY=''

    # Interpret arguments and options passed through command-line.
    render_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Define action value. We use non-option arguments to define the
    # action value (ACTIONVAL) variable.
    for ACTIONVAL in "$@";do
        
        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        cli_checkRepoDirSource

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges

        # Define action name using action value as reference.  
        if [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Identity/Images/Themes" ]];then
            ACTIONNAM="${FUNCNAME}_doThemeActions"
        elif [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Identity/Images" ]];then
            ACTIONNAM="${FUNCNAME}_doBaseActions"
        else
            cli_printMessage "`gettext "The path provided doesn't support rendition."`" 'AsErrorLine'
            cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
        fi

        # Execute action name.
        if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
            eval $ACTIONNAM
        else
            cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
            cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
        fi

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges

    done

}
