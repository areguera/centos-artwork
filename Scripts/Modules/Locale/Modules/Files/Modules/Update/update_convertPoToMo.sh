#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Convert portable object (.po) files to machine object (.mo) files.
function update_convertPoToMo {

    # Print action message.
    tcar_printMessage "${MO_FILE}" --as-creating-line

    # Verify absolute path to machine object directory, if it doesn't
    # exist create it.
    if [[ ! -d $(dirname ${MO_FILE}) ]];then
        mkdir -p $(dirname ${MO_FILE})
    fi

    # Create machine object from portable object.
    msgfmt --check ${PO_FILE} --output-file=${MO_FILE}

}
