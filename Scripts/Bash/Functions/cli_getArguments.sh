#!/bin/bash
#
# cli_getArguments.sh -- This function initializes the action
# name and value used by functionalities to perform their goals.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_getArguments {

    # Set command-line arguments for processing using positional
    # parameters variables.
    eval set -- "$ARGUMENTS"

    # Define function name (FUNCNAM) variable from first command-line
    # argument.  As convenction we use the first argument to determine
    # the exact name of functionality to call. Later we use action
    # name (ACTIONNAM) and action value (ACTIONVAL) to know, inside
    # functionality defined by FUNCNAME, the exact action to perform.
    FUNCNAM=$(cli_getRepoName "$1" 'f')

    # Define action name (ACTIONNAM) and action value (ACTIONVAL)
    # variables passed as second argument to the command line
    # interface when the format is `--option=value' without the value
    # # part.
    if [[ "$2" =~ '^--[a-z-]+=.+$' ]];then

        # Define action name passed in the second argument.
        ACTIONNAM=$(echo "$2" | cut -d = -f1)

        # Define action value passed in the second argument. 
        ACTIONVAL=$(echo "$2" | cut -d = -f2-)

    # Define action name (ACTIONNAM), and action value (ACTIONVAL)
    # variables passed as second argument to the command line
    # interface when the format is `--option' without the value part.
    elif [[ "$2" =~ '^--[a-z-]+=?$' ]];then

        # Define action name passed in the second argument.
        ACTIONNAM=$(echo "$2" | cut -d = -f1)

        # Define action value passed in the second argument.  There is
        # no action value (ACTIONVAL) entered from command-line here.
        # To find out which action value to use, check current working
        # directory, and if inside the repository, use current working
        # directory as ACTIONVAL default value.
        if [[ $(pwd) =~ '^/home/centos/artwork' ]];then
            ACTIONVAL=$(pwd)
        fi

    # Define default action when second argument is wrongly specified,
    # or not specified at all.
    else
        cli_printMessage "`gettext "Missing arguments."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Check action value passed in the second argument.
    cli_checkActionArguments

    # Remove the first and second arguments passed to centos-art.sh
    # command-line in order to build optional arguments, they are
    # already set in FUNCNAM, ACTIONNAM, and ACTIONVAL variables, so
    # we remove it from command-line arguments in order for getopt to
    # interpret it not.  Now, what was preivously set on $2 is now at
    # $1, what was previously set on $3 is now set at $2, and so on.
    shift 2

    # Redefine positional parameters stored inside ARGUMENTS variable.
    cli_doParseArgumentsReDef "$@"

}
