#!/bin/bash
#
# svg_convertPngToKsplash.sh -- This function collects KDE splash
# (KSplash) required files and creates a tar.gz package that groups
# them all together. Use this function as last-rendition action for
# KSplash base-rendition action.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function svg_convertPngToKsplash {

    local -a SRC
    local -a DST
    local FONT=''
    local COUNT=0

    # Define font used to print bottom splash message.
    FONT=$(svg_getTTFont "DejaVuLGCSans-Bold")

    # Check existence of font file.
    cli_checkFiles -e "$FONT"

    # Define absolute source location of files.
    SRC[0]="${OUTPUT}/splash_top.png"
    SRC[1]="${OUTPUT}/splash_active_bar.png"
    SRC[2]="${OUTPUT}/splash_inactive_bar.png"
    SRC[3]="${OUTPUT}/splash_bottom.png"
    SRC[4]="$(dirname $TEMPLATE)/Theme.rc"

    # Check absolute source location of files.
    cli_checkFiles -e "${SRC[@]}"

    # Define relative target location of files.
    DST[0]="${OUTPUT}/splash_top.png"
    DST[1]="${OUTPUT}/splash_active_bar.png"
    DST[2]="${OUTPUT}/splash_inactive_bar.png"
    DST[3]="${OUTPUT}/splash_bottom.png"
    DST[4]="${OUTPUT}/Theme.rc"

    # Print action message.
    cli_printMessage "${OUTPUT}/Preview.png" --as-creating-line

    # Create `Preview.png' image.
    convert -append ${SRC[0]} ${SRC[1]} ${SRC[3]} ${OUTPUT}/Preview.png

    # Add bottom text to Preview.png image. The text position was set
    # inside an image of 400x300 pixels. If you change the final
    # preview image dimension, you probably need to change the text
    # position too.
    mogrify -draw 'text 6,295 "KDE is up and running."' \
        -fill \#ffffff \
        -font $FONT \
        ${OUTPUT}/Preview.png

    # Copy `Theme.rc' file.
    cp ${SRC[4]} ${DST[4]}

    # Apply common translation markers to Theme.rc file.
    cli_expandTMarkers "${DST[4]}"

}
