#!/bin/bash
#
# prepare_getOptions.sh -- This function parses command options
# provided to `centos-art.sh' script when the first argument in the
# command-line is the `prepare' word. To parse options, this function
# makes use of getopt program.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="quiet,answer-yes,packages,links,images,manuals,environment"

    # Parse arguments using getopt(1) command parser.
    cli_parseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do
        case "$1" in

            --quiet )
                FLAG_QUIET="true"
                FLAG_DONT_COMMIT_CHANGES="true"
                shift 1
                ;;

            --answer-yes )
                FLAG_ANSWER="true"
                shift 1
                ;;

            --packages )
                ACTIONNAMS="${ACTIONNAMS} prepare_updatePackages"
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

            --environment )
                ACTIONNAMS="${ACTIONNAMS} prepare_getEnvars"
                shift 1
                ;;

            * )
                break
        esac
    done

}
