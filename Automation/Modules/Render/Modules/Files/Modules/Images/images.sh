#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Direct/images.sh -- This module
#   standardizes production of image files from other image files.
#   There is no intermediate process here.  The image or images
#   provided as value to render-from variable are used to create the
#   image specified in the section line using the command specified in
#   the command variable, without any intermediate process.
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

function images {

    tcar_checkFiles -i "image" ${SOURCE[*]}

    COMMAND=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "command")
    if [[ -z ${COMMAND} ]];then
        COMMAND="/usr/bin/images -append"
    fi

    if [[ ! -d $(dirname ${TARGET}) ]];then
        mkdir -p $(dirname ${TARGET})
    fi
 
    tcar_printMessage "${TARGET}" --as-creating-line

    eval ${COMMAND} ${SOURCES[*]} ${TARGET}

}
