#!/bin/bash
#
# help_updateChaptersMenu.sh - This function updates chapter menu.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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
# 
# ----------------------------------------------------------------------
# $Id: help_updateChaptersMenu.sh 44 2010-09-17 05:58:18Z al $
# ----------------------------------------------------------------------

function help_updateChaptersMenu {

    local ACTION=$1
    local MENUCHAPTERS=''

    # Build menu of chapters. The Index node is not included as other
    # nodes are. The Index node is defined insde the master texinfo
    # file (repository.texi). To create the final .info file
    # correctly, the Index line in the menu should remain, even no
    # other node exist.
    if [[ -f ${MANUALS_FILE[2]} ]];then
        MENUCHAPTERS=$(cat ${MANUALS_FILE[2]} \
            | egrep -v "^(@(end )?menu$|\* `gettext "Index"`::.*)$")
    fi

    # Re-defined menu of chapters based on action.
    case $ACTION in
        'remove-entry' )
            # Remove chapter from menu.
            MENUCHAPTERS=$(echo "$MENUCHAPTERS" \
                | egrep -v "^\* ${CHAPTERNAME}::[[:print:]]*$")
            ;;
        'update-entry' | * )
            # Update chapter menu using texinfo format.
            MENUCHAPTERS="$MENUCHAPTERS
                * $CHAPTERNAME::"
            ;;
    esac

    # Remove opening spaces/tabs and empty line from the menu of
    # chapters. Empty lines may occur the first time the menu of
    # chapters is created.
    MENUCHAPTERS=$(echo "$MENUCHAPTERS" | sed -r 's!^[[:space:]]+!!' \
        | egrep -v '^[[:space:]]*$')

    # Organize menu of chapters alphabetically and verify that no
    # duplicated line be included on the list.
    MENUCHAPTERS=$(echo "$MENUCHAPTERS" | sort | uniq )

    # Give format to final menu output.
    MENUCHAPTERS="@menu
    $MENUCHAPTERS
    * `gettext "Index"`::
    @end menu"

    # Strip opening space/tabs from final menu of chapters.
    MENUCHAPTERS=$(echo "$MENUCHAPTERS" | sed -r 's!^[[:space:]]+!!' \
        | egrep -v '^[[:space:]]*$')

    # Dump organized menu of chapters into file.
    echo "$MENUCHAPTERS" > ${MANUALS_FILE[2]}

}
