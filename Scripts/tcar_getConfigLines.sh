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

# Standardize the way configuration lines are retrieved form
# configuration files. As arguments, the configuration file absolute
# path, the configuration section name, and the configuration option
# name must be provided.
function tcar_getConfigLines {

    # Initialize absolute path to configuration file.
    local CONFIGURATION_FILE="${1}"

    # Initialize configuration section name where the variable value
    # we want to to retrieve is set in.
    local CONFIGURATION_SECTION="${2}"

    # Initialize variable name we want to retrieve value from.
    local CONFIGURATION_OPTION="${3}"

    # Verify configuration variable name. When no variable name is
    # provided print all configuration lines that can be considered as
    # well-formed paths. Be sure configuration variable name starts
    # just at the beginning of the line.
    if [[ ! ${CONFIGURATION_OPTION} =~ '^[[:alnum:]_./-]+$' ]];then
        CONFIGURATION_OPTION='[[:alnum:]_./-]+[[:space:]]*='
    fi

    # Retrieve configuration lines from configuration file. Don't sort
    # the value of this value so as to preserve the order given in the
    # configuration file. This is important because configuration
    # files are being used for setting render-from priorities.
    local CONFIGURATION_LINES=$(cat ${CONFIGURATION_FILE} \
        | egrep -v '^#' \
        | egrep -v '^[[:space:]]*$' \
        | sed -r -n "/^\[${CONFIGURATION_SECTION}\][[:space:]]*$/,/^\[/p" \
        | egrep -v '^\[' \
        | egrep "^${CONFIGURATION_OPTION}")

    # Output value related to variable name.
    echo "${CONFIGURATION_LINES}"

}
