#!/bin/bash
#
# manual_restoreCrossReferences.sh -- This function restores old
# missing cross references back into their link form. This function
# applies in those cases where new documentation entries are added to
# documentation structure. It is a verification looking for matching
# documentation entries previously defined as missing. This function
# relays in the missing message output produced by functions like
# manual_removeCrossReferences, in order to return them back into the
# link format. 
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function manual_restoreCrossReferences {

    local -a PATTERN
    local -a REPLACE

    # Build the node string using global entry (ENTRY) variable being
    # processed currently.
    local NODE=$(echo "$ENTRY" \
        | cut -d / -f10- \
        | tr '/' ' ' \
        | sed -r "s/(${MANUALS_FILE[7]}|\.texi)$//")

    # Define regular expression patterns from
    # message_removeCrossReferences function output.
    PATTERN[0]="--- @strong\{`gettext "Removed"`\}\((pxref|xref|ref):(${NODE})\) ---"
    PATTERN[1]="^@comment --- `gettext "Removed"`\((\* ${NODE}:(.*)?:(.*)?)\) ---$"

    # Define replacement string for message_removeCrossReferences
    # function output. Here is where we turn Removed messages back
    # into links.
    REPLACE[0]='@\1{\2}'
    REPLACE[1]='\1'

    # Sanitate messages built from broken cross reference messages
    # produced by manual_removeCrossReferences function for section
    # texinfo files. We don't toch chapter texinfo files because they
    # are handled by manual_updateMenu, and manual_updateNode
    # functions.  If we don't sanitate messages built from broken
    # cross reference messages, they may become obsoletes since the
    # documentation entry, they represent, can be recreated in the
    # future and at that time the link wouldn't be broken any more, so
    # we need to be aware of this.
    sed -r -i \
        -e "s!${PATTERN[0]}!${REPLACE[0]}!Mg" \
        -e "s!${PATTERN[1]}!${REPLACE[1]}!g" \
        $(find ${MANUALS_DIR[2]} -mindepth 3 -name '*.texi')

}
