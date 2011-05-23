#!/bin/bash
#
# render_svg_checkModelExportId.sh -- This function standardizes the export id
# used inside svg files and the way of verify them.
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

function render_svg_checkModelExportId {

    local INSTANCE="$1"
    local EXPORTID="$2"

    # Verify instance.
    cli_checkFiles $INSTANCE

    # Verify export id.
    if [[ $EXPORTID == '' ]];then
        cli_printMessage "`gettext "The export id value cannot be empty."`" --as-error-line
    fi

    # Check export id inside design templates.
    grep "id=\"$EXPORTID\"" $INSTANCE > /dev/null
    if [[ $? -gt 0 ]];then
        cli_printMessage "`eval_gettext "There is not export id (\\\$EXPORTID) inside \\\"\\\$TEMPLATE\\\"."`" --as-error-line
    fi

}
