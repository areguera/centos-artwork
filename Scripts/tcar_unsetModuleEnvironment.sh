#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Unset functions exported to tcar.sh script execution environment.
function tcar_unsetModuleEnvironment {

    # Reset text domain locally, in order to prevent this function
    # from using the last text domain definition. By default all
    # common functions do use the same MO file.
    local TEXTDOMAIN="${TCAR_SCRIPT_NAME}"

    # Verify suffix value used to retrieve function files.
    if [[ -z ${TCAR_MODULE_NAME} ]];then
        tcar_printMessage "`gettext "The export id was not provided."`" --as-error-line
    fi

    # Define list of format-specific functionalities. This is the list
    # of function definitions previously exported by
    # `tcar_setModuleEnvironmentScripts'.  Be sure to limit the list
    # to function names that start with the suffix specified only.
    local TCAR_MODULE_SCRIPT_FN=''
    local TCAR_MODULE_SCRIPT_FNS=$(declare -F | gawk '{ print $3 }' | egrep "^${TCAR_MODULE_NAME}")

    # Unset function names from current execution environment.
    for TCAR_MODULE_SCRIPT_FN in ${TCAR_MODULE_SCRIPT_FNS};do
        unset -f ${TCAR_MODULE_SCRIPT_FN}
        tcar_printMessage "unset -f : ${TCAR_MODULE_SCRIPT_FN}" --as-debugger-line
    done

}
