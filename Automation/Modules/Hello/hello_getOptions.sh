#!/bin/bash
######################################################################
#
#   hello_getOptions.sh -- Interpret hello module's specific options.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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

function hello_getOptions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="help::,version,greeting:,lowercase,uppercase"

    # Redefine arguments using getopt(1) command parser.
    tcar_setModuleArguments

    # Reset positional parameters on this function, using output
    # produced from (getopt) arguments parser.
    eval set -- "${TCAR_MODULE_ARGUMENT}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            --help )
                tcar_printHelp "${2}"
                ;;

            --version )
                tcar_printVersion "${TCAR_MODULE_NAME}"
                ;;

            --greeting )
                HELLO_GREETING="${2:-${HELLO_GREETING}}"
                shift 2
                ;;

            --lowercase )
                HELLO_ACTIONS="lowercase ${HELLO_ACTIONS}"
                shift 1
                ;;

            --uppercase )
                HELLO_ACTIONS="uppercase ${HELLO_ACTIONS}"
                shift 1
                ;;

            -- )
                shift 1
                break
                ;;
        esac
    done

    # Define actions default value.
    HELLO_ACTIONS=${HELLO_ACTIONS:-default}

    # Redefine arguments using current positional parameters. Only
    # paths should remain as arguments, at this point.
    TCAR_MODULE_ARGUMENT="${@}"

}
