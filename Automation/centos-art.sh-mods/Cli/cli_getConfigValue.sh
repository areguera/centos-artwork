#!/bin/bash
######################################################################
#
#   cli_getConfigValue.sh -- This function standardizes the way
#   configuration values are retrieved from configuration files. As
#   arguments, the configuration file absolute path, the configuration
#   section name, and the configuration option name must be provided.
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

function cli_getConfigValue {

    # Initialize absolute path to configuration file.
    local CONFIGURATION_FILE="${1}"

    # Initialize configuration section name where the variable value
    # we want to to retrieve is set in.
    local CONFIGURATION_SECTION="${2}"

    # Initialize variable name we want to retrieve value from.
    local CONFIGURATION_OPTION="${3}"

    # Retrieve configuration lines from configuration file.
    local CONFIGURATION_LINES=$(cli_getConfigLines \
        "${CONFIGURATION_FILE}" "${CONFIGURATION_SECTION}" "${CONFIGURATION_OPTION}")

    # Parse configuration lines to retrieve the values of variable
    # names.
    local CONFIGURATION_VALUE=$(echo ${CONFIGURATION_LINES} \
        | cut -d= -f2- \
        | sed -r -e 's/"//g' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )

    # Output values related to variable name.
    echo "${CONFIGURATION_VALUE}"

}
