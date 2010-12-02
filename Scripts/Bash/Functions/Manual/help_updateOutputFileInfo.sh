#!/bin/bash
#
# help_updateOutputFileInfo.sh -- This function updates manual's info
# output related file.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function help_updateOutputFileInfo {

    # Output action message.
    cli_printMessage "`gettext "Updating manual's info output"`" 'AsResponseLine'

    # Check info output directory.
    [[ ! -d ${MANUALS_DIR[3]} ]] &&  mkdir -p ${MANUALS_DIR[3]}

    # Update info file.
    /usr/bin/makeinfo ${MANUALS_FILE[1]} --output=${MANUALS_FILE[4]}

    # Check info file. If the info file was not created then there are
    # errors to fix.
    if [[ ! -f ${MANUALS_FILE[4]} ]];then
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Compress info file.
    bzip2 -f ${MANUALS_FILE[4]}

}
