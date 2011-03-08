#!/bin/bash
#
# identity_renderSvg.sh -- This function performs base-rendition
# action for SVG files.
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

function identity_renderSvg {

    # Define export id used inside design templates. This value
    # defines the design area we want to export.
    local EXPORTID='CENTOSARTWORK'

    # Check export id inside design templates.
    grep "id=\"$EXPORTID\"" $INSTANCE > /dev/null
    if [[ $? -gt 0 ]];then
        cli_printMessage "`eval_gettext "There is no export id (\\\$EXPORTID) inside \\\$TEMPLATE."`" "AsErrorLine"
        cli_printMessage '-' 'AsSeparatorLine'
        continue
    fi

    # Check existence of external files. Inside design templates and
    # their instances, external files are used to refere the
    # background information required by the design template. If such
    # background information is not available the image is produced
    # without background information. This is something that need to
    # be avoided.
    identity_checkSvgAbsref "$INSTANCE"

    # Render template instance using inkscape. Modify the inkscape
    # output to reduce the amount of characters used in description
    # column at final output.
    cli_printMessage "$(inkscape $INSTANCE \
        --export-id=$EXPORTID --export-png=${FILE}.png | sed -r \
        -e "s!Area !`gettext "Area"`: !" \
        -e "s!Background RRGGBBAA:!`gettext "Background"`: RRGGBBAA!" \
        -e "s!Bitmap saved as:!`gettext "Saved as"`:!")" 'AsRegularLine'
 
}
