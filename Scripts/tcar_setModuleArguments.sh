#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Use getopt to process arguments passed to tcar.sh script.  This
# function works with the following three environment variables:
#
#   ARGSS
#       Stores getopt short arguments definition.
#
#   ARGSL
#       Stores getopt long arguments definition.
#
#   TCAR_MODULE_ARGUMENT
#       Stores arguments passed to functions or command-line interface
#       depending the context it is defined.
#
# These three variables are not defined in this function but the
# function environment you want to provide option parsing for, through
# getopt command. Using local definition for these three variables let
# you to nest option parsing inside different function-environment
# levels.
function tcar_setModuleArguments {

    # Verify presence of either short or long options in the
    # environment. There is not anything to do here if they both are
    # empty.
    if [[ -z ${ARGSS} && -z ${ARGSL} ]];then
        return
    fi

    # Redefine positional parameters using TCAR_MODULE_ARGUMENT variable.
    eval set -- "${TCAR_MODULE_ARGUMENT}"

    # Process positional parameters using getopt's option validation.
    TCAR_MODULE_ARGUMENT=$(getopt -o "${ARGSS}" -l "${ARGSL}" \
        -n "${TCAR_SCRIPT_NAME} (${TCAR_MODULE_NAME})" -- "${@}")

    # Verify getopt's exit status and finish the script execution with
    # an error message, if it failed.
    if [[ $? -ne 0 ]];then
        tcar_printMessage "`gettext "The argument verification failed."`" --as-error-line
    fi

}
