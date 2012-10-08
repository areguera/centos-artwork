#!/bin/bash
#
# help_getOptions.sh -- This function interpretes option arguments
# passed to `help' functionality through the command-line and defines
# action names accordingly.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function help_getOptions {

    # Define short options we want to support.
    local ARGSS="q,h"

    # Define long options we want to support.
    local ARGSL="quiet,help,answer-yes,read,search:,edit,update-output,update-structure,copy,delete,rename,sync-changes"

    # Redefine ARGUMENTS using getopt(1) command parser.
    cli_parseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            -h | --help )
                ${CLI_NAME} help --read trunk/Scripts/Bash/Functions/Help
                shift 1
                exit
                ;;

            -q | --quiet )
                FLAG_QUIET="true"
                shift 1
                ;;

            --answer-yes )
                FLAG_ANSWER="true"
                shift 1
                ;;

            --search )
                ACTIONNAM="searchIndex"
                FLAG_SEARCH="$2"
                shift 2
                ;;
    
            --edit )
                ACTIONNAM="editEntry"
                shift 1
                ;;

            --copy )
                ACTIONNAM="copyEntry"
                shift 1
                ;;
    
            --delete )
                ACTIONNAM="deleteEntry"
                shift 1
                ;;

            --rename )
                ACTIONNAM="renameEntry"
                shift 1
                ;;
    
            --update-output )
                ACTIONNAM="updateOutputFiles"
                shift 1
                ;;

            --update-structure )
                ACTIONNAM="updateStructureSection"
                shift 1
                ;;
    
            --read )
                ACTIONNAM="searchNode"
                shift 1
                ;;

            --sync-changes )
                FLAG_SYNC_CHANGES="true"
                shift 1
                ;;

            -- )
                # Remove the `--' argument from the list of arguments
                # in order for processing non-option arguments
                # correctly. At this point all option arguments have
                # been processed already but the `--' argument still
                # remains to mark ending of option arguments and
                # begining of non-option arguments. The `--' argument
                # needs to be removed here in order to avoid
                # centos-art.sh script to process it as a path inside
                # the repository, which obviously is not.
                shift 1
                break
                ;;
        esac
    done

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

}
