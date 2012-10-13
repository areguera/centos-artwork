#!/bin/bash
#
# prepare_getOptions.sh -- This function parses command options
# provided to `centos-art.sh' script when the first argument in the
# command-line is the `prepare' word. To parse options, this function
# makes use of getopt program.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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
    local ARGSS="q,h"

    # Define long options we want to support.
    local ARGSL="quiet,help,answer-yes,packages,locales,links,images,manuals,set-environment,see-environment,sync-changes"

    # Redefine ARGUMENTS using getopt(1) command parser.
    cli_parseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            -h | --help )
                cli_runFunEnvironment help --read --format="texinfo" trunk/Scripts/Bash/Functions/Prepare
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

            --sync-changes )
                FLAG_SYNC_CHANGES="true"
                shift 1
                ;;

            * )
                break
        esac
    done

}
