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

declare -xr TCAR_SCRIPT_NAME="tcar"
declare -xr TCAR_SCRIPT_VERSION="0.9"

######################################################################
# Script Internationalization
######################################################################

# Set the script language information using the LC format. This format
# shows both language and country information (e.g., `es_ES').
declare -xr TCAR_SCRIPT_LANG_LC=$(echo ${LANG} | cut -d'.' -f1)

# Set the script language information using the LL format. This format
# shows only the language information (e.g., `es').
declare -xr TCAR_SCRIPT_LANG_LL=$(echo ${TCAR_SCRIPT_LANG_LC} | cut -d'_' -f1)

# Set the script language information using the CC format. This format
# shows only the country information (e.g., `ES').
declare -xr TCAR_SCRIPT_LANG_CC=$(echo ${TCAR_SCRIPT_LANG_LC} | cut -d'_' -f2)

# Set function environments required by GNU gettext system.
. gettext.sh

######################################################################
# Script Configuration Files (redefine global variables)
######################################################################

declare -xr TCAR_SCRIPT_CONFIGS="/etc/tcar/tcar.conf ${HOME}/.tcar.conf"
for TCAR_SCRIPT_CONFIG in ${TCAR_SCRIPT_CONFIGS};do
    if [[ -f ${TCAR_SCRIPT_CONFIG} ]];then
        . ${TCAR_SCRIPT_CONFIG}
    fi
done

######################################################################
# Script Global Functions
######################################################################

# Export script's environment functions.
for SCRIPT_FILE in $(ls ${TCAR_SCRIPT_BASEDIR}/tcar_*.sh);do
    if [[ -x ${SCRIPT_FILE} ]];then
        . ${SCRIPT_FILE}
        export -f $(grep '^function ' ${SCRIPT_FILE} | cut -d' ' -f2)
    else
        echo "${SCRIPT_FILE} `gettext "has not execution rights."`"
        exit 1
    fi
done

######################################################################
# Signals
######################################################################

# Trap signals in order to terminate the script execution correctly
# (e.g., removing all temporal files before leaving).  Trapping the
# exit signal seems to be enough by now, since it is always present as
# part of the script execution flow. Each time the tcar.sh
# script is executed it will inevitably end with an EXIT signal at
# some point of its execution, even if it is interrupted in the middle
# of its execution (e.g., through `Ctrl+C').
trap tcar_terminateScriptExecution 0

######################################################################
# Default Action
######################################################################

if [[ $# -eq 0 ]];then
    tcar_printUsage
fi

######################################################################
# Parse Command-line Arguments
######################################################################

declare -x TCAR_MODULE_NAME=''
declare -x TCAR_MODULE_ARGUMENT=''
declare -x TCAR_SCRIPT_ARGUMENT=''

# Retrieve module's name using the first argument of tcar.sh
# script as reference.
if [[ ! ${1} =~ '^-' ]];then
    TCAR_MODULE_NAME="${1}"; shift 1
else
    TCAR_MODULE_NAME=""
fi

# Initialize tcar.sh script specific options. The way tcar.sh script
# retrieves its options isn't as sophisticated (e.g., it doesn't
# provide valid-option verifications) as it is provided by getopt
# command. I cannot use getopt here because it is used already when
# loading module-specific options. Using more than one invocation of
# getopt in the same script is not possible (e.g., one of the
# invocations may enter in conflict with the other one when different
# option definitions are expected in the command-line.)
while true; do

    # Store non-option arguments passed to tcar.sh script.
    if [[ ! ${1} =~ '^-' ]];then
        TCAR_SCRIPT_ARGUMENT="${1} ${TCAR_SCRIPT_ARGUMENT}"
        shift 1
        if [[ $# -gt 0 ]];then
            continue
        else
            break
        fi
    fi

    case "${1}" in

        --help )

            if [[ -z ${TCAR_MODULE_NAME} ]];then
                tcar_printHelp
            else
                # Store the argument for further processing inside the
                # module environment that will be executed later.
                TCAR_MODULE_ARGUMENT="-g ${1} ${TCAR_MODULE_ARGUMENT}"
                shift 1
            fi
            ;;

        --version )

            if [[ -z ${TCAR_MODULE_NAME} ]];then
                tcar_printVersion
            else
                TCAR_MODULE_ARGUMENT="-g ${1} ${TCAR_MODULE_ARGUMENT}"
                shift 1
            fi
            ;;

        --quiet )

            TCAR_FLAG_QUIET='true'
            shift 1
            ;;

        --yes )

            TCAR_FLAG_YES='true'
            shift 1
            ;;

        --debug )

            TCAR_FLAG_DEBUG='true'
            shift 1
            ;;

        * ) 

            # Store module-specific option arguments. This is, all
            # arguments not considered part of tcar.sh script
            # itself. The module-specific option arguments are passed,
            # later, to getopt for option processing, inside the
            # module-specific environments.
            TCAR_MODULE_ARGUMENT="-g ${1} ${TCAR_MODULE_ARGUMENT}"
            shift 1
            if [[ $# -gt 0 ]];then
                continue
            else
                break
            fi
            ;;
    esac
done

# Initiate module-specific environment.
tcar_setModuleEnvironment -m "${TCAR_MODULE_NAME}" ${TCAR_MODULE_ARGUMENT} ${TCAR_SCRIPT_ARGUMENT}

# At this point everything has been done without errors. So, exit
# tcar.sh script successfully.
exit 0
