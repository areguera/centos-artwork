#!/bin/bash
#
# texinfo_makeSeeAlso.sh -- This function creates a menu with all
# section entries found one or more levels down the current node
# information.  The texinfo code of this menu is expanded wherever a
# `@menu...@end menu' definition be found inside a section entry.
# When no menu definition is found, nothing is expanded.
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

function texinfo_makeSeeAlso {

    local MENU=''
    local MENUNODES=''
    local CHILD_ENTRY=''
    local CHILD_ENTRIES=''

    # Initialize section definition absolute path.
    local MANUAL_ENTRY="$1"

    # Initialize amount of levels the menu is build for. 
    local LEVELS_DEEP="$2"

    # Define pattern used to build list of child sections. A child
    # section shares the same path information of its parent with out
    # file extension. For example, if you have the `identity',
    # `identity-images' and `identity-images-themes' section entries,
    # `identity-images' is a child entry of `identity' likewise
    # `identity-images-themes' is a child entry of `identity-images'.
    local PATTERN="$(echo $MANUAL_ENTRY | sed -r "s/\.${MANUAL_EXTENSION}$//")"

    # Define list of child entries we'll use as reference to build the
    # menu nodes. Reverse the output here to produce the correct value
    # based on menu nodes definition set further.
    local CHILD_ENTRIES=$(cli_getFilesList ${MANUAL_CHAPTER_DIR} \
        --pattern="${PATTERN}-[[:alnum:]]+\.${MANUAL_EXTENSION}" | sort -r | uniq )

    # Define menu nodes using section entries as reference.
    for CHILD_ENTRY in $CHILD_ENTRIES;do
        MENUNODES="* $(${FLAG_BACKEND}_getEntryNode "$CHILD_ENTRY")::\n${MENUNODES}"
    done

    # Define menu using menu nodes.
    MENU="@menu\n${MENUNODES}@end menu"

    # Expand menu definition using translation marker or menu
    # definition itself.
    sed -r -i "/^@menu$/,/^@end menu$/c\\${MENU}" $MANUAL_ENTRY
    
}
