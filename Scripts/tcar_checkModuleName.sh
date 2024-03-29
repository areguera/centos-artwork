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

# Verify whether child and sibling modules do exist or not, based on
# module's based directory.
function tcar_checkModuleName {

    local TCAR_MODULE_LIST=$(ls ${TCAR_MODULE_BASEDIR} | tr '\n' '|' \
        | sed -r 's/\|$//' | tr '[[:upper:]]' '[[:lower:]]')

    tcar_printMessage "TCAR_MODULE_LIST : ${TCAR_MODULE_LIST}" --as-debugger-line

    tcar_checkFiles -m "^(${TCAR_MODULE_LIST})$" "${TCAR_MODULE_NAME}"

}
