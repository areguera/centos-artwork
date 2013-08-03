#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Alter/Modules/Color/Scripts/palette_checkColorFormats.sh
#   -- This function verifies formats of colors (i.e., the way color
#   information is specified).
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
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
######################################################################

function palette_checkColorFormats {

    local COLOR=''
    local PALETTE_COLORS=${1}

    # Loop through colors and perform format verification as specified
    # by pattern.
    for COLOR in ${PALETTE_COLORS};do
        tcar_checkFiles ${COLOR} --match='#[0-9a-f]{6}$'
    done

}
