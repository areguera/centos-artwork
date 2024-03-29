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

# Initialize the command-line options used by locale module.
function locale_getOptions {

    # Define short options we want to support.
    local ARGSS="h::,v,f:,u,e,d,r"

    # Define long options we want to support.
    local ARGSL="help::,version,filter:,update,edit,delete,recursive"

    # Redefine arguments using getopt(1) command parser.
    tcar_setModuleArguments

    # Reset positional parameters on this function, using output
    # produced from (getopt) arguments parser.
    eval set -- "${TCAR_MODULE_ARGUMENT}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            -h | --help )
                tcar_printHelp "${2}"
                ;;

            -v | --version )
                tcar_printVersion "${TCAR_MODULE_NAME}"
                ;;

            -f | --filter )
                TCAR_FLAG_FILTER="${2:-${TCAR_FLAG_FILTER}}"
                shift 2
                ;;

            -u | --update )
                ACTIONS="${ACTIONS} update"
                shift 1
                ;;

            -e | --edit )
                ACTIONS="${ACTIONS} edit"
                shift 1
                ;;

            -d | --delete )
                ACTIONS="${ACTIONS} delete"
                shift 1
                ;;

            -r | --recursive )
                LOCALE_FLAG_RECURSIVE="true"
                shift 1
                ;;

            -- )
                shift 1
                break
                ;;
        esac
    done

    # Define default module actions.
    ACTIONS=${ACTIONS:-'update'}

    # Redefine arguments using current positional parameters. Only
    # paths should remain as arguments, at this point.
    TCAR_MODULE_ARGUMENT="${@}"

}
