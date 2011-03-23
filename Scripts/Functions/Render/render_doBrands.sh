#!/bin/bash
#
# render_doBrands.sh -- This function provides last-rendition
# actions to produce CentOS brands. This function takes both The
# CentOS Symbol and The CentOS Type images and produces variation of
# them in different dimensions and formats using ImageMagick tool-set.
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

function render_doBrands {

    local SOURCEFILE=''
    local TARGETDIR=''
    local TARGETFILE=''
    local NEWFILE=''

    # Define absolute path to image file.
    local FILE="$1"

    # Define height dimensions you want to produce brands for.
    local SIZES="16 20 22 24 32 36 40 48 64 96 128 148 164 196 200 512"

    # Define image formats you want to produce brands for.
    local FORMATS="png xpm pdf jpg tif"

    # Redefine absolute path to directory where final brand images
    # will be stored. Notice how both final image directory and design
    # model have the same name, this is intentional in order to keep
    # images and design models related and organized inside their own
    # directory structures.
    local DIRNAME=$(cli_getRepoName "$FILE" 'd')/$(cli_getRepoName "$FILE" 'fd')

    # Check directory where final brand images will be stored.
    if [[ ! -d $DIRNAME ]];then
        mkdir -p ${DIRNAME}
    fi

    for SIZE in ${SIZES};do

        # Redefine name of new file.
        NEWFILE=${DIRNAME}/${SIZE}

        for FORMAT in ${FORMATS};do
        
            # Output action information.
            cli_printMessage "${NEWFILE}.${FORMAT}" "AsCreatingLine"

            # Convert and resize to create new file.
            convert -resize x${SIZE} ${FILE}.png ${NEWFILE}.${FORMAT}

        done

        # Create logo copy in 2 colors.
        cli_printMessage "${NEWFILE}.xbm (`gettext "2 colors grayscale"`)" "AsCreatingLine"
        convert -resize x${SIZE} -colorspace gray -colors 2 ${FILE}.png ${NEWFILE}.xbm

        # Create logo copy in emboss effect.
        cli_printMessage "${NEWFILE}-emboss.png" "AsCreatingLine"
        convert -resize x${SIZE} -emboss 1 ${FILE}.png ${NEWFILE}-emboss.png

    done

    # Output division line.
    cli_printMessage '-' 'AsSeparatorLine'
}
