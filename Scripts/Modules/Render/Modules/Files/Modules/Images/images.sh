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

# Standardize production of image files from other image files.  There
# is no intermediate process here.  The image or images provided as
# value to render-from variable are used to create the image specified
# in the section line using the command specified in the command
# variable, without any intermediate process.
function images {

    tcar_checkFiles -i "image" ${SOURCES[*]}

    COMMAND=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "command")
    if [[ -z ${COMMAND} ]];then
        COMMAND="/usr/bin/images -append"
    fi

    if [[ ! -d $(dirname ${RENDER_TARGET}) ]];then
        mkdir -p $(dirname ${RENDER_TARGET})
    fi
 
    tcar_printMessage "${RENDER_TARGET}" --as-creating-line

    eval ${COMMAND} ${SOURCES[*]} ${RENDER_TARGET}

}
