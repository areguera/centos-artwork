#!/bin/bash
######################################################################
#
#   cli.sh -- This function initiates the centos-art.sh script
#   command-line interface. This is the first script the centos-art.sh
#   runs, onces it has been executed in a terminal.
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

function cli {

    # Initialize command-line interface default configuration values.
    if [[ -f ${TCAR_CLI_INIT_DIR}/cli.conf ]];then
        . ${TCAR_CLI_INIT_DIR}/cli.conf
    fi

    # Initialize list of common functionalities to load.
    for CLI_FUNCTION in $(ls ${TCAR_CLI_INIT_DIR}/Scripts/*.sh);do
        if [[ -x ${CLI_FUNCTION} ]];then
            . ${CLI_FUNCTION}
            export -f $(grep '^function ' ${CLI_FUNCTION} | cut -d' ' -f2)
        else
            echo "${CLI_FUNCTION} `gettext "has not execution rights."`"
        fi
    done

    # Trap signals in order to terminate the script execution
    # correctly (e.g., removing all temporal files before leaving).
    # Trapping the exit signal seems to be enough by now, since it is
    # always present as part of the script execution flow. Each time
    # the centos-art.sh script is executed it will inevitably end with
    # an EXIT signal at some point of its execution, even if it is
    # interrupted in the middle of its execution (e.g., through
    # `Ctrl+C').
    trap cli_terminateScriptExecution 0

    # Redefine arguments using current positional parameters. 
    cli_setArguments "${@}"

    # Redefine positional parameters using arguments variable.
    eval set -- "${TCAR_MODULE_ARGUMENTS}"

    # Check the number of arguments passed in the command-line
    # interface.  The first argument must be the name of the module
    # you want to execute. So at least one argument must be provided
    # in the command-line.
    if [[ $# -lt 1 ]];then
        cli_printHelp ${TCAR_CLI_NAME}
    else
        # Check module's name. The module's name is critical for
        # centos-art.sh script to do something coherent. If it is not
        # provided or provided incorrectly, finish the script
        # execution with help information.
        if [[ ! "${1}" =~ '^[[:alpha:]]+$' ]];then
            cli_printHelp ${TCAR_CLI_NAME}-cli
        fi
    fi

    # Define function name (MODULE_INIT_NAME) using the first argument
    # in the command-line.
    local MODULE_INIT_NAME=$(cli_getRepoName ${1} -f | cut -d '-' -f1)

    # Define function directory.
    local MODULE_INIT_DIR=${TCAR_CLI_BASEDIR}/Modules/${TCAR_CLI_NAME}-${MODULE_INIT_NAME}

    # Define function file name.
    local MODULE_INIT_FILE=${MODULE_INIT_DIR}/${MODULE_INIT_NAME}.sh

    # Check function script execution rights.
    cli_checkFiles -x ${MODULE_INIT_FILE}

    # Remove the first argument passed to centos-art.sh command-line
    # in order to build optional arguments inside functionalities. We
    # start counting from second argument (inclusive) on.
    shift 1

    # Define default text editors used by centos-art.sh script.
    if [[ ! "${TCAR_USER_EDITOR}" =~ '/usr/bin/(vim|emacs|nano)' ]];then
        TCAR_USER_EDITOR='/usr/bin/vim'
    fi
    
    # Check text editor execution rights.
    cli_checkFiles -x ${TCAR_USER_EDITOR}

    # Go for function initialization. Keep the cli_exportFunctions
    # function calling after all variables and arguments definitions.
    cli_exportFunctions "${MODULE_INIT_FILE}"

    # Execute function.
    ${MODULE_INIT_NAME} "${@}"

}
