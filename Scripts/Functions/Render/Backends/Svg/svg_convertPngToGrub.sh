#!/bin/bash
#
# svg_convertPngToGrub.sh -- This function provides post-rendition
# action used to produce GRUB images.
#
# Initially, the color information is defined with GIMP (The GNU Image
# Manipulation Program) as a `.gpl' palette of color. This palette of
# colors contains 14 colors only and is saved in a file named
# `grub.gpl.  The `grub.gpl' file is used to build the `grub.ppm' file
# which provide the color information needed to reduce the full color
# PNG image, produced as result of SVG base-rendition, to the amount
# of colors specified (i.e., 14 colors). Later, with the 14 color PNG
# image already created, the `grub.ppm' file is used to build the
# `splash.xpm.gz' file.
#
# In order for this function to work, the `grub.gpl' file should have
# a format similar to the following:
#
#   GIMP Palette
#   Name: CentOS-TreeFlower-4-Syslinux
#   Columns: 14
#   #
#    32  76 141	204c8d
#    36  82 146	245292
#    52  93 152	345d98
#    72 108 162	486ca2
#   102 131 176	6683b0
#   126 153 190	7e99be
#   146 170 200	92aac8
#   161 182 209	a1b6d1
#   182 199 219	b6c7db
#   202 214 228	cad6e4
#   221 230 238	dde6ee
#   235 241 245	ebf1f5
#   246 251 254	f6fbfe
#   254 255 252	fefffc
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function svg_convertPngToGrub {

    # Define number of colors the images will be produced on.
    local COLORS='14'

    # Define options using those passed to actions from pre-rendition
    # configuration script. These options are applied to pnmremap when
    # doing color reduction, so any option available for pnmremap
    # command can be passed to renderSyslinux functionality.
    local OPTIONS=$(render_getConfigOption "$ACTION" '2-')

    # Check options passed to action. This is required in order to
    # aviod using options used already in this script. For example
    # -verbose and -mapfile options.
    for OPTION in $OPTIONS;do
        # Remove anything after equal sign inside option.
        OPTION=$(echo -n $OPTION | cut -d'=' -f1)
        if [[ "$OPTION" =~ "-(mapfile|verbose)" ]];then
            cli_printMessage "`eval_gettext "The \\\"\\\$OPTION\\\" option is already used."`" --as-error-line
        fi
    done

    # Define file name prefix.
    local PREFIX="-${COLORS}c"

    # Redefine file name prefix using options as reference. This is
    # useful to differenciate final files produced using
    # Floyd-Steinberg dithering and files which are not.
    if [[ "$OPTIONS" =~ '-floyd' ]];then
        PREFIX="${PREFIX}-floyd"
    fi

    # Define absolute path to GPL palette.  This palettes should have
    # 14 colors only. For more information on this see the GRUB's
    # documentation.
    local PALETTE_GPL=${MOTIF_DIR}/Palettes/grub.gpl

    # Verify GPL palette existence. If it doesn't exist copy the one
    # provided by the design model through subversion (to keep track
    # of the change) and expand translation markers in the copied
    # instance.
    if [[ ! -f $PALETTE_GPL ]];then
        svn cp ${MODEL_BASEDIR}/${FLAG_THEME_MODEL}/Palettes/grub.gpl ${PALETTE_GPL}
        cli_replaceTMarkers ${PALETTE_GPL}
    fi

    # Define absolute path to PPM palette. The PPM palette is built
    # from source palette (PALETTE_GPL) and provides the color
    # information understood by `ppmremap', the program used to
    # produce images in a specific amount of colors.
    local PALETTE_PPM=$(cli_getTemporalFile "grub.ppm")

    # Create image in Netpbm superformat (PNM). The PNM image file is
    # created from the PNG image rendered previously as centos-art
    # base-rendition output. The PNM image is an intermediate format
    # used to manipulate images through Netpbm tools.
    cli_printMessage "${FILE}.pnm" --as-savedas-line
    pngtopnm -verbose \
        < ${FILE}.png 2>${FILE}.log > ${FILE}.pnm

    # Print the path to GPL palette.
    cli_printMessage "$PALETTE_GPL" --as-palette-line

    # Create PPM palette using GPL palette.
    ${RENDER_BACKEND}_convertGplToPpm "$PALETTE_GPL" "$PALETTE_PPM" "$COLORS"

    # Reduce colors as specified in PPM palette.  Here we use the PPM
    # palette to enforce the color position in the image index and the
    # Floyd-Steinberg dithering in order to improve color reduction.
    cli_printMessage "${FILE}${PREFIX}.ppm" --as-savedas-line
    pnmremap -verbose -mapfile=$PALETTE_PPM $OPTIONS \
        < ${FILE}.pnm 2>>${FILE}.log > ${FILE}${PREFIX}.ppm

    # Remove PPM palette. It is no longer needed.
    if [[ -f ${PALETTE_PPM} ]];then
        rm $PALETTE_PPM
    fi

    # Create the 14 colors xpm.gz file.
    cli_printMessage "${FILE}${PREFIX}.xpm.gz" --as-savedas-line
    ppmtoxpm \
        < ${FILE}${PREFIX}.ppm 2>>${FILE}.log > ${FILE}.xpm \
        && gzip --force ${FILE}.xpm \
        && mv ${FILE}.xpm.gz ${FILE}${PREFIX}.xpm.gz

}
