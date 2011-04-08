#!/bin/bash
#
# help_updateMenu.sh -- This function updates menu lines inside
# texinfo chapters.  If this function is called with the
# 'remove-entry' string as first argument, then the menu line related
# to the entry being processed is removed. If this function is called
# with the 'update-entry' string as first argument, then the menu line
# related to the entry being processed is added to the menu. If no
# argument is passed to this function, the 'update-entry' action is
# assumed.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_updateMenu {

    # Specify which action to do inside chapter's menu.
    local ACTION="$1"

    # Build the menu node related to the entry being processed
    # currently.
    local MENUNODE=$(echo "$ENTRY" | cut -d / -f8- | tr '/' ' ' \
        | sed 's!\.texi$!!')

    # Give format to menu line using texinfo style.
    local MENULINE="* ${MANUAL_CHAPTER_NAME} $MENUNODE::" 

    # Define chapter's menu. Remove `@menu', `@end menu', and empty lines
    # from output.
    local MENU=$(cat $MANUAL_CHAPTER_DIR/chapter-menu.texi \
        | egrep -v '^[[:space:]]*$' | egrep -v '^@(end )?menu') 

    # Re-defined chapter's menu based on action.
    case $ACTION in
        'remove-entry' )
            # Remove menu line from chapter's menu.
            MENU=$(echo "$MENU"  | egrep -v "$MENULINE")
            ;;
        'update-entry' | * )
            # Add menu line to chapter's menu. This is the default
            # behaivour if no argument is passed to help_updateMenu
            # function.
            MENU="$MENU
            $MENULINE"
            ;;
    esac

    # Organize menu alphabetically, remove empty and duplicated lines.
    # At this point, empty line may occur the first time the menu is
    # created, don't let them to scape.
    MENU=$(echo "$MENU" | egrep -v '^[[:space:]]*$' | sort | uniq )

    # Rebuild chapter's menu structure adding '@menu' and '@end menu'
    # lines back in menu.
    MENU="@menu
    $MENU
    @end menu"

    # Remove opening spaces/tabs from final menu structure.
    MENU=$(echo "$MENU" | sed -r 's!^[[:space:]]+!!g')

    # Dump final menu structure back into chapter's menu file.
    echo "$MENU" > $MANUAL_CHAPTER_DIR/chapter-menu.texi

}
