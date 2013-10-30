#!/bin/bash
######################################################################
#
#   media.sh -- This module produces artwork for installation media.
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

function media {

    local MEDIA_TYPE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" 'media-type')
    tcar_checkFiles -m '^[[:alnum:]]+$' "${MEDIA_TYPE}"

    local MEDIA_NUMBER=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" 'media-number')
    tcar_checkFiles -m '^[[:digit:]]+$' "${MEDIA_NUMBER}"

    local MEDIA_RELEASE=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" 'media-release')
    tcar_checkFiles -m '^[[:digit:].]+$' "${MEDIA_RELEASE}"

    local MEDIA_ARCH=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" 'media-arch')
    tcar_checkFiles -m '^[[:alnum:]_-]+$' "${MEDIA_ARCH}"

    local MEDIA_SOURCES=${SOURCES[*]}
    local MEDIA_SOURCES_MAX=${#SOURCES[*]}

    local MEDIA_NUMBER_CURRENT=1

    while [[ ${MEDIA_NUMBER_CURRENT} -le ${MEDIA_NUMBER} ]];do

        local COUNTER=0
        local -a SOURCES_INSTANCES

        for RELEASE in ${MEDIA_RELEASE};do

            for ARCH in ${MEDIA_ARCH};do

                for MEDIA_SOURCE in ${MEDIA_SOURCES};do

                    SOURCES_INSTANCES[${COUNTER}]=$(tcar_getTemporalFile ${MEDIA_SOURCE})

                    # Create source instance considering whether or
                    # not it has translation files related. Apply
                    # translation files to source instance, if any.
                    render_setLocalizedXml "${MEDIA_SOURCE}" "${SOURCES_INSTANCES[${COUNTER}]}"

                    # Expand translation markers specific to
                    # installation media.
                    sed -i -r -e "s/=MEDIUM=/${MEDIA_TYPE}/g" \
                              -e "s/=CURRENT=/${MEDIA_NUMBER_CURRENT}/g" \
                              -e "s/=RELEASE=/${RELEASE}/g" \
                              -e "s/=ARCH=/${ARCH}/g" \
                              -e "s/=LAST=/${MEDIA_NUMBER}/g" \
                              ${SOURCES_INSTANCES[${COUNTER}]}

                    RENDER_TARGET="$(dirname ${RENDER_TARGET})/${SECTION}-${RELEASE}-${ARCH}-${MEDIA_NUMBER_CURRENT}of${MEDIA_NUMBER}.png"

                    SOURCES[${COUNTER}]=${SOURCES_INSTANCES[${COUNTER}]}

                    svg_setBaseRendition

                    rm ${SOURCES[${COUNTER}]}

                    if [[ ${MEDIA_SOURCES_MAX} -gt 1 ]];then
                        COUNTER=$(( ${COUNTER} + 1 ))
                    fi

                done

            done

        done

        MEDIA_NUMBER_CURRENT=$(( ${MEDIA_NUMBER_CURRENT} + 1 ))

    done 

}
