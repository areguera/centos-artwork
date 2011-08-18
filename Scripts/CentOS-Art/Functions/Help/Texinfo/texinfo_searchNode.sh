#!/bin/bash
#
# texinfo_searchNode.sh -- This function converts the documentation
# entry provided to `centos-art.sh' script command-line into a node
# and tries to read it from the manual's `.info' output file.
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

    # Verify documentation entry and, if it doesn't exist, prompt out
    # its creation.
    if [[ ! -f "$MANUAL_ENTRY" ]];then
        texinfo_editEntry
    fi

    # Verify manual output files and, if they don't exist, create
    # them.
    if [[ ! -f ${MANUAL_BASEFILE}.info.bz2 ]];then
        texinfo_updateOutputFiles
    fi

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Print action message.
    cli_printMessage "${MANUAL_BASEFILE}.info.bz2" --as-reading-line

    # Define manual node that will be read.
    local MANUAL_NODE="$(texinfo_getEntryNode "$MANUAL_ENTRY")"

    # Verify manual node that will be read. When the manual name is
    # the only value passed as documentation entry, then use the `Top'
    # node as manual node to be read.
    if [[ $MANUAL_NODE =~ $(texinfo_getEntryNode "$MANUAL_NAME") ]];then
        MANUAL_NODE='Top'
    fi

    # Use info reader to read the manual node.
    info --node="${MANUAL_NODE}" --file="${MANUAL_BASEFILE}.info.bz2"

}
