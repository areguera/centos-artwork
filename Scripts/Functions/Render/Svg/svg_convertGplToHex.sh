#!/bin/bash
#
# svg_convertGplToHex.sh -- This function takes one palette produced
# by Gimp (e.g., syslinux.gpl) as input and outputs the list of
# hexadecimal colors and their respective index position the
# `pnmtolss16' program needs (e.g., #RRGGBB=0 #RRGGBB=1 ... [all
# values in the same line]).
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

function svg_convertGplToHex {

    # Define path to GPL palette. This is the .gpl file we use to
    # retrive color information from.
    local PALETTE_GPL="$1"

    # Define path to HEX palette. This is the palette used to stored
    # the color information the `ppmtolss16' program needs.
    local PALETTE_HEX="$2"

    # Define the number of colors this function should return.
    local NUMBER="$3"

    # Define list of colors from GPL palette.
    local COLORS=$(svg_getColors $PALETTE_GPL --head=$NUMBER --tail=$NUMBER)

    # Verify number of colors returned in the list. They must match
    # exactly the amount specified, no more no less. Sometimes, the
    # list of colors may have less colors than it should have, so we
    # need to prevent such palettes from being used.
    svg_checkColorAmount "$COLORS" "$NUMBER"

    # Verify format of colors.
    svg_checkColorFormats "$COLORS" --format='rrggbb'

    # Create list of colors to be processed by `pnmtolss16'.
    echo "$COLORS" | nl | gawk '{ printf "%s=%d ", $2, $1 - 1 }' \
        > $PALETTE_HEX

    # Verify HEX palette existence.
    cli_checkFiles $PALETTE_HEX

}
