#!/bin/bash
#
# identity_doIdentityImageGrub.sh -- This function provides
# post-rendition action used to produce GRUB images.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function identity_doIdentityImageGrub {

    local FILE="$1"
    local ACTION="$2"
    local OPTIONS=''

    # Define 16 colors images default file name prefix.
    local PREFIX='-14c'

    # Define options using those passed to actions from pre-rendition
    # configuration script. These options are applied to pnmremap when
    # doing color reduction, so any option available for pnmremap
    # command can be passed to renderSyslinux functionality.
    OPTIONS=$(identity_getIdentityConfigOption "$ACTION" '2-')

    # Re-define 16 colors images default file name prefix using
    # options as reference. This is useful to differenciate final
    # files produced using Floyd-Steinberg dithering and files which
    # do not.
    if [[ "$OPTIONS" =~ '-floyd' ]];then
        PREFIX="${PREFIX}-floyd"
    fi

    # Check options passed to action. This is required in order to
    # aviod using options used already in this script. For example
    # -verbose and -mapfile options.
    for OPTION in $OPTIONS;do
        # Remove anything after equal sign inside option.
        OPTION=$(echo -n $OPTION | cut -d'=' -f1)
        if [[ "$OPTION" =~ "-(mapfile|verbose)" ]];then
            cli_printMessage "`eval_gettext "The \\\$OPTION option is already used."`"
            cli_printMessage "$(caller)" "AsToKnowMoreLine"
        fi
    done

    # Define motif's palette location.
    local PALETTES=$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getPathComponent '--theme')/Colors
    
    # Define the Netpbm color palettes used when reducing colors.
    # These palettes should be 14 colors based. For more information
    # on this see the GRUB's documentation.
    local PALETTE_PPM=$PALETTES/grub.ppm

    # Print which palette of colors centos-art.sh script is using to
    # produce grub content. This is relevant in order to know if we
    # are using whether trunk or branches palette of colors.
    cli_printMessage "$PALETTE_PPM" 'AsPaletteLine'

    # Check GRUB's palettes existence:  If there is no palette assume
    # that this is the first time you are rendition GRUB images. If
    # that is the case the script will provide you with the PNG format
    # which should be used as base to produce (using GIMP) the .gpl
    # palette.  The .gpl palette information is used to produced
    # (using GIMP) the colormap (.ppm) which is used to automate the
    # GRUB's 14 colors image (splash.png) rendition.  If there is no
    # palette available, do not apply color reduction, show a message,
    # and continue.
    cli_checkFiles $PALETTE_PPM

    # Create Netpbm superformat (PNM). PNM file is created from the
    # PNG image rendered previously. PNM is a common point for image
    # manipulation using Netpbm tools.
    cli_printMessage "${FILE}.pnm" "AsSavedAsLine"
    pngtopnm -verbose \
        < ${FILE}.png 2>${FILE}.log > ${FILE}.pnm

    # Reduce colors as specified in ppm palette of colors.
    cli_printMessage "${FILE}${PREFIX}.ppm" "AsSavedAsLine"
    pnmremap -verbose -mapfile=$PALETTE_PPM $OPTIONS \
        < ${FILE}.pnm 2>>${FILE}.log > ${FILE}${PREFIX}.ppm

    # Create the 14 colors xpm.gz file.
    cli_printMessage "${FILE}${PREFIX}.xpm.gz" "AsSavedAsLine"
    ppmtoxpm \
        < ${FILE}${PREFIX}.ppm 2>>${FILE}.log > ${FILE}.xpm \
        && gzip --force ${FILE}.xpm \
        && mv ${FILE}.xpm.gz ${FILE}${PREFIX}.xpm.gz

}
