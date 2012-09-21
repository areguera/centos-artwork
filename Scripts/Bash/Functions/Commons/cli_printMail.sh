#!/bin/bash
#
# cli_printMail.sh -- This function standardize the way MAILADDRSs are
# printed inside centos-art.sh script. This function describes the
# domain organization of The CentOS Project through its MAILADDRSs and
# provides a way to print them out when needed.
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

function cli_printMail {

    local MAILADDRS=''

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='as-html-link:,docs'

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

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            --docs )
                MAILADDRS="${TCAR_BRAND}-docs@$(cli_printUrl --domain)"
                ;;

            --as-html-link )
                MAILADDRS="<a href=\"mailto:${2}\">${2}</a>"
                shift 2
                ;;

            -- )

                shift 1
                break
                ;;
        esac
    done

    # Print mail address.
    echo "$MAILADDRS"

}
