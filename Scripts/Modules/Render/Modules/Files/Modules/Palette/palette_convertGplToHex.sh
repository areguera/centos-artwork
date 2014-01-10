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

# Take one palette produced by GIMP (e.g., syslinux.gpl) as input and
# outputs the list of hexadecimal colors and their respective index
# position the `pnmtolss16' program needs (e.g., #RRGGBB=0 #RRGGBB=1
# ... [all values in the same line]).
function palette_convertGplToHex {

    # Create list of colors to be processed by `pnmtolss16'.
    echo "${PALETTE_GPL_COLORS}" | nl | gawk '{ printf "%s=%d ", $2, $1 - 1 }' \
        > ${PALETTE_HEX}

}
