#!/bin/bash
######################################################################
#
#   centos-art.sh -- The CentOS artwork repository automation tool.
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

# Verify absolute path to the working directory. This information is
# critical for centos-art.sh script to work.
if [[ ! ${TCAR_BASEDIR} ]] || [[ -z ${TCAR_BASEDIR} ]] \
    || [[ ! -d ${TCAR_BASEDIR} ]];then
    printf "Enter repository's absolute path: "
    read TCAR_BASEDIR
    declare -xr TCAR_BASEDIR=$(printf ${TCAR_BASEDIR} \
        | sed -r -e 's,/+,/,g' -e 's,/+$,,')
fi

# Define automation scripts base directory. We need to define it here
# in order to reach the configuration file. All other environment
# variable definitions must be declared inside the configuration file.
if [[ -d ${TCAR_BASEDIR} ]];then
    declare -xr TCAR_SCRIPT_BASEDIR=${TCAR_BASEDIR}/Automation
else
    exit 1
fi

# Initialize default configuration values.
if [[ -d ${TCAR_SCRIPT_BASEDIR} ]];then
    . ${TCAR_SCRIPT_BASEDIR}/centos-art.conf.sh
else
    exit 1
fi

# Initialize user-specific configuration values. Users can use this
# file to customize the way centos-art.sh script behaves.
if [[ -f ${TCAR_USER_CONFIG} ]];then
    . ${TCAR_USER_CONFIG}
fi

# Export script's environment functions.
for SCRIPT_FILE in $(ls ${TCAR_SCRIPT_BASEDIR}/Scripts/*.sh);do
    if [[ -x ${SCRIPT_FILE} ]];then
        . ${SCRIPT_FILE}
        export -f $(grep '^function ' ${SCRIPT_FILE} | cut -d' ' -f2)
    else
        echo "${SCRIPT_FILE} `gettext "has not execution rights."`"
        exit 1
    fi
done

# Trap signals in order to terminate the script execution correctly
# (e.g., removing all temporal files before leaving).  Trapping the
# exit signal seems to be enough by now, since it is always present as
# part of the script execution flow. Each time the centos-art.sh
# script is executed it will inevitably end with an EXIT signal at
# some point of its execution, even if it is interrupted in the middle
# of its execution (e.g., through `Ctrl+C').
trap tcar_terminateScriptExecution 0

# Retrieve module's name using the first argument of centos-art.sh
# script as reference.
if [[ ! ${1} =~ '^-' ]];then
    TCAR_MODULE_NAME="${1}"; shift 1
else
    TCAR_MODULE_NAME=""
fi

# Initialize centos-art.sh script specific options. The way
# centos-art.sh script retrieve its options isn't as sophisticated
# (e.g., it doesn't provide valid-option verifications) as it is
# provided by getopt command. We cannot use getopt here because it is
# already used when loading module-specific options. Using more than
# one invocation of getopt in the same script is not possible (e.g.,
# one of the invocations may enter in conflict with the other one when
# different option definitions are expected in the command-line.)
while true; do

    # Store non-option arguments passed to centos-art.sh script.
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

    -h | --he | --hel | --help )
        # Print centos-art.sh script's help.
        if [[ -z ${TCAR_MODULE_NAME} ]];then
            ${TCAR_MANUAL_READER} ${TCAR_SCRIPT_NAME}
            exit 0
        else
            TCAR_MODULE_ARGUMENT="-g ${1} ${TCAR_MODULE_ARGUMENT}"
            shift 1
        fi
        ;;

    -v | --ve | --ver | --vers | --versi | --versio | --version )
        # Print centos-art.sh script's version.
        if [[ -z ${TCAR_MODULE_NAME} ]];then
            tcar_printVersion
            exit 0
        else
            TCAR_MODULE_ARGUMENT="-g ${1} ${TCAR_MODULE_ARGUMENT}"
            shift 1
        fi
        ;;

    -q | --qu | --qui | --quie | --quiet )
        TCAR_FLAG_QUIET='true'
        shift 1
        ;;

    -y | --ye | --yes )
        TCAR_FLAG_YES='true'
        shift 1
        ;;

    -d | --de | --deb | --debu | --debug )
        TCAR_FLAG_DEBUG='true'
        shift 1
        ;;

    * ) 
        # Store module-specific option arguments. This is, all
        # arguments not considered part of centos-art.sh script
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
# centos-art.sh script successfully.
exit 0
