#!/bin/bash
#
# texinfo_renameEntry.sh -- This function renames documentation entries
# and updates documentation structure to reflect changes.
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

function texinfo_renameEntry {

    # Copy source documentation entry.
    ${FUNCNAM}_copyEntry "$1" "$2"

    # Delete source documentation entry. The source documentation
    # entry has been copied already, so to create the rename effect
    # delete it from repository filesystem.
    ${FUNCNAM}_deleteEntry "$1"

    # At this point, source documentation entry has been removed and
    # all menu, nodes and cross-references have been commented. So,
    # replace commented menu, nodes and cross-reference information
    # from source to target documentation entry.
    ${FUNCNAM}_renameCrossReferences "$1" "$2"

}
