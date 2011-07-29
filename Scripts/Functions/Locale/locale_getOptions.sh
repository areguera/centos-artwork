#!/bin/bash
#
# locale_getOptions.sh -- This function interprets option parameters
# passed to `locale' functionality and defines action names
# accordingly.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function locale_getOptions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="filter:,quiet,answer-yes,dont-commit-changes,update,edit,delete,dont-create-mo"

    # Parse arguments using getopt(1) command parser.
    cli_parseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
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

            --answer-yes )
                FLAG_ANSWER="true"
                shift 1
                ;;

            --dont-commit-changes )
                FLAG_DONT_COMMIT_CHANGES="true"
                shift 1
                ;;

            --update )
                ACTIONNAMS="$ACTIONNAMS ${CLI_FUNCNAME}_updateMessages"
                shift 1
                ;;

            --edit )
                ACTIONNAMS="$ACTIONNAMS ${CLI_FUNCNAME}_editMessages"
                shift 1
                ;;

            --delete )
                ACTIONNAMS="$ACTIONNAMS ${CLI_FUNCNAME}_deleteMessages"
                shift 1
                ;;

            --dont-create-mo )
                FLAG_DONT_CREATE_MO="true"
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

    # Verify action names. When no action name is specified, use
    # edition as default action name.
    if [[ $ACTIONNAMS == '' ]];then
        ACTIONNAMS="${CLI_FUNCNAME}_editMessages"
    fi

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

    # Verify non-option arguments passed to command-line. If there
    # isn't any, redefine the ARGUMENTS variable to use the current
    # location the functionality was called from.
    if [[ $ARGUMENTS == '' ]];then
        ARGUMENTS=${PWD}
    fi

}
