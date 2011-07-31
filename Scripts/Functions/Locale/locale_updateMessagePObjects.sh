#!/bin/bash
#
# locale_updateMessagePObjects.sh -- This function initializes the
# portable object when it doesn't exist. When the portable object does
# exist, it is updated instead. In both cases, the portable object
# template is used as source to merge changes inside the portable
# object.
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

function locale_updateMessagePObjects {

    local FILE="$1"

    # Verify the portable object template. The portable object
    # template is used to create the portable object. We cannot
    # continue without it. 
    cli_checkFiles "${FILE}.pot"

    # Print action message.
    cli_printMessage "${FILE}.po" --as-creating-line

    # Verify existence of portable object. The portable object is the
    # file translators edit in order to make translation works.
    if [[ -f ${FILE}.po ]];then

        # Update portable object merging both portable object and
        # portable object template.
        msgmerge --output="${FILE}.po" "${FILE}.po" "${FILE}.pot" --quiet

    else

        # Initiate portable object using portable object template.
        # Do not print msginit sterr output, use centos-art action
        # message instead.
        msginit -i ${FILE}.pot -o ${FILE}.po --width=70 \
            --no-translator 2> /dev/null

        # Sanitate portable object metadata. This is the first time
        # the portable object is created so some modifications are
        # needed to customized metadata.
        ${CLI_FUNCNAME}_updateMessageMetadata "${FILE}.po"

    fi

}
