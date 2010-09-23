#!/bin/bash
#
# render_doIdentityImageKsplash.sh -- This function provides
# post-rendering actions to render KSplash images.
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
# $Id: render_doIdentityImageKsplash.sh 71 2010-09-18 05:41:11Z al $
# ----------------------------------------------------------------------

function render_doIdentityImageKsplash {

    local FILE=$1

    # Define names of files with dynamic store location.
    local KSPLASH_TOP="$(dirname $FILE)/splash_top.png"
    local KSPLASH_PREVIEW="$(dirname $FILE)/Preview.png"
    local KSPLASH_PREVIEW_FONT=/home/centos/artwork/trunk/Identity/Fonts/Ttf/DejaVuLGCSans-Bold.ttf

    # Define relative location to splash_active_bar and splash_bottom
    # images. Since we are building Preview with active and bottom
    # splash only, there is no need to include inactive bar on
    # checking.
    local KSPLASH_ACTIVE_BAR="$OPTIONVAL/splash_active_bar.png"
    local KSPLASH_BOTTOM="$OPTIONVAL/splash_bottom.png"

    # The Preview.png image is produced if the current file being
    # rendered is the splash_top image. The splash_top image is the
    # only file that is rendered for different versions.  The
    # splash_top image is taken as reference to create the whole
    # ksplash image preview.
    if [ ! "$(basename $FILE).png" == "splash_top.png" ];then 
        continue
    fi

    # Check required image files existence.
    cli_checkFiles $KSPLASH_PREVIEW
    cli_checkFiles $KSPLASH_ACTIVE_BAR
    cli_checkFiles $KSPLASH_BOTTOM
    cli_checkFiles $KSPLASH_PREVIEW_FONT

    # Create Preview.png image.
    convert -append \
        $KSPLASH_TOP \
        $KSPLASH_ACTIVE_BAR \
        $KSPLASH_BOTTOM \
        $KSPLASH_PREVIEW

    # Add bottom text to Preview.png image. The text position was set
    # inside an image of 400x300 pixels. If you change the final
    # preview image dimension, you need to change the text position
    # too.
    mogrify -draw 'text 6,295 "KDE is up and running."' \
        -fill \#ffffff \
        -font $KSPLASH_PREVIEW_FONT \
        $KSPLASH_PREVIEW

    cli_printMessage "$KSPLASH_PREVIEW" "AsSavedAsLine"

}
