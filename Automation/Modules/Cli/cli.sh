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

    # Initialize command-line interface common functions.
    for MODULE_SCRIPT in $(ls ${TCAR_SCRIPT_INIT_DIR}/Scripts/*.sh);do
        if [[ -x ${MODULE_SCRIPT} ]];then
            . ${MODULE_SCRIPT}
            export -f $(grep '^function ' ${MODULE_SCRIPT} | cut -d' ' -f2)
        else
            echo "${MODULE_SCRIPT} `gettext "has not execution rights."`"
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

    # Initialize command-line interface default configuration values.
    if [[ -f ${TCAR_SCRIPT_INIT_DIR}/${TCAR_SCRIPT_INIT}.conf ]];then
        . ${TCAR_SCRIPT_INIT_DIR}/${TCAR_SCRIPT_INIT}.conf
    fi

    # Verify first argument passed to centos-art.sh script.
    if [[ ${1} == "${TCAR_SCRIPT_INIT}" ]];then
        cli_getOptions "${@}"
    else
        cli_initModule "${@}"
    fi

}
