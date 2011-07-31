#!/bin/bash
#
# locale.sh -- This function provides internationalization features
# for centos-art.sh script through GNU gettext standard processes.
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

function locale {

    # Do not locale messages for English language. The English
    # language is already used as translation pattern and there is no
    # translation messages for it.
    if [[ $(cli_getCurrentLocale) =~ '^en' ]];then
        cli_printMessage "`gettext "Cannot locale English language to itself."`" --as-error-line
    fi

    local ACTIONNAMS=''
    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize default value to create/update machine object flag.
    # The machine object flag (--dont-create-mo) controls whether
    # centos-art.sh script does create/update the machine object
    # related object or not.
    local FLAG_DONT_CREATE_MO='false'

    # Define localization (l10n) base directory. This is the place
    # where all translation messages are organized in. Translation
    # messages, here, are organized using the same organization of the
    # components they represent inside the `trunk/Identity',
    # `trunk/Manuals' or `trunk/Scripts' directory structures.
    # The localization base directory must be used as source location
    # for subverion operations (e.g., status, update, commit, etc.).
    # Otherwise, it would be difficult to add directory structures
    # that have several levels down from the localization base
    # directory up to the repository (e.g., it is not possible in
    # subversion to add a directory structure which parent directory
    # structure hasn't been added to the repository, previously.).
    L10N_BASEDIR="$(cli_getRepoTLDir)/L10n"

    # Interpret arguments and options passed through command-line.
    ${CLI_FUNCNAME}_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncroRepoChanges "${L10N_BASEDIR}"

    # Define action value. As convenction, we use non-option arguments
    # to define the action value (ACTIONVAL) variable.
    for ACTIONVAL in "$@";do

        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        ACTIONVAL=$(cli_checkRepoDirSource $ACTIONVAL)

        # Verify whether the directory provided can have localization
        # messages or not.
        if [[ ! $(cli_isLocalized $ACTIONVAL) == 'true' ]];then
            cli_printMessage "`gettext "The path provided doesn't support localization."`" --as-error-line
        fi

        # Define localization working directory. This is the place
        # where language-specific directories are stored in.
        WORKDIR=$(echo ${ACTIONVAL} \
            | sed -r -e "s!trunk/(Identity|Scripts|Manuals)!trunk/L10n/\1!")

        # Redefine localization working directory to include
        # language-specific directories. This is the place where POT,
        # PO, and MO files are stored in.
        WORKDIR=$WORKDIR/$(cli_getCurrentLocale)

        # Execute action names.
        for ACTIONNAM in $ACTIONNAMS;do
            ${ACTIONNAM}
        done

    done

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncroRepoChanges "${L10N_BASEDIR}"

}
