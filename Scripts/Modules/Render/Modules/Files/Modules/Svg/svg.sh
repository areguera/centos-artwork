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

# Initialize the svg module. The svg module takes SVG fies as input
# and produces different kind of images based on either simple or
# advanced rendition flow.
function svg {

    # Define command used to create final images from instance images.
    COMMAND=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "command")
    if [[ -z ${COMMAND} ]];then
        if [[ ${#SOURCES[*]} -gt 1 ]];then
            COMMAND="/usr/bin/convert +append"
        else
            COMMAND="/bin/cp"
        fi
    fi

    RENDER_FLOWS=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "render-flow")
    if [[ -z ${RENDER_FLOWS} ]];then
        RENDER_FLOWS='base'
    fi

    BRANDS=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "brand")

    COMMENT=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "comment")

    EXPORTID=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "export-id")

    RELEASE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" 'release')
    if [[ -z ${RELEASE} ]];then
        RELEASE=$(cut -f3 -d' ' /etc/redhat-release)
    fi
    MAJOR_RELEASE=$(echo ${RELEASE} | cut -d. -f1)

    for RENDER_FLOW in ${RENDER_FLOWS} ;do
        tcar_setModuleEnvironment -m "${RENDER_FLOW}" -t "child"
    done

}
