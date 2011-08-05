#!/bin/bash
#
# texinfo_searchIndex.sh -- This function does an index search inside the
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

function texinfo_searchIndex {

    # Rebuild output files to propagate recent changes.
    ${MANUAL_BACKEND}_updateOutputFiles

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Print action message.
    cli_printMessage "${MANUAL_BASEFILE}.info.bz2" --as-reading-line

    # Execute info command to perform an index-search.
    /usr/bin/info --index-search="$FLAG_SEARCH" --file=${MANUAL_BASEFILE}.info.bz2

}
