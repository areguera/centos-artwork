#!/bin/bash
#
# cli_exportFunctions.sh -- This function standardizes the way
# specific functionalities are exported to centos-art.sh script
# environment.
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

function cli_exportFunctions {

    # Retrieve export identifier for the function we want to export.
    local EXPORTID="$1"

    # Verify the export identification existence. This argument must
    # be passed as first argument and match a relative path format.
    if [[ ! $EXPORTID ]] || [[ $EXPORTID == '' ]];then
        cli_printMessage "`gettext "The export id must be passed as first argument."`" --as-error-line
    elif [[ ! $EXPORTID =~ '^[A-Z][[:alpha:]]+(/[[:alpha:]_]+)+$' ]];then
        cli_printMessage "`gettext "The export id doesn't match its pattern."`" --as-error-line
    fi

    # Define the source location where function files are placed in.
    local LOCATION=${CLI_BASEDIR}/Functions/$(dirname ${EXPORTID})

    # Define suffix used to retrieve function files.
    local SUFFIX=$(basename "$EXPORTID")

    # Verify the suffix value used to retrieve function files.
    # Assuming no suffix value is passed as second argument to this
    # function, use the function name value (CLI_FUNCNAME) as default
    # value.
    if [[ $SUFFIX == '' ]];then
        SUFFIX="${CLI_FUNCNAME}"
    fi

    # Redefine suffix to match all related function files inside the
    # related function directory.
    SUFFIX=${SUFFIX}'[[:alpha:]_]*'

    # Define the pattern used to retrieve function names from function
    # files.
    local PATTERN="^function[[:space:]]+${SUFFIX}[[:space:]]+{[[:space:]]*$"

    # Define the list of files.
    local FUNCFILE=''
    local FUNCFILES=$(cli_getFilesList ${LOCATION} --pattern="${LOCATION}/${SUFFIX}\.sh$" \
        --maxdepth='1' --mindepth='1' --type='f')

    # Verify the list of files. If no function file exists for the
    # location specified stop the script execution. Otherwise the
    # script will surely try to execute a function that haven't been
    # exported yet and report an error about it.
    if [[ $FUNCFILES == '' ]];then
        cli_printMessage "${FUNCNAME}: `gettext "No function file was found."`" --as-error-line
    fi

    # Process the list of files.
    for FUNCFILE in $FUNCFILES;do

        # Verify the execution rights for function file.
        cli_checkFiles -x ${FUNCFILE}

        # Verify that function files have not been already exported.
        # If they have been already exported don't export them again.
        # Instead, continue with the next function file in the list.
        declare -F | gawk '{ print $3 }' | egrep "^${FUNCFILE}$" > /dev/null
        if [[ $? -eq 0 ]];then
            continue
        fi

        # Initialize the function file.
        . ${FUNCFILE}

        # Export the function names inside the file to current shell
        # script environment.
        export -f $(egrep "${PATTERN}" ${FUNCFILE} | gawk '{ print $2 }')

    done

}
