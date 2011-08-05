#!/bin/bash
#
# texinfo_updateStructureSection.sh -- This function looks for all
# section entry files inside manual's base directory and updates menu,
# nodes and cross references definitions for them all, one at a time.
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

function texinfo_updateStructureSection {

    # Print action message. These actions might consume some time to
    # finish. The more section entries the regular expression pattern
    # matches, the more time it will take to finish.
    cli_printMessage "`gettext "Updating section menus, nodes and cross references"`" --as-banner-line

    local PATTERN=''
    local MANUAL_ENTRIES=''
    local ACTIONNAM_SECMENU=''
    local ACTIONNAM_CROSREF=''

    # Define regular expression pattern used to build the list of
    # section entries that will be processed.
    if [[ "$1" != '' ]];then
        PATTERN="$1"
    else
        PATTERN="${MANUAL_ENTRY}"
    fi

    # Verify the pattern value considering both the chapter and
    # section names. This is required when no chapter or section name
    # is provided to `centos-art.sh' script, as non-option argument in
    # the command-line (e.g., `centos-art help --update-structure').
    if [[ $PATTERN =~ "${MANUAL_NAME}\.${MANUAL_EXTENSION}$" ]] \
        || [[ $PATTERN =~ "chapter\.${MANUAL_EXTENSION}$" ]];then
        PATTERN="$(dirname ${MANUAL_ENTRY})/.+\.${MANUAL_EXTENSION}"
    fi

    # Define action to perform on menu, nodes and cross references
    # definitions.
    case "$2" in 

        --delete )

            # Remove menu and node definitions for sections inside
            # manual, in order to reflect the changes.
            ACTIONNAM_SECMENU='updateSectionMenu --delete-entry'

            # Remove cross reference definitions inside manual
            # structure.
            ACTIONNAM_CROSREF='deleteCrossReferences'
            ;;

        --update | * )

            # Update menu and node definitions for sections inside
            # manual, in order to reflect the changes.
            ACTIONNAM_SECMENU='updateSectionMenu --add-entry'

            # Resotre cross reference definitions inside manual
            # structure.  If a documentation entry has been removed by
            # mistake and that mistake is later fixed by adding the
            # removed documentation entry back into the manual
            # structure, it is necessary to rebuild the missing cross
            # reference information inside the manual structure in
            # order to reactivate the removed cross refereces, as
            # well.
            ACTIONNAM_CROSREF='restoreCrossReferences'
            ;;

    esac

    # Define list of target entries using find's regular expression
    # pattern as reference. Notice that, when we update section
    # definition files, the files already exist in the working copy so
    # the pattern can be its absolute path without any problem. If the
    # pattern is built correctly, it will match the location and so be
    # returned to build the list of entries to process. Notice also
    # that, when updating, it is possible to use a regular expression
    # to match more than one location and build the list of entries
    # based on such matching.  In this last configuration, let you to
    # update menu, nodes and cross references to many section
    # definitions (i.e., all those section definition file that match
    # the pattern you specified). 
    MANUAL_ENTRIES=$(cli_getFilesList ${MANUAL_BASEDIR_L10N} \
        --pattern="${PATTERN}" | egrep -v "/(${MANUAL_NAME}|chapter)")

    # Verify list of target entries. Assuming is is empty,  define
    # list of target documentation entries using pattern as reference
    # instead.  When we delete a section entry from the working copy,
    # using find to retrive its path isn't possible because the
    # section definition file is removed before executing find and by
    # consequence no match is found.  This issue provokes no section
    # entry to be removed from menu, nodes and cross references. In
    # order to solve this, use the pattern value as list of target
    # entries.  Notice that, in this case, the pattern value must be
    # the absolute path to that documentation entry which doesn't
    # exist and we want to update menu, nodes and cross references
    # information for.
    if [[ $MANUAL_ENTRIES == '' ]] && [[ $PATTERN =~ '^[[:alnum:]./_-]+$' ]];then
        MANUAL_ENTRIES=${PATTERN}
    fi

    # Verify list of target entries. Assumming it is still empty,
    # there is nothing else to do here but printing an error message
    # describing the fact that no section entry was found to process.
    if [[ $MANUAL_ENTRIES == '' ]];then
        cli_printMessage "`gettext "No section entry found to process."`" --as-error-line
    fi

    # Loop through target documentation entries in order to update the
    # documentation structure (e.g., it is not enough with copying
    # documentation entry files, it is also needed to update menu,
    # nodes and related cross-references).
    for MANUAL_ENTRY in ${MANUAL_ENTRIES};do
        cli_printMessage "${MANUAL_ENTRY}" --as-response-line
        ${MANUAL_BACKEND}_${ACTIONNAM_SECMENU}
        ${MANUAL_BACKEND}_updateSectionNodes
        ${MANUAL_BACKEND}_makeSeeAlso "${MANUAL_ENTRY}"
        ${MANUAL_BACKEND}_${ACTIONNAM_CROSREF} "${MANUAL_ENTRY}"
    done

}
