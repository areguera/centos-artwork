#!/bin/bash
#
# texinfo_getEntry.sh -- This function builds a documentation entry
# based on location specified as first positional parameter.
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

function texinfo_getEntry {

    local MANUAL_ENTRY=''
    local MANUAL_SECTION_NAME=''
    local MANUAL_SECTION_NAMES="$@"

    # Loop through list of section names.
    for MANUAL_SECTION_NAME in $MANUAL_SECTION_NAMES;do

        # Define absolute path to documentation entry.
        MANUAL_ENTRY=${MANUAL_BASEDIR_L10N}/${MANUAL_CHAPTER_NAME}/${MANUAL_SECTION_NAME}.${MANUAL_EXTENSION}

        # Output entry's absolute path.
        echo ${MANUAL_ENTRY}

    done
    
}
