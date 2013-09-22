#!/bin/bash
######################################################################
#
#   tcar_setModuleEnvironment.sh -- This function initiates
#   first-level module (or simply, module) environments inside the
#   centos-art.sh script. 
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

function tcar_setModuleEnvironment {

    # Define module's name (MODULE_NAME) using the first argument
    # in the command-line.
    local MODULE_NAME=$(tcar_getRepoName "${1}" "-f" | cut -d '-' -f1)

    # Define regular expression to match available modules.
    local MODULE_NAME_LIST=$(ls ${TCAR_SCRIPT_MODULES_BASEDIR} \
        | tr '\n' '|' | sed -r 's/\|$//' | tr '[[:upper:]]' '[[:lower:]]')

    # Check module's name possible values.
    if [[ ! ${MODULE_NAME} =~ "^(${MODULE_NAME_LIST})$" ]];then
        tcar_printMessage "`eval_gettext "The module (\\\$MODULE_NAME) isn't supported yet."`" --as-error-line
    fi

    # Define module's directory.
    local MODULE_DIR=${TCAR_SCRIPT_MODULES_BASEDIR}/$(tcar_getRepoName "${MODULE_NAME}" "-d")

    # Define module's related directories.
    local MODULE_DIR_MODULES=${MODULE_DIR}/Modules
    local MODULE_DIR_MANUALS=${MODULE_DIR}/Manuals
    local MODULE_DIR_CONFIGS=${MODULE_DIR}/Configs

    # Define the sub-module's base directory where sub-module
    # processing will start from.
    local SUBMODULE_BASEDIR=${MODULE_DIR_MODULES}

    # Define module's initialization file.
    local MODULE_INIT_FILE=${MODULE_DIR}/${MODULE_NAME}.sh

    # Check function script execution rights.
    tcar_checkFiles -ex ${MODULE_INIT_FILE}

    # Remove the first argument passed to centos-art.sh command-line
    # in order to build optional arguments inside functionalities. We
    # start counting from second argument on, inclusively.
    shift 1

    # Load module-specific (function) scripts into current execution
    # environment.  Keep the tcar_setModuleEnvironmentScripts function
    # call after all variables and arguments definitions.
    tcar_setModuleEnvironmentScripts "${MODULE_DIR}" "${MODULE_NAME}" "${MODULE_INIT_FILE}"

    # Execute module-specific initialization script.
    ${MODULE_NAME} "${@}"

    # Unset the module environment.
    tcar_unsetModuleEnvironment "${MODULE_NAME}"

}
