#!/bin/bash
#
# cli_getFilesList.sh -- This function standardizes the way list of
# files are built inside centos-art.sh script. This function outputs a
# sorted and unique list of files based on the options and locations
# passed as argument.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function cli_getFilesList {

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='pattern:,mindepth:,maxdepth:,type:,uid:'

    # Initialize pattern used to reduce the find output.
    local PATTERN="$FLAG_FILTER"

    # Initialize options used with find command.
    local OPTIONS=''

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

    while true;do
        case "$1" in

            --pattern )
                PATTERN="$2"
                shift 2
                ;;

            --maxdepth )
                OPTIONS="$OPTIONS -maxdepth $2"
                shift 2
                ;;

            --mindepth )
                OPTIONS="$OPTIONS -mindepth $2"
                shift 2
                ;;

            --type )
                OPTIONS="$OPTIONS -type $2"
                shift 2
                ;;

            --uid )
                OPTIONS="$OPTIONS -uid $2"
                shift 2
                ;;

            -- )
                shift 1
                break
                ;;
        esac
    done

    # At this point all options arguments have been processed and
    # removed from positional parameters. Only non-option arguments
    # remain so we use them as source location for find command to
    # look files for.
    local LOCATIONS=$@

    # Verify that locations does exist.
    cli_checkFiles -e ${LOCATIONS}

    # Redefine pattern as regular expression. When we use regular
    # expressions with find, regular expressions are evaluated against
    # the whole file path.  This way, when the regular expression is
    # specified, we need to build it in a way that matches the whole
    # path we are using. Doing so, every time we pass the `--filter'
    # option in the command-line could be a tedious task.  Instead, in
    # the sake of reducing some typing, we prepare the regular
    # expression here to match the whole path using the regular
    # expression provided by the user as pattern. Do not use LOCATION
    # variable as part of regular expression so it could be possible
    # to use path expansion.  Using path expansion reduce the amount
    # of places to find out things and so the time required to finish
    # the task.
    #
    # Don't do such path expansion here. Instead, do it when you call
    # this function. Otherwise you would be prohibiting the
    # application of exact patterns. 
    #PATTERN="^/.*${PATTERN}$"

    # Define list of files to process. At this point we cannot verify
    # whether the LOCATION is a directory or a file since path
    # expansion could be introduced to it. The best we can do is
    # verifying exit status and go on.
    find ${LOCATIONS} -regextype posix-egrep ${OPTIONS} -regex "${PATTERN}" | sort | uniq

}
