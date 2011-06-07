#!/bin/bash
#
# render_svg_convertPngToBrands.sh -- This function provides
# last-rendition actions to produce CentOS brands. This function takes
# both The CentOS Symbol and The CentOS Type images and produces
# variation of them in different dimensions and formats using
# ImageMagick tool-set.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function render_svg_convertPngToBrands {

    # Define height dimensions you want to produce brands for.
    local SIZES="16 20 22 24 32 36 40 48 64 96 128 148 164 196 200 512"

    # Define image formats you want to produce brands for.
    local FORMATS="png xpm pdf jpg tif"

    for SIZE in ${SIZES};do

        for FORMAT in ${FORMATS};do
        
            # Output action information.
            cli_printMessage "${FILE}-${SIZE}.${FORMAT}" --as-creating-line

            # Convert and resize to create new file.
            convert -support 0.8 -resize x${SIZE} ${FILE}.png ${FILE}-${SIZE}.${FORMAT}

        done

        # Create logo copy in 2 colors.
        cli_printMessage "${FILE}-${SIZE}.xbm (`gettext "2 colors grayscale"`)" --as-creating-line
        convert -resize x${SIZE} -colorspace gray -colors 2 ${FILE}.png ${FILE}-${SIZE}.xbm

        # Create logo copy in emboss effect.
        cli_printMessage "${FILE}-${SIZE}-emboss.png" --as-creating-line
        convert -resize x${SIZE} -emboss 1 ${FILE}.png ${FILE}-${SIZE}-emboss.png

    done

}
