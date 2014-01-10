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

# Standardize the way tcar.sh script prints help about itself.
function tcar_printHelp {

    if [[ -z ${TCAR_MODULE_NAME} ]];then
        TCAR_MANPAGE_NAME=${TCAR_SCRIPT_NAME}
    else
        TCAR_MANPAGE_NAME=${TCAR_SCRIPT_NAME}-${TCAR_MODULE_NAME}
    fi

    # Print requested documentation. 
    /usr/bin/man -M ${TCAR_SCRIPT_DIR_MANUALS} "${TCAR_MANPAGE_NAME}"

    # Finish script execution successfully.
    exit 0

}
