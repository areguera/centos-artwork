#!/bin/bash
#
# svg_convertPngToBrands.sh -- This function provides post-rendition
# actions to produce brand images in different sizes and formats from
# the same SVG design model.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function svg_convertPngToBrands {

    # Define height dimensions you want to produce brands for.
    local SIZE=""
    local SIZES="16 20 22 24 32 36 38 40 48 64 72 78 96 112 124 128 148 164 196 200 512"

    # Define image formats you want to produce brands for.
    local FORMAT=""
    local FORMATS="xpm pdf jpg tif"

    for SIZE in ${SIZES};do

        # Redefine absolute path to file location where size-specific
        # images will be stored in.
        local FINALFILE=$(dirname $FILE)/${SIZE}/$(basename $FILE)

        # Prepare directory where size-specific images will be stored
        # in. If it doesn't exist create it.
        if [[ ! -d $(dirname $FINALFILE) ]];then
            mkdir -p $(dirname $FINALFILE)
        fi

        # Print action message.
        cli_printMessage "${FINALFILE}.png" --as-creating-line

        # Create size-specific PNG image ommiting all output.
        inkscape $INSTANCE --export-id=$EXPORTID \
            --export-png=${FINALFILE}.png --export-height=${SIZE} \
            &> /dev/null

        for FORMAT in ${FORMATS};do
        
            # Print action message.
            cli_printMessage "${FINALFILE}.${FORMAT}" --as-creating-line

            # Convert size-specific PNG image into different formats.
            convert ${FINALFILE}.png ${FINALFILE}.${FORMAT}

        done

        # Create copy of size-specific image in 2 colors.
        cli_printMessage "${FINALFILE}.xbm" --as-creating-line
        convert -colorspace gray -colors 2 ${FINALFILE}.png ${FINALFILE}.xbm

        # Create copy of size-specific image with emboss effect.
        cli_printMessage "${FINALFILE}-emboss.png" --as-creating-line
        convert -emboss 1 ${FINALFILE}.png ${FINALFILE}-emboss.png

    done

}
