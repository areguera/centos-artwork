#!/bin/bash
#
# render_doIdentityTMarkersCommons.sh -- This function standardizes
# replacements for common translation markers. Raplacements are
# applied to temporal instances used to produce the final file.
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

function render_doIdentityTMarkersCommons {

    # Initialize variables.
    local -a SRC
    local -a DST
    local COUNT=0
    local LOCATION=''

    # Define source location on which sed replacements take place. By
    # default we use the value of INSTANCE variable, but if $1 is not
    # empty assume $1 as source location on which sed replacements
    # take place. This makes possible to reuse this function on
    # different source locations.
    if [[ "$1" != '' ]];then
        LOCATION="$1" 
    else
        LOCATION="${INSTANCE}" 
    fi

    # Verify source location file.
    cli_checkFiles "$LOCATION" 'f'

    # Define translation markers.
    SRC[0]='=THEME='
    SRC[1]='=THEMENAME='
    SRC[2]='=THEMERELEASE='
    SRC[3]='=RELEASE='
    SRC[4]='=MAJOR_RELEASE='
    SRC[5]='=MINOR_RELEASE='
    SRC[6]='=COPYRIGHT='
    SRC[7]='=DESCRIPTION='
    SRC[8]='=LICENSE='
    SRC[9]='=URL='
    SRC[10]='=URLLOCALE='
    SRC[11]='=ARCH='

    # Define replacements for translation markers.
    DST[0]="$(cli_getPathComponent "$FILE" '--theme')"
    DST[1]="$(cli_getPathComponent "$FILE" '--theme-name')"
    DST[2]="$(cli_getPathComponent "$FILE" '--theme-release')"
    DST[3]="$(cli_getPathComponent "$FILE" '--release')"
    DST[4]="$(cli_getPathComponent "$FILE" '--release-major')"
    DST[5]="$(cli_getPathComponent "$FILE" '--release-minor')"
    DST[6]="$(cli_getCopyrightInfo '--copyright')"
    DST[7]="$(cli_getCopyrightInfo '--description')"
    DST[8]="$(cli_getCopyrightInfo '--license')"
    DST[9]="http://www.centos.org"
    # Define url locale information. We don't want to show locale
    # information inside url for English language. English is the
    # default locale and no locale level is used for it.  However, if
    # we are rendering a language different from English, the locale
    # information should be present in the url.
    if [[ $(cli_getCurrentLocale) == 'en' ]];then
        DST[10]=''
    else
        DST[10]="$(cli_getCurrentLocale)/"
    fi
    DST[11]="$(cli_getPathComponent "$FILE" '--architecture')"

    # Apply replacements for translation markers.
    while [[ ${COUNT} -lt ${#SRC[*]} ]];do

        # Use sed to replace translation markers inside the design
        # model instance.
        sed -r -i "s!${SRC[$COUNT]}!${DST[$COUNT]}!g" ${LOCATION}

        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

    # Unset specific translation markers and specific replacement
    # variables in order to clean them up. Otherwise, undesired values
    # may ramain from one file to another.
    unset SRC
    unset DST

}
