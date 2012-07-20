#!/bin/bash
#
# cli_getConfigValue.sh -- This function retrives configuration values
# from configuration files. As arguments, the configuration file
# absolute path, the configuration section name, and the configuration
# variable name must be provided.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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
    
function cli_getConfigValue {

    # Initialize absolute path to configuration file.
    local CONFIG_ABSPATH="$1"

    # Initialize configuration section name where the variable value
    # we want to to retrive is set in.
    local CONFIG_SECTION="$2"

    # Initialize variable name we want to retrive value from.
    local CONFIG_VARNAME="$3"

    # Retrive configuration lines from configuration file.
    local CONFIG_LINES=$(cli_getConfigLines \
        "$CONFIG_ABSPATH" "$CONFIG_SECTION" "$CONFIG_VARNAME")

    # Parse configuration lines to retrive the values of variable
    # names.
    local CONFIG_VARVALUE=$(echo $CONFIG_LINES \
        | cut -d'=' -f2- \
        | sed -r 's/^"(.*)"$/\1/')

    # Output values related to variable name.
    echo "$CONFIG_VARVALUE"

}
