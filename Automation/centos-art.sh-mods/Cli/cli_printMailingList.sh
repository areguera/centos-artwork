#!/bin/bash
######################################################################
#
#   cli_printMailingList.sh -- This function standardizes the way
#   mailing list addresses are printed on content produced by
#   centos-art.sh script.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
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
######################################################################

function cli_printMailingList {

    local MAILADDRS=''

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='as-html-link:,docs'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope. Doing this is very important to
    # avoid any clash with higher execution environments.
    local CLI_FUNCTION_ARGUMENTS=''

    # Process all arguments currently available in this function
    # environment. If either ARGSS or ARGSL local variables have been
    # defined, argument processing goes through getopt for validation.
    cli_setArguments "${@}"

    # Redefine positional parameters using CLI_FUNCTION_ARGUMENTS variable.
    eval set -- "${CLI_FUNCTION_ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            --docs )
                MAILADDRS="${TCAR_BRAND}-docs@$(cli_printUrl --domain)"
                shift 1
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
    echo "${MAILADDRS}"

}
