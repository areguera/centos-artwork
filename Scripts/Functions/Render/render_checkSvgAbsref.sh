#!/bin/bash
#
# render_checkSvgAbsref.sh -- This function retrives absolute files
# and checks their existence. In order for design templates to point
# different artistic motifs, design templates make use of external
# files which point to specific artistic motif background images. If
# such external files don't exist, try to create the background image
# required by cropping a higher background image (e.g.,
# 2048x1536-final.png).  If this isn't possible neither, then create
# the background image using a plain color and crop from it then.  We
# can't go on without the required background information.
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

function render_checkSvgAbsref {

    local FILE=''
    local BG_DST_FILES=''
    local BG_DST_FILE=''
    local BG_DST_FILE_WIDTH=''
    local BG_DST_FILE_HEIGHT=''
    local BG_SRC_FILE=''
    local BG_SRC_FILE_COLOR=''
    local BG_SRC_FILE_WIDTH=''
    local BG_SRC_FILE_HEIGHT=''

    # Define absolute path to the translated instance of design model.
    FILE="$1"

    # Verify existence of file we need to retrive absolute paths from.
    cli_checkFiles "$FILE"

    # Retrive absolute paths from file.
    BG_DST_FILES=$(egrep "(sodipodi:absref|xlink:href)=\"${HOME}.+" $FILE \
        | sed -r "s,.+=\"(${HOME}.+\.png)\".*,\1," | sort | uniq)

    # Verify absolute paths retrived from file.
    for BG_DST_FILE in $BG_DST_FILES;do

        # Print action
        cli_printMessage "$BG_DST_FILE" --as-checking-line

        if [[ ! -a $BG_DST_FILE ]];then
  
            # Define the source background file, the image file will
            # crop when no specific background informatio be available
            # for using. Generally, this is the most reusable
            # background file inside the artistic motifs (e.g,.  the
            # `2048x1536-final.png' file).  We can use this image file
            # to create almost all artworks inside The CentOS
            # Distribution visual manifestation when
            # resolution-specific backgrounds don't exist. 
            BG_SRC_FILE=$(echo $BG_DST_FILE \
                | sed -r "s!(.+)/[[:digit:]]+x[[:digit:]]+(-final\.png)!\1/2048x1536\2!")

            # Verify existence of source background file. If the file
            # doesn't exist create it using The CentOS Project default
            # background color information, as specified in its
            # corporate identity manual.
            if [[ ! -f $BG_SRC_FILE ]];then

                # Define plain color for the source background file
                # the required background information is cropped from.
                BG_SRC_FILE_COLOR='rgb:20/4C/8D'

                # Define width for the source background file the
                # required background information is cropped from.
                BG_SRC_FILE_WIDTH=$(echo $BG_SRC_FILE \
                    | sed -r 's!.+/([[:digit:]]+)x[[:digit:]]+-final\.png!\1!')

                # Define height for the source background file the
                # required background information is cropped from.
                BG_SRC_FILE_HEIGHT=$(echo $BG_SRC_FILE \
                    | sed -r 's!.+/[[:digit:]]+x([[:digit:]]+)-final\.png!\1!')

                # Print action message.
                cli_printMessage "${BG_SRC_FILE} ($BG_SRC_FILE_COLOR)" --as-creating-line

                # Create the source background file.
                ppmmake -quiet ${BG_SRC_FILE_COLOR} \
                    ${BG_SRC_FILE_WIDTH} ${BG_SRC_FILE_HEIGHT} \
                    | pnmtopng > ${BG_SRC_FILE}

            fi

            # Print action message.
            cli_printMessage "$BG_SRC_FILE" --as-cropping-line

            # Define the width of the required background information.
            BG_DST_FILE_WIDTH=$(echo $BG_DST_FILE \
                | sed -r 's!.+/([[:digit:]]+)x[[:digit:]]+-final\.png!\1!')

            # Define the height of the required background information.
            BG_DST_FILE_HEIGHT=$(echo $BG_DST_FILE \
                | sed -r 's!.+/[[:digit:]]+x([[:digit:]]+)-final\.png!\1!')
 
            # Create required backgrounnd information.
            convert -quiet \
                -crop ${BG_DST_FILE_WIDTH}x${BG_DST_FILE_HEIGHT}+0+0 \
                ${BG_SRC_FILE} ${BG_DST_FILE}

            # Verify required background information.
            cli_checkFiles $BG_DST_FILE

        fi

    done

}
