#!/bin/bash
########################################################################
#
#   centos-art.sh -- The CentOS artwork repository automation tool.
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
########################################################################

# Verify absolute path to the working directory. This information is
# critical for centos-art.sh script to work.
if [[ ! ${TCAR_BASEDIR} ]] || [[ -z ${TCAR_BASEDIR} ]] \
    || [[ ! -d ${TCAR_BASEDIR} ]];then
    echo -n "Enter repository's absolute path: "
    read TCAR_BASEDIR
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
    . ${TCAR_SCRIPT_BASEDIR}/centos-art.conf
else
    exit 1
fi

# Initialize user-specific configuration values.
if [[ -f ${TCAR_USER_CONFIG} ]];then
    . ${TCAR_USER_CONFIG}
fi

case ${1} in

    --help )
        # Print script help.
        ${TCAR_MANUAL_READER} ${TCAR_SCRIPT_NAME}
        ;;

    --version )
        # Print script version.
        echo "`eval_gettext "Running $TCAR_SCRIPT_NAME (v$TCAR_SCRIPT_VERSION)."`"
        ;;

    * )
        # Initialize script command-line interface.
        if [[ -x ${TCAR_SCRIPT_INIT_FILE} ]];then
            . ${TCAR_SCRIPT_INIT_FILE} \
            && export -f ${TCAR_SCRIPT_INIT} \
            && ${TCAR_SCRIPT_INIT} "$@"
        else
            echo "${TCAR_SCRIPT_INIT_FILE} `gettext "has not execution rights."`"
        fi
        ;;
esac

exit 0
