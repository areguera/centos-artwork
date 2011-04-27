#!/bin/bash
#
# render_convertGplToHex.sh -- This function takes one palette
# produced by Gimp (e.g., syslinux.gpl) as input and outputs the list
# of hexadecimal colors and their respective index position the
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

function render_convertGplToHex {

    local COLOR=''
    local COUNT=0
    local -a FILES

    # Define path to GPL palette. This is the .gpl file we use to
    # retrive color information from.
    local PALETTE_GPL="$1"

    # Define path to HEX palette. This is the palette used to stored
    # the color information the `ppmtolss16' program needs.
    local PALETTE_HEX="$2"

    # Define the number of colors this function should return.
    local COLOR_NUMBER="$3"

    # Verify the number of colors this function should return. As
    # convenction, we are producing images in 14 and 16 colors only to
    # cover Grub and Syslinux images need respectively.
    if [[ ! $COLOR_NUMBER =~ '^(14|16)$' ]];then
        cli_printMessage "`eval_gettext "Reducing image to \\\`\\\$COLOR_NUMBER' colors is not supported."`" 'AsErrorLine'
        cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
    fi

    # Define list of colors from GPL palette.
    local COLORS=$(render_getColors "$PALETTE_GPL")

    # Verify number of colors returned in the list.
    if [[ ! $(echo "$COLORS" |  wc -l) =~ $COLOR_NUMBER ]];then
        cli_printMessage "`gettext "The palette doesn't have the correct number of colors."`" 'AsErrorLine'
        cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
    fi

    # Verify format of colors inside the list.
    for COLOR in $COLORS;do
        if [[ ! $COLOR =~ '^[0-9a-f]{6}$' ]];then
            cli_printMessage "`eval_gettext "The \\\`\\\$COLOR' string isn't a valid color code."`" 'AsErrorLine'
            cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
        fi
    done

    # Create list of colors to be process by pnmtolss16 
    echo "$COLORS" | nl | awk '{ printf "#%s=%d ", $2, $1 - 1 }' \
        > $PALETTE_HEX

    # Verify HEX palette existence.
    cli_checkFiles "$PALETTE_PPM" 'f'

}
