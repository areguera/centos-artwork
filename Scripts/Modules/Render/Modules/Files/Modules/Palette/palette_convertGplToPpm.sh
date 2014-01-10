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

# Take one palette produced by Gimp (e.g., syslinux.gpl) as input and
# outputs one PPM file based on it (e.g., syslinux.ppm).
function palette_convertGplToPpm {

    local -a FILES
    local COUNT=0

    # Create temporal images (of 1x1 pixel each) to store each color
    # retrieved from Gimp's palette.
    for COLOR in ${PALETTE_GPL_COLORS};do
        FILES[${COUNT}]=$(tcar_getTemporalFile ${COUNT}.ppm)
        ppmmake ${COLOR} 1 1 > ${FILES[${COUNT}]}
        COUNT=$((${COUNT} + 1))
    done

    # Concatenate each temporal image from left to right to create the
    # PPM file.
    pnmcat -lr ${FILES[*]} > ${PALETTE_PPM}

    # Remove temporal images used to build the PPM palette file.
    rm ${FILES[*]}

    # Verify PPM palette existence.
    tcar_checkFiles -ef "${PALETTE_PPM}"

}
