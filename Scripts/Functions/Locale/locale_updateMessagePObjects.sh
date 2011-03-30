#!/bin/bash
#
# locale_updateMessagePObjects.sh --- This function verifies,
# initializes or updates portable objects from portable object
# templates.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function locale_updateMessagePObjects {

    local FILE="$1"

    # Verify the portable object template. The portable object
    # template is used to create the portable object. 
    cli_checkFiles "${FILE}.pot" 'f'

    # Verify existence of portable object. The portable object is the
    # file translators edit in order to make translation works.
    if [[ -f ${FILE}.po ]];then

        # Print action message.
        cli_printMessage "${FILE}.po" 'AsUpdatingLine'

        # Update portable object merging both portable object and
        # portable object template.
        msgmerge --output="${FILE}.po" "${FILE}.po" "${FILE}.pot" --quiet

    else

        # Print action message.
        cli_printMessage "${FILE}.po" 'AsCreatingLine'

        # Initiate portable object using portable object template.
        # Do not print msginit sterr output, use centos-art action
        # message instead.
        msginit -i ${FILE}.pot -o ${FILE}.po --width=70 \
            --no-translator 2> /dev/null

        # Sanitate portable object metadata. This is the first time
        # the portable object is created so some modifications are
        # needed to customized metadata.
        locale_updateMessageMetadata "${FILE}.po"

    fi

}
