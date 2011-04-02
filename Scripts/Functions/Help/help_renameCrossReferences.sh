#!/bin/bash
#
# help_renameCrossReferences.sh -- This function replaces a node
# pattern with a node replacement and updates cross-reference
# definitions to reflect the changes.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_renameCrossReferences {

    local NODE=''
    local COUNT=1
    local ENTRIES=''
    local NODE_SRC=''
    local NODE_DST=''

    # Define node pattern for source documenation entry.
    NODE_SRC=$(echo "$ENTRY" \
        | cut -d / -f8- \
        | tr '/' ' ' \
        | sed -r \
            -e "s/(chapter-intro\.texi|\.texi)$//")

    # Define node replacement for target documentation entry.
    NODE_DST=$(echo "$ENTRY_DST" \
        | cut -d / -f8- \
        | tr '/' ' ' \
        | sed -r \
            -e "s/(chapter-intro\.texi|\.texi)$//")

    # Define list of entries to process.
    ENTRIES=$(cli_getFilesList "${MANUAL_BASEDIR}" '.*\.texi')

    # Set action preamble.
    cli_printActionPreamble "$ENTRIES" '' ''

    # Update node-related cross-references. The node-related cross
    # reference definition, long ones specially, could require more
    # than one line to be set. By default, GNU sed does not matches 
    # newline characters in the pattern space, so we need to make use
    # of `label' feature and the `N' command in order to build a
    # pattern space that includes the newline character in it. Here we
    # use the `a' letter to name the label we use, followed by N
    # command to add a newline to the pattern space, the s command to
    # make the pattern replacement using the `g' flag to make it
    # global and finaly the command `b' to branch label named `a'.
    sed -r -i ":a;N;s!${NODE_SRC}!${NODE_DST}!g;ba" ${ENTRIES}

    # At this point, source documentation entry has been renamed from
    # source to target documentation entry, but they are still
    # commented. So, uncomment them restoring target documentation
    # entries.
    help_restoreCrossReferences "${ENTRY_DST}"

}
