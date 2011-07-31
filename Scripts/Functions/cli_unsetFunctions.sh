#!/bin/bash
#
# cli_unsetFunctions.sh -- This function unsets funtionalities from
# `centos-art.sh' script execution evironment.
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

function cli_unsetFunctions {

    # Define source location where function files are placed in.
    local LOCATION=$1

    # Define suffix used to retrive function files.
    local SUFFIX=$2

    # Verify suffix value used to retrive function files. Assuming no
    # suffix value is passed as second argument to this function, use
    # the function name value (CLI_FUNCNAME) as default value.
    if [[ $SUFFIX == '' ]];then
        SUFFIX=$CLI_FUNCNAME
    fi

    # Define list of backend-specific functionalities. This is the
    # list of function definitions previously exported by
    # `cli_exportFunctions'.  Be sure to limit the list to function
    # names that start with the suffix specified only.
    local FUNCDEF=''
    local FUNCDEFS=$(declare -F | gawk '{ print $3 }' | egrep "^${SUFFIX}")

    # Unset function names from current execution environment.
    for FUNCDEF in $FUNCDEFS;do
        unset -f $FUNCDEF
    done

}
