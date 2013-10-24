#!/bin/bash
######################################################################
#
#   extended_setBaseRendition.sh -- This function standardize base
#   rendition tasks needed to perform the extended production of PNG
#   files from SVG files.
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

function extended_setBaseRendition {

    svg_setBaseRendition

    # Create path for different image formats creation using PNG image
    # extension as reference.
    local RENDER_TARGET=$(echo ${RENDER_TARGET} | sed -r "s/\.png$//")

    # Convert images from PNG to those formats specified in the
    # configuration file.
    for FORMAT in ${FORMATS};do
        if [[ ${FORMAT} =~ 'png' ]];then
            continue
        fi
        tcar_printMessage "${RENDER_TARGET}.${FORMAT}" --as-creating-line
        convert ${RENDER_TARGET}.png ${RENDER_TARGET}.${FORMAT}
    done

}
