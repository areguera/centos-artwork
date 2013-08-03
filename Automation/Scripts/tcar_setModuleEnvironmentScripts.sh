#!/bin/bash
######################################################################
#
#   tcar_setModuleEnvironmentScripts.sh -- This function standardizes
#   the way specific functionalities are exported to centos-art.sh
#   script environment.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
#
# Copyright (C) 2009-2013 The CentOS Project
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

    # Define the pattern used to retrieve function names from function
    # files.
    local FUNCTION_PATTERN="^function[[:space:]]+${MODULE_NAME}(_[[:alnum:]]+)?[[:space:]]+{[[:space:]]*$"

    # Define the list of files.
    local MODULE_SCRIPTS="${MODULE_INIT_FILE}"
    if [[ -d ${MODULE_DIR} ]];then
        MODULE_SCRIPTS="${MODULE_SCRIPTS} 
            $(tcar_getFilesList ${MODULE_DIR} \
            --pattern="${MODULE_DIR}/${MODULE_NAME}_.+\.sh$" --maxdepth='1' \
            --mindepth='1' --type='f')"
    fi

    # Verify the list of files. If no function file exists for the
    # location specified stop the script execution. Otherwise the
    # script will surely try to execute a function that haven't been
    # exported yet and report an error about it.
    if [[ -z ${MODULE_SCRIPTS} ]];then
        tcar_printMessage "${FUNCNAME}: `gettext "No function file was found."`" --as-error-line
    fi

    # Process the list of files.
    for MODULE_SCRIPT in ${MODULE_SCRIPTS};do

        # Verify the execution rights for function file.
        tcar_checkFiles -x ${MODULE_SCRIPT}

        # Verify that function files have not been already exported.
        # If they have been already exported don't export them again.
        # Instead, continue with the next function file in the list.
        declare -F | gawk '{ print $3 }' | egrep "^${MODULE_SCRIPT}$" > /dev/null
        if [[ $? -eq 0 ]];then
            continue
        fi

        # Initialize the function file.
        . ${MODULE_SCRIPT}

        # Export the function names inside the file to current shell
        # script environment.
        export -f $(egrep "${FUNCTION_PATTERN}" ${MODULE_SCRIPT} | gawk '{ print $2 }')

    done

}
