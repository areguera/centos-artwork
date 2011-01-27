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

    # Define translation markers. The translation marker definition
    # order is important. Note that when we render concept directory
    # structure, we make two replacements to produce the final
    # copyright note. First, we replace =COPYRIGHT= translation marker
    # and later the =THEMENAME= translation maker (not the oposite).
    SRC[0]='=COPYRIGHT='
    SRC[1]='=DESCRIPTION='
    SRC[2]='=LICENSE='
    SRC[3]='=THEME='
    SRC[4]='=THEMENAME='
    SRC[5]='=THEMERELEASE='
    SRC[6]='=RELEASE='
    SRC[7]='=MAJOR_RELEASE='
    SRC[8]='=MINOR_RELEASE='
    SRC[9]='=URL='
    SRC[10]='=URLLOCALE='
    SRC[11]='=ARCH='

    # Define replacements for translation markers.
    DST[0]="$(cli_getCopyrightInfo '--copyright')"
    DST[1]="$(cli_getCopyrightInfo '--description')"
    DST[2]="$(cli_getCopyrightInfo '--license')"
    DST[3]="$(cli_getPathComponent "$FILE" '--theme')"
    DST[4]="$(cli_getPathComponent "$FILE" '--theme-name')"
    DST[5]="$(cli_getPathComponent "$FILE" '--theme-release')"
    DST[6]="$(cli_getPathComponent "$FILE" '--release')"
    DST[7]="$(cli_getPathComponent "$FILE" '--release-major')"
    DST[8]="$(cli_getPathComponent "$FILE" '--release-minor')"
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
