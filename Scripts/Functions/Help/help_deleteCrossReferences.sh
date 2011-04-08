#!/bin/bash
#
# help_deleteCrossReferences.sh -- This function looks inside
# texinfo source files, from section level on, and removes all cross
# referece definitions related to a documentation entry. Use this
# function in coordination with help_deleteEntry function, in order
# to keep cross reference information, inside the documentation
# manual, syncronized.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_deleteCrossReferences {

    local -a PATTERN
    local -a REPLACE
    local LOCATION=''

    # Define entry location. Verify first argument to make this
    # function reusable. If no value is passed as first argument use
    # entry global information value as default value instead.
    if [[ "$1" != '' ]];then
        LOCATION="$1"
    else
        LOCATION="$ENTRY"
    fi

    # Build the node string using entry location.
    local NODE=$(echo "$LOCATION" \
        | cut -d / -f7- \
        | tr '/' ' ' \
        | sed -r \
            -e "s/(chapter-intro\.texi|\.texi)$//" \
            -e 's! !( |\\n)!g')

    # Define regular expression patterns for texinfo cross reference
    # commands.
    PATTERN[0]="@(pxref|xref|ref)\{(${NODE})\}"
    PATTERN[1]="^(\* ${NODE}:(.*)?:(.*)?)$"

    # Define replacement string for missing entries. It is convenient
    # to keep missing entries in documentation for documentation team
    # to know. Removing the missing cross reference may intorudce
    # confussion. Imagine that! you are spending lots of hours in an
    # article and suddenly one of your cross refereces disappears with
    # no visible reason, with the next working copy update you
    # perform. That's frustrating. Instead, when centos-art.sh script
    # finds a missing cross reference it removes the link and remark
    # the issue for you to act on it.
    REPLACE[0]='--- @strong{'`gettext "Removed"`'}(\1:\2) ---'
    REPLACE[1]='@comment --- '`gettext "Removed"`'(\1) ---'

    # Define list of entries to process.
    local ENTRIES=$(cli_getFilesList "${MANUAL_BASEDIR}" '.*\.texi')

    # Set action preamble.
    cli_printActionPreamble "$ENTRIES" '' ''

    # Update node-related cross references. The node-related cross
    # reference definition, long ones specially, could require more
    # than one line to be set. By default, GNU sed does not matches 
    # newline characters in the pattern space, so we need to make use
    # of `label' feature and the `N' command in order to build a
    # pattern space that includes the newline character in it. Here we
    # use the `a' letter to name the label we use, followed by N
    # command to add a newline to the pattern space, the s command to
    # make the pattern replacement using the `g' flag to make it
    # global and finaly the command `b' to branch label named `a'.
    sed -r -i ":a;N;s!${PATTERN[0]}!${REPLACE[0]}!g;ba" ${ENTRIES}

    # Update menu-related cross references. Menu-related cross
    # references hardly appear in more than one line, so there is no
    # need to complicate the replacement command.
    sed -r -i "s!${PATTERN[1]}!${REPLACE[1]}!" ${ENTRIES}

}
