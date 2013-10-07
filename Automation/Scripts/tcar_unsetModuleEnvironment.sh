#!/bin/bash
######################################################################
#
#   tcar_unsetModuleEnvironment.sh -- This function unsets
#   functionalities from centos-art.sh script execution environment.
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

function tcar_unsetModuleEnvironment {

    # Define gettext-specific variables locally, to provide
    # per-function localization.
    local TEXTDOMAIN="${FUNCNAME}.sh"
    local TEXTDOMAINDIR="${TCAR_SCRIPT_BASEDIR}/Scripts/Locales"

    # Verify suffix value used to retrieve function files.
    if [[ -z ${TCAR_MODULE_NAME} ]];then
        tcar_printMessage "`gettext "The export id was not provided."`" --as-error-line
    fi

    # Define list of format-specific functionalities. This is the list
    # of function definitions previously exported by
    # `tcar_setModuleEnvironmentScripts'.  Be sure to limit the list
    # to function names that start with the suffix specified only.
    local FUNCTION_DEF=''
    local FUNCTION_DEFS=$(declare -F | gawk '{ print $3 }' | egrep "^${TCAR_MODULE_NAME}")

    # Unset function names from current execution environment.
    for FUNCTION_DEF in ${FUNCTION_DEFS};do
        unset -f ${FUNCTION_DEF}
    done

}
