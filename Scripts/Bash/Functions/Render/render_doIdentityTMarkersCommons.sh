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

    # Define translation markers.
    SRC[0]='=THEME='
    SRC[1]='=COPYRIGHT='
    SRC[2]='=DESCRIPTION='
    SRC[3]='=LICENSE='
    SRC[4]='=NAME='
    SRC[5]='=RELEASE='
    SRC[6]='=URL='
    SRC[7]='=RELEASE='
    SRC[8]='=MAJOR_RELEASE='
    SRC[9]='=MINOR_RELEASE='
    SRC[10]='=URLLOCALE='

    # Define replacements for translation markers.
    DST[0]="$(cli_getThemeName)"
    DST[1]="$(cli_getCopyrightInfo '--copyright')"
    DST[2]="$(cli_getCopyrightInfo '--description')"
    DST[3]="$(cli_getCopyrightInfo '--license')"
    DST[4]="$(cli_getThemeName '--name')"
    DST[5]="$(cli_getThemeName '--release')"
    DST[6]="http://www.centos.org"
    DST[7]="$(cli_getRelease "$FILE")"
    DST[8]="$(cli_getRelease "$FILE" '--major')"
    DST[9]="$(cli_getRelease "$FILE" '--minor')"
    # Define url locale information. We don't want to show locale
    # information inside url for English language. English is the
    # default locale and no locale level is used for it.  However, if
    # we are rendering for a language different from English, the
    # locale level in the url should be present.
    if [[ $(cli_getCurrentLocale) == 'en' ]];then
        DST[10]=''
    else
        DST[10]="$(cli_getCurrentLocale)/"
    fi

    # Apply replacements for translation markers.
    while [[ ${COUNT} -lt ${#SRC[*]} ]];do

        # Use sed to replace translation markers inside the design
        # model instance.
        sed -r -i "s!${SRC[$COUNT]}!${DST[$COUNT]}!g" ${INSTANCE}

        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

    # Unset specific translation markers and specific replacement
    # variables in order to clean them up. Otherwise, undesired values
    # may ramain from one file to another.
    unset SRC
    unset DST

}
