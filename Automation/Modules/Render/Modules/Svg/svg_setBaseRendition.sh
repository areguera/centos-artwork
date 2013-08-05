#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Svg/Scripts/svg_setBaseRendition.sh -- This
#   function standardizes the base rendition tasks needed to produce
#   PNG files from SVG files.
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

function svg_setBaseRendition {

    local COUNTER=0

    local -a SOURCE_INSTANCES
    local -a TARGET_INSTANCES
    local -a TARGET_COMMANDS
    local -a INKSCAPE_OPTIONS

    while [[ ${COUNTER} -lt ${#SOURCES[*]} ]];do

        # Verify existence and extension of design models.
        tcar_checkFiles -ef -m '\.(svgz|svg)$' ${SOURCES[${COUNTER}]} 

        # Define file name for design model instances. We need to use
        # a random string in from of it to prevent duplication.
        # Remember that different files can have the same name in
        # different locations. Use the correct file information.
        SOURCE_INSTANCES[${COUNTER}]=${TCAR_SCRIPT_TEMPDIR}/${RANDOM}-$(basename ${SOURCES[${COUNTER}]})

        # Define file name for image instances. We need to use a
        # random string in from of it to prevent duplication.
        # Remember that different files can have the same name in
        # different locations. Use the correct file information.
        TARGET_INSTANCES[${COUNTER}]=${TCAR_SCRIPT_TEMPDIR}/${RANDOM}-$(basename ${SOURCES[${COUNTER}]} \
            | sed -r 's/\.(svgz|svg)$/.png/')

        # Create source instance considering whether or not it has
        # translation files related.Apply translation files to source instance, if any.
        render_setLocalizedXml "${SOURCES[${COUNTER}]}" "${SOURCE_INSTANCES[${COUNTER}]}"

        # Make your best to be sure the source instance you are
        # processing is a valid Scalable Vector Graphic (SVG) file.
        tcar_checkFiles -i 'text/xml' ${SOURCE_INSTANCES[${COUNTER}]}

        # Expand any translation file that might exist.
        tcar_setTranslationMarkers ${SOURCE_INSTANCES[${COUNTER}]}

        svg_checkModelAbsref "${SOURCE_INSTANCES[${COUNTER}]}"

        svg_setBaseRenditionOptions

        svg_setBaseRenditionCommand

        COUNTER=$(( ${COUNTER} + 1 ))

    done
    
    # Verify existence of output directory.
    if [[ ! -d $(dirname ${TARGET}) ]];then
        mkdir -p $(dirname ${TARGET})
    fi

    tcar_printMessage "${TARGET}" --as-creating-line

    # Apply command to PNG images produced from design models to
    # construct the final PNG image.
    ${COMMAND} ${TARGET_INSTANCES[*]} ${TARGET}

    # Apply branding images to final PNG image.
    if [[ ! -z ${BRANDS} ]];then
        svg_setBrandInformation
    fi

    # Apply comment to final PNG image.
    if [[ ! -z ${COMMENT} ]];then
        /usr/bin/mogrify -comment "${COMMENT}" ${TARGET}
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
    unset TARGET_COMMANDS
    unset INKSCAPE_OPTIONS
    unset COUNTER

}
