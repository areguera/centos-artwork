#!/bin/bash
#
# cli_replaceTMarkers.sh -- This function standardizes
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

function cli_replaceTMarkers {

    # Initialize variables.
    local -a SRC
    local -a DST
    local COUNT=0
    local COUNTSRC=0
    local COUNTDST=0
    local LOCATION=''

    # Define source location on which sed replacements take place.
    LOCATION="$1" 

    # Verify file source location.
    cli_checkFiles "$LOCATION" 'f'

    # Define translation markers. The translation marker definition
    # order is important. Note that when we render concept directory
    # structure, we make two replacements to produce the final
    # copyright note. First, we replace =COPYRIGHT= translation marker
    # and later the =THEMENAME= translation maker (not the oposite).
    SRC[0]='=COPYRIGHT='
    SRC[1]='=DESCRIPTION='
    SRC[2]='=LICENSE='
    SRC[3]='=LICENSE_URL='
    SRC[4]='=THEME='
    SRC[5]='=THEMENAME='
    SRC[6]='=THEMERELEASE='
    SRC[7]='=RELEASE='
    SRC[8]='=MAJOR_RELEASE='
    SRC[9]='=MINOR_RELEASE='
    SRC[10]='=URL='
    SRC[11]='=ARCH='
    SRC[12]='=URL_WIKI='
    SRC[13]='=URL_LISTS='
    SRC[14]='=URL_FORUMS='
    SRC[15]='=URL_MIRRORS='
    SRC[16]='=URL_DOCS='
    SRC[17]='=MAIL_DOCS='

    # Define replacements for translation markers.
    DST[0]="$(cli_getCopyrightInfo '--copyright')"
    DST[1]="$(cli_getCopyrightInfo '--description')"
    DST[2]="$(cli_getCopyrightInfo '--license')"
    DST[3]="$(cli_getCopyrightInfo '--license-url')"
    DST[4]="$(cli_getPathComponent "$FILE" '--theme')"
    DST[5]="$(cli_getPathComponent "$FILE" '--theme-name')"
    DST[6]="$(cli_getPathComponent "$FILE" '--theme-release')"
    DST[7]="$(cli_getPathComponent "$FILE" '--release')"
    DST[8]="$(cli_getPathComponent "$FILE" '--release-major')"
    DST[9]="$(cli_getPathComponent "$FILE" '--release-minor')"
    DST[10]="http://$(cli_getCurrentLocale '--langcode-only').centos.org/"
    DST[11]="$(cli_getPathComponent "$FILE" '--architecture')"
    DST[12]="=URL=wiki/"
    DST[13]="=URL=lists/"
    DST[14]="=URL=forums/"
    DST[15]="=URL=mirrors/"
    DST[16]="=URL=docs/"
    DST[17]="centos-docs@$(cli_getCurrentLocale '--langcode-only').centos.org"

    # Do replacement of nested translation markers.
    while [[ $COUNTDST -lt ${#DST[@]} ]];do

        # Verify existence of translation markers. If there is no
        # translation marker on replacement, continue with the next
        # one in the list.
        if [[ ! ${DST[$COUNTDST]} =~ '=[A-Z_]+=' ]];then
            # Increment destination counter.
            COUNTDST=$(($COUNTDST + 1))
            # The current replacement value doesn't have translation
            # marker inside, so skip it and evaluate the next
            # replacement value in the list.
            continue
        fi

        while [[ $COUNTSRC -lt ${#SRC[*]} ]];do

            # Update replacements.
            DST[$COUNTDST]=$(echo ${DST[$COUNTDST]} \
                | sed -r "s!${SRC[$COUNTSRC]}!${DST[$COUNTSRC]}!g")

            # Increment source counter.
            COUNTSRC=$(($COUNTSRC + 1))

        done

        # Reset source counter
        COUNTSRC=0

        # Increment destination counter.
        COUNTDST=$(($COUNTDST + 1))

    done

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
