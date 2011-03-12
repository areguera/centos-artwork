#!/bin/bash
#
# locale.sh -- This function provides internationalization features
# for centos-art.sh script through gettext standard processes.
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

function locale {

    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize default value to create/update machine object flag.
    # The machine object flag (--dont-create-mo) controls whether
    # centos-art.sh script does create/update the machine object
    # related object or not.
    local FLAG_DONT_CREATE_MO='false'

    # Interpret arguments and options passed through command-line.
    locale_getArguments

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Define action name. It does matter what option be passed to
    # centos-art, there are many different actions to perform based on
    # the option passed (e.g., `--edit', `--read', `--search', etc.).
    # In that sake, we defined action name inside document_getArguments,
    # at the moment of interpreting options.

    # Define action value. As convenction, we use non-option arguments
    # to define the action value (ACTIONVAL) variable.
    for ACTIONVAL in "$@";do

        if [[ $ACTIONVAL == '--' ]];then
            continue
        fi

        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        cli_checkRepoDirSource

        # Define locales base directory where locale directory structures
        # are stored in.
        local BASEDIR="$(cli_getRepoTLDir)/Locales"

        # Define locales work directory. This is the place where
        # locale files (e.g., .po, .pot, .mo), for a specific parent
        # directories, are stored in. There is one locale work
        # directory for each parent directory or said differently,
        # each parent directory has a parallel directory under
        # `trunk/Locales' to store its translation messages.
        local WORKDIR=$(echo ${ACTIONVAL} \
            | sed -r -e 's!trunk/(Identity|Manuals|Scripts)!trunk/Locales/\1!')
  
        # Create work directory, if it doesn't exist.
        if [[ ! -d $WORKDIR ]];then
            mkdir -p $WORKDIR
        fi

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges "${WORKDIR}"

        # Execute action name.
        if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
            eval $ACTIONNAM
        else
            cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'
        fi

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges "${WORKDIR}"

    done

}
