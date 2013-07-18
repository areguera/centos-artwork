#!/bin/bash
#
# conf.sh -- This function standardizes the way images are produced
# from configuration files.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function conf {

    # Initialize local variables.
    local MODEL=''
    local -a MODELS
    local FORMAT=''
    local HEIGHT=''
    local FGCOLOR=''
    local BGCOLOR=''

    # Define list with all section names. These are the final file
    # names we want to produce images for.
    local FILENAME=''
    local FILENAMES=$(cli_getConfigSectionNames $TEMPLATE)

    for FILENAME in $FILENAMES;do

        # Retrieve models you want to produce the image from.  Notice
        # that relative path passed in this option must point to one
        # existent file inside the working copy.
        for MODEL in $(cli_getConfigValue "$TEMPLATE" "$FILENAME" "models");do
            MODELS[((++${#MODELS[*]}))]=${TCAR_WORKDIR}/${MODEL}
        done

        # Retrieve formats you want to produce the image for. This
        # variable contains one or more image format supported by
        # ImageMagick.  For example, `xpm', `jpg', 'tiff', etc.
        local FORMATS=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "formats")
        if [[ -z ${FORMATS} ]];then
            FORMATS="xpm pdf jpg tif"
        fi
        
        # Retrieve heights you want to produce the image for. This
        # variable contains one or more numerical values. For example,
        # `16', `24', `32', etc.
        local HEIGHTS=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "heights")
        if [[ -z ${HEIGHTS} ]];then
            HEIGHTS="16 20 22 24 32 36 38 40 48 64 72 78 96 112 124 128 148 164 196 200 512"
        fi

        # Retrieve foreground colors you want to produce the image
        # for. This variable contains one or more color number in
        # hexadecimal format. For example, `000000', `ffffff', etc.
        local FGCOLORS=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "fgcolors")
        if [[ -z ${FGCOLORS} ]];then
            FGCOLORS="000000"
        fi

        # Retrieve background colors you want to produce the image
        # for. This variable contains one or more color number in
        # hexadecimal format with opacity information included.
        # Opacity is specified between 0.0 and 1.0 where 0.0 is full
        # transparency and 1.0 full opacity. For example, the
        # following values are accepted: `000000-0', `ffffff-1', etc.
        local BGCOLORS=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "bgcolors") 
        if [[ -z ${BGCOLORS} ]];then
            BGCOLORS="000000-0"
        fi

        # Retrieve command-line you want execute to produce the image.
        # For example, `/usr/bin/convert +append'
        local COMMAND=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "command") 
        if [[ -z ${COMMAND} ]];then
            COMMAND=/bin/cp
        fi

        for FGCOLOR in $FGCOLORS;do

            # Verify value passed as foreground color.
            cli_checkFiles ${FGCOLOR} --match="^[a-fA-F0-9]{3,6}$"

            for BGCOLOR in $BGCOLORS;do

                # Verify value passed as background color.
                cli_checkFiles ${BGCOLOR} --match="^[a-fA-F0-9]{6}-(0|1)$"

                for HEIGHT in $HEIGHTS;do

                    # Verify value passed as height.
                    cli_checkFiles ${HEIGHT} --match="^[[:digit:]]+$"

                    # Do base rendition actions.
                    conf_setBaseRendition

                done
            done
        done

        # Reset models list to prevent it from growing for each file
        # name (configuration section) iteration and create this way
        # unexpected images as final result.
        unset MODELS

    done

}
