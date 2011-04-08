#!/bin/bash
#
# render.sh -- This function initializes rendition variables and
# actions to centos-art.sh script.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
    # whether convert or not content produced by centos-art
    # base-rendition. By default there is no content convertion.
    local FLAG_CONVERT=''

    # Initialize `--rotate' option. The rotate option controls whether
    # rotate or not image content produced by centos-art
    # base-rendition.  By default there is no content rotation.
    local FLAG_ROTATE=''

    # Initialize `--resize' option. The resize option controls whether
    # resize or not content produced by centos-art base-rendition. By
    # default there is no content resizing.
    local FLAG_RESIZE=''

    # Initialize `--group-by' option. The grouped-by option specifies
    # whether grouping or not content produced by centos-art
    # base-rendition. By default there is no content grouping.
    local FLAG_GROUPED_BY=''

    # Interpret arguments and options passed through command-line.
    render_getArguments

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Define action name. No matter what option be passed to
    # centos-art, there is only one action to perform (i.e., the
    # base-rendition flow).
    ACTIONNAM="${FUNCNAME}_doBaseActions"

    # Define action value. We use non-option arguments to define the
    # action value (ACTIONVAL) variable.
    for ACTIONVAL in "$@";do
        
        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        cli_checkRepoDirSource

        # Define the renderable top directory structure. This is, the
        # place where renderable directory structures are stored.
        # Directory structures outside this directory won't be
        # processed.
        if [[ ! $ACTIONVAL =~ "^$(cli_getRepoTLDir)/(Identity/Images|$(cli_getPathComponent '--theme-pattern'))" ]];then
            cli_printMessage "`gettext "The path provided doesn't support rendition."`" 'AsErrorLine'
            cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
        fi

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges

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
