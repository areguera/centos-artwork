#!/bin/bash
######################################################################
#
#   svg.sh -- This module standardizes localization update actions of
#   svg files inside the repository.
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

function svg {

    local SVG_FILE=''
    local SVG_FILES=${SOURCES[*]}

    for SVG_FILE in ${SVG_FILES};do

        # Define POT's default location using the source file as
        # reference. The portable object template is
        # locale-independent so it must be out of locale-specific
        # directories.
        local POT_FILE=${SVG_FILE}.pot

        tcar_printMessage "${POT_FILE}" --as-creating-line

        local SVG_INSTANCE=$(tcar_getTemporalFile $(basename ${SVG_FILE}))

        svg_createSvgInstance

        update_convertXmlToPot "${SVG_INSTANCE}" "${POT_FILE}"

        update_convertPotToPo "${POT_FILE}" "${PO_FILE}"

    done

}
