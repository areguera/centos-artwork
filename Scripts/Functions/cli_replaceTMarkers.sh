#!/bin/bash
#
# cli_replaceTMarkers.sh -- This function standardizes
# replacements for common translation markers. Raplacements are
# applied to temporal instances used to produce the final file.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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
    SRC[0]='=COPYRIGHT_YEAR='
    SRC[1]='=COPYRIGHT_HOLDER='
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
    SRC[18]='=URL_LL='
    SRC[19]='=DOMAIN_LL='
    SRC[20]='=URL_IRC='
    SRC[21]='=LOCALE_LL='
    SRC[22]='=LOCALE='
    SRC[23]='=REPO_TLDIR='

    # Define replacements for translation markers.
    DST[0]="$(cli_getCopyrightInfo '--copyright-year')"
    DST[1]="$(cli_getCopyrightInfo '--copyright-holder')"
    DST[2]="$(cli_getCopyrightInfo '--license')"
    DST[3]="$(cli_getCopyrightInfo '--license-url')"
    DST[4]="$(cli_getPathComponent "$OUTPUT" '--theme')"
    DST[5]="$(cli_getPathComponent "$OUTPUT" '--theme-name')"
    DST[6]="$(cli_getPathComponent "$OUTPUT" '--theme-release')"
    DST[7]="$(cli_getPathComponent "$FLAG_RELEASEVER" '--release')"
    DST[8]="$(cli_getPathComponent "$FLAG_RELEASEVER" '--release-major')"
    DST[9]="$(cli_getPathComponent "$FLAG_RELEASEVER" '--release-minor')"
    DST[10]="http://www.centos.org/=URL_LL="
    DST[11]="$(cli_getPathComponent "$FLAG_BASEARCH" '--architecture')"
    DST[12]="http://wiki.centos.org/=URL_LL="
    DST[13]="http://lists.centos.org/=URL_LL="
    DST[14]="http://forums.centos.org/=URL_LL="
    DST[15]="http://mirrors.centos.org/=URL_LL="
    DST[16]="http://docs.centos.org/=URL_LL="
    DST[17]="centos-docs@centos.org"
    if [[ ! $(cli_getCurrentLocale) =~ '^en' ]];then
        DST[18]="$(cli_getCurrentLocale '--langcode-only')/"
    else
        DST[18]=""
    fi
    if [[ ! $(cli_getCurrentLocale) =~ '^en' ]];then
        DST[19]="$(cli_getCurrentLocale '--langcode-only')."
    else
        DST[19]=""
    fi
    DST[20]='http://www.centos.org/modules/tinycontent/index.php?id=8'
    DST[21]="$(cli_getCurrentLocale '--langcode-only')"
    DST[22]="$(cli_getCurrentLocale)"
    DST[23]="$(cli_getRepoTLDir)"

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
