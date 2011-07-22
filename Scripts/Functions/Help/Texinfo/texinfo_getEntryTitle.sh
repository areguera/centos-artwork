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

    # Verify style provided through `--style' option and transform
    # the phrase value in accordance with it.
    if [[ $FLAG_STYLE == 'cap-first-only' ]];then

        # In the entire phrase provided, capitalize the first word
        # only.
        PHRASE=$(echo "${PHRASE}" | tr '[:upper:]' '[:lower:]' \
            | sed -r 's!^([[:alpha:]])!\u\1!')

    elif [[ $FLAG_STYLE == 'directory' ]];then

        # In the entire phrase provided, concatenate all words with
        # slash (/) character and remark the fact it is a directory.
        PHRASE=$(echo "${PHRASE}" | sed -r \
            -e 's/(Trunk|Branches|Tags)/\l\1/' \
            -e 's/ /\//g' \
            -e 's/\/([[:alpha:]])/\/\u\1/g')

        PHRASE="@file{$PHRASE}"

    else

        # In the entire phrase provided, capitalize all words.
        PHRASE=$(echo "${PHRASE}" | tr '[:upper:]' '[:lower:]' \
            | sed -r 's!\<([[:alpha:]]+)\>!\u\1!g')

    fi

    # Output transformed phrase.
    echo "$PHRASE"

}
