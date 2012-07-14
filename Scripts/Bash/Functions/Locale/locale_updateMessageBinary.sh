#!/bin/bash
#
# locale_updateMessageBinary.sh -- This function creates/updates
# machine objects (.mo) from portable objects (.po).
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

function locale_updateMessageBinary {

    # Verify machine object creation flag.
    if [[ ${FLAG_DONT_CREATE_MO} == 'true' ]];then
        return
    fi

    # Define absolute path to portable object file.
    local PO_FILE="$1"

    # Verify existence of portable object file.
    cli_checkFiles "${PO_FILE}"

    # Define absolute path to machine object directory.
    local MO_DIR="${L10N_WORKDIR}/LC_MESSAGES"

    # Define absolute path to machine object file.
    local MO_FILE="${MO_DIR}/${CLI_NAME}.sh.mo"

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
