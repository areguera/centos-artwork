#!/bin/bash
#
# texinfo_updateMenu.sh -- This function updates chapter's menu
# definition file.  If this function is called with the 'remove-entry'
# string as first argument, the menu line related to the entry being
# processed is removed. Otherwise, if this function is called with the
# 'update-entry' string as first argument, the menu line related to
# the entry being processed is added to menu's bottom.  If no argument
# is passed to this function, the 'update-entry' action is assumed.
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

function texinfo_updateMenu {

    # Specify which action to do with documentation entry inside the
    # chapter menu.
    local ACTION="$1"

    # Build node information used inside chapter menu.
    local MENUNODE=$(${FLAG_BACKEND}_getNode "$MANUAL_ENTRY")

    # Define menu entry using texinfo style and node information as
    # reference.
    local MENULINE="* ${MANUAL_CHAPTER_NAME} ${MENUNODE}::" 

    # Retrive list of menu entries from chapter menu and exclude
    # `@menu', `@end menu' and empty lines from output.
    local MENU=$(cat $MANUAL_CHAPTER_DIR/chapter-menu.${MANUAL_EXTENSION} \
        | egrep -v '^[[:space:]]*$' | egrep -v '^@(end )?menu')

    # Re-defined chapter menu entries based on action provided to this
    # function as first positional parameter.
    case $ACTION in

        'remove-entry' )
            # Remove menu entry from chapter menu.
            MENU=$(echo "$MENU" | egrep -v "$MENULINE")
            ;;

        'update-entry' | * )
            # Add menu entry to chapter menu list as last entry.
            MENU="$MENU
            $MENULINE"
            ;;

    esac

    # Remove empty lines from chapter menu entries. Don't order
    # alphabetically.  That would suppress the idea of putting the
    # last entry added as last entry in the chapter menu entries.
    MENU=$(echo "$MENU" | egrep -v '^[[:space:]]*$')

    # Rebuild list of chapter menu entries including '@menu' and '@end
    # menu' lines back into chapter menu.
    MENU="@menu
    $MENU
    @end menu"

    # Remove opening spaces/tabs from final menu structure.
    MENU=$(echo "$MENU" | sed -r 's!^[[:space:]]+!!g')

    # Dump chapter menu entries back into chapter's menu definition
    # file.
    echo "$MENU" > $MANUAL_CHAPTER_DIR/chapter-menu.${MANUAL_EXTENSION}

}
