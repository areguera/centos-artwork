#!/bin/bash
#
# svg_convertPngToSyslinux.sh -- This function provides post-rendition
# action used to produce LSS16 images, the images used by isolinux.
#
# Initially, the color information is defined with GIMP (The GNU Image
# Manipulation Program) as a `.gpl' palette of color. This palette of
# colors contains 16 colors only and is saved in a file named
# `syslinux.gpl.  The `syslinux.gpl' file is used to build two other
# files: the `syslinux.ppm' file and the `syslinux.hex' file. The
# `syslinux.ppm' provides the color information needed to reduce the
# full color PNG image, produced as result of SVG base-rendition, to
# the amount of colors specified (i.e., 16 colors). Later, with the 16
# color PNG image already created, the `syslinux.hex' file is used to
# build the LSS16 image.
#
# In order to produce images in LSS16 format correctly, it is required
# that both the `syslinux.ppm' and `syslinux.hex' files do contain the
# same color information. This is, both `syslinux.ppm' and
# `syslinux.hex' must represent the same color values and in the same
# color index.
#
# In order for this function to work, the `syslinux.gpl' file should
# have a format similar to the following:
#
# GIMP Palette
# Name: CentOS-TreeFlower-4-Syslinux
# Columns: 16
# #
# 32  76 141	204c8d
# 37  82 146	255292
# 52  94 153	345e99
# 73 110 162	496ea2
# 91 124 172	5b7cac
# 108 136 180	6c88b4
# 120 146 186	7892ba
# 131 158 193	839ec1
# 255 255 255	ffffff
# 146 170 200	92aac8
# 162 182 209	a2b6d1
# 183 199 219	b7c7db
# 204 216 230	ccd8e6
# 221 229 238	dde5ee
# 235 241 245	ebf1f5
# 246 251 254	f6fbfe
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

function svg_convertPngToSyslinux {

    # Define number of colors the images will be produced on.
    local COLORS='16'

    # Define options using those passed to actions from pre-rendition
    # configuration script. These options are applied to pnmremap when
    # doing color reduction, so any option available for pnmremap
    # command can be passed to renderSyslinux functionality.
    local OPTIONS=$(render_getConfigOption "$ACTION" '2-')

    # Check options passed to action. This is required in order to
    # aviod using options already used in this script. For example
    # -verbose and -mapfile options.
    for OPTION in $OPTIONS;do
        # Remove anything after equal sign inside option.
        OPTION=$(echo $OPTION | cut -d'=' -f1)
        if [[ "$OPTION" =~ "-(mapfile|verbose)" ]];then
            cli_printMessage "`eval_gettext "The \\\"\\\$OPTION\\\" option is already used."`" --as-error-line
        fi
    done

    # Define default file name prefix for 16 colors images.
    local PREFIX="-${COLORS}c"

    # Re-define 16 colors images default file name prefix using
    # options as reference. This is useful to differenciate final
    # files produced using Floyd-Steinberg dithering and final files
    # which are not.
    if [[ "$OPTIONS" =~ '-floyd' ]];then
        PREFIX="${PREFIX}-floyd"
    fi

    # Define absolute path to GPL palette. The GPL palette defines the
    # color information used to build syslinux images.  This palette
    # should be set to 16 colors and, as specified in isolinux
    # documentation, the background color should be indexed on
    # position 0 and the forground in position 7 (see
    # /usr/share/doc/syslinux-X.XX/isolinux.doc, for more
    # information.)
    local PALETTE_GPL=${MOTIF_DIR}/Palettes/syslinux.gpl

    # Verify GPL palette existence. If it doesn't exist copy the one
    # provided by the design model through subversion (to keep track
    # of the change) and expand translation markers in the copied
    # instance.
    if [[ ! -f $PALETTE_GPL ]];then
        svn cp ${MODEL_BASEDIR}/${FLAG_THEME_MODEL}/Palettes/syslinux.gpl ${PALETTE_GPL}
        cli_expandTMarkers ${PALETTE_GPL}
    fi

    # Define absolute path to PPM palette. The PPM palette is built
    # from source palette (PALETTE_GPL) and provides the color
    # information understood by `ppmremap', the program used to
    # produce images in a specific amount of colors.
    local PALETTE_PPM=$(cli_getTemporalFile "syslinux.ppm")

    # Define the HEX palette. The HEX palette is built from source
    # palette (PALETTE_GPL) and provides the color information in the
    # format understood by `ppmtolss16', the program used to produce
    # images in LSS16 format.  The HEX palette stores just one line
    # with the color information as described in isolinux
    # documentation (i.e #RRGGBB=0 #RRGGBB=1 ... [all values in the
    # same line])
    local PALETTE_HEX=$(cli_getTemporalFile "syslinux.hex")

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
    svg_convertGplToPpm "$PALETTE_GPL" "$PALETTE_PPM" "$COLORS"
 
    # Create HEX palette using GPL palette.
    svg_convertGplToHex "$PALETTE_GPL" "$PALETTE_HEX" "$COLORS"

    # Reduce colors as specified in PPM palette.  Here we use the PPM
    # palette to enforce the color position in the image index and the
    # Floyd-Steinberg dithering in order to improve color reduction.
    cli_printMessage "${FILE}${PREFIX}.pnm" --as-savedas-line
    pnmremap -verbose -mapfile=$PALETTE_PPM $OPTIONS \
        < ${FILE}.pnm 2>> ${FILE}.log > ${FILE}${PREFIX}.pnm

    # Create LSS16 image. 
    cli_printMessage "${FILE}${PREFIX}.lss" --as-savedas-line
    ppmtolss16 $(cat $PALETTE_HEX) \
        < ${FILE}${PREFIX}.pnm 2>>${FILE}.log > ${FILE}${PREFIX}.lss
     
    # Remove HEX palette. It is no longer needed.
    if [[ -f ${PALETTE_HEX} ]];then
        rm $PALETTE_HEX
    fi

    # Create the PPM image indexed to 16 colors. Also the colormap
    # used in the LSS16 image is saved on ${FILE}.log; this is useful to
    # verify the correct order of colors in the image index.
    cli_printMessage "${FILE}${PREFIX}.ppm" --as-savedas-line
    lss16toppm -map \
        < ${FILE}${PREFIX}.lss 2>>${FILE}.log > ${FILE}${PREFIX}.ppm
      
    # Create the 16 colors PNG image.
    cli_printMessage "${FILE}${PREFIX}.png" --as-savedas-line
    pnmtopng -verbose -palette=$PALETTE_PPM \
        < ${FILE}${PREFIX}.pnm 2>>${FILE}.log > ${FILE}${PREFIX}.png
   
    # Remove PPM palette. It is no longer needed.
    if [[ -f ${PALETTE_PPM} ]];then
        rm $PALETTE_PPM
    fi

}
