#!/bin/bash
#
# svg_convertGplToPpm.sh -- This function takes one palette produced
# by Gimp (e.g., syslinux.gpl) as input and outputs one PPM file based
# on it (e.g., syslinux.ppm).
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

function svg_convertGplToPpm {

    local -a FILES
    local COUNT=0

    # Define path to GPL palette. This is the .gpl file we use to
    # retrive color information from.
    local PALETTE_GPL="$1"

    # Define path to PPM palette. This is the .ppm file we'll save
    # color information to.
    local PALETTE_PPM="$2"

    # Define the number of colors this function should return.
    local NUMBER="$3"

    # Define list of colors from GPL palette.
    local COLOR=''
    local COLORS=$(svg_getColors "$PALETTE_GPL" --head=$NUMBER --tail=$NUMBER --format='rrrggbb')

    # Verify amount of colors in the list of colors.
    svg_checkColorAmount "$COLORS" "$NUMBER"

    # Verify format of colors.
    svg_checkColorFormats $COLORS --format='rrggbb'

    # Create temporal images (of 1x1 pixel each) to store each color
    # retrived from Gimp's palette. 
    for COLOR in $COLORS;do
        FILES[$COUNT]=$(cli_getTemporalFile ${COUNT}.ppm)
        ppmmake $COLOR 1 1 > ${FILES[$COUNT]}
        COUNT=$(($COUNT + 1))
    done

    # Concatenate each temporal image from left to right to create the
    # PPM file.
    pnmcat -lr ${FILES[*]} > $PALETTE_PPM

    # Remove temporal images used to build the PPM palette file.
    rm ${FILES[*]}

    # Verify PPM palette existence.
    cli_checkFiles "$PALETTE_PPM"

}
