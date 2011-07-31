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

    # Verify documentation entry. If it doesn't exist, ask to create
    # it.
    if [[ ! -f "$MANUAL_ENTRY" ]];then
        ${FLAG_BACKEND}_editEntry
    fi

    # Verify manual output files. If they don't exist, create them.
    if [[ ! -f ${MANUAL_BASEFILE}.info.bz2 ]];then
        ${FLAG_BACKEND}_updateOutputFiles
    fi

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Print action message.
    cli_printMessage "${MANUAL_BASEFILE}.info.bz2" --as-reading-line

    # Use info reader to present manual's info output.
    info --node="$(${FLAG_BACKEND}_getEntryNode "$MANUAL_ENTRY")" --file=${MANUAL_BASEFILE}.info.bz2

}
