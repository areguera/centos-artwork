#!/bin/bash
#
# texinfo_deleteCrossReferences.sh -- This function looks inside
# texinfo source files, from section level on, and removes all cross
# referece definitions related to a documentation entry. Use this
# function in coordination with texinfo_deleteEntry function, in order
# to keep cross reference information, inside the documentation
# manual, syncronized.
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

function texinfo_deleteCrossReferences {

    local -a PATTERN
    local -a REPLACE

    # Define documentation entry.
    local MANUAL_ENTRY="$1"

    # Verify documentation entry. If documentation entry is empty,
    # stop script execution with an error message.
    if [[ $MANUAL_ENTRY == '' ]];then
        cli_printMessage "`gettext "The first positional parameter cannot be empty."`" --as-error-line
    fi

    # Build the node string using entry location.
    local NODE="$(${MANUAL_BACKEND}_getEntryNode "$MANUAL_ENTRY")"

    # Define regular expression patterns for texinfo cross reference
    # commands.
    PATTERN[0]="@(pxref|xref|ref)\{(${NODE})\}"
    REPLACE[0]='--- @strong{'`gettext "Removed"`'}(\1:\2) ---'

    # Define replacement string for missing entries. It is convenient
    # to keep missing entries in documentation for documentation team
    # to know. Removing the missing cross reference may intorudce
    # confussion. Imagine that! you are spending lots of hours in an
    # article and suddenly one of your cross refereces disappears with
    # no visible reason, with the next working copy update you
    # perform. That's frustrating. Instead, when centos-art.sh script
    # finds a missing cross reference it removes the link and remark
    # the issue for you to act on it.
    PATTERN[1]="^(\* ${NODE}:(.*):(.*))$"
    REPLACE[1]='\@comment --- '`gettext "Removed"`'(\1) ---'

    # Define list of entries to process.
    local MANUAL_ENTRIES=$(cli_getFilesList ${MANUAL_BASEDIR_L10N} \
        --pattern=".+\.${MANUAL_EXTENSION}")

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
    sed -r -i ":a;N;s!${PATTERN[0]}!${REPLACE[0]}!g;ba" ${MANUAL_ENTRIES}

    # Update menu-related cross references. Menu-related cross
    # references hardly appear in more than one line, so there is no
    # need to complicate much the replacement command.
    sed -r -i "s!${PATTERN[1]}!${REPLACE[1]}!" ${MANUAL_ENTRIES}

}
