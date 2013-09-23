#!/bin/bash
######################################################################
#
#   prepare_getOptions.sh -- This function parses options passed to
#   `centos-art.sh' script command-line, when the first argument is
#   the `prepare' word. To parse options, this function makes use of
#   getopt program.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
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

function prepare_getOptions {

    # Define short options we want to support.
    local ARGSS="h,v"

    # Define long options we want to support.
    local ARGSL="help,version,packages,locales,links,documents,images"

    # Redefine arguments using getopt(1) command parser.
    tcar_setArguments "${@}"

    # Reset positional parameters on this function, using output
    # produced from (getopt) arguments parser.
    eval set -- "${TCAR_ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            -h | --help )
                tcar_printHelp
                ;;

            -v | --version )
                tcar_printVersion
                ;;

            --packages )
                SUBMODULES="${SUBMODULES} packages"
                shift 1
                ;;

            --locales )
                SUBMODULES="${SUBMODULES} locales"
                shift 1
                ;;

            --links )
                SUBMODULES="${SUBMODULES} links"
                shift 1
                ;;

            --documents )
                SUBMODULES="${SUBMODULES} documents"
                shift 1
                ;;

            --images )
                SUBMODULES="${SUBMODULES} images"
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
    TCAR_ARGUMENTS="${@}"

}
