#!/bin/bash
######################################################################
#
#   cli_setArguments.sh -- This function uses getopt to process
#   arguments passed to centos-art.sh script.
#
#   This function works with the following three variables:
#
#       ARGSS
#           Stores getopt short arguments definition.
#
#       ARGSL
#           Stores getopt long arguments definition.  
#
#       TCAR_MODULE_ARGUMENTS
#           Stores arguments passed to functions or command-line
#           interface depending the context it is defined.
#
#   These three variables are not defined in this function but the
#   function environment you want to provide option parsing for,
#   through getopt command. Using local definition for these three
#   variables let you to nest option parsing inside different
#   function-environment levels.
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
#
######################################################################

function cli_setArguments {

    # Verify existence of arguments that will be processed. If there
    # is none, return to caller.
    if [[ -z "${@}" ]];then
        return
    fi

    local ARGUMENT=''

    # Fill up arguments global variable with current positional
    # parameter  information. To avoid interpretation problems, use
    # single quotes to enclose each argument (TCAR_MODULE_ARGUMENTS) from
    # command-line individually.
    for ARGUMENT in "${@}"; do

        # Remove any single quote from arguments passed to
        # centos-art.sh script. We will use single quotes for grouping
        # option values so white space can be passed through them.
        ARGUMENT=$(echo "${ARGUMENT}" | tr -d "'")

        # Concatenate arguments and enclose them to let getopt to
        # process them when they have spaces inside.
        TCAR_MODULE_ARGUMENTS="${TCAR_MODULE_ARGUMENTS} '${ARGUMENT}'"

    done

    # Verify non-option arguments passed to command-line. If there
    # isn't any or dot is provided, redefine the TCAR_MODULE_ARGUMENTS variable to
    # use the current location the centos-art.sh script was called
    # from.
    if [[ -z "${TCAR_MODULE_ARGUMENTS}" ]];then 
        TCAR_MODULE_ARGUMENTS=${PWD}
    fi

    # Redefine positional parameters using TCAR_MODULE_ARGUMENTS variable.
    if [[ ! -z ${ARGSS} ]] || [[ ! -z ${ARGSL} ]];then
        eval set -- "${TCAR_MODULE_ARGUMENTS}"
        TCAR_MODULE_ARGUMENTS=$(getopt -o "${ARGSS}" -l "${ARGSL}" \
            -n "${TCAR_CLI_COMMAND} ($(cli_printCaller 2))" -- "${@}")
        if [[ $? -ne 0 ]];then
            cli_printMessage "`gettext "The argument verification failed."`" --as-error-line
        fi
    fi

}
