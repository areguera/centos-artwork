#!/bin/bash
######################################################################
#
#   tcar_setModuleEnvironment.sh -- This function initiates module
#   environments inside the tcar.sh script.
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

function tcar_setModuleEnvironment {

    local ARG_MODULE_NAME=''
    local ARG_MODULE_TYPE=''
    local ARG_MODULE_ARGS=''

    # Retrieve module's name and module's type from arguments passed
    # through this function positional parameters.
    OPTIND=1
    while getopts "m:,t:,g:" OPTION "${@}"; do
        case "${OPTION}" in
            m ) ARG_MODULE_NAME="${OPTARG}" ;;
            t ) ARG_MODULE_TYPE="${OPTARG}" ;;
            g ) ARG_MODULE_ARGS="${OPTARG} ${ARG_MODULE_ARGS}" ;;
        esac
    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( ${OPTIND} - 1 ))

    # Initialize module's global counter.
    TCAR_MODULE_COUNT=${TCAR_MODULE_COUNT:-0}

    # When the last module in the chain of executed modules is the
    # same module being currently executed, don't create a new
    # position for it in the chain of modules. Instead, use the
    # information it already has from its previous execution. In order
    # for this to work, the current module must be executed as sibling
    # module of other module or itself.
    if [[ ${TCAR_MODULE_COUNT} -gt 0 ]];then
        if [[ ${TCAR_MODULE_NAMES[((${TCAR_MODULE_COUNT} - 1))]} == ${ARG_MODULE_NAME} ]];then
            if [[ ${ARG_MODULE_TYPE} == 'sibling' ]];then
                tcar_printMessage '~~~~~~~~~~~~~~~~~~~~~~~~~> : '"${TCAR_MODULE_NAME} ${TCAR_MODULE_ARGUMENT}" --as-debugger-line
                ${ARG_MODULE_NAME} ${ARG_MODULE_ARGS} ${@}
                return
            fi
        fi
    fi

    tcar_printMessage '=========================>: ['${TCAR_MODULE_COUNT}'] | '${FUNCNAME[1]} --as-debugger-line

    # Define module's base directory. This is the directory where the
    # initialization script is stored in.
    local TCAR_MODULE_BASEDIR=${TCAR_SCRIPT_MODULES_BASEDIR}
    if [[ ${#TCAR_MODULE_BASEDIRS[*]} -gt 0 ]];then
        if [[ ${ARG_MODULE_TYPE} == "parent" ]];then
            TCAR_MODULE_BASEDIR=${TCAR_SCRIPT_MODULES_BASEDIR}
        elif [[ ${ARG_MODULE_TYPE} == "sibling" ]];then
            if [[ ${TCAR_MODULE_TYPES[((${TCAR_MODULE_COUNT} - 1 ))]} == 'sibling' ]];then
                TCAR_MODULE_BASEDIR=${TCAR_MODULE_BASEDIRS[((${TCAR_MODULE_COUNT}-2))]}
            else
                TCAR_MODULE_BASEDIR=${TCAR_MODULE_BASEDIRS[((${TCAR_MODULE_COUNT}-1))]}
            fi
        else
            TCAR_MODULE_BASEDIR=${TCAR_MODULE_BASEDIRS[${TCAR_MODULE_COUNT}]}
        fi
    fi
    tcar_printMessage "TCAR_MODULE_BASEDIR : ${TCAR_MODULE_BASEDIR}" --as-debugger-line

    # Define module's name.
    TCAR_MODULE_NAMES[${TCAR_MODULE_COUNT}]=$(tcar_getRepoName "${ARG_MODULE_NAME:-unknown}" "-f" | cut -d '-' -f1)
    local TCAR_MODULE_NAME=${TCAR_MODULE_NAMES[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_NAME : [${TCAR_MODULE_COUNT}]=${TCAR_MODULE_NAME}" --as-debugger-line

    # Define module's type.
    TCAR_MODULE_TYPES[${TCAR_MODULE_COUNT}]="${ARG_MODULE_TYPE:-parent}"
    local TCAR_MODULE_TYPE=${TCAR_MODULE_TYPES[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_TYPE : ${TCAR_MODULE_TYPE}" --as-debugger-line

    # Define module's arguments.  This variable is used in different
    # module environments to pass positional parameters from one
    # environment to another using local definitions.
    TCAR_MODULE_ARGUMENTS[${TCAR_MODULE_COUNT}]="${ARG_MODULE_ARGS:-} ${@}"
    local TCAR_MODULE_ARGUMENT=${TCAR_MODULE_ARGUMENTS[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_ARGUMENT : ${TCAR_MODULE_ARGUMENT}" --as-debugger-line

    # Check module's name possible values.
    tcar_checkModuleName

    # Define module's directory.
    TCAR_MODULE_DIRS[${TCAR_MODULE_COUNT}]=${TCAR_MODULE_BASEDIR}/$(tcar_getRepoName "${TCAR_MODULE_NAME}" "-f")
    local TCAR_MODULE_DIR=${TCAR_MODULE_DIRS[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_DIR : ${TCAR_MODULE_DIR}" --as-debugger-line

    # Define module's directories not reused from module's parent
    # directory structure.
    TCAR_MODULE_DIRS_MODULES[${TCAR_MODULE_COUNT}]=${TCAR_MODULE_DIR}/modules
    local TCAR_MODULE_DIR_MODULES=${TCAR_MODULE_DIRS_MODULES[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_DIR_MODULES : ${TCAR_MODULE_DIR_MODULES}" --as-debugger-line

    TCAR_MODULE_DIRS_CONFIGS[${TCAR_MODULE_COUNT}]=${TCAR_MODULE_DIR}/configs
    local TCAR_MODULE_DIR_CONFIGS=${TCAR_MODULE_DIRS_CONFIGS[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_DIR_CONFIGS : ${TCAR_MODULE_DIR_CONFIGS}" --as-debugger-line

    # Define module's directories reused from module's parent
    # directory structure.
    TCAR_MODULE_DIRS_MANUALS[${TCAR_MODULE_COUNT}]=${TCAR_MODULE_DIRS[0]}/manuals
    local TCAR_MODULE_DIR_MANUALS=${TCAR_MODULE_DIRS_MANUALS[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_DIR_MANUALS : ${TCAR_MODULE_DIR_MANUALS}" --as-debugger-line

    TCAR_MODULE_DIRS_LOCALES[${TCAR_MODULE_COUNT}]=${TCAR_MODULE_DIRS[0]}/locales
    local TCAR_MODULE_DIR_LOCALES=${TCAR_MODULE_DIRS_LOCALES[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_DIR_LOCALES : ${TCAR_MODULE_DIR_LOCALES}" --as-debugger-line

    # Define module's initialization file.
    TCAR_MODULE_INIT_FILES[${TCAR_MODULE_COUNT}]=${TCAR_MODULE_DIR}/${TCAR_MODULE_NAME}.sh
    local TCAR_MODULE_INIT_FILE=${TCAR_MODULE_INIT_FILES[${TCAR_MODULE_COUNT}]}
    tcar_printMessage "TCAR_MODULE_INIT_FILE : ${TCAR_MODULE_INIT_FILE}" --as-debugger-line

    # Define module's connection with their localization files. It is
    # required that gettext-specific variables be defined locally, in
    # order to implement per-module localization.
    local TEXTDOMAIN=$(basename ${TCAR_MODULE_INIT_FILE})
    tcar_printMessage "TEXTDOMAIN: ${TEXTDOMAIN}" --as-debugger-line

    # Increment module's counter just before creating next module's
    # base directory.
    TCAR_MODULE_COUNT=$(( ${TCAR_MODULE_COUNT} + 1 ))

    # Define next module's base directory.
    TCAR_MODULE_BASEDIRS[${TCAR_MODULE_COUNT}]=${TCAR_MODULE_DIR_MODULES}

    # Check function script execution rights.
    tcar_checkFiles -ex ${TCAR_MODULE_INIT_FILE}

    # Load module-specific (function) scripts into current execution
    # environment.  Keep the tcar_setModuleEnvironmentScripts function
    # call after all variables and arguments definitions.
    tcar_setModuleEnvironmentScripts

    # Execute module's initialization script with its arguments.
    tcar_printMessage '-------------------------> : '"${TCAR_MODULE_NAME} ${TCAR_MODULE_ARGUMENT}" --as-debugger-line
    ${TCAR_MODULE_NAME} ${TCAR_MODULE_ARGUMENT}

    # Unset module-specific environment.
    tcar_printMessage '<------------------------- : '"${TCAR_MODULE_NAME} ${TCAR_MODULE_ARGUMENT}" --as-debugger-line
    tcar_unsetModuleEnvironment

    # Decrement module counter just after unset unused module
    # environments.
    TCAR_MODULE_COUNT=$(( ${TCAR_MODULE_COUNT} - 1 ))

    # Unset array and non-array variables used in this function.
    if [[ ${TCAR_MODULE_COUNT} -eq 0 ]];then
        unset TCAR_MODULE_NAMES
        unset TCAR_MODULE_BASEDIRS
        unset TCAR_MODULE_DIRS
        unset TCAR_MODULE_DIRS_MODULES
        unset TCAR_MODULE_DIRS_MANUALS
        unset TCAR_MODULE_DIRS_LOCALES
        unset TCAR_MODULE_DIRS_CONFIGS
        unset TCAR_MODULE_NAME
        unset TCAR_MODULE_DIR
        unset TCAR_MODULE_DIR_MODULES
        unset TCAR_MODULE_DIR_MANUALS
        unset TCAR_MODULE_DIR_LOCALES
        unset TCAR_MODULE_DIR_CONFIGS
    fi

    tcar_printMessage '<=========================: ['${TCAR_MODULE_COUNT}'] | '${FUNCNAME[1]} --as-debugger-line

}
