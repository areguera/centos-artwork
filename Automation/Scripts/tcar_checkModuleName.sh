#!/bin/bash
######################################################################
#
#   tcar_checkModuleName.sh -- This function uses the module's based
#   directory to verify whether child and sibling modules do exist or
#   not.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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

function tcar_checkModuleName {

    local TCAR_MODULE_LIST=$(ls ${TCAR_MODULE_BASEDIR} | tr '\n' '|' \
        | sed -r 's/\|$//' | tr '[[:upper:]]' '[[:lower:]]')

    tcar_checkFiles -m "^(${TCAR_MODULE_LIST})$" "${TCAR_MODULE_NAME}"

    tcar_printMessage "TCAR_MODULE_LIST : ${TCAR_MODULE_LIST}" --as-debugger-line

}
