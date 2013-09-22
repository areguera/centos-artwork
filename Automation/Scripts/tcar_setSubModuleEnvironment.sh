#!/bin/bash
######################################################################
#
#   tcar_setSubModuleEnvironment.sh -- This function initiates
#   modules' sub-module environments inside the centos-art.sh script.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2013 The CentOS Project
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

function tcar_setSubModuleEnvironment {

    # Define sub-module's name (SUBMODULE_NAME) using the first
    # argument in the command-line.
    local SUBMODULE_NAME=$(tcar_getRepoName "${1}" "-f" | cut -d '-' -f1)

    # Define regular expression to match available sub-modules.
    local SUBMODULE_NAME_LIST=$(ls ${SUBMODULE_BASEDIR} \
        | tr '\n' '|' | sed -r 's/\|$//' | tr '[[:upper:]]' '[[:lower:]]')

    # Check sub-module's name possible values.
    if [[ ! ${SUBMODULE_NAME} =~ "^(${SUBMODULE_NAME_LIST})$" ]];then
        tcar_printMessage "`eval_gettext "The sub-module (\\\$SUBMODULE_NAME) isn't supported yet."`" --as-error-line
    fi

    # Define sub-module's directory.
    local SUBMODULE_DIR=${SUBMODULE_BASEDIR}/$(tcar_getRepoName "${SUBMODULE_NAME}" "-d")

    # Define sub-module's related directories.
    local SUBMODULE_DIR_MODULES=${SUBMODULE_DIR}/Modules
    local SUBMODULE_DIR_MANUALS=${SUBMODULE_DIR}/Manuals
    local SUBMODULE_DIR_CONFIGS=${SUBMODULE_DIR}/Configs

    # Reset sub-module's current directory.
    local SUBMODULE_BASEDIR=${SUBMODULE_DIR_MODULES}

    # Define sub-module's initialization file.
    local SUBMODULE_INIT_FILE=${SUBMODULE_DIR}/${SUBMODULE_NAME}.sh

    # Check function script execution rights.
    tcar_checkFiles -ex ${SUBMODULE_INIT_FILE}

    # Remove the first argument passed to centos-art.sh command-line
    # in order to build optional arguments inside functionalities. We
    # start counting from second argument on, inclusively.
    shift 1

    # Verify the number of arguments passed to centos-art.sh script.
    # By default, to all sub-modules, when no argument is provided
    # after the sub-module name, use the current directory as default
    # directory to look for configuration files.
    if [[ $# -eq 0 ]];then
        set -- ${PWD}
    fi

    # Load sub-module-specific (function) scripts into current
    # execution environment.
    tcar_setModuleEnvironmentScripts "${SUBMODULE_DIR}" "${SUBMODULE_NAME}" "${SUBMODULE_INIT_FILE}"

    # Execute sub-module-specific initialization script.
    ${SUBMODULE_NAME} "${@}"

    # Unset the sub-module environment.
    tcar_unsetModuleEnvironment "${SUBMODULE_NAME}"

}
