#!/bin/bash
######################################################################
#
#   Modules/Locale/locale_convertPotToPo.sh -- This function
#   initializes the portable object when it doesn't exist. When the
#   portable object does exist, it is updated instead. In both cases,
#   the portable object template is used as source to merge changes
#   inside the portable object.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>
#
# Copyright (C) 2009-2013 The CentOS Project
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
######################################################################

function locale_convertPotToPo {

    local POT_FILE="${1}"
    local PO_FILE="${2}"

    # Verify the portable object template. The portable object
    # template is used to create the portable object. We cannot
    # continue without it. 
    tcar_checkFiles -ef ${POT_FILE}

    # Create the PO's parent directory if it doesn't exist.
    if [[ ! -d $(dirname ${PO_FILE}) ]];then
        mkdir -p $(dirname ${PO_FILE})
    fi

    # Print action message.
    tcar_printMessage "${PO_FILE}" --as-creating-line

    # Verify existence of portable object. The portable object is the
    # file translators edit in order to make translation works.
    if [[ -f ${PO_FILE} ]];then

        # Update portable object merging both portable object and
        # portable object template.
        msgmerge --output-file="${PO_FILE}" "${PO_FILE}" "${POT_FILE}" --quiet

    else

        # Initiate portable object using portable object template.
        # Do not print msginit sterr output, use centos-art action
        # message instead.
        msginit -i ${POT_FILE} -o ${PO_FILE} --width=70 \
            --no-translator > /dev/null 2>&1

    fi

    # Sanitate metadata inside the PO file.
    locale_updatePoMetadata "${PO_FILE}"

}
