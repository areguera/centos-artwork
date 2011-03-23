#!/bin/bash
#
# cli_checkPathComponent.sh -- This function checks parts/components
# from repository paths. Generally, the path information is passed to
# the function's first positional argument and the part/component we
# want to check is passed to the function's second positional
# argument. If the second argument is not passed, then the first
# argument is assumed to be the part/component we want to check, and
# the action value (ACTIONVAL) variable is used instead as source path
# information.
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

function cli_checkPathComponent {

    local -a PATTERNS
    local LOCATION=''
    local OPTION=''
    local MESSAGE=''

    # Define location which we retrive information from.
    if [[ "$#" -eq 1 ]];then
        LOCATION="$ACTIONVAL"
        OPTION="$1"
    elif [[ "$#" -eq 2 ]];then
        LOCATION="$1"
        OPTION="$2"
    else
       cli_printMessage "${FUNCNAME}: `gettext "Invalid arguments."`" 'AsErrorLine'
       cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine' 
    fi

    # Define patterns.
    PATTERNS[0]="^.+/$(cli_getPathComponent "${LOCATION}" '--release-pattern')/.*$"
    PATTERNS[1]=$(cli_getPathComponent "${LOCATION}" '--release-architecture')
    PATTERNS[2]=$(cli_getPathComponent "${LOCATION}" '--release-theme')

    # Identify which part of the release we want to output.
    case "$OPTION" in

        '--release' )
            if [[ $LOCATION =~ ${PATTERN[0]} ]];then
                MESSAGE="`eval_gettext "The release \\\`\\\$LOCATION' is not valid."`"
            fi
            ;;

        '--architecture' )
            if [[ $LOCATION =~ ${PATTERN[1]} ]];then
                MESSAGE="`eval_gettext "The architecture \\\`\\\$LOCATION' is not valid."`"
            fi
            ;;

        '--theme' )
            if [[ $LOCATION =~ ${PATTERN[2]} ]];then
                MESSAGE="`eval_gettext "The theme \\\`\\\$LOCATION' is not valid."`"
            fi
            ;;

        '--default' | * )
            if [[ $LOCATION == '' ]] \
                || [[ $LOCATION =~ '(\.\.(/)?)' ]] \
                || [[ ! $LOCATION =~ '^[A-Za-z0-9\.:/_-]+$' ]]; then 
                MESSAGE="`eval_gettext "The value \\\`\\\$LOCATION' is not valid."`"
            fi
            ;;
    esac

    # Output message.
    if [[ $MESSAGE != '' ]];then
        cli_printMessage "$MESSAGE" 'AsErrorLine'
        cli_printMessage "${FUNCDIRNAM}" "AsToKnowMoreLine"
    fi

}
