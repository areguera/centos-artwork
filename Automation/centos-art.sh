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
if [[ ! ${TCAR_REPO_WRKDIR} ]] || [[ -z ${TCAR_REPO_WRKDIR} ]] \
    || [[ ! -d ${TCAR_REPO_WRKDIR} ]];then
    if [[ ! -d $(dirname ${0}) ]] || [[ $(dirname ${0}) =~ "^${HOME}/bin" ]];then
        printf "Enter repository's absolute path:"
        read TCAR_REPO_WRKDIR
    fi
fi

# Define automation scripts base directory. We need to define it here
# in order to reach the configuration file. All other environment
# variable definitions must be declared inside the configuration file.
declare -xr TCAR_CLI_BASEDIR=${TCAR_REPO_WRKDIR}/Automation

# Initialize default configuration values.
. ${TCAR_CLI_BASEDIR}/centos-art.conf

# Initialize user-specific configuration values.
if [[ -f ${TCAR_USER_CONFIG} ]];then
    . ${TCAR_USER_CONFIG}
fi

# Initialize the centos-art.sh script command-line interface.
if [[ -x ${TCAR_CLI_INIT_FILE} ]];then
    . ${TCAR_CLI_INIT_FILE} \
        && export -f ${TCAR_CLI_INIT} \
        && ${TCAR_CLI_INIT} "$@"
else
    echo "${TCAR_CLI_INIT_FILE} has not execution rights."
fi
