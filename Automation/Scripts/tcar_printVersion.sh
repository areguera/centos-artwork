#!/bin/bash
######################################################################
#
#   tcar_printVersion.sh -- This function standardizes the way
#   centos-art.sh script prints version about itself.
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

function tcar_printVersion {

    local PROGRAM_NAME=${1:-${TCAR_SCRIPT_NAME}}
    local YEAR=$(tcar_printCopyrightInfo --year)
    local HOLDER=$(tcar_printCopyrightInfo --holder)

    if [[ ${PROGRAM_NAME} == ${TCAR_SCRIPT_NAME} ]];then
        tcar_printMessage "${TCAR_SCRIPT_NAME} ${TCAR_SCRIPT_VERSION}" --as-stdout-line
    else
        tcar_printMessage "${PROGRAM_NAME} (${TCAR_SCRIPT_NAME}) ${TCAR_SCRIPT_VERSION}" --as-stdout-line
    fi
    tcar_printMessage "Copyright (C) ${YEAR} ${HOLDER}" --as-stdout-line
    tcar_printMessage "`eval_gettext "\\\$PROGRAM_NAME comes with NO WARRANTY, to the extent permitted by law. You may redistribute copies of \\\$PROGRAM_NAME under the terms of the GNU General Public License. For more information about these matters, see the files named COPYING."`" --as-stdout-line | fold --width=66 --spaces

    exit 0

}
