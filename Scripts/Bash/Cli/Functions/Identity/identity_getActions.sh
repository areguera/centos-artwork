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

    # Initialize actions array variable, the place used to
    # to store post-rendition and last-rendition action definitions
    # retrived from command-line interface.
    local -a ACTIONS

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="render:,release:,architecture:,copy:,to:,syslinux,grub,gdm,kdm,ksplash,format:,group-by-type:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do

        case "$1" in

            --render )
                ACTIONNAM="${FUNCNAM}_render"
                ACTIONVAL="$2"
                shift 2
                ;;

            --copy )
                ACTIONVAL="$2"
                ACTIONNAM="${FUNCNAME}_doCopy"
                shift 2
                ;;

            --release )
                FLAG_RELEASE="$2"
                if [[ ! $FLAG_RELEASE =~ $(cli_getPathComponent '--release-pattern') ]];then
                    cli_printMessage "`gettext "The release number provided is not supported."`" 'AsErrorLine'
                    cli_printMessage "$(caller)" 'AsToKnowMoreLine'
                fi
                shift 2
                ;;

            --architecture )
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

            --syslinux )
                ACTIONS[$((${#ACTIONS[*]} + 1))]='POST:renderSyslinux:'
                ACTIONS[$((${#ACTIONS[*]} + 1))]='POST:renderSyslinux:-floyd'
                shift 1
                ;;

            --grub )
                ACTIONS[$((${#ACTIONS[*]} + 1))]='POST:renderGrub:'
                ACTIONS[$((${#ACTIONS[*]} + 1))]='POST:renderGrub:-floyd'
                shift 1
                ;;

            --ksplash )
                ACTIONS[$((${#ACTIONS[*]} + 1))]='LAST:renderKsplash'
                shift 1
                ;;

            --gdm )
                ACTIONS[$((${#ACTIONS[*]} + 1))]='LAST:renderDm:Gdm:800x600 1024x768 1280x1024 1360x768 1680x1050 2048x1536 2560x960 2560x1240 3271x1227'
                shift 1
                ;;

            --kdm )
                ACTIONS[$((${#ACTIONS[*]} + 1))]='LAST:renderDm:Kdm:800x600 1024x768 1280x1024 1360x768 1680x1050 2048x1536 2560x960 2560x1240 3271x1227'
                shift 1
                ;;

            --group-by-type )
                ACTIONS[$((${#ACTIONS[*]} + 1))]="POST:groupByType:$2"
                shift 2
                ;;

            --format )
                ACTIONS[$((${#ACTIONS[*]} + 1))]="POST:renderFormats:$2"
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
