#!/bin/bash
#
# cli_getFunctions.sh -- This function loads funtionalities supported by
# centos-art.sh script.
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

function cli_getFunctions {

    # Define source location where function files are placed in.
    local LOCATION=$1

    # Define pattern used to retrive function names from function
    # files.
    local PATTERN="^function[[:space:]]+${FUNCNAM}[[:alnum:]_]*[[:space:]]+{$"

    # Define list of files.
    local FUNCFILES=$(cli_getFilesList "${LOCATION}" "${FUNCNAM}.*\.sh")

    # Process list of files.
    for FILE in $FUNCFILES;do

        # Verify file execution rights.
        cli_checkFiles $FILE --execution

        # Initialize file.
        . $FILE

        # Export function names inside the file to current shell
        # script environment.
        export -f $(egrep "${PATTERN}" ${FILE} | cut -d' ' -f2)

    done

    # Execute function.
    eval $FUNCNAM

}
