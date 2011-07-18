#!/bin/bash
#
# texinfo_updateChapterNodes.sh -- This function updates nodes of
# chapters based on menu of chapters.
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

function texinfo_updateChapterNodes {

    # Build chapter nodes using entries from chapter menu as
    # reference. Don't include `Licenses' or `Index' chapters here.
    # These chapters are part of our manual's main defintion file and
    # shouldn't be handled as regular chapters.
    local CHAPTERNODES=$(cat ${MANUAL_BASEFILE}-menu.${MANUAL_EXTENSION} \
        | egrep -v '^@(end )?menu$' | egrep -v '^\* (Licenses|Index)::$'\
        | sed -r 's!^\* !!' | sed -r 's!::[[:print:]]*$!!g' \
        | sed -r 's! !_!g')

    # Build list of inclusions from chapter nodes. 
    local FILENODE=$(\
        for CHAPTERNODE in ${CHAPTERNODES};do
            INCL=$(echo ${CHAPTERNODE} \
                | sed -r "s!(${CHAPTERNODE})!\1/chapter\.${MANUAL_EXTENSION}!")
            # Output inclusion line using texinfo format.
            echo "@include $INCL"
        done)

    # Dump organized nodes of chapters into file.
    echo "$FILENODE" > ${MANUAL_BASEFILE}-nodes.${MANUAL_EXTENSION}

}
