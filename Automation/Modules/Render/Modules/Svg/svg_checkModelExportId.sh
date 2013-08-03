#!/bin/bash
######################################################################
#
#   Modules/Render/Modules/Svg/Scripts/svg_checkModelExportId.sh --
#   This function standardizes the export id used inside svg files and
#   the way of verify them.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function svg_checkModelExportId {

    local INSTANCE="$1"
    local EXPORTID="$2"

    # Verify instance.
    tcar_checkFiles -e ${INSTANCE}

    # Verify export id.
    tcar_checkFiles ${EXPORTID} --match="[[:alnum:]]+"

    # Check export id inside design templates.
    grep "id=\"${EXPORTID}\"" ${INSTANCE} > /dev/null
    if [[ $? -gt 0 ]];then
        tcar_printMessage "`eval_gettext "There is not export id (\\\${EXPORTID}) inside \\\"\\\${TEMPLATE}\\\"."`" --as-error-line
    fi

}
