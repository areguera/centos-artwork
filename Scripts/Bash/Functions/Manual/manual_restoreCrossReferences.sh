#!/bin/bash
#
# manual_restoreCrossReferences.sh -- This function looks inside
# texinfo source files, from section level on, and restores any cross
# reference related to a documentation entry. This function is used in
# those cases where documentation entries are created/recreated to
# documentation structure. It is a verification that looks for
# matching documentation entries previously defined as removed by
# manual_removeCrossReferences function. The
# manual_restoreCrossReferences function relays in the removed message
# format produced by manual_removeCrossReferences function, in order
# to return them back into the link format. 
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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

    # Define regular expression patterns to match removed message
    # format produced by message_removeCrossReferences function.
    PATTERN[0]="--- @strong\{`gettext "Removed"`\}\((pxref|xref|ref):(${NODE})\) ---"
    PATTERN[1]="^@comment --- `gettext "Removed"`\((\* ${NODE}:(.*)?:(.*)?)\) ---$"

    # Define replacement string to turn removed message back to cross
    # reference link.
    REPLACE[0]='@\1{\2}'
    REPLACE[1]='\1'

    # Build list of source texinfo files to process, from section
    # level on, and apply replacement string previously defined.  At
    # this point we don't touch chapter related texinfo files (i.e.,
    # repository-menu.texi and repository-nodes.texi) nor section
    # related definition files (i.e., chapter-nodes.texi,
    # chapter-menu.texi, chapter-index.texi) because they are handled
    # by manual_updateChapterMenu, manual_updateChapterNode,
    # manual_updateMenu, and manual_updateNodes functions
    # respectively.  If we don't sanitate messages built from broken
    # cross reference messages, they may become obsolete since the
    # documentation entry, they represent, can be recreated in the
    # future and, at that time, the link wouldn't be broken any more,
    # so we need to be aware of this.
    sed -r -i \
        -e "s!${PATTERN[0]}!${REPLACE[0]}!Mg" \
        -e "s!${PATTERN[1]}!${REPLACE[1]}!g" \
        $(find ${MANUALS_DIR[2]} -mindepth 3 -name '*.texi')

}
