#!/bin/bash
#
# render_resizePngTo.sh -- This function provides post-rendition to
# resize images produced by centos-art base-rendition.
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

function render_resizePngTo {

    local SIZE=''
    local SIZES=$(render_getConfigOption "$ACTION" '2-')
    local SRC=''
    local DST=''

    # Check base file existence.
    cli_checkFiles ${FILE}.png 'f'

    # Check image degrees.
    if [[ "$SIZES" != "" ]];then

        # Loop through image degrees and convert them using PNG file
        # as base.
        for SIZE in $SIZES;do
            SRC=${FILE}.png
            DST=${FILE}-resized-$(echo $SIZE | sed 's!%!!').png
            cli_printMessage "$DST" "AsSavedAsLine"
            convert -resize $SIZE ${SRC} ${DST}
        done

    fi

}
