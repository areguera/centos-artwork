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

    local CLI_FUNCTION_NAME=''
    local CLI_FUNCTION_DIR=''
    local CLI_FUNCTION_FILE=''
    local CLI_FUNCTION=''
    local CLI_FUNCTIONS=$(ls ${TCAR_CLI_INIT_DIR}/${TCAR_CLI_INIT_FUNCTION}_*.sh)

    # Initialize list of common functionalities to load.
    for CLI_FUNCTION in ${CLI_FUNCTIONS};do
        if [[ -x ${CLI_FUNCTION} ]];then
            . ${CLI_FUNCTION}
            export -f $(grep '^function ' ${CLI_FUNCTION} | cut -d' ' -f2)
        else
            echo "${CLI_FUNCTION} `gettext "has not execution rights."`"
            exit
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

    # Initialize variable holding arguments passed to centos-art.sh
    # command-line interface.
    local CLI_FUNCTION_ARGUMENTS=''

    # Redefine arguments using current positional parameters. 
    cli_setArguments "${@}"

    # Redefine positional parameters using arguments variable.
    eval set -- "${CLI_FUNCTION_ARGUMENTS}"

    # Check function name. The function name is critical for
    # centos-art.sh script to do something coherent. If it is not
    # provided, execute the help functionality and end script
    # execution.
    if [[ ! "${1}" ]] || [[ ! "${1}" =~ '^[[:alpha:]]' ]];then
        cli_runFnEnvironment help --read --format="texinfo" tcar-fs:::
        exit
    fi

    # Define function name (CLI_FUNCTION_NAME) using the first argument in
    # the command-line.
    CLI_FUNCTION_NAME=$(cli_getRepoName ${1} -f | cut -d '-' -f1)

    # Define function directory.
    CLI_FUNCTION_DIR=$(cli_getRepoName ${CLI_FUNCTION_NAME} -d)

    # Define function file name.
    CLI_FUNCTION_FILE=${TCAR_CLI_MODSDIR}/${CLI_FUNCTION_DIR}/${CLI_FUNCTION_NAME}.sh

    # Check function script execution rights.
    cli_checkFiles -x ${CLI_FUNCTION_FILE}

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
    cli_exportFunctions "${CLI_FUNCTION_DIR}/${CLI_FUNCTION_NAME}"

    # Execute function.
    ${CLI_FUNCTION_NAME} "${@}"

}
