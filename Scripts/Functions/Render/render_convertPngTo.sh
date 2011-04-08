#!/bin/bash
#
# render_convertPngTo.sh -- This function provides post-rendition
# to convert images produced by centos-art base-rendition.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function render_convertPngTo {

    # Get image formats.
    local FORMATS=$(render_getConfigOption "$ACTION" '2-')

    # Check base file existence.
    cli_checkFiles ${FILE}.png 'f'

    # Check image formats and do convertion.
    if [[ "$FORMATS" != "" ]];then
        for FORMAT in $FORMATS;do
            cli_printMessage "${FILE}.${FORMAT}" "AsSavedAsLine"
            convert -quality 85 ${FILE}.png ${FILE}.${FORMAT}
        done

    fi

}
