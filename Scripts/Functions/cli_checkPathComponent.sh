#!/bin/bash
#
# cli_checkPathComponent.sh -- This function checks parts/components
# from repository paths.
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

function cli_checkPathComponent {

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='release,architecture,theme'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Initialize file variable as local to avoid conflicts outside
    # this function scope. In the file variable will set the file path
    # we are going to verify.
    local FILE=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_doParseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Define list of locations we want to apply verifications to.
    local FILES=$(echo $@ | sed -r 's!^.*--[[:space:]](.+)$!\1!')

    # Verify list of locations, it is required that one location be
    # present in the list and also be a valid file.
    if [[ $FILES == '--' ]];then
        cli_printMessage "You need to provide one file at least." --as-error-line 
    fi

    # Look for options passed through positional parameters.
    while true; do

        case "$1" in

            --release )
                for FILE in $(echo $FILES);do
                    if [[ ! $FILE =~ "^.+/$(cli_getPathComponent --release-pattern)/.*$" ]];then
                        cli_printMessage "`eval_gettext "The release \\\"\\\$FILE\\\" is not valid."`" --as-error-line
                    fi
                done
                shift 2
                break
                ;;

            --architecture )
                for FILE in $(echo $FILES);do
                    if [[ ! $FILE =~ $(cli_getPathComponent --architecture-pattern) ]];then
                        cli_printMessage "`eval_gettext "The architecture \\\"\\\$FILE\\\" is not valid."`" --as-error-line
                    fi
                done
                shift 2
                break
                ;;

            --theme )
                for FILE in $(echo $FILES);do
                    if [[ ! $FILE =~ $(cli_getPathComponent --theme-pattern) ]];then
                        cli_printMessage "`eval_gettext "The theme \\\"\\\$FILE\\\" is not valid."`" --as-error-line
                    fi
                done
                shift 2
                break
                ;;

            -- )
                for FILE in $(echo $FILES);do
                    if [[ $FILE == '' ]] \
                        || [[ $FILE =~ '(\.\.(/)?)' ]] \
                        || [[ ! $FILE =~ '^[A-Za-z0-9\.:/_-]+$' ]]; then 
                        cli_printMessage "`eval_gettext "The value \\\"\\\$FILE\\\" is not valid."`" --as-error-line
                    fi
                done
                shift 2
                break
                ;;

        esac
    done

}
