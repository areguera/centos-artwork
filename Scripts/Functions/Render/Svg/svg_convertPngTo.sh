#!/bin/bash
#
# svg_convertPngTo.sh -- This function provides post-rendition actions
# to use the `convert' command of ImageMagick tool set.
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

function svg_convertPngTo {

    # Initialize image formats.
    local FORMAT=''
    local FORMATS=$(${CLI_FUNCNAME}_getConfigOption "$ACTION" '2')

    # Convert from PNG to specified formats.
    for FORMAT in $FORMATS;do
        cli_printMessage "${FILE}.${FORMAT}" --as-savedas-line
        convert -quality 85 ${FILE}.png ${FILE}.${FORMAT}
    done

}
