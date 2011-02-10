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
    local ARGSL="update:,edit:,report:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            --update )

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_updateMessages"

                # Redefine action value.
                ACTIONVAL="$2"

                # Break while loop.
                shift 2
                ;;

            --edit )

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_editMessages"

                # Redefine action value.
                ACTIONVAL="$2"

                # Break while loop.
                shift 2
                ;;

            --report )

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_printTranslationReport"

                # Redefine action value.
                ACTIONVAL="$2"

                # Break while loop.
                shift 2
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

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
