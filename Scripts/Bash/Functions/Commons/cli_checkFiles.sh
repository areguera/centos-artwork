#!/bin/bash
#
# cli_checkFiles.sh -- This function standardizes the way file
# conditional expressions are applied inside centos-art.sh script.
# Here is where we answer questions like: is the file a regular file
# or a directory?  or, is it a symbolic link? or even, does it have
# execution rights, etc.  If the verification fails somehow at any
# point, an error message is output and centos-art.sh script ends its
# execution. 
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

function cli_checkFiles {

    # Define short options.
    local ARGSS='d,e,f,h,x'

    # Define long options.
    local ARGSL=''

    # Initialize array variables.
    local -a CONDITION_PATTERN
    local -a CONDITION_MESSAGE

    # Initialize array variable counter.
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

            -d )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-d'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a directory."`"
                shift 1
                ;;

            -e )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-e'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "doesn't exist."`"
                ;;

            -f )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-f'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a regular file."`"
                shift 1
                ;;

            -h )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-h'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a symbolic link."`"
                shift 1
                ;;

            -x )
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-x'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't an executable file."`"
                shift 1
                ;;

            -- )
                shift 1
                break
                ;;

        esac
    done

    # FIXME: Find a way to be sure that file is inside the working
    # copy and under version control too. All the files we use to
    # produce content (i.e., svg, docbook, texinfo, etc.) must be
    # under version control and inside the working copy.  Note also
    # that we uso temporal files which aren't inside the working copy
    # nor under version control. So a way to verify different types of
    # files based on context must be available.
    #
    # For example: It would be useful to have an option to standardize
    # questions like "Is this file under version control?" or "Is this
    # file under the working copy directory structure?".

    # Define list of files we want to apply verifications to, now that
    # all option-like arguments have been removed from positional
    # paramters list.
    local FILE=''
    local FILES=$@

    for FILE in $FILES;do

        while [[ ${COUNTER} -lt ${#CONDITION_PATTERN[*]} ]];do

            test ! "${CONDITION_PATTERN[$COUNTER]} ${FILE}" \
                && cli_printMessage "${FILE} ${CONDITION_MESSAGE[$COUNTER]}" --as-error-line

            COUNTER=$(($COUNTER + 1))

        done

    done

}
