#!/bin/bash
#
# texinfo_searchNode.sh -- This function does a node search inside the
# info document.
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

function texinfo_searchNode {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Define list of documentation entries.
    local MANUAL_ENTRY=''
    local MANUAL_ENTRIES=$(${FLAG_BACKEND}_getEntry "$@")

    # Loop through manual entries and read related node.
    for MANUAL_ENTRY in $MANUAL_ENTRIES;do

        # Print action message.
        cli_printMessage "${MANUAL_BASEFILE}.info.bz2" --as-reading-line

        # Check documentation entry inside documentation structure. If
        # the documentation entry exits use the info reader to open
        # the info file at the specified node for reading it on the
        # terminal. Otherwise, ask the user to create it.
        if [[ -f "$MANUAL_ENTRY" ]];then
            /usr/bin/info --node="$(${FLAG_BACKEND}_getNode)" --file=${MANUAL_BASEFILE}.info.bz2
        else
            ${FLAG_BACKEND}_editEntry
        fi

    done

}
