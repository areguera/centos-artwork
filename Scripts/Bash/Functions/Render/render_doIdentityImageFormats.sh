#!/bin/bash
#
# render_doIdentityImageFormats.sh -- This function provides
# post-rendering action used to convert images from PNG to different
# image formats.  This function uses ImageMagick command line image
# manipulation tool set to convert the base PNG image to as many
# formats as ImageMagick supports.
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

function render_doIdentityImageFormats {

    # Get absolute path of PNG image file.
    local FILE="$1"

    # Get image formats.
    local FORMATS=$(render_getConfOption "$2" '2-')

    # Check base file existence.
    if [[ -f ${FILE}.png ]];then

        # Check image formats.
        if [[ "$FORMATS" != "" ]];then

            # Loop through image formats and do format convertion using
            # PNG file as base.
            for FORMAT in $FORMATS;do
                cli_printMessage "${FILE}.${FORMAT}" "AsSavedAsLine"
                convert -quality 85 ${FILE}.png ${FILE}.${FORMAT}
            done

        fi

    fi

}
