#!/bin/bash
#
# cli_getPathComponent.sh -- This function outputs different parts
# from path string. By default the full release information is output.
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

function cli_getPathComponent {

    local -a PATTERN
    local RELEASE=''

    # Define release pattern.
    PATTERN[0]="(([[:digit:]]+)(\.([[:digit:]]+)){,1})"

    # Define architecture pattern.
    PATTERN[1]='(i386|x86_64)'

    # Identify which part of the release we want to output.
    case "$2" in

        '--arch' )
            RELEASE=$(echo "$1" | sed -r "s!.+/${PATTERN[0]}/${PATTERN[1]}/.+!\5!")
            ;;

        '--major-release' )
            RELEASE=$(echo "$1" | sed -r "s!.+/${PATTERN[0]}/.+!\2!")
            ;;

        '--minor-release' )
            RELEASE=$(echo "$1" | sed -r "s!.+/${PATTERN[0]}/.+!\4!")
            ;;

        '--verify-release' )
            # Verify release value against release pattern.
            if [[ ! $RELEASE =~ "^${PATTERN}$" ]];then
                cli_printMessage "`gettext "The release number \\\`\\\$RELEASE' is not valid."`" 'AsErrorLine'
                cli_printMessage "$(caller)" 'AsToKnowMoreLine'
            fi
            ;;

        '--release-pattern' )
            RELEASE=$(echo ${PATTERN[0]})
            ;;

        '--arch-pattern' )
            RELEASE=$(echo ${PATTERN[1]})
            ;;

        '--full-release' | * )
            # Define absolute path from which relase information is retrived.
            # As convenction, we use the first coincidence that match release
            # pattern.
            RELEASE=$(echo "$1" | sed -r "s!.+/${PATTERN[0]}/.+!\1!" )
            ;;
    esac

    # If no release information is found in the provided absolute
    # path, use zero as default release information.
    if [[ ! "$RELEASE" =~ "$PATTERN" ]];then
        RELEASE='0'
    fi

    # Output release information.
    echo "$RELEASE"

}
