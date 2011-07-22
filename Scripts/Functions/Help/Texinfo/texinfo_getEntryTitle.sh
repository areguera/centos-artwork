#!/bin/bash
#
# texinfo_getEntryTitle.sh -- This function standardizes the way entry
# titles for chapters and sections are printed out.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function texinfo_getEntryTitle {

    # Initialize phrase we want to transform based on style provided.
    local PHRASE="$1"

    # Define section style. Through this property you can customize
    # the section title in predefined ways.  By default, section
    # titles are printed with each word capitalized (`cap-each-word').
    # Other values to this option are `cap-first-only' (to capitalize
    # just the first word in the title) or `directory' to transform
    # each word to a directory path.
    local MANUAL_SECTION_STYLE=$(cli_getConfigValue "${MANUAL_CONFIG_FILE}" "main" "manual_section_style")
    if [[ ! $MANUAL_SECTION_STYLE =~ '^(cap-each-word|cap-first-only|directory)$' ]];then
        MANUAL_SECTION_STYLE='cap-each-word'
    fi

    # Verify section style provided and transform the phrase value in
    # accordance with it.
    case $MANUAL_SECTION_STYLE in

        'cap-first-only' )

            # In the entire phrase provided, capitalize the first word
            # only.
            PHRASE=$(echo "${PHRASE}" | tr '[:upper:]' '[:lower:]' \
                | sed -r 's!^([[:alpha:]])!\u\1!')
            ;;

        'directory' )

            # In the entire phrase provided, concatenate all words
            # with slash (/) character and remark the fact it is a
            # directory.
            PHRASE=$(echo "${PHRASE}" | sed -r \
                -e 's/(Trunk|Branches|Tags)/\l\1/' \
                -e 's/ /\//g' \
                -e 's/\/([[:alpha:]])/\/\u\1/g')

            PHRASE="@file{$PHRASE}"
            ;;

        'cap-each-word' | * )

            # In the entire phrase provided, capitalize all words.
            PHRASE=$(echo "${PHRASE}" | tr '[:upper:]' '[:lower:]' \
                | sed -r 's!\<([[:alpha:]]+)\>!\u\1!g')
            ;;

    esac

    # Output transformed phrase.
    echo "$PHRASE"

}
