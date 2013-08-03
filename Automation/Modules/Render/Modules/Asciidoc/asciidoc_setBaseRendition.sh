#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Asciidoc/Scripts/asciidoc_setBaseRendition.sh
#   -- This function standardizes transformation of asciidoc files
#   into docbook files.
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

function asciidoc_setBaseRendition {

    local COUNTER=0

    while [[ ${COUNTER} -lt ${#SOURCES[*]} ]];do

        tcar_checkFiles "${SOURCES[${COUNTER}]}" -f --match='\.asciidoc$'

        # Define file name for design model instances. We need to use
        # a random string in from of it to prevent duplication.
        # Remember that different files can have the same name in
        # different locations. Use the correct file information.
        SOURCE_INSTANCES[${COUNTER}]=$(tcar_getTemporalFile "${RANDOM}-$(basename ${SOURCES[${COUNTER}]})")

        # Define file name for image instances. We need to use a
        # random string in from of it to prevent duplication.
        # Remember that different files can have the same name in
        # different locations. Use the correct file information.
        TARGET_INSTANCES[${COUNTER}]=$(tcar_getTemporalFile "${RANDOM}-$(basename ${SOURCES[${COUNTER}]} \
            | sed -r 's/\.asciidoc$/.docbook/')")

        /usr/bin/asciidoc --backend="docbook" --doctype="${RENDER_FLOW}" \
            --out-file="${SOURCE_INSTANCES[${COUNTER}]}" ${SOURCES[${COUNTER}]}

        # Create source instance considering whether or not it has
        # translation files related.Apply translation files to source
        # instance, if any.
        render_setLocalizedXml "${SOURCE_INSTANCES[${COUNTER}]}" "${TARGET_INSTANCES[${COUNTER}]}"

        # Make your best to be sure the source instance you are
        # processing is a valid DocBook file.
        tcar_checkFiles ${TARGET_INSTANCES[${COUNTER}]} --mime='^text/xml$'

        # Expand any translation file that might exist.
        tcar_setTranslationMarkers ${TARGET_INSTANCES[${COUNTER}]}

        COUNTER=$(( ${COUNTER} + 1 ))

    done

    # Initiate format-specific transformations for current render
    # flow.
    for DOCBOOK_FILE in ${TARGET_INSTANCES[*]};do
        tcar_setModuleEnvironment "${RENDER_FLOW}" "${@}"
    done

}
