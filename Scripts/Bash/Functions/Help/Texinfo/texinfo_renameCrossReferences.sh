#!/bin/bash
#
# texinfo_renameCrossReferences.sh -- This function renames menu,
# nodes and cross references related to chapters and sections that
# have been renamed previously.
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

function texinfo_renameCrossReferences {

    local -a PATTERN
    local -a REPLACE

    # Build source and target node definitions.
    local NODE_SRC="$(texinfo_getEntryNode "$MANUAL_ENTRY_SRC")"
    local NODE_DST="$(texinfo_getEntryNode "$MANUAL_ENTRY_DST")"

    # Define regular expression pattern and its replacement for node
    # definitions that have been previously removed.
    PATTERN[0]="--- @strong\{`gettext "Removed"`\}\((pxref|xref|ref):\<${NODE_SRC}\>(.*)\) ---"
    REPLACE[0]="\@\1{${NODE_DST}\2}"

    # Define regular expression pattern and its replacement for menu
    # definitions that have been previously removed.
    PATTERN[1]="^@comment --- `gettext "Removed"`\(\* \<${NODE_SRC}\>(.*)\) ---$"
    REPLACE[1]="* ${NODE_DST}\1"

    # Define list of entries to process. This is, all the texinfo
    # source files the documentation manual is made of.
    local MANUAL_ENTRIES=$(cli_getFilesList ${MANUAL_BASEDIR_L10N} \
        --pattern=".+\.${MANUAL_EXTENSION}")

    # Update node cross references. The node-related cross reference
    # definition, long ones specially, could require more than one
    # line to be set. By default, GNU sed does not matches newline
    # characters in the pattern space, so we need to make use of
    # `label' feature and the `N' command in order to build a pattern
    # space that includes the newline character in it. Here we use the
    # `a' letter to name the label we use, followed by N command to
    # add a newline to the pattern space, the s command to make the
    # pattern replacement using the `g' flag to make it global and
    # finaly the command `b' to branch label named `a'.
    #
    # Inside the pattern space, the `\<' and `\>' are used to restrict
    # the match pattern to a word boundary. The word boundary
    # restriction applied here is required to avoid undesired
    # replacements when we replace singular words with their plurals.
    # For example, if we need to change the node `Manual' to its
    # plular (i.e., `Manuals'), and no boundary restriction is used in
    # the pattern space to do that, we might end up having nodes like
    # `Manualsssss' which probably doesn't exist. This is because this
    # sed command might be applied to the same file more than once;
    # and each time it is applied, a new `Manuals' replaces the
    # previous `Manuals' replacement to form `Manualss', `Manualsss',
    # and so on for each interaction. Using word boundaries
    # restrictions prevent such issue from happening.
    sed -r -i ":a;N;s!${PATTERN[0]}!${REPLACE[0]}!g;ba" ${MANUAL_ENTRIES}

    # Update menu cross references. Menu cross reference definitions
    # hardly appear in more than one line, so there is no need to
    # complicate the replacement command.
    sed -r -i "s!${PATTERN[1]}!${REPLACE[1]}!" ${MANUAL_ENTRIES}

}
