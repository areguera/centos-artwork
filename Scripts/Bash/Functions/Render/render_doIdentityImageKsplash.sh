#!/bin/bash
#
# render_doIdentityImageKsplash.sh -- This function collects KDE
# splash (KSplash) required files and creates a tar.gz package that
# groups them all together. Use this function as last-rendition
# action for KSplash base-rendition action.
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

function render_doIdentityImageKsplash {

    local -a SRC
    local -a DST
    local FONT=''
    local COUNT=0

    # Define font used to print bottom splash message.
    FONT=$(cli_getRepoTLDir)/Identity/Fonts/DejaVuLGCSans-Bold.ttf

    # Check existence of font file.
    cli_checkFiles "$FONT" 'f'

    # Define absolute source location of files.
    SRC[0]="${DIRNAME}/splash_top.png"
    SRC[1]="${DIRNAME}/splash_active_bar.png"
    SRC[2]="${DIRNAME}/splash_inactive_bar.png"
    SRC[3]="${DIRNAME}/splash_bottom.png"
    SRC[4]="$(cli_getRepoTLDir)/Identity/Themes/Models/${THEMEMODEL}/Distro/BootUp/KSplash/Theme.rc"

    # Check absolute source location of files.
    cli_checkFiles "${SRC[@]}" 'f'

    # Define relative target location of files.
    DST[0]="${DIRNAME}/splash_top.png"
    DST[1]="${DIRNAME}/splash_active_bar.png"
    DST[2]="${DIRNAME}/splash_inactive_bar.png"
    DST[3]="${DIRNAME}/splash_bottom.png"
    DST[4]="${DIRNAME}/Theme.rc"

    # Create `Preview.png' image.
    convert -append ${SRC[0]} ${SRC[1]} ${SRC[3]} ${DIRNAME}/Preview.png

    # Add bottom text to Preview.png image. The text position was set
    # inside an image of 400x300 pixels. If you change the final
    # preview image dimension, you probably need to change the text
    # position too.
    mogrify -draw 'text 6,295 "KDE is up and running."' \
        -fill \#ffffff \
        -font $FONT \
        ${DIRNAME}/Preview.png

    # Copy `Theme.rc' file.
    cp ${SRC[4]} ${DST[4]}

    # Apply common translation markers to Theme.rc file.
    cli_replaceTMarkers "${DST[4]}"

}
