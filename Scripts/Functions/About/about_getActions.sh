#!/bin/bash
#
# about_getActions.sh -- This function interpretes arguments passed to
# about functionality and calls actions accordingly.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------
    
function about_getActions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="license,history,authors,copying"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            --license )
                ACTIONVAL="${FUNCCONFIG}/license.txt"
                break
                ;;

            --history )
                ACTIONVAL="${FUNCCONFIG}/history.txt"
                break
                ;;

            --authors )
                ACTIONVAL="${FUNCCONFIG}/authors.txt"
                break
                ;;

            --copying | * )
                ACTIONVAL="${FUNCCONFIG}/copying.txt"
                break
                ;;

        esac
    done

    # Execute action name.
    if [[ -f $ACTIONVAL ]];then
        less $ACTIONVAL
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
    fi

}
