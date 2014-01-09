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

# Interpret module-specific options for hello.
function hello_getOptions {

    # Define short options we want to support.
    local ARGSS="h::,v,g:,l,u,c,r"

    # Define long options we want to support.
    local ARGSL="help::,version,greeting:,lower,upper,camel,random"

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

            -g | --greeting )
                HELLO_WORLD="${2:-${HELLO_WORLD}}"
                shift 2
                ;;

            -l | --lower )
                ACTIONS="lower ${ACTIONS}"
                shift 1
                ;;

            -u | --upper )
                ACTIONS="upper ${ACTIONS}"
                shift 1
                ;;

            -c | --camel )
                ACTIONS="camel ${ACTIONS}"
                shift 1
                ;;

            -r | --random )
                ACTIONS="random ${ACTIONS}"
                shift 1
                ;;

            -- )
                shift 1
                break
                ;;
        esac
    done

    # Redefine arguments using current positional parameters. Only
    # paths should remain as arguments, at this point.
    TCAR_MODULE_ARGUMENT="${@}"

}
