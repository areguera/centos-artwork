#!/bin/bash
#
# render_convertGplToPpm.sh -- This function takes one palette
# produced by Gimp (e.g., syslinux.gpl) as input and outputs one PPM
# file based on it (e.g., syslinux.ppm).
#
# Copyright 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function render_convertGplToPpm {

    local COLOR=''
    local COUNT=0
    local -a FILES

    # Define path to GPL palette. This is the .gpl file we use to
    # retrive color information from.
    local PALETTE_GPL="$1"

    # Define path to PPM palette. This is the .ppm file we'll save
    # color information to.
    local PALETTE_PPM="$2"

    # Define the number of colors this function should return.
    local COLOR_NUMBER="$3"

    # Verify the number of colors this function should return. As
    # convenction, we are producing images in 14 and 16 colors only to
    # cover Grub and Syslinux images need respectively.
    if [[ ! $COLOR_NUMBER =~ '^(14|16)$' ]];then
        cli_printMessage "`eval_gettext "Reducing image to \\\`\\\$COLOR_NUMBER' colors is not supported."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Define list of colors from GPL palette.
    local COLORS=$(render_getColors "$PALETTE_GPL")

    # Verify number of colors returned in the list.
    if [[ ! $(echo "$COLORS" |  wc -l) =~ $COLOR_NUMBER ]];then
        cli_printMessage "`gettext "The palette doesn't have the correct number of colors."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Verify format of colors inside the list.
    for COLOR in $COLORS;do
        if [[ ! $COLOR =~ '^[0-9a-f]{6}$' ]];then
            cli_printMessage "`eval_gettext "The \\\`\\\$COLOR' string isn't a valid color code."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'
        fi
    done

    # Create temporal images (of 1x1 pixel each) for each color
    # retrived from Gimp's palette.
    for COLOR in $COLORS;do
        FILES[$COUNT]=$(cli_getTemporalFile "color-${COUNT}.ppm")
        ppmmake $(echo "$COLOR" \
            | sed -r 's!(.{2})(.{2})(.{2})!rgb:\1/\2/\3!') 1 1 \
            > ${FILES[$COUNT]}
        COUNT=$(($COUNT + 1))
    done

    # Concatenate temporal images from left to right to create the PPM
    # file.
    pnmcat -lr ${FILES[*]} > $PALETTE_PPM

    # Remove temporal images.
    rm ${FILES[*]}

    # Verify PPM palette existence.
    cli_checkFiles "$PALETTE_PPM" 'f'

}
