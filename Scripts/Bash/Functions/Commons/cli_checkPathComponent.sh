#!/bin/bash
#
# cli_checkPathComponent.sh -- This function checks parts/components
# from repository paths.
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

function cli_checkPathComponent {

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='release,architecture,motif,everything'

    # Initialize array variables used to process options.
    local -a CONDITION_PATTERN
    local -a CONDITION_MESSAGE

    # Initialize counter used to process array variables.
    local COUNTER=0

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope. Doing this is very important to
    # avoid any clash with higher execution environments.
    local ARGUMENTS=''

    # Prepare ARGUMENTS for getopt.
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS using getopt(1) command parser.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through positional parameters.
    while true; do

        case "$1" in

            --release )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="^.+/$(cli_getPathComponent --release-pattern)/.*$"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "contains an invalid release format."`"
                shift 1
                ;;

            --architecture )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="$(cli_getPathComponent --architecture-pattern)"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "contains an invalid architecture format."`" --as-error-line
                shift 1
                ;;

            --motif )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="$(cli_getPathComponent --motif-pattern)"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "contains an invalid theme format."`"
                shift 1
                ;;

            --everything )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="^[[:alnum:]/]+"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "contains an invalid format."`"
                shift 1
                ;;

            -- )
                shift 1
                break
                ;;

        esac
    done

    # Define list of files we want to apply verifications to, now that
    # all option-like arguments have been removed from positional
    # paramters list.
    local FILE=''
    local FILES="$@"

    for FILE in $FILES;do

        while [[ ${COUNTER} -lt ${#CONDITION_PATTERN[*]} ]];do

            if [[ ! ${FILE} =~ "${CONDITION_PATTERN[$COUNTER]}" ]];then
                cli_printMessage "${FILE} ${CONDITION_MESSAGE[$COUNTER]}" --as-error-line
            fi

            COUNTER=$(($COUNTER + 1))

        done

    done

}
