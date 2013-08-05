#!/bin/bash
######################################################################
#
#   tcar_setArguments.sh -- This function uses getopt to process
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
#       TCAR_ARGUMENTS
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

function tcar_setArguments {

    local ARGUMENT=''

    # Fill up arguments global variable with current positional
    # parameter  information. To avoid interpretation problems, use
    # single quotes to enclose each argument (TCAR_ARGUMENTS) from
    # command-line individually.
    for ARGUMENT in "${@}"; do

        # Remove any single quote from arguments passed to
        # centos-art.sh script. We will use single quotes for grouping
        # option values so white space can be passed through them.
        ARGUMENT=$(printf %s "${ARGUMENT}" | tr -d "'")

        # Concatenate arguments and enclose them to let getopt to
        # process them when they have spaces inside.
        TCAR_ARGUMENTS="${TCAR_ARGUMENTS} '${ARGUMENT}'"

    done

    # Verify non-option arguments passed to command-line. If there
    # isn't any or dot is provided, redefine the TCAR_ARGUMENTS
    # variable to use the current location the centos-art.sh script
    # was called from.
    if [[ -z "${TCAR_ARGUMENTS}" ]];then
        TCAR_ARGUMENTS=${PWD}
    fi

    # Verify presence of either short or long options in the
    # environment. If they are present apply option validation through
    # getopt.
    if [[ ! -z ${ARGSS} ]] || [[ ! -z ${ARGSL} ]];then

        # Redefine positional parameters using TCAR_ARGUMENTS variable.
        eval set -- "${TCAR_ARGUMENTS}"

        # Process positional parameters using getopt's option validation.
        TCAR_ARGUMENTS=$(getopt -o "${ARGSS}" -l "${ARGSL}" \
            -n "${TCAR_SCRIPT_COMMAND} (${MODULE_NAME})" -- "${@}")

        # Verify getopt's exit status and finish the script execution
        # with an error message, if it failed.
        if [[ $? -ne 0 ]];then
            tcar_printMessage "`gettext "The argument verification failed."`" --as-error-line
        fi

    fi

}
