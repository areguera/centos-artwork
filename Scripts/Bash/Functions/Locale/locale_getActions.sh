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
    local ARGSS="f:"

    # Define long options we want to support.
    local ARGSL="filter:,status,edit"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            --status )

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_doMessagesStatus"

                # Redefine action value. There is no action value to
                # verify here.

                # Look for related sub-options.
                while true; do
                    case "$2" in

                        -f|--filter )

                            # Redefine regular expression.
                            FLAG_FILTER="$3"

                            # Rotate positional parameters
                            shift 3
                            ;;

                        * )
                            break
                            ;;

                    esac
                done

                # Break while loop.
                break
                ;;

            --edit )

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_doMessages"

                # Redefine action value. It is required for
                # cli_commitRepoChanges to know where locale changes
                # are.
                ACTIONVAL=/home/centos/artwork/trunk/Scripts/Bash/Locale

                # Verify action value variable.
                if [[ $ACTIONVAL == '' ]];then
                    cli_printMessage "$(caller)" 'AsToKnowMoreLine'
                fi

                # Break while loop.
                break
                ;;

            * )
                break
        esac
    done

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
