#!/bin/bash
######################################################################
#
#   tcar_setModuleEnvironment.sh -- This function initiates module
#   environments inside the centos-art.sh script.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
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
        tcar_printMessage "`gettext "The module provided isn't valid."`" --as-error-line
    fi

    # Define module's directory.
    local MODULE_DIR=${TCAR_SCRIPT_MODULES_BASEDIR}/$(tcar_getRepoName "${MODULE_NAME}" "-d")

    # Define module's related directories.
    local MODULE_DIR_MODULES=${MODULE_DIR}/Modules
    local MODULE_DIR_MANUALS=${MODULE_DIR}/Manuals
    local MODULE_DIR_SCRIPTS=${MODULE_DIR}/Scripts
    local MODULE_DIR_LOCALES=${MODULE_DIR}/Locales

    # Define module's initialization file.
    local MODULE_INIT_FILE=${MODULE_DIR}/${MODULE_NAME}.sh

    # Check function script execution rights.
    tcar_checkFiles -x ${MODULE_INIT_FILE}

    # Remove the first argument passed to centos-art.sh command-line
    # in order to build optional arguments inside functionalities. We
    # start counting from second argument on, inclusively.
    shift 1

    # Verify number of arguments passed to centos-art.sh script. By
    # default, to all modules, when no option is provided the version
    # information is printed.
    if [[ $# -lt 1 ]];then
        tcar_printVersion
    fi

    # Redefine module-specific configuration values.
    if [[ -f ${MODULE_DIR}/${MODULE_NAME}.conf.sh ]];then
        . ${MODULE_DIR}/${MODULE_NAME}.conf.sh
    fi

    # Redefine module-specific internationalization configuration variables.
    declare -x TEXTDOMAIN=${MODULE_NAME}
    declare -x TEXTDOMAINDIR=${MODULE_DIR}/Locales

    # Load module-specific (function) scripts into current execution
    # environment.  Keep the tcar_setModuleEnvironmentScripts function
    # call after all variables and arguments definitions.
    tcar_setModuleEnvironmentScripts

    # Execute module-specific initialization script.
    ${MODULE_NAME} "${@}"

}
