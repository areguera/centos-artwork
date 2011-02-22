#!/bin/bash
#
# manual_deleteCrossReferences.sh -- This function looks inside
# texinfo source files, from section level on, and removes all cross
# referece definitions related to a documentation entry. Use this
# function in coordination with manual_deleteEntry function, in order
# to keep cross reference information, inside the documentation
# manual, syncronized.
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

function manual_deleteCrossReferences {

    local -a PATTERN
    local -a REPLACE

    # Build the node string using global entry (ENTRY) variable being
    # processed currently.
    local NODE=$(echo "$ENTRY" \
        | cut -d / -f8- \
        | tr '/' ' ' \
        | sed -r "s/(chapter-intro\.texi|\.texi)$//")

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

    # Sanitate all missing cross references, related to entry, in
    # section texinfo files. Missing cross references, related to
    # entry, in chapter texinfo files are already handled by
    # manual_updateMenu, and manual_updateNode functions. If we don't
    # sanitate missing cross refereces before info file is created,
    # errors are displayed since makeinfo don't produce info output
    # with broken cross refereces.
    local ENTRIES=$(cli_getFilesList "${MANUAL_DIR}" '.*\.texi')
    if [[ $ENTRIES != '' ]];then
        sed -r -i \
            -e "s!${PATTERN[0]}!${REPLACE[0]}!Mg" \
            -e "s!${PATTERN[1]}!${REPLACE[1]}!g" \
            $ENTRIES
    fi

}
