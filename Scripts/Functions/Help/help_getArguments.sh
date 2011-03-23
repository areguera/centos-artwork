#!/bin/bash
#
# help_getArguments.sh -- This function interpretes arguments passed
# to `manual' functionality and calls actions accordingly.
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

function help_getArguments {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="filter:,quiet,answer:,dont-commit-changes,read,search,edit,update"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            --filter )
                FLAG_FILTER="$2"
                shift 2
                ;;

            --quiet )
                FLAG_QUIET="true"
                FLAG_DONT_COMMIT_CHANGES="true"
                shift 1
                ;;

            --answer )
                FLAG_ANSWER="$2"
                shift 2
                ;;

            --dont-commit-changes )
                FLAG_DONT_COMMIT_CHANGES="true"
                shift 1
                ;;

            --search )
                ACTIONNAM="${FUNCNAM}_searchIndex"
                shift 1
                ;;
    
            --edit )
                ACTIONNAM="${FUNCNAM}_editEntry"
                shift 1
                ;;
    
            --update )
                ACTIONNAM="${FUNCNAM}_updateOutputFiles"
                shift 1
                ;;
    
            --read | * )
                ACTIONNAM="${FUNCNAM}_searchNode"
                FLAG_DONT_COMMIT_CHANGES='true'
                break
                ;;
        esac
    done

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

}
