#!/bin/bash
######################################################################
#
#   tcar_getConfigValue.sh -- This function standardizes the way
#   configuration values are retrieved from configuration files. As
#   arguments, the configuration file absolute path, the configuration
#   section name, and the configuration option name must be provided.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
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

function tcar_getConfigValue {

    local CONFIGURATION_FILE="${1}"

    local CONFIGURATION_SECTION="${2}"

    local CONFIGURATION_OPTION="${3}"

    local CONFIGURATION_LINES=$(tcar_getConfigLines \
        "${CONFIGURATION_FILE}" "${CONFIGURATION_SECTION}" "${CONFIGURATION_OPTION}")

    for CONFIGURATION_LINE in "${CONFIGURATION_LINES}";do

        local CONFIGURATION_VALUE=$(echo "${CONFIGURATION_LINE}" \
            | cut -d= -f2- | sed -r -e 's/"//g' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

        eval echo ${CONFIGURATION_VALUE}

    done


}
