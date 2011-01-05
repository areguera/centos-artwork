#!/bin/bash
#
# cli_getCurrentLocale.sh -- This function checks LANG environment
# variable and returns the current locale from more specific to less
# specific. For example, if the locale 'en_GB' is the current one, it
# should be used instead of just 'en'.
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

function cli_getCurrentLocale {

    local -a PATTERNS
    local PATTERN=''
    local CURRENTLOCALE=''

    # Define pattern for current locale using LL_CC.ENCODING format.
    PATTERNS[0]=$LANG

    # Define pattern for current locale using LL_CC format.
    PATTERNS[1]=$(echo $LANG | sed -r 's!(^[a-z]{2,3}_[A-Z]{2}).+$!\1!')

    # Define pattern for current locale using LL format.
    PATTERNS[2]=$(echo $LANG | sed -r 's!^([a-z]{2,3}).+$!\1!')

    # Define which system locale to use as centos-art.sh script
    # current locale. Take care with pattern order, it is relevant for
    # this function to work as expected.
    for PATTERN in "${PATTERNS[@]}";do
        CURRENTLOCALE=$(cli_getLocales | egrep $PATTERN)
        if [[ $CURRENTLOCALE != '' ]];then
            break
        fi
    done

    # Define centos-art.sh script default current locale. If
    # centos-art.sh script doesn't support current system locale, use
    # English (en) as default current locale.
    if [[ $CURRENTLOCALE == '' ]];then
        CURRENTLOCALE='en'
    fi

    # Output current locale. Be sure that just one value is output.
    echo $CURRENTLOCALE | sort | uniq | head -n1

}
