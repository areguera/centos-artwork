#!/bin/bash
#
# texinfo_renameEntryChapter.sh -- This function standardizes renaming
# tasks related to manual chapters inside documentation manuals
# written in texinfo format.
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

function texinfo_renameEntryChapter {

    # Copy section source entry to target location.
    ${MANUAL_BACKEND}_copyEntryChapter

    # Delete section source entry.
    ${MANUAL_BACKEND}_deleteEntryChapter

    # Rename menu, nodes and cross references related entries.
    ${MANUAL_BACKEND}_renameCrossReferences

}
