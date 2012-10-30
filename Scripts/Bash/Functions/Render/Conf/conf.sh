#!/bin/bash
#
# conf.sh -- This function standardizes the way images are produced
# from configuration files.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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
    local FORMATS=''
    local HEIGHT=''
    local HEIGHTS=''
    local FGCOLOR=''
    local FGCOLORS=''
    local BGCOLOR=''
    local BGCOLORS=''
    local COMMAND=''

    # Define list with all section names. These are the final file
    # names we want to produce images for.
    local FILENAME=''
    local FILENAMES=$(cli_getConfigSectionNames $TEMPLATE)

    for FILENAME in $FILENAMES;do

        # Retrieve models you want to produce the image from.  Notice
        # that relative path passed in this option must begin with
        # `trunk/' directory and point to an existent file.
        for MODEL in $(cli_getConfigValue "$TEMPLATE" "$FILENAME" "models");do
            MODELS[((++${#MODELS[*]}))]=${TCAR_WORKDIR}/${MODEL}
        done

        # Retrieve formats you want to produce the image for. This
        # variable contains one or more image format supported by
        # ImageMagick.  For example, `xpm', `jpg', 'tiff', etc.
        FORMATS=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "formats")
        
        # Retrieve heights you want to produce the image for. This
        # variable contains one or more numerical values. For example,
        # `16', `24', `32', etc.
        HEIGHTS=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "heights")

        # Retrieve foreground colors you want to produce the image
        # for. This variable contains one or more color number in
        # hexadecimal format. For example, `000000', `ffffff', etc.
        FGCOLORS=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "fgcolors")

        # Retrieve background colors you want to produce the image
        # for. This variable contains one or more color number in
        # hexadecimal format with opacity information included.
        # Opacity is specified between 0.0 and 1.0 where 0.0 is full
        # transparency and 1.0 full opacity. For example, the
        # following values are accepted: `000000-0', `ffffff-1', etc.
        BGCOLORS=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "bgcolors") 

        # Retrieve command-line you want execute to produce the image.
        # For example, `/usr/bin/convert +append'
        COMMAND=$(cli_getConfigValue "$TEMPLATE" "$FILENAME" "command") 

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
                    conf_doBaseActions

                done
            done
        done

        # Reset models list to prevent it from growing for each file
        # name (configuration section) iteration and create this way
        # unexpected images as final result.
        unset MODELS

    done

}
