#!/bin/bash
#
# render_getArguments.sh -- This function interprets arguments passed to
# render functionality and calls actions accordingly.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function render_getArguments {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="render:,releasever:,basearch:,copy:,to:,convert-to:,group-by:,theme-model:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do

        case "$1" in

            --releasever )
                FLAG_RELEASE="$2"
                if [[ ! $FLAG_RELEASE =~ $(cli_getPathComponent '--release-pattern') ]];then
                    cli_printMessage "`gettext "The release version provided is not supported."`" 'AsErrorLine'
                    cli_printMessage "$(caller)" 'AsToKnowMoreLine'
                fi
                shift 2
                ;;

            --basearch )
                FLAG_ARCHITECTURE="$2"
                if [[ ! $FLAG_ARCHITECTURE =~ $(cli_getPathComponent '--architecture-pattern') ]];then
                    cli_printMessage "`gettext "The architecture provided is not supported."`" 'AsErrorLine'
                    cli_printMessage "$(caller)" 'AsToKnowMoreLine'
                fi
                shift 2
                ;;

            --to )
                FLAG_TO="$2"
                shift 2
                ;;

            --convert-to )
                FLAG_CONVERT_TO="$2"
                shift 2
                ;;

            --group-by )
                FLAG_GROUPED_BY="$2"
                shift 2
                ;;

            --theme-model )
                FLAG_THEME_MODEL=$(cli_getRepoName "$2" 'd')
                shift 2
                ;;

            * )
                # Break options loop.
                break
        esac
    done

    # Read remaining arguments and build the action value from them.
    # At this point all options should be processed.
    for ACTIONVAL in "$@";do
        
        if [[ $ACTIONVAL == '--' ]];then
            continue
        fi

        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        cli_checkRepoDirSource

        # Syncronize changes between the working copy and the central
        # repository to bring down changes.
        cli_syncroRepoChanges

        # Execute base-rendition flow.
        eval ${FUNCNAM}_doBaseActions

        # Syncronize changes between the working copy and the central
        # repository to commit up changes.
        cli_commitRepoChanges

    done

}
