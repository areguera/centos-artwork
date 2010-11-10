#!/bin/bash
#
# render_doIdentityImageBrands.sh -- This function provides
# post-rendering actions to produce CentOS brands.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function render_doIdentityImageBrands {

    local SOURCEFILE=''
    local TARGETDIR=''
    local TARGETFILE=''

    # Define absolute path to image file.
    local FILE="$1"

    # Define image formats.
    local FORMATS="$2"

    # Create logo copy in defined formats.
    render_doIdentityImageFormats "$FILE" "$FORMATS"

    # Create logo copy in 2 colors.
    cli_printMessage "${FILE}.xbm (`gettext "2 colors grayscale"`)" "AsSavedAsLine"
    convert -colorspace gray -colors 2 \
        ${FILE}.png \
        ${FILE}.xbm

    # Create logo copy in emboss effect.
    cli_printMessage "${FILE}-emboss.png" "AsSavedAsLine"
    convert -emboss 1 \
        ${FILE}.png \
        ${FILE}-emboss.png

    # Move logo copy in 2 colors into its final location. This action
    # complements groupByType post-rendering action.
    SOURCEFILE=$FILE.xbm
    TARGETDIR=$(dirname $FILE)/Xbm
    TARGETFILE=$TARGETDIR/$(basename $SOURCEFILE)
    # --- centos-art path $SOURCEFILE --move-to=$TARGETDIR
    cli_printMessage "$TARGETFILE" 'AsMovedToLine'
    cli_checkFiles $TARGETDIR 'd'
    if [[ $? -ne 0 ]];then
        mkdir -p $TARGETDIR
    fi
    mv ${SOURCEFILE} --target-directory=$TARGETDIR --force

    # Move logo copy with emboss effect into its final location. This
    # action complements groupByType post-rendering action.
    SOURCEFILE=${FILE}-emboss.png
    TARGETDIR=$(dirname $FILE)/Png
    TARGETFILE=$TARGETDIR/$(basename $SOURCEFILE)
    # --- centos-art path $SOURCEFILE --move-to=$TARGETDIR
    cli_printMessage "$TARGETFILE" 'AsMovedToLine'
    cli_checkFiles $TARGETDIR 'd'
    if [[ $? -ne 0 ]];then
        mkdir -p $TARGETDIR
    fi
    mv ${SOURCEFILE} --target-directory=$TARGETDIR --force

}
