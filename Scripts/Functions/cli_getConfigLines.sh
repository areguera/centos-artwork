#!/bin/bash
#
# cli_getConfigLines.sh -- This function retrives configuration lines
# form configuration files. As arguments, the configuration file
# absolute path, the configuration section name, and the configuration
# variable name must be provided.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

    # Verify absolute path to configuration file.
    cli_checkFiles ${CONFIG_ABSPATH}

    # Initialize configuration section name where the variable value
    # we want to to retrive is set in.
    local CONFIG_SECTION="$2"

    # Verify configuration section name. Be sure it is one of the
    # supported values.
    if [[ ! $CONFIG_SECTION =~ '^(main|templates)$' ]];then
        CONFIG_SECTION='main'
    fi

    # Initialize variable name we want to retrive value from.
    local CONFIG_VARNAME="$3"

    # Verify configuration variable name. When no variable name is
    # provided print all configuration lines. Be sure configuration
    # variable name starts just at the begining of the line.
    if [[ ! $CONFIG_VARNAME =~ '^[[:alnum:]_/-\.]+$' ]];then
        CONFIG_VARNAME='^[[:alnum:]_/-\.]+='
    else
        CONFIG_VARNAME="^${CONFIG_VARNAME}"
    fi

    # Retrive configuration lines from configuration file.
    local CONFIG_LINES=$(cat ${MANUAL_CONFIG_FILE} \
        | egrep -v '^#' \
        | egrep -v '^[[:space:]]*$' \
        | sed -r 's![[:space:]]*!!g' \
        | sed -r -n "/^\[${CONFIG_SECTION}\]$/,/^\[/p" \
        | egrep -v '^\[' | sort | uniq \
        | egrep "${CONFIG_VARNAME}")

    # Output value related to variable name.
    echo "$CONFIG_LINES"

}
