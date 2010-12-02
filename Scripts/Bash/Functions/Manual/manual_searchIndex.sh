#!/bin/bash
#
# manual_searchIndex.sh -- This function does an index search inside the
# info document.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function manual_searchIndex {

    # Define search pattern format.
    local PATTERN='^[[:alnum:],]+$'

    # Define default search string.
    local SEARCH=''

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="filter:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in
            --filter )
               SEARCH="$2" 
               shift 2
               ;;
            * )
                break
        esac
    done

    # Re-define default SEARCH value. If the search string is not
    # provided as `--filter' argument, ask user to provide one. 
    if [[ ! $SEARCH =~ $PATTERN ]];then
        cli_printMessage "`gettext "Enter the search pattern"`" "AsRequestLine"
        read SEARCH
    fi

    # Validate search string using search pattern.
    if [[ ! "$SEARCH" =~ $PATTERN ]];then
        cli_printMessage "`gettext "The search pattern is not valid."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Perform index search inside documentation info file.
    /usr/bin/info --index-search="$SEARCH" --file=${MANUALS_FILE[4]}

}
