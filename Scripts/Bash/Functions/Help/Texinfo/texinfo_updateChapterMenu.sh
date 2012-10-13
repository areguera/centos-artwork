#!/bin/bash
#
# texinfo_updateChapterMenu.sh -- This function updates chapter menu.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function texinfo_updateChapterMenu {

    local ACTION=$1
    local MENUCHAPTERS=''

    # Print action name.
    cli_printMessage "${MANUAL_BASEFILE}-menu.${MANUAL_EXTENSION}" --as-creating-line

    # Build menu of chapters. The Index node is not included as other
    # nodes are. The Index node is defined inside the master texinfo
    # file (repository.texinfo) as an included file. To create the final
    # .info file correctly, the Index line in the menu should remain,
    # even no other node exist.
    if [[ -f ${MANUAL_BASEFILE}-menu.${MANUAL_EXTENSION} ]];then
        MENUCHAPTERS=$(cat ${MANUAL_BASEFILE}-menu.${MANUAL_EXTENSION} \
            | egrep -v "^@(end )?menu$" \
            | egrep -v '^\* (Licenses|Index)::$')
    fi

    # Re-defined menu of chapters based on action.
    case $ACTION in

        --delete-entry )
            # Remove chapter from menu.
            MENUCHAPTERS=$(echo "${MENUCHAPTERS}" \
                | egrep -v '^\* '"${MANUAL_CHAPTER_NAME}"'::[[:print:]]*$')
            ;;

        --add-entry | * )
            # Update chapter menu using texinfo format. Be sure the
            # chapter node itself is not included here, that would
            # duplicate it inside the menu definition file which end
            # up being a definition error. Take care the way you quote
            # egrep's pattern, prevent to end up using the syntax
            # `$"..."' which has security risks.
            MENUCHAPTERS="$(echo "${MENUCHAPTERS}" \
                | egrep -v '\* '"${MANUAL_CHAPTER_NAME}"'::[[:print:]]*$')
                * ${MANUAL_CHAPTER_NAME}::"
            ;;
    esac

    # Remove opening spaces/tabs and empty line from the menu of
    # chapters. Empty lines may occur the first time the menu of
    # chapters is created.
    MENUCHAPTERS=$(echo "${MENUCHAPTERS}" | sed -r 's!^[[:space:]]+!!' \
        | egrep -v '^[[:space:]]*$')

    # Organize menu of chapters alphabetically and verify that no
    # duplicated line be included on the list. Notice that organizing
    # menu this way supresses the idea of putting the last chapter
    # created at the end of the list. 
    #MENUCHAPTERS=$(echo "${MENUCHAPTERS}" | sort | uniq)

    # Give format to final menu output.
    MENUCHAPTERS="@menu
    ${MENUCHAPTERS}
    * Licenses::
    * Index::
    @end menu"

    # Remove opening space/tabs from menu's final definition.
    MENUCHAPTERS=$(echo "${MENUCHAPTERS}" | sed -r 's!^[[:space:]]+!!' \
        | egrep -v '^[[:space:]]*$')

    # Dump organized menu of chapters into file.
    echo "${MENUCHAPTERS}" > ${MANUAL_BASEFILE}-menu.${MANUAL_EXTENSION}

}
