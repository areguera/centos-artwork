#!/bin/bash
#
# cli_getRepoTLDir.sh -- This function returns the repository top
# level absolute path. The repository top level absolute path can be
# either ${HOME}/artwork/trunk, ${HOME}/artwork/branches, or
# ${HOME}/artwork/tags.
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

function cli_getRepoTLDir {

    # Define short options.
    local ARGSS='r'

    # Define long options.
    local ARGSL='relative'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Initialize path pattern and replacement.
    local PATTERN=''
    local REPLACE=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Define the location we want to apply verifications to.
    local LOCATION=$(echo $@ | sed -r 's!^.*--[[:space:]](.+)$!\1!')

    # Verify location passed as non-option argument. If no location is
    # passed as non-option argument to this function, then set the
    # trunk directory structure as default location.
    if [[ $LOCATION =~ '--$' ]];then
        LOCATION=${HOME}/artwork/trunk
    fi

    # Verify location where the working copy should be stored in the
    # workstations. Whatever the location provided be, it should refer
    # to one of the top level directories inside the working copy of
    # CentOS Artwork Repository which, in turn, should be sotred in
    # the `artwork' directory immediatly under your home directory.
    if [[ ! $LOCATION =~ "^${HOME}/artwork/(trunk|branches|tags)" ]];then
        cli_printMessage "`eval_gettext "The location \\\"\\\$LOCATION\\\" is not valid."`" --as-error-line
    fi

    # Look for options passed through positional parameters.
    while true;do

        case "$1" in
    
            -r|--relative )
                PATTERN="^${HOME}/artwork/(trunk|branches|tags)/.+$"
                REPLACE='\1'
                shift 2
                break
                ;;

            -- )
                PATTERN="^(${HOME}/artwork/(trunk|branches|tags))/.+$"
                REPLACE='\1'
                shift 1
                break
                ;;
        esac

    done

    # Print out top level directory.
    echo $LOCATION | sed -r "s!${PATTERN}!${REPLACE}!g"

}
