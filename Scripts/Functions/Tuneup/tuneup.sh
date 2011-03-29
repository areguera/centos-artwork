#!/bin/bash
#
# tuneup.sh -- This function groups maintainance tasks which are
# applied to files based on their extension.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function tuneup {

    local ACTIONNAM=''
    local ACTIONVAL=''

    # Interpret arguments and options passed through command-line.
    tuneup_getArguments

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Define action name. No matter what option be passed to
    # centos-art, there is only one action to perform (i.e., build the
    # list of files and interpretation of file extensions for further
    # processing).
    ACTIONNAM="${FUNCNAME}_doBaseActions"

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
