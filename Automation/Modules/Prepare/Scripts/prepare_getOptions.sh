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

function prepare_getOptions {

    # Define short options we want to support.
    local ARGSS="h,v,q"

    # Define long options we want to support.
    local ARGSL="help,version,quiet,yes,packages,links,images,manuals,all,directories,synchronize"

    # Define module arguments local to this function. This is very
    # important in order to provide option parsing for different
    # function environment levels.
    local TCAR_ARGUMENTS=''

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
                ;;

            -v | --version )
                tcar_printVersion
                ;;

            -q | --quiet )
                TCAR_FLAG_QUIET="true"
                shift 1
                ;;

            --yes )
                TCAR_FLAG_YES="true"
                shift 1
                ;;

            --packages )
                MODULE_ACTIONS="${MODULE_ACTIONS} prepare_setPackages"
                shift 1
                ;;

            --images )
                MODULE_ACTIONS="${MODULE_ACTIONS} prepare_setImages"
                shift 1
                ;;

            --manuals )
                MODULE_ACTIONS="${MODULE_ACTIONS} prepare_setManuals"
                shift 1
                ;;

            --links )
                MODULE_ACTIONS="${MODULE_ACTIONS} prepare_setLinks"
                shift 1
                ;;

            --all )
                MODULE_ACTIONS="prepare_setPackages prepare_setImages
                    prepare_setManuals prepare_setLinks"
                shift 1
                ;;

            --directories )
                MODULE_ACTIONS="${MODULE_ACTIONS} prepare_updateDirectoryStructure"
                shift 1
                ;;

            --synchronize )
                TCAR_FLAG_SYNCHRONIZE="true"
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

}
