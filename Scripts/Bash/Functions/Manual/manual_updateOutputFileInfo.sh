#!/bin/bash
#
# manual_updateOutputFileInfo.sh -- This function exports
# documentation manual to info format.
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

function manual_updateOutputFileInfo {

    # Output action message.
    cli_printMessage "${MANUAL_BASEFILE}.info.bz2" 'AsUpdatingLine'

    # Update info file.
    /usr/bin/makeinfo ${MANUAL_BASEFILE}.texi --output=${MANUAL_BASEFILE}.info

    # Compress info file.
    if [[ $? -eq 0 ]];then
        bzip2 -f ${MANUAL_BASEFILE}.info
    fi

}
