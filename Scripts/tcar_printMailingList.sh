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

# Standardize the way mailing list addresses are printed on content
# produced by tcar.sh script.
function tcar_printMailingList {

    local MAILADDRS=''

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='as-html-link:,docs'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope. Doing this is very important to
    # avoid any clash with higher execution environments.
    local TCAR_MODULE_ARGUMENT=''

    # Process all arguments currently available in this function
    # environment. If either ARGSS or ARGSL local variables have been
    # defined, argument processing goes through getopt for validation.
    tcar_setModuleArguments "${@}"

    # Redefine positional parameters using TCAR_MODULE_ARGUMENT variable.
    eval set -- "${TCAR_MODULE_ARGUMENT}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            --docs )
                MAILADDRS="${TCAR_BRAND}-docs@$(tcar_printUrl --domain)"
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
