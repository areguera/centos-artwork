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

# Standardize file archiving inside the tcar.sh script.
function archive {

    tcar_printMessage "${RENDER_TARGET}" --as-creating-line

    COMMAND=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "command")
    if [[ -z ${COMMAND} ]];then
        COMMAND="/bin/tar --remove-files -czf"
    fi

    # Let file names to be changed before compressing them.
    for SOURCE in ${SOURCES[*]};do
        FILE_LH=$(echo ${SOURCE} | gawk -F: '{ print $1 }')
        tcar_checkFiles -ef ${FILE_LH}
        FILE_RH=$(echo ${SOURCE} | gawk -F: '{ print $2 }')
        cp ${FILE_LH} ${TCAR_SCRIPT_TEMPDIR}/${FILE_RH}
    done

    pushd ${TCAR_SCRIPT_TEMPDIR} > /dev/null

    ${COMMAND} ${RENDER_TARGET} *

    popd > /dev/null

}
