#!/bin/bash
#
# svn_getOptions.sh -- This function interprets option parameters
# passed to `svn' functionality and calls actions accordingly.
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

function svn_getOptions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="sync,update,commit,is-versioned,commit-changes,get-status"

    # Redefine ARGUMENTS using getopt(1) command parser.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do

        case "$1" in

            --sync )
                ACTIONNAMS="${ACTIONNAMS} svn_syncroRepoChanges"
                shift 1
                ;;

            --commit )
                ACTIONNAMS="${ACTIONNAMS} svn_commitRepoChanges"
                shift 1
                ;;

            --update )
                ACTIONNAMS="${ACTIONNAMS} svn_updateRepoChanges"
                shift 1
                ;;

            --is-versioned )
                ACTIONNAMS="${ACTIONNAMS} svn_isVersioned"
                shift 1
                ;;

            --get-status )
                ACTIONNAMS="${ACTIONNAMS} svn_getRepoStatus"
                shift 1
                ;;

            --commit-changes )
                FLAG_COMMIT_CHANGES="true"
                shift 1
                ;;


            -- )
                # Remove the `--' argument from the list of arguments
                # in order for processing non-option arguments
                # correctly. At this point all option arguments have
                # been processed already but the `--' argument still
                # remains to mark ending of option arguments and
                # begining of non-option arguments. The `--' argument
                # needs to be removed here in order to avoid
                # centos-art.sh script to process it as a path inside
                # the repository, which obviously is not.
                shift 1
                break
                ;;
        esac
    done

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_parseArgumentsReDef "$@"

}
