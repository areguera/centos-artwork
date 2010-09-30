#!/bin/bash
#
# render_doIdentityImageSyslinux.sh -- This function provides
# post-rendering action used to produce syslinux images.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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
# $Id: render_doIdentityImageSyslinux.sh 71 2010-09-18 05:41:11Z al $
# ----------------------------------------------------------------------

function render_doIdentityImageSyslinux {

    local FILE=$1

    # Define Motif's palette location. We do this relatively.
    local
    PALETTES=/home/centos/artwork/trunk/Identity/Themes/Motifs/$(cli_getThemeName)/Colors
   
    # Define the Netpbm color palette used when reducing colors. This
    # palette should be 16 colors based. For more information on this
    # see the isolinux documentation.
    local PALETTE_PPM=$PALETTES/syslinux.ppm

    # Define hexadecimal color information used by ppmtolss16.  Color
    # information and order used on PALETTE_HEX and PALETTE_PPM should
    # match exactly.
    local PALETTE_HEX=$PALETTES/syslinux.hex

    # Check syslinux's palettes existence:  If there is no palette
    # assume that this is the first time you are rendering syslinux
    # images. If that is the case the script will provide you with the
    # PNG format which should be used as base to produce (using GIMP)
    # the .gpl palette.  The .gpl palette information is used to
    # produced (using GIMP) the colormap (.ppm) which is used to
    # automate the syslinux's 16 colors image (syslinux-splash.png)
    # rendering.  If there is no palette available, do not apply color
    # reduction, show a message, and continue.
    cli_checkFiles $PALETTE_PPM
    cli_checkFiles $PALETTE_HEX

    # Create Netpbm superformat (PNM). PNM file is created from the
    # PNG image rendered previously. PNM is a common point for image
    # manipulation using Netpbm tools.
    cli_printMessage "$FILE.pnm" "AsSavedAsLine"
        pngtopnm -verbose \
        < $FILE.png \
        2>$FILE.log > $FILE.pnm
   
    # Reduce colors. Here we use the Netpbm color $PALETTE_PPM to
    # enforce the color position in the image index and the
    # Floyd-Steinberg dithering in order to improve color reduction.
    cli_printMessage "$FILE-16c.pnm" "AsSavedAsLine"
    pnmremap -verbose -floyd -mapfile=$PALETTE_PPM \
        < $FILE.pnm \
        2>>$FILE.log > $FILE-16c.pnm
      
    # Create LSS16 image. As specified in isolinux documentation the
    # background color should be indexed on position 0 and forground
    # in position 7 (see /usr/share/doc/syslinux-X.XX/isolinux.doc).
    # This order of colors is specified in $PALETTE_PPM and redefined
    # here again for the LSS16 image format. Both $PALETTE_PPM and
    # LSS16 color map redefinition ($PALETTE_HEX) should have the same
    # colors and index order. PALETTE_HEX should return just one line
    # with the color information as described in isolinux
    # documentation (i.e #RRGGBB=0 #RRGGBB=1 ... [all values in the
    # same line]).
    cli_printMessage "$FILE.lss" "AsSavedAsLine"
    PALETTE_HEX=$(cat $PALETTE_HEX | tr "\n" ' ' | tr -s ' ')
    ppmtolss16 $PALETTE_HEX \
        < $FILE-16c.pnm \
        2>>$FILE.log \
        > $FILE.lss
     
    # Create the PPM image indexed to 16 colors. Also the colormap
    # used in the LSS16 image is saved on $FILE.log; this is useful to
    # verify the correct order of colors in the image index.
    cli_printMessage "$FILE-16c.ppm" "AsSavedAsLine"
    lss16toppm -map < $FILE.lss \
       2>>$FILE.log \
       > $FILE.ppm
      
    # Create the 16 colors PNG image.
    cli_printMessage "$FILE-16c.png" "AsSavedAsLine"
    pnmtopng -verbose -palette=$PALETTE_PPM \
       < $FILE-16c.pnm \
       2>>$FILE.log \
       > $FILE-16c.png
   
}
