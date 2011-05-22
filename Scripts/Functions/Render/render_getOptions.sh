#!/bin/bash
#
# render_getOptions.sh -- This function interprets option parameters
# passed to `render' functionality and calls actions accordingly.
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

function render_getOptions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="filter:,quiet,answer-yes,dont-commit-changes,dont-dirspecific,releasever:,basearch:,post-rendition:,last-rendition:,theme-model:"

    # Redefine ARGUMENTS variable using getopt output.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do

        case "$1" in

            --filter )
                FLAG_FILTER="$2"
                shift 2
                ;;

            --quiet )
                FLAG_QUIET="true"
                FLAG_DONT_COMMIT_CHANGES="true"
                shift 1
                ;;

            --answer-yes )
                FLAG_ANSWER="true"
                shift 1
                ;;

            --dont-commit-changes )
                FLAG_DONT_COMMIT_CHANGES="true"
                shift 1
                ;;

            --dont-dirspecific )
                FLAG_DONT_DIRSPECIFIC="true"
                shift 1
                ;;

            --post-rendition )
                FLAG_POSTRENDITION="$2"
                shift 2
                ;;

            --last-rendition )
                FLAG_LASTRENDITION="$2"
                shift 2
                ;;

            --basearch )
                FLAG_BASEARCH="$2"
                if [[ ! $FLAG_BASEARCH =~ $(cli_getPathComponent --architecture-pattern) ]];then
                    cli_printMessage "`gettext "The architecture provided is not supported."`" --as-error-line
                fi
                shift 2
                ;;

            --releasever )
                FLAG_RELEASEVER="$2"
                if [[ ! $FLAG_RELEASEVER =~ $(cli_getPathComponent --release-pattern) ]];then
                    cli_printMessage "`gettext "The release version provided is not supported."`" --as-error-line
                fi
                shift 2
                ;;

            --theme-model )
                FLAG_THEME_MODEL=$(cli_getRepoName $2 -d)
                shift 2
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
