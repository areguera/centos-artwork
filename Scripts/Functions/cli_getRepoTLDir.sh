#!/bin/bash
#
# cli_getRepoTLDir.sh -- This function returns the repository top
# level absolute path. The repository top level absolute path may be
# /home/centos/artwork/trunk, /home/centos/artwork/branches, or
# /home/centos/artwork/tags.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_getRepoTLDir {

    local PATTERN=''
    local REPLACE=''
    local LOCATION=''
    
    # Define location. If first argument is provided use it as default
    # location.  Otherwise, if first argument is not provided,
    # location takes the action value (ACTIONVAL) as default.
    if [[ "$1" != '' ]];then
        LOCATION="$1"
    else
        LOCATION="$ACTIONVAL"
    fi

    # Verify location.
    if [[ $LOCATION =~ "^${HOME}/artwork/(trunk|branches|tags)/.+$" ]];then
        case "$2" in
            -r|--relative )
                PATTERN="^${HOME}/artwork/(trunk|branches|tags)/.+$"
                REPLACE='\1'
                ;;
            -a|--absolute|* )
                PATTERN="^(${HOME}/artwork/(trunk|branches|tags))/.+$"
                REPLACE='\1'
                ;;
        esac
    else
        cli_printMessage "${FUNCNAME}: `eval_gettext "The location \\\`\\\$LOCATION' is not valid."`" 'AsErrorLine'
        cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
    fi

    # Print location.
    echo $LOCATION | sed -r "s!${PATTERN}!${REPLACE}!g"

}
