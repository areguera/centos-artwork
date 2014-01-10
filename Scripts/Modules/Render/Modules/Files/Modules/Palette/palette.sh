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

# Standardize the way palette of colors are applied to image files in
# order to produce images with specific number of colors.
function palette {

    local FILENAME=$(tcar_getTemporalFile "$(echo ${SOURCES[0]} \
        | sed -r 's/\.[[:alpha:]]+$//')")

    local LOGS=${RENDER_TARGET}.log

    # Define absolute path to GPL palette. This file is the reference
    # taken to set the max number of colors the final image will be
    # produced for.
    local PALETTE_GPL=$(tcar_getConfigValue ${CONFIGURATION} ${SECTION} 'palette-gpl')
    tcar_checkFiles -ef ${PALETTE_GPL}

    local PALETTE_GPL_COLORS=$(palette_getColors "${PALETTE_GPL}")

    # Define absolute path to PPM palette. The PPM palette is built
    # from source palette (PALETTE_GPL) and provides the color
    # information understood by `ppmremap', the program used to
    # produce images in a specific amount of colors.
    local PALETTE_PPM=$(tcar_getTemporalFile 'palette.ppm')

    # Verify format of colors returned in the list.
    palette_checkColorFormats "${PALETTE_GPL_COLORS}"

    # Create image in Netpbm superformat (PNM). The PNM image file is
    # created from the PNG image rendered previously as tcar
    # base-rendition output. The PNM image is an intermediate format
    # used to manipulate images through Netpbm tools.
    pngtopnm -verbose \
        < ${SOURCES[0]} 2>${LOGS} > ${FILENAME}.pnm

    # Create PPM palette using GPL palette.
    palette_convertGplToPpm
    
    # Reduce colors as specified in PPM palette.  Here we use the PPM
    # palette to enforce the color position in the image index and the
    # Floyd-Steinberg dithering in order to improve color reduction.
    pnmremap -verbose -mapfile=${PALETTE_PPM} -floyd \
        < ${FILENAME}.pnm 2>>${LOGS} > ${FILENAME}.ppm

    # Print action message.
    tcar_printMessage "${RENDER_TARGET}" --as-creating-line

    if [[ ${RENDER_TARGET} =~ '\.lss$' ]];then

        # Define the HEX palette. The HEX palette is built from source
        # palette (PALETTE_GPL) and provides the color information in
        # the format understood by `ppmtolss16', the program used to
        # produce images in LSS16 format.  The HEX palette stores just
        # one line with the color information as described in isolinux
        # documentation (i.e #RRGGBB=0 #RRGGBB=1 ... [all values in
        # the same line])
        local PALETTE_HEX=$(tcar_getTemporalFile "palette.hex")

        # Create HEX palette using GPL palette.
        palette_convertGplToHex

        # Create LSS16 image. 
        ppmtolss16 $(cat ${PALETTE_HEX}) \
            < ${FILENAME}.ppm 2>>${LOGS} > ${RENDER_TARGET}
     
        # Create PPM image indexed to 16 colors. Also the colormap
        # used in the LSS16 image is saved on ${FILE}.log; this is
        # useful to verify the correct order of colors in the image
        # index.
        lss16toppm -map \
            < ${RENDER_TARGET} 2>>${LOGS} > ${RENDER_TARGET}.ppm

    else

        # Create final file.
        /usr/bin/convert ${FILENAME}.ppm ${RENDER_TARGET}

    fi

}
