#!/bin/bash
#
# texinfo_updateChaptersNodes.sh -- This function updates nodes of
# chapters based on menu of chapters.
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

function texinfo_updateChaptersNodes {

    # Build list "nodes of chapters" based on menu of chapters.
    local CHAPTERNODES=$(cat ${MANUAL_BASEFILE}-menu.texi \
        | egrep -v '^@(end )?menu$' \
        | egrep -v "^\* `gettext "Index"`::[[:print:]]*$" \
        | sed -r 's!^\* !!' | sed -r 's!::[[:print:]]*$!!g' \
        | sed -r 's! !_!g' | sort | uniq )

    # Build list of texinfo inclusions to load chapters' nodes.
    local FILENODE=$(\
    for CHAPTERNODE in ${CHAPTERNODES};do

        INCL=$(echo ${CHAPTERNODE} | sed -r "s!(${CHAPTERNODE})!\1/chapter\.texi!")

        # Output inclusion line using texinfo format.
        echo "@include $INCL"

    done)

    # Dump organized nodes of chapters into file.
    echo "$FILENODE" > ${MANUAL_BASEFILE}-nodes.texi

}
