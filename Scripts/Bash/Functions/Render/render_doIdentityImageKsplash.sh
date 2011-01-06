#!/bin/bash
#
# render_doIdentityImageKsplash.sh -- This function renders 
# KSplash Preview.png image. Use this function as last-rendition
# function to KSplash base-rendition.  
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

    # Define variables as local to avoid conflicts outside.
    local RELDIR=''
    local KSPLASH_TOP=''
    local KSPLASH_PREVIEW=''
    local RELDIRS=$(find $ACTIONVAL -regextype posix-egrep -maxdepth 1 \
        -type d -regex "^.*/${RELEASE_FORMAT}$" | egrep $FLAG_FILTER)

    # Define font file used to render Preview.png bottom text.
    local KSPLASH_PREVIEW_FONT=/home/centos/artwork/trunk/Identity/Fonts/Ttf/DejaVuLGCSans-Bold.ttf

    # Define relative location to splash_active_bar and splash_bottom
    # images. Since we are building Preview with active and bottom
    # splash only, there is no need to include inactive bar on
    # checking.
    local KSPLASH_ACTIVE_BAR="$ACTIONVAL/splash_active_bar.png"
    local KSPLASH_BOTTOM="$ACTIONVAL/splash_bottom.png"

    # Check existence of non-release-specific required image files.
    cli_checkFiles $KSPLASH_ACTIVE_BAR
    cli_checkFiles $KSPLASH_BOTTOM
    cli_checkFiles $KSPLASH_PREVIEW_FONT

    # Look for release specific directories.
    for RELDIR in $RELDIRS;do

        # Define release-specific files.
        KSPLASH_TOP="${RELDIR}/splash_top.png"
        KSPLASH_PREVIEW="${RELDIR}/Preview.png"

        # Check existence of release-specific required image files.
        cli_checkFiles $KSPLASH_TOP

        # Create Preview.png image.
        convert -append \
            $KSPLASH_TOP \
            $KSPLASH_ACTIVE_BAR \
            $KSPLASH_BOTTOM \
            $KSPLASH_PREVIEW

        # Add bottom text to Preview.png image. The text position was
        # set inside an image of 400x300 pixels. If you change the
        # final preview image dimension, you need to change the text
        # position too.
        mogrify -draw 'text 6,295 "KDE is up and running."' \
            -fill \#ffffff \
            -font $KSPLASH_PREVIEW_FONT \
            $KSPLASH_PREVIEW

        cli_printMessage "$KSPLASH_PREVIEW" "AsSavedAsLine"

    done

    # Output separator line.
    cli_printMessage '-' 'AsSeparatorLine'

}
