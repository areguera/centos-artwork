#!/bin/bash
#
# cli_exportFunctions.sh -- This function exports funtionalities to
# `centos-art.sh' script execution evironment.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function cli_exportFunctions {

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

    # Define pattern used to retrive function names from function
    # files.
    local PATTERN="^function[[:space:]]+${SUFFIX}[[:alnum:]_]*[[:space:]]+{$"

    # Define list of files.
    local FUNCFILE=''
    local FUNCFILES=$(cli_getFilesList ${LOCATION} --pattern="${SUFFIX}.*\.sh" --maxdepth="1")

    # Verify list of files. If no function file exists for the
    # location specified stop the script execution. Otherwise the
    # script will surely try to execute a function that haven't been
    # exported yet and report an error about it.
    if [[ $FUNCFILES == '' ]];then
        cli_printMessage "`gettext "No function file was found for this action."`" --as-error-line
    fi

    # Process list of files.
    for FUNCFILE in $FUNCFILES;do

        # Verify file execution rights.
        cli_checkFiles $FUNCFILE --execution

        # Initialize file.
        . $FUNCFILE

        # Export function names inside the file to current shell
        # script environment.
        export -f $(egrep "${PATTERN}" ${FUNCFILE} | gawk '{ print $2 }')

    done

}
