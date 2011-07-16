#!/bin/bash
#
# texinfo_updateStructureSection.sh -- This function looks for all
# documentation entry (section) files inside manual's base directory and
# updates menu, nodes and cross references for them.
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

function texinfo_updateStructureSection {

    local PATTERN=''
    local MANUAL_ENTRY=''
    local MANUAL_ENTRIES=''

    # Define find's regular expression pattern.
    if [[ $1 != '' ]];then
        PATTERN="$1"
    else
        PATTERN=".+\.${MANUAL_EXTENSION}"
    fi

    # Define list of target documentation entries using find's regular
    # expression pattern as reference. This is required in order to
    # process non-existent documentation entries (e.g., when they are
    # created for first time). Otherwise, the list of documentation
    # entries will be empty an no entry would be processed.
    if [[ ${PATTERN} =~ '^/.+\.texinfo$' ]];then

        # When the pattern value is an absolute path to a
        # documentation entry, use that value as only documentation
        # entry in the list.
        MANUAL_ENTRIES=${PATTERN}

    else

        # When the pattern value is a regular expression, use
        # cli_getFilesList to build the list of documentation entries
        # using it.  Don't include manual or chapter definition files
        # in this list, it would create documentation entries for them
        # and that shouldn't happen.
        MANUAL_ENTRIES=$(cli_getFilesList $(dirname ${MANUAL_BASEDIR}) \
            --pattern="$PATTERN" | egrep -v "/(${MANUAL_NAME}|chapter)")
    fi

    # Print action message.
    cli_printMessage "`gettext "Updating section menus, nodes and cross references."`" --as-response-line

    # Loop through target documentation entries in order to update
    # the documentation structure (e.g., It is not enough with copying
    # documentation entry files, it is also needed to update menu,
    # nodes and related cross-references).
    for MANUAL_ENTRY in ${MANUAL_ENTRIES};do

        # Update menu and node definitions for sections inside manual
        # in order to reflect the changes.
        ${FLAG_BACKEND}_updateSectionMenu
        ${FLAG_BACKEND}_updateNodes

        # Resotre cross reference definitions inside manual structure.
        # If a documentation entry has been removed by mistake and
        # that mistake is later fixed by adding the removed
        # documentation entry back into the manual structure, it is
        # necessary to rebuild the missing cross reference information
        # inside the manual structure in order to reactivate the
        # removed cross refereces, as well.
        ${FLAG_BACKEND}_restoreCrossReferences $MANUAL_ENTRY

    done

}
