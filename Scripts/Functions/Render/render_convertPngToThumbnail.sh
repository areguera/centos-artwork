#!/bin/bash
#
# render_convertPngToThumbnail.sh -- This function provides post-rendition to
# create thumbnails from images produced by centos-art base-rendition.
# Thumbnails are created in PNG and JPG format for you to decide which
# is the more appropriate one. When no size is specified, thumbnails
# are created at 250 pixels width and height is automatically
# calculated to match the image ratio.
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

function render_convertPngToThumbnail {

    # Get image size.
    local SIZES=$(render_getConfigOption "$ACTION" '2-')

    # Check base file existence.
    cli_checkFiles "${FILE}.png" 'f'

    # Check image sizes and do convertion.
    if [[ "$SIZES" == "" ]];then
        SIZES='250'
    fi

    # Create thumbnails.
    for SIZE in $SIZES;do
        cli_printMessage "${FILE}-thumb-${SIZE}.png" --as-savedas-line
        convert -resize ${SIZE} ${FILE}.png ${FILE}-thumb-${SIZE}.png
        cli_printMessage "${FILE}-thumb-${SIZE}.jpg" --as-savedas-line
        convert -resize ${SIZE} ${FILE}-thumb-${SIZE}.png ${FILE}-thumb-${SIZE}.jpg
        cli_printMessage "${FILE}-thumb-${SIZE}.pdf" --as-savedas-line
        convert -resize ${SIZE} ${FILE}-thumb-${SIZE}.png ${FILE}-thumb-${SIZE}.pdf
    done

}
