#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Standardize construction of translation markers and their related
# expansion. As convention, translation markers must be set inside
# source files (e.g., Docbook, Svg, etc.) and expanded inside temporal
# instances used to produce final contents.
function tcar_setTranslationMarkers {

    # Initialize variables.
    local -a SRC
    local -a DST
    local COUNT=0
    local COUNTSRC=0
    local COUNTDST=0

    # Define source location on which sed replacements take place.
    local LOCATION="${1}"

    # Verify that source location does exist.
    tcar_checkFiles -ef ${LOCATION}

    # Define copyright translation markers.
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR_FIRST='
    DST[((++${#DST[*]}))]="$(tcar_printCopyrightInfo --first-year)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR(_LAST)?='
    DST[((++${#DST[*]}))]="$(tcar_printCopyrightInfo --year)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR(S)?_LIST='
    DST[((++${#DST[*]}))]="$(tcar_printCopyrightInfo --years-list)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_HOLDER='
    DST[((++${#DST[*]}))]="$(tcar_printCopyrightInfo --holder)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_HOLDER_PREDICATE='
    DST[((++${#DST[*]}))]="$(tcar_printCopyrightInfo --holder-predicate)"

    # Define license translation markers.
    SRC[((++${#SRC[*]}))]='=LICENSE='
    DST[((++${#DST[*]}))]="$(tcar_printCopyrightInfo --license)"
    SRC[((++${#SRC[*]}))]='=LICENSE_URL='
    DST[((++${#DST[*]}))]="$(tcar_printCopyrightInfo --license-url)"

    # Define theme translation markers.
    SRC[((++${#SRC[*]}))]='=THEME='
    DST[((++${#DST[*]}))]="$(tcar_getPathComponent ${RENDER_TARGET} --motif)"
    SRC[((++${#SRC[*]}))]='=THEMENAME='
    DST[((++${#DST[*]}))]="$(tcar_getPathComponent ${RENDER_TARGET} --motif-name)"
    SRC[((++${#SRC[*]}))]='=THEMERELEASE='
    DST[((++${#DST[*]}))]="$(tcar_getPathComponent ${RENDER_TARGET} --motif-version)"

    # Define url translation markers.
    SRC[((++${#SRC[*]}))]='=URL='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--home' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_WIKI='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--wiki' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_LISTS='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--lists' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_FORUMS='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--forums' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_MIRRORS='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--mirrors' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_DOCS='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--docs' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_PROJECTS='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--projects' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_BUGS='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--bugs' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_SVN='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--svn' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_TRAC='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--trac' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_PLANET='
    DST[((++${#DST[*]}))]=$(tcar_printUrl '--planet' '--with-locale')

    # Define release translation markers.
    SRC[((++${#SRC[*]}))]='=RELEASE='
    DST[((++${#DST[*]}))]=${RELEASE}
    SRC[((++${#SRC[*]}))]='=MAJOR_RELEASE='
    DST[((++${#DST[*]}))]=${MAJOR_RELEASE}

    # Define emails translation markers.
    SRC[((++${#SRC[*]}))]='=MAIL_DOCS='
    DST[((++${#DST[*]}))]="$(tcar_printMailingList --docs)"

    # Define locale translation markers.
    SRC[((++${#SRC[*]}))]='=LOCALE='
    DST[((++${#DST[*]}))]="${TCAR_SCRIPT_LANG_LC}"
    SRC[((++${#SRC[*]}))]='=LOCALE_LL='
    DST[((++${#DST[*]}))]="${TCAR_SCRIPT_LANG_LL}"
    SRC[((++${#SRC[*]}))]='=LOCALE_CC='
    DST[((++${#DST[*]}))]="${TCAR_SCRIPT_LANG_CC}"

    # Define domain translation markers for domains.
    SRC[((++${#SRC[*]}))]='=DOMAIN_LL='
    if [[ ! ${TCAR_SCRIPT_LANG_LL} =~ '^en' ]];then
        DST[((++${#DST[*]}))]="${TCAR_SCRIPT_LANG_LL}"
    else
        DST[((++${#DST[*]}))]=""
    fi

    # Define repository translation markers.
    SRC[((++${#SRC[*]}))]='=(REPO_TLDIR|REPO_HOME|TCAR_BASEDIR)='
    DST[((++${#DST[*]}))]="${TCAR_BASEDIR}"

    # Do replacement of nested translation markers.
    while [[ ${COUNTDST} -lt ${#DST[@]} ]];do

        # Verify existence of translation markers. If there is no
        # translation marker on replacement, continue with the next
        # one in the list.
        if [[ ! ${DST[${COUNTDST}]} =~ '=[A-Z_]+=' ]];then
            # Increment destination counter.
            COUNTDST=$((${COUNTDST} + 1))
            # The current replacement value doesn't have translation
            # marker inside, so skip it and evaluate the next
            # replacement value in the list.
            continue
        fi

        while [[ ${COUNTSRC} -lt ${#SRC[*]} ]];do

            # Update replacements.
            DST[${COUNTDST}]=$(echo ${DST[${COUNTDST}]} \
                | sed -r "s!${SRC[${COUNTSRC}]}!${DST[${COUNTSRC}]}!g")

            # Increment source counter.
            COUNTSRC=$((${COUNTSRC} + 1))

        done

        # Reset source counter
        COUNTSRC=0

        # Increment destination counter.
        COUNTDST=$((${COUNTDST} + 1))

    done

    # Apply replacements for translation markers.
    while [[ ${COUNT} -lt ${#SRC[*]} ]];do

        # Use sed to replace translation markers inside the design
        # model instance.
        sed -r -i "s!${SRC[${COUNT}]}!${DST[${COUNT}]}!g" ${LOCATION}

        # Increment counter.
        COUNT=$((${COUNT} + 1))

    done

    # Remove escaped character from translation markers. This is one
    # of the reasons why translation marker should be expanded in
    # source files instances not the source files themselves.
    # Escaping translation markers provides a way of talking about
    # them without expanding them.
    sed -r -i 's/(=)\\([A-Z_]+=)/\1\2/g' ${LOCATION}

    # Unset specific translation markers and specific replacement
    # variables in order to clean them up. Otherwise, undesired values
    # may remain from one file to another.
    unset SRC
    unset DST

}
