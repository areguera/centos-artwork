#!/bin/bash
#
# texinfo_deleteEntrySection.sh -- This function standardized section
# deletion inside the manual structure.
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

function texinfo_deleteEntrySection {

    # Print action message.
    cli_printMessage "$MANUAL_ENTRY" --as-deleting-line

    # Verify existence of documentation entry before deleting it. We
    # cannot delete an entry which doesn't exist.
    cli_checkFiles "$MANUAL_ENTRY"

    # Revert pending changes inside the section entry in order to
    # prepare the file for deletion.
    svn revert $MANUAL_ENTRY --quiet

    # Remove documentation entry using subversion to register the
    # change.
    svn del $MANUAL_ENTRY --quiet

    # Update section menu, nodes and cross references.
    ${FLAG_BACKEND}_updateStructureSection "${MANUAL_ENTRY}" --delete

}
