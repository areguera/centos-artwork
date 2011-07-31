#!/bin/bash
#
# svg_convertPngToBranded.sh -- This function standardizes image
# branding. Once the base PNG image is rendered and the
# `--with-brands' option is provided, this function composites a new
# branded image using the preferences set in the `branding.conf' file.
# The `branding.conf' file must be stored in the design model root
# location used as reference to produce the base PNG image.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function svg_convertPngToBranded {

    # Verify whether the option `--with-brands' was provided or not to
    # `centos-art.sh' script command-line.
    if [[ $FLAG_WITH_BRANDS == 'false' ]];then
        return
    fi

    local BRANDING_CONF_FILE=''
    local BRANDING_CONF_SECTION=''
    local BRANDING_CONF_VALUES=''
    local BRANDING_CONF_VALUE=''
    local BRAND=''
    local POSITION=''
    local POSITIONS=''

    # Define absolute path to branding configuration file.
    BRANDING_CONF_FILE="$(cli_getRepoTLDir)/Identity/Models/Themes/${FLAG_THEME_MODEL}/branding.conf"

    # Define regular expression matching the variable name (i.e., the
    # left column), inside the configuration line, you want to match
    # on.
    BRANDING_CONF_VARNAME=$(echo $TEMPLATE | cut -d/ -f10-)

    # Define list of configuration lines related to current design
    # model. This are the lines that tell us how and where to apply
    # branding information on base PNG image. Be sure that only
    # configuration lines from supported section names (e.g.,
    # `symbol', `type', `logo') be read, no need to waste resources
    # with others.
    BRANDING_CONF_VALUES=$(\
        for BRANDING_CONF_SECTION in $(echo "types symbols logos");do
            cli_getConfigValue "${BRANDING_CONF_FILE}" "${BRANDING_CONF_SECTION}" "${BRANDING_CONF_VARNAME}"
        done)

    for BRANDING_CONF_VALUE in $BRANDING_CONF_VALUES;do

        # Define absolute path to image file used as brand. This is
        # the image put over the PNG image produced as result of
        # design models base rendition.
        BRAND="$(cli_getRepoTLDir)/Identity/Images/Brands/$(echo $BRANDING_CONF_VALUE \
            | gawk 'BEGIN{ FS=":" } { print $1 }')"

        # Verify absolute path to image file used as brand. Assuming
        # no brand image file is found, continue with the next
        # configuration line.
        if [[ ! -f $BRAND ]];then
            continue
        fi

        # Define list of positions using the format of ImageMagick
        # `-geometry' option argument. 
        POSITIONS=$(echo "$BRANDING_CONF_VALUE" | cut -d: -f2- | tr ':' ' ')

        # Loop through list of brand image positions and use the
        # composite command from ImageMagick, to overlap brand image
        # over unbranded image just rendered.
        for POSITION in $POSITIONS;do
            composite -geometry $POSITION $BRAND ${FILE}.png ${FILE}.png
        done

    done

}
