#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Standardize the way list of files are built inside tcar.sh script.
# This function outputs a sorted and unique list of files based on the
# options and locations passed as argument.
function tcar_getFilesList {

    # Initialize pattern used to reduce the find output.
    local PATTERN="${TCAR_FLAG_FILTER}"

    # Initialize options used with find command.
    local OPTIONS=''

    OPTIND=1
    while getopts "p:,a:,i:,t:,u:" OPTION "${@}"; do

        case "${OPTION}" in
            p )
                PATTERN="${OPTARG}"
                ;;
            a )
                OPTIONS="${OPTIONS} -maxdepth ${OPTARG}"
                ;;
            i )
                OPTIONS="${OPTIONS} -mindepth ${OPTARG}"
                ;;
            t )
                OPTIONS="${OPTIONS} -type ${OPTARG}"
                ;;
            u )
                OPTIONS="${OPTIONS} -uid ${OPTARG}"
                ;;
        esac

    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( ${OPTIND} - 1 ))

    # At this point all options arguments have been processed and
    # removed from positional parameters. Only non-option arguments
    # remain so we use them as source location for find command to
    # look files for.

    # Verify that locations does exist.
    tcar_checkFiles -e ${@}

    # Redefine pattern as regular expression. When we use regular
    # expressions with find, regular expressions are evaluated against
    # the whole file path.  This way, when the regular expression is
    # specified, we need to build it in a way that matches the whole
    # path we are using. Doing so, every time we pass the `--filter'
    # option in the command-line could be a tedious task.  Instead, in
    # the sake of reducing some typing, we prepare the regular
    # expression here to match the whole path using the regular
    # expression provided by the user as pattern. Do not use locations
    # as part of regular expression so it could be possible to use
    # path expansion.  Using path expansion reduce the amount of
    # places to find out things and so the time required to finish the
    # task.
    #
    # Don't do such path expansion here. Instead, do it when you call
    # this function. Otherwise you would be prohibiting the
    # application of exact patterns. 
    #PATTERN="^/.*${PATTERN}$"

    # Define list of files to process. At this point we cannot verify
    # whether the location is a directory or a file since path
    # expansion could be introduced to it. The best we can do is
    # verifying exit status and go on.
    find ${@} -regextype posix-egrep ${OPTIONS} -regex "${PATTERN}" | sort | uniq

}
