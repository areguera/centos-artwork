#!/bin/bash
######################################################################
#
#   render_getOptions.sh -- This function interprets option arguments
#   passed to `render' module and calls actions accordingly.
#
#   Written by:
#   * Alain Reguera Delagdo <al@centos.org.cu>, 2009-2013
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

function render_getOptions {

    # Define short options we want to support.
    local ARGSS="h::,v,f:"

    # Define long options we want to support.
    local ARGSL="help::,version,filter:"

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

            -- )
                # Remove the `--' argument from the list of arguments
                # in order for processing non-option arguments
                # correctly. At this point all option arguments have
                # been processed already but the `--' argument still
                # remains to mark ending of option arguments and
                # beginning of non-option arguments. The `--' argument
                # needs to be removed here in order to avoid
                # centos-art.sh script to process it as a path inside
                # the repository, which obviously is not.
                shift 1
                break
                ;;
        esac
    done

    # Redefine arguments using current positional parameters. Only
    # paths should remain as arguments, at this point.
    TCAR_MODULE_ARGUMENT="${@}"

}
