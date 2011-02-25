#!/bin/bash
#
# locale_getActions.sh -- This function interprets arguments passed to
# `locale' functionality and calls actions accordingly.
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

function locale_getActions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="update:,edit:,dont-create-mo"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            --update )

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_updateMessages"

                # Redefine action value.
                ACTIONVAL="$2"

                # Rotate positional parameters
                shift 2
                ;;

            --edit )

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_editMessages"

                # Redefine action value.
                ACTIONVAL="$2"

                # Rotate positional parameters
                shift 2
                ;;

            --dont-create-mo )

                # Redefine create machine object flag.
                FLAG_DONT_CREATE_MO="true"

                # Rotate positional parameters
                shift 1
                ;;

            * )
                break
                ;;
        esac
    done

    # Check action value. Be sure the action value matches the
    # convenctions defined for source locations inside the working
    # copy.
    cli_checkRepoDirSource

    # Define locales base directory where locale directory structures
    # are stored in.
    local BASEDIR="$(cli_getRepoTLDir)/Locales"

    # Define locales work directory. This is the place where locale
    # files (e.g., .po, .pot, .mo), for a specific parent directories,
    # are stored in. There is one locale work directory for each
    # parent directory or said differently, each parent directory has
    # a parallel directory under `trunk/Locales' to store its
    # translation messages.
    local WORKDIR=$(echo $ACTIONVAL | sed -r \
            -e 's!trunk/(Identity|Manuals|Scripts)!trunk/Locales/\1!' \
            -e "s!/(Bash)!/\1/$(cli_getCurrentLocale)!" \
            -e "s!/${CLI_PROGRAM}!!") 
  
    # Syncronize changes between the working copy and the central
    # repository to bring down changes.
    cli_commitRepoChanges "${WORKDIR}"

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Syncronize changes between the working copy and the central
    # repository to commit up changes.
    cli_commitRepoChanges "${WORKDIR}"

}
