#!/bin/bash
#
# texinfo_renameCrossReferences.sh -- This function replaces a node
# pattern with a node replacement and updates cross-reference
# definitions to reflect the changes.
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

function texinfo_renameCrossReferences {

    local MANUAL_ENTRY_SRC=$(${MANUAL_BACKEND}_getEntry "$1")
    local MANUAL_ENTRY_DST=$(${MANUAL_BACKEND}_getEntry "$2")

    # Define node pattern for source documenation entry.
    local NODE_SRC=$(${MANUAL_BACKEND}_getNode "$MANUAL_ENTRY_SRC")

    # Define node replacement for target documentation entry.
    local NODE_DST=$(${MANUAL_BACKEND}_getNode "$MANUAL_ENTRY_DST")

    # Define list of entries to process.
    local MANUAL_ENTRIES=$(cli_getFilesList ${MANUAL_BASEDIR} \
        --pattern=".*\.${MANUAL_EXTENSION}")

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
    #
    # Inside the pattern space, the `\<' and `\>' are used to restrict
    # the match pattern to a word boundary. The word boundary
    # restriction applied here is required to avoid undesired
    # replacements when we replace singular words with their plurals.
    # For example, if we need to change the word `Manual' to its
    # plular (i.e., `Manuals'), and no boundary restriction is used in
    # the pattern space to do that, we might end up having words like
    # `Manualsssss'. This is because this sed command might be applied
    # to the same file many times; and each time it is applied a new
    # `Manuals' replaces the previous `Manuals' replacement to form
    # `Manualss', `Manualsss', and so on for each interaction.
    sed -r -i ":a;N;s!\<${NODE_SRC}\>!${NODE_DST}!g;ba" ${MANUAL_ENTRIES}

    # At this point, source documentation entry has been renamed from
    # source to target documentation entry, but they are still
    # commented. So, uncomment them restoring target documentation
    # entries.
    ${MANUAL_BACKEND}_restoreCrossReferences "${MANUAL_ENTRY_DST}"

}
