#!/bin/bash
######################################################################
#
#   svg_setBaseRendition.sh -- This function standardizes the base
#   rendition tasks needed to produce PNG files from SVG files.
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

function svg_setBaseRendition {

    local COUNTER=0

    local -a SOURCE_INSTANCES
    local -a TARGET_INSTANCES
    local -a INKSCAPE_OPTIONS

    while [[ ${COUNTER} -lt ${#SOURCES[*]} ]];do

        render_setInstances "${SOURCES[${COUNTER}]}" '(svgz|svg)' 'png'

        render_setLocalizedXml "${SOURCES[${COUNTER}]}" "${SOURCE_INSTANCES[${COUNTER}]}"

        tcar_setTranslationMarkers ${SOURCE_INSTANCES[${COUNTER}]}

        svg_checkModelAbsref "${SOURCE_INSTANCES[${COUNTER}]}"

        svg_setBaseRenditionOptions

        svg_setBaseRenditionCommand

        COUNTER=$(( ${COUNTER} + 1 ))

    done
    
    # Verify existence of output directory.
    if [[ ! -d $(dirname ${RENDER_TARGET}) ]];then
        mkdir -p $(dirname ${RENDER_TARGET})
    fi

    tcar_printMessage "${RENDER_TARGET}" --as-creating-line

    # Apply command to PNG images produced from design models to
    # construct the final PNG image.
    if [[ -n ${COMMAND} ]];then
        ${COMMAND} ${TARGET_INSTANCES[*]} ${RENDER_TARGET}
    fi

    # Apply branding images to final PNG image.
    if [[ -n ${BRANDS} ]];then
        svg_setBrandInformation
    fi

    # Apply comment to final PNG image.
    if [[ -n ${COMMENT} ]];then
        /usr/bin/mogrify -comment "${COMMENT}" ${RENDER_TARGET}
    fi

    # Remove instances to save disk space. There is no need to have
    # unused files inside the temporal directory. They would be
    # consuming space unnecessarily. Moreover, there is a remote
    # chance of name collapsing (because the huge number of files that
    # would be in place and the week random string we are putting in
    # front of files) which may produce unexpected results.
    rm ${TARGET_INSTANCES[*]} ${SOURCE_INSTANCES[*]}

    # Unset array variables and their counter to prevent undesired
    # concatenations.
    unset SOURCE_INSTANCES
    unset TARGET_INSTANCES
    unset INKSCAPE_OPTIONS
    unset COUNTER

}
