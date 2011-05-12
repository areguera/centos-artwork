#!/bin/bash
#
# render_svg.sh -- This function performs base-rendition action for
# SVG files.
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

function render_svg {

    # Initialize the export id used inside design templates. This
    # value defines the design area we want to export.
    local EXPORTID='CENTOSARTWORK'

    # Verify the export id.
    render_svg_checkExportId "$INSTANCE" "$EXPORTID" 

    # Check existence of external files. Inside design templates and
    # their instances, external files are used to refere the
    # background information required by the design template. If such
    # background information is not available the image is produced
    # without background information. This is something that need to
    # be avoided.
    render_svg_checkAbsref "$INSTANCE"

    # Render template instance using inkscape and save the output.
    local INKSCAPE_OUTPUT="$(\
        inkscape $INSTANCE --export-id=$EXPORTID --export-png=${FILE}.png)"

    # Modify output from inkscape to fit the centos-art.sh script
    # output visual style.
    cli_printMessage "$(echo "$INKSCAPE_OUTPUT" | egrep '^Area' \
        | sed -r "s!^Area!`gettext "Area"`:!")"
    cli_printMessage "$(echo "$INKSCAPE_OUTPUT" | egrep '^Background' \
        | sed -r "s!^Background (RRGGBBAA):(.*)!`gettext "Background"`: \1 \2!")" 
    cli_printMessage "$(echo "$INKSCAPE_OUTPUT" | egrep '^Bitmap saved as' \
        | sed -r "s!^Bitmap saved as:!`gettext "Saved as"`:!")"
 
}
