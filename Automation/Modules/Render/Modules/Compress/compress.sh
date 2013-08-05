#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Compress/compress.sh -- This file
#   standardize file compression inside the centos-art.sh script.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function compress {

    tcar_printMessage "${TARGET}" --as-creating-line

    COMMAND=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "command")
    if [[ -z ${COMMAND} ]];then
        COMMAND="/bin/gzip"
    fi

    tcar_checkFiles -ef ${SOURCES[*]}

    ${COMMAND} ${SOURCES[*]}

}
