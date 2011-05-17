#!/bin/bash
#
# locale.sh -- This function provides internationalization features
# for centos-art.sh script through gettext standard processes.
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

    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize default value to create/update machine object flag.
    # The machine object flag (--dont-create-mo) controls whether
    # centos-art.sh script does create/update the machine object
    # related object or not.
    local FLAG_DONT_CREATE_MO='false'

    # Interpret arguments and options passed through command-line.
    locale_getOptions

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

        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        cli_checkRepoDirSource

        # Define work directory. This is the place where locales
        # directories will be stored in.
        WORKDIR=$(echo ${ACTIONVAL} \
            | sed -r -e "s!trunk/(Identity|Scripts|Manual)!trunk/Locales/\1!")

        # Add current locale to work directory. This is the place
        # where parent directories specific translation messages
        # (e.g., the .po, .pot and .mo files) will be stored in.  The
        # `locale' functionality creates translation messages for all
        # translatable files inside the parent directory and never for
        # individual files inside the same parent directory.
        WORKDIR=$WORKDIR/$(cli_getCurrentLocale)

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges "${WORKDIR}"

        # Execute action name.
        if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
            eval $ACTIONNAM
        else
            cli_printMessage "`gettext "A valid action is required."`" --as-error-line
        fi

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges "${WORKDIR}"

    done

}
