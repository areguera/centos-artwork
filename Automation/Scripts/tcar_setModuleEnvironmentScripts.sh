#!/bin/bash
######################################################################
#
#   tcar_setModuleEnvironmentScripts.sh -- This function standardizes
#   the way specific functionalities are exported to centos-art.sh
#   script environment.
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

function tcar_setModuleEnvironmentScripts {

    # Define gettext-specific variables locally, to provide
    # per-function localization.
    local TEXTDOMAIN="${FUNCNAME}.sh"
    local TEXTDOMAINDIR="${TCAR_SCRIPT_BASEDIR}/Scripts/Locales"

    # Define the pattern used to retrieve function names from function
    # files.
    local FUNCTION_PATTERN="^function[[:space:]]+${TCAR_MODULE_NAME}(_[[:alnum:]]+)?[[:space:]]+{[[:space:]]*$"

    # Define the list of files.
    local TCAR_MODULE_SCRIPT=''
    local TCAR_MODULE_SCRIPTS="${TCAR_MODULE_INIT_FILE}"
    if [[ -d ${TCAR_MODULE_DIR} ]];then
        TCAR_MODULE_SCRIPTS="${TCAR_MODULE_SCRIPTS}
            $(tcar_getFilesList ${TCAR_MODULE_DIR} \
            --pattern="${TCAR_MODULE_DIR}/${TCAR_MODULE_NAME}_[[:alnum:]]+\.sh$" --type='f')"
    fi

    # Verify the list of files. If no function file exists for the
    # location specified stop the script execution. Otherwise the
    # script will surely try to execute a function that haven't been
    # exported yet and report an error about it.
    if [[ -z ${TCAR_MODULE_SCRIPTS} ]];then
        tcar_printMessage "${FUNCNAME}: `gettext "No function file was found."`" --as-error-line
    fi

    # Process the list of files.
    for TCAR_MODULE_SCRIPT in ${TCAR_MODULE_SCRIPTS};do

        # Verify the execution rights for function file.
        tcar_checkFiles -ex ${TCAR_MODULE_SCRIPT}

        # Verify that function files have not been already exported.
        # If they have been already exported don't export them again.
        # Instead, continue with the next function file in the list.
        declare -F | gawk '{ print $3 }' | egrep "^${TCAR_MODULE_SCRIPT}$" > /dev/null
        if [[ $? -eq 0 ]];then
            continue
        fi

        # Initialize the function file.
        . ${TCAR_MODULE_SCRIPT}

        # Retrieve the function's name from function's file.
        local TCAR_MODULE_SCRIPT_FN=$(egrep "${FUNCTION_PATTERN}" ${TCAR_MODULE_SCRIPT} \
            | gawk '{ print $2 }')

        # Export the function names inside the file to current shell
        # script environment.
        export -f ${TCAR_MODULE_SCRIPT_FN}

        tcar_printMessage "export -f : ${TCAR_MODULE_SCRIPT_FN}" --as-debugger-line

    done

}
