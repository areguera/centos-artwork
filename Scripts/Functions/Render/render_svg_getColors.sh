#!/bin/bash
#
# render_svg_getColors.sh -- This function takes one palette produced by
# Gimp (e.g., syslinux.gpl) as input and outputs a list of colors as
# specified.
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

function render_svg_getColors {

    # Define path to GPL palette. This is the .gpl file we use to
    # retrive color information from.
    local PALETTE_GPL="$1"

    # Retrive fourth column of information from GPL palette. The
    # fourth column of GPL palette contains the palette commentary
    # field. The palette commentary field can be anything, but for the
    # sake of our own convenience we use it to store the color
    # hexadecimal value.  Notice that you can put your comments from
    # the fifth column on.
    local COLORS=$(sed -r '1,/^#/d' $PALETTE_GPL | awk '{ printf "%s\n", $4 }')

    # Output list of colors. 
    echo "$COLORS"
 
}
