#!/bin/bash
#
# help_restoreCrossReferences.sh -- This function looks inside
# texinfo source files, from section level on, and restores any cross
# reference related to a documentation entry. This function is used in
# those cases where documentation entries are created/recreated to
# documentation structure. It is a verification that looks for
# matching documentation entries previously defined as removed by
# help_deleteCrossReferences function. The
# help_restoreCrossReferences function relays in the removed message
# format produced by help_deleteCrossReferences function, in order
# to return them back into the link format. 
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

function help_restoreCrossReferences {

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
        | cut -d / -f8- \
        | tr '/' ' ' \
        | sed -r \
            -e "s/(chapter-intro\.texi|\.texi)$//" \
            -e 's! !( |\\n)!g')

    # Define regular expression patterns to match removed message
    # format produced by message_removeCrossReferences function.
    PATTERN[0]="--- @strong\{`gettext "Removed"`\}\((pxref|xref|ref):(${NODE})\) ---"
    PATTERN[1]="^@comment --- `gettext "Removed"`\((\* ${NODE}:(.*)?:(.*)?)\) ---$"

    # Define replacement string to turn removed message back to cross
    # reference link.
    REPLACE[0]='@\1{\2}'
    REPLACE[1]='\1'

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
