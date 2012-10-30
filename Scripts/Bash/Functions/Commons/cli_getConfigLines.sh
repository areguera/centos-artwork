#!/bin/bash
#
# cli_getConfigLines.sh -- This function standardizes the way
# configuration lines are retrieved form configuration files. As
# arguments, the configuration file absolute path, the configuration
# section name, and the configuration option name must be provided.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------
    
function cli_getConfigLines {

    # Initialize absolute path to configuration file.
    local CONFIG_ABSPATH="$1"

    # Verify that configuration file does exist.
    cli_checkFiles -e ${CONFIG_ABSPATH}

    # Initialize configuration section name where the variable value
    # we want to to retrieve is set in.
    local CONFIG_SECTION="$2"

    # Be sure the configuration section name has the correct format.
    if [[ ! $CONFIG_SECTION =~ '^[[:alnum:]._-]+$' ]];then
        cli_printMessage "`gettext "The configuration section provided is incorrect."`" --as-error-line
    fi

    # Initialize variable name we want to retrieve value from.
    local CONFIG_OPTION="$3"

    # Verify configuration variable name. When no variable name is
    # provided print all configuration lines that can be considered as
    # well-formed paths. Be sure configuration variable name starts
    # just at the beginning of the line.
    if [[ ! $CONFIG_OPTION =~ '^[[:alnum:]_./-]+$' ]];then
        CONFIG_OPTION='[[:alnum:]_./-]+='
    fi

    # Retrieve configuration lines from configuration file.
    local CONFIG_LINES=$(cat ${CONFIG_ABSPATH} \
        | egrep -v '^#' \
        | egrep -v '^[[:space:]]*$' \
        | sed -r -n "/^\[${CONFIG_SECTION}\][[:space:]]*$/,/^\[/p" \
        | egrep -v '^\[' | sort | uniq \
        | egrep "^${CONFIG_OPTION}")

    # Output value related to variable name.
    echo "$CONFIG_LINES"

}
