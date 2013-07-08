#!/bin/bash
#
# prepare_getOptions.sh -- This function parses command options
# provided to `centos-art.sh' script when the first argument in the
# command-line is the `prepare' word. To parse options, this function
# makes use of getopt program.
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

function prepare_getOptions {

    # Define short options we want to support.
    local ARGSS="h,q"

    # Define long options we want to support.
    local ARGSL="help,quiet,answer-yes,packages,locales,links,images,manuals,directories,set-environment,see-environment,synchronize"

    # Redefine CLI_FUNCTION_ARGUMENTS using getopt(1) command parser.
    cli_parseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$CLI_FUNCTION_ARGUMENTS"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            -h | --help )
                cli_runFnEnvironment help --read --format="texinfo" "tcar-fs::scripts:bash-functions-prepare"
                shift 1
                exit
                ;;

            -q | --quiet )
                FLAG_QUIET="true"
                shift 1
                ;;

            --answer-yes )
                FLAG_ANSWER="true"
                shift 1
                ;;

            --set-environment )
                ACTIONNAMS="${ACTIONNAMS} prepare_updateEnvironment"
                shift 1
                ;;

            --see-environment )
                ACTIONNAMS="${ACTIONNAMS} prepare_seeEnvironment"
                shift 1
                ;;

            --packages )
                ACTIONNAMS="${ACTIONNAMS} prepare_updatePackages"
                shift 1
                ;;

            --locales )
                ACTIONNAMS="${ACTIONNAMS} prepare_updateLocales"
                shift 1
                ;;

            --links )
                ACTIONNAMS="${ACTIONNAMS} prepare_updateLinks"
                shift 1
                ;;

            --images )
                ACTIONNAMS="${ACTIONNAMS} prepare_updateImages"
                shift 1
                ;;

            --manuals )
                ACTIONNAMS="${ACTIONNAMS} prepare_updateManuals"
                shift 1
                ;;

            --directories )
                ACTIONNAMS="${ACTIONNAMS} prepare_updateDirectoryStructure"
                shift 1
                ;;

            --synchronize )
                FLAG_SYNCHRONIZE="true"
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

    # Redefine CLI_FUNCTION_ARGUMENTS variable using current
    # positional parameters. 
    cli_parseArgumentsReDef "$@"

}
