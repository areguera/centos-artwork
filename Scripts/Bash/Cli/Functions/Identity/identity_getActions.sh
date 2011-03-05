#!/bin/bash
#
# identity_getActions.sh -- This function interprets arguments passed to
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

function identity_getActions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="render:,release:,architecture:,copy:,to:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do

        case "$1" in

            --render )

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_render"

                # Redefine action value.
                ACTIONVAL="$2"

                # Rotate positional parameters
                shift 2
                ;;

            --copy )
            
                # Redefine action value variable.
                ACTIONVAL="$2"

                # Redefine action name variable.
                ACTIONNAM="${FUNCNAME}_doCopy"

                # Rotate positional parameters
                shift 2
                ;;

            --release )
            
                # Redefine release number flag.
                FLAG_RELEASE="$2"

                # Verify release number flag.
                if [[ ! $FLAG_RELEASE =~ $(cli_getPathComponent '--release-pattern') ]];then
                    cli_printMessage "`gettext "The release number provided is not supported."`" 'AsErrorLine'
                    cli_printMessage "$(caller)" 'AsToKnowMoreLine'
                fi

                # Rotate positional parameters
                shift 2
                ;;

            --architecture )
            
                # Redefine architecture flag.
                FLAG_ARCHITECTURE="$2"

                # Verify architecture flag.
                if [[ ! $FLAG_ARCHITECTURE =~ $(cli_getPathComponent '--architecture-pattern') ]];then
                    cli_printMessage "`gettext "The architecture provided is not supported."`" 'AsErrorLine'
                    cli_printMessage "$(caller)" 'AsToKnowMoreLine'
                fi

                # Rotate positional parameters
                shift 2
                ;;

            --to )
            
                # Redefine target value flag.
                FLAG_TO="$2"

                # Rotate positional parameters
                shift 2
                ;;

            * )
                # Break options loop.
                break
        esac
    done

    # Check action value. Be sure the action value matches the
    # convenctions defined for source locations inside the working
    # copy.
    cli_checkRepoDirSource

    # Define pre-rendition configuration directory. Pre-rendition
    # configuration directory is where we store render.conf.sh
    # scripts. The render.conf.sh script defines how each identity
    # content is rendered.
    local ARTCONF=$(echo "$ACTIONVAL" \
        | sed -r -e 's!/(Identity)!/Scripts/Bash/Cli/Functions/Identity/Config/\1!' \
                 -e "s!/Motifs/$(cli_getPathComponent '--theme')!!" )

    # Check directory of pre-rendition configuration script.
    cli_checkFiles "$ARTCONF" 'd'

    # Syncronize changes between the working copy and the central
    # repository to bring down changes.
    cli_syncroRepoChanges

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Syncronize changes between the working copy and the central
    # repository to commit up changes.
    cli_commitRepoChanges

}
