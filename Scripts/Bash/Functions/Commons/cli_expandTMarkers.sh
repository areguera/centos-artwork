#!/bin/bash
#
# cli_expandTMarkers.sh -- This function standardizes
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

function cli_expandTMarkers {

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
    cli_checkFiles $LOCATION

    # Define copyright translation markers.
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR_LAST='
    DST[((++${#DST[*]}))]="$(cli_printCopyrightInfo --copyright-year)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR='
    DST[((++${#DST[*]}))]="$(cli_printCopyrightInfo --copyright-year)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR_LIST='
    DST[((++${#DST[*]}))]="$(cli_printCopyrightInfo --copyright-year-list)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_HOLDER='
    DST[((++${#DST[*]}))]="$(cli_printCopyrightInfo --copyright-holder)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_HOLDER_PREDICATE='
    DST[((++${#DST[*]}))]="$(cli_printCopyrightInfo --copyright-holder-predicate)"

    # Define name of branding files. This files are mainly used under
    # Identity/(Images|Models)/Brands/ directory structure. These
    # file names may vary from one project to another so we use this
    # variable to control the name of such files.
    SRC[((++${#SRC[*]}))]='=BRAND='
    DST[((++${#DST[*]}))]="${BRAND}"

    # Define license translation markers.
    SRC[((++${#SRC[*]}))]='=LICENSE='
    DST[((++${#DST[*]}))]="$(cli_printCopyrightInfo --license)"
    SRC[((++${#SRC[*]}))]='=LICENSE_URL='
    DST[((++${#DST[*]}))]="$(cli_printCopyrightInfo --license-url)"

    # Define theme translation markers.
    SRC[((++${#SRC[*]}))]='=THEME='
    DST[((++${#DST[*]}))]="$(cli_getPathComponent $OUTPUT --motif)"
    SRC[((++${#SRC[*]}))]='=THEMENAME='
    DST[((++${#DST[*]}))]="$(cli_getPathComponent $OUTPUT --motif-name)"
    SRC[((++${#SRC[*]}))]='=THEMERELEASE='
    DST[((++${#DST[*]}))]="$(cli_getPathComponent $OUTPUT --motif-release)"

    # Define release-specific translation markers.
    SRC[((++${#SRC[*]}))]='=RELEASE='
    DST[((++${#DST[*]}))]="$FLAG_RELEASEVER"
    SRC[((++${#SRC[*]}))]='=MAJOR_RELEASE='
    DST[((++${#DST[*]}))]="$(echo $FLAG_RELEASEVER | cut -d'.' -f1)"
    SRC[((++${#SRC[*]}))]='=MINOR_RELEASE='
    DST[((++${#DST[*]}))]="$(echo $FLAG_RELEASEVER | cut -d'.' -f2)"

    # Define architectures translation markers.
    SRC[((++${#SRC[*]}))]='=ARCH='
    DST[((++${#DST[*]}))]="$(cli_getPathComponent $FLAG_BASEARCH --architecture)"

    # Define url translation markers.
    SRC[((++${#SRC[*]}))]='=URL='
    DST[((++${#DST[*]}))]=$(cli_printUrl '--home' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_WIKI='
    DST[((++${#DST[*]}))]=$(cli_printUrl '--wiki' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_LISTS='
    DST[((++${#DST[*]}))]=$(cli_printUrl '--lists' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_FORUMS='
    DST[((++${#DST[*]}))]=$(cli_printUrl '--forums' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_MIRRORS='
    DST[((++${#DST[*]}))]=$(cli_printUrl '--mirrors' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_DOCS='
    DST[((++${#DST[*]}))]=$(cli_printUrl '--docs' '--with-locale')
    SRC[((++${#SRC[*]}))]='=URL_IRC='
    DST[((++${#DST[*]}))]=$(cli_printUrl '--irc')

    # Define emails translation markers.
    SRC[((++${#SRC[*]}))]='=MAIL_DOCS='
    DST[((++${#DST[*]}))]="${MAILINGLIST_DOCS}"
    SRC[((++${#SRC[*]}))]='=MAIL_L10N='
    DST[((++${#DST[*]}))]="${MAILINGLIST_L10N}"

    # Define locale translation markers.
    SRC[((++${#SRC[*]}))]='=LOCALE_LL='
    DST[((++${#DST[*]}))]="$(cli_getCurrentLocale '--langcode-only')"
    SRC[((++${#SRC[*]}))]='=LOCALE='
    DST[((++${#DST[*]}))]="$(cli_getCurrentLocale)"

    # Define domain translation markers for domains.
    SRC[((++${#SRC[*]}))]='=DOMAIN_LL='
    if [[ ! $(cli_getCurrentLocale) =~ '^en' ]];then
        DST[((++${#DST[*]}))]="$(cli_getCurrentLocale '--langcode-only')."
    else
        DST[((++${#DST[*]}))]=""
    fi

    # Define repository translation markers.
    SRC[((++${#SRC[*]}))]='=REPO_TLDIR='
    DST[((++${#DST[*]}))]="$(cli_getRepoTLDir)"
    SRC[((++${#SRC[*]}))]='=REPO_HOME='
    DST[((++${#DST[*]}))]="${CLI_WRKCOPY}"

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
