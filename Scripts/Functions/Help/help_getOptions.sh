#!/bin/bash
#
# help_getOptions.sh -- This function interpretes arguments passed to
# `manual' functionality and calls actions accordingly.
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

function help_getOptions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="quiet,answer-yes,dont-commit-changes,read,search:,edit,update,copy,delete,rename,backend:"

    # Parse arguments using getopt(1) command parser.
    cli_parseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define default action for help functionality.  This is, the
    # action performed when no non-option argument is passed to
    # `centos-art.sh' script command-line internface.
    if [[ $# -le 1 ]];then
        /usr/bin/info --node="Top" --file=${MANUAL_BASEFILE}.info.bz2
        exit
    fi

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            --quiet )
                FLAG_QUIET="true"
                FLAG_DONT_COMMIT_CHANGES="true"
                shift 1
                ;;

            --answer-yes )
                FLAG_ANSWER="true"
                shift 1
                ;;

            --dont-commit-changes )
                FLAG_DONT_COMMIT_CHANGES="true"
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
    
            --update )
                ACTIONNAM="updateOutputFiles"
                shift 1
                ;;
    
            --read )
                ACTIONNAM="searchNode"
                shift 1
                ;;
            
            --backend )
                FLAG_BACKEND=$(cli_getRepoName ${2} -f)
                shift 2
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

    # Redefine name of function directory to point the module
    # specified by `--backend' option.
    FUNCDIRNAM="$(cli_getRepoName ${FUNCNAM} -d)/Backends/$(cli_getRepoName ${FLAG_BACKEND} -d)"

    # Redefine action name using function name.  From this point on,
    # control is given to modules. No function outside modules can be
    # loaded from now on. If you need to execute one, then you can't
    # use the FUNCNAM variable for that. Instead, use the full name of
    # the function (e.g., help_getEntry).
    ACTIONNAM="${FLAG_BACKEND}_${ACTIONNAM}"

    # Verify action name. It is required that the action name
    # specified does have a definition file. Otherwise it is a action
    # name valid, but not supported yet (e.g., it needs to be
    # written).
    if [[ ! -f ${FUNCDIR}/${FUNCDIRNAM}/${ACTIONNAM}.sh ]];then
        cli_printMessage "`gettext "The action provided is not supported yet."`" --as-error-line
    fi

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

}
