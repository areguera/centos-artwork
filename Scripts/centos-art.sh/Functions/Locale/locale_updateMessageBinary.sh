#!/bin/bash
#
# locale_updateMessageBinary.sh -- This function creates/updates
# machine objects (.mo) from portable objects (.po).
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
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
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function locale_updateMessageBinary {

    # Verify machine object creation flag.
    if [[ ${FLAG_DONT_CREATE_MO} == 'true' ]];then
        return
    fi

    local PO=''
    local MO=''
    local FILE=''
    local FILES="$1"

    for FILE in $FILES;do

        # Verify existence of portable object.
        cli_checkFiles "${FILE}" 'f'

        # Define absolute path to portable object.
        PO=$FILE

        # Define absolute path to machine object.
        MO=$(dirname ${PO})/LC_MESSAGES/$(basename ${PO} | sed -r 's!\.po$!.mo!')

        # Print action message.
        if [[ -f ${MO} ]];then
            cli_printMessage "${MO}" 'AsUpdatingLine'
        else
            cli_printMessage "${MO}" 'AsCreatingLine'
        fi

        # Define directory used to store machine object.
        MODIR=$(dirname ${MO})

        # Create directory to store machine object, if it doesn't
        # exist.
        if [[ ! -d ${MODIR} ]];then
            mkdir -p ${MODIR}
        fi
    
        # Create machine object from portable object.
        msgfmt --check ${PO} --output-file=${MO}

    done

}
