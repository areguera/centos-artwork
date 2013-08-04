#!/bin/bash
#
# locale_getOptions.sh -- This function interprets option parameters
# passed to `locale' functionality and defines action names
# accordingly.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function locale_getOptions {

    # Define short options we want to support.
    local ARGSS="h"

    # Define long options we want to support.
    local ARGSL="help,filter:,update,edit,delete"

    # Redefine arguments using getopt(1) command parser.
    tcar_setArguments "${@}"

    # Reset positional parameters on this function, using output
    # produced from (getopt) arguments parser.
    eval set -- "${TCAR_ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            -h | --help )
                tcar_printHelp
                exit
                ;;

            --filter )
                TCAR_FLAG_FILTER="$2"
                shift 2
                ;;

            --update )
                LOCALE_ACTIONS="$LOCALE_ACTIONS update"
                shift 1
                ;;

            --edit )
                LOCALE_ACTIONS="$LOCALE_ACTIONS edit"
                shift 1
                ;;

            --delete )
                LOCALE_ACTIONS="$LOCALE_ACTIONS delete"
                shift 1
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

    if [[ -z ${LOCALE_ACTIONS} ]];then
        LOCALE_ACTIONS='update'
    fi

    # Redefine arguments using current positional parameters. Only
    # paths should remain as arguments, at this point.
    TCAR_ARGUMENTS="${@}"

}
