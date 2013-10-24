#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Svg/Scripts/svg_setBrandInformation.sh --
#   This function takes brand information from configuration files,
#   processes it, and apply it on final PNG image file.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function svg_setBrandInformation {

    for BRAND in ${BRANDS};do

        local FILENAME=$(echo ${BRAND} | cut -d: -f1)
        local GEOMETRY=$(echo ${BRAND} | cut -d: -f2)

        tcar_checkFiles -ef ${FILENAME}

        /usr/bin/composite -geometry ${GEOMETRY} ${FILENAME} ${RENDER_TARGET} ${RENDER_TARGET}

    done

}
