#!/bin/bash
#
# cli_getCurrentLocale.sh -- This function checks LANG environment
# variable and returns the current locale information in the LL_CC
# format.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_getCurrentLocale {

    local CURRENTLOCALE=''
    local OPTION="$1"

    # Redefine current locale using LL_CC format.
    CURRENTLOCALE=$(echo $LANG | sed -r 's!(^[a-z]{2,3}_[A-Z]{2}).+$!\1!')

    # Define centos-art.sh script default current locale. If
    # centos-art.sh script doesn't support current system locale, use
    # English language from United States as default current locale.
    if [[ $CURRENTLOCALE == '' ]];then
        CURRENTLOCALE='en_US'
    fi

    # Output current locale.    
    case $OPTION in

        '--langcode-only' )
            echo "${CURRENTLOCALE}" | cut -d_ -f1
            ;;

        '--langcode-and-countrycode'| * )
            echo "${CURRENTLOCALE}"
            ;;
    esac
}
