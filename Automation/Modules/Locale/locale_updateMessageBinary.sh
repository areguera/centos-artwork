#!/bin/bash
#
# locale_updateMessageBinary.sh -- This function creates/updates
# machine objects (.mo) from portable objects (.po).
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function locale_updateMessageBinary {

    # Verify machine object creation flag.
    if [[ ${FLAG_DONT_CREATE_MO} == 'true' ]];then
        return
    fi

    # Define absolute path to final portable object. This is the file
    # that contains all the individual function translation messages
    # and is used to build the machine object (.mo) file.
    local PO_FILE=${TRANSLATION[0]}

    # Define absolute path to machine object directory.
    local MO_DIR="$(dirame ${CONFIGURATION})/${TCAR_SCRIPT_LANG_LC}/LC_MESSAGES"

    # Define absolute path to machine object file.
    local MO_FILE="${MO_DIR}/${TEXTDOMAIN}.mo"

    # Print action message.
    cli_printMessage "${PO_FILE}" --as-creating-line

    # Combine all the function individual portable objects into just
    # one portable object. Be sure to use just the first translation
    # found, otherwise the automated flow will be broken for you to
    # decide which one of two or more variants should remain in the
    # portable object.
    msgcat ${PO_FILES} --use-first --output-file=${PO_FILE}
    
    # Print action message.
    cli_printMessage "${MO_FILE}" --as-creating-line

    # Verify absolute path to machine object directory, if it doesn't
    # exist create it.
    if [[ ! -d ${MO_DIR} ]];then
        mkdir -p ${MO_DIR}
    fi

    # Create machine object from portable object.
    msgfmt --check ${PO_FILE} --output-file=${MO_FILE}

}
