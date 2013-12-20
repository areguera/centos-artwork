#!/bin/bash
######################################################################
#
#   extended.sh -- This function standardize extended production of
#   PNG files from SVG files. The extended production consists on
#   producing PNG images in in different formats, heights, foreground
#   colors and background colors.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function extended {

    # Retrieve formats you want to produce the image for. This
    # variable contains one or more image format supported by
    # ImageMagick.  For example, `xpm', `jpg', 'tiff', etc.
    local FORMATS=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "formats")
    if [[ -z ${FORMATS} ]];then
        FORMATS="png"
    fi
        
    # Retrieve heights you want to produce the image for. This
    # variable contains one or more numerical values. For example,
    # `16', `24', `32', etc.
    local HEIGHTS=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "heights")
    if [[ -z ${HEIGHTS} ]];then
        HEIGHTS="16 20 22 24 26 32 36 38 40 48 52 64 72 78 96 112 124 128 148 164 196 200 512"
    fi

    # Retrieve foreground colors you want to produce the image for.
    # This variable contains one or more color number in hexadecimal
    # format. For example, `000000', `ffffff', etc.
    local FGCOLORS=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "fgcolors")
    if [[ -z ${FGCOLORS} ]];then
        FGCOLORS="000000"
    fi

    # Retrieve background colors you want to produce the image for.
    # This variable contains one or more color number in hexadecimal
    # format with opacity information included.  Opacity is specified
    # between 0.0 and 1.0 where 0.0 is full transparency and 1.0 full
    # opacity. For example, the following values are accepted:
    # `000000-0', `ffffff-1', etc.
    local BGCOLORS=$(tcar_getConfigValue "${CONFIGURATION}" "${SECTION}" "bgcolors") 
    if [[ -z ${BGCOLORS} ]];then
        BGCOLORS="ffffff-0 ffffff-1"
    fi

    for BGCOLOR in ${BGCOLORS};do

        # Verify value passed as background color.
        tcar_checkFiles -m '^[a-fA-F0-9]{6}-(0|1)$' ${BGCOLOR}

        for FGCOLOR in ${FGCOLORS};do

            # Verify value passed as foreground color.
            tcar_checkFiles -m '^[a-fA-F0-9]{3,6}$' ${FGCOLOR}

            for HEIGHT in ${HEIGHTS};do

                # Verify value passed as height.
                tcar_checkFiles -m '^[[:digit:]]+$' ${HEIGHT}

                # Do base rendition actions.
                extended_setBaseRendition

            done
        done
    done


}
