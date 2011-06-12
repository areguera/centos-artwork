#!/bin/bash
#
# help_getChapterDir.sh -- This function outputs the entry's
# chapter directory.
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

function help_getChapterDir {

    local MANUAL_ENTRY=''
    local MANUAL_ENTRIES="$1"

    # At this point, we need to take a desition about documentation
    # design, in order to answer the question: How do we assign
    # chapters, sections and subsections automatically, based on the
    # repository structure?  and also, how such design could be
    # adapted to changes in the repository structure?
    #
    # One solution would be: represent the repository's directory
    # structure as sections inside a chapter named `Directories' or
    # something similar. Subsections and subsubsections will not have
    # their own files, they all will be written inside the same
    # section file that represents the repository documentation entry.
    for MANUAL_ENTRY in $MANUAL_ENTRIES;do
        ${FUNCNAM}_getEntry $MANUAL_ENTRY | cut -d / -f-8
    done | sort | uniq

}
