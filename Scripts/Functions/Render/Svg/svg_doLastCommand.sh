#!/bin/bash
#
# svg_doLastCommand.sh -- This function standardizes the way
# last-rendition commands are applied to base-rendition and
# post-rendition outputs.
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

function svg_doLastCommand {

    # Define the file extensions. This value is a regular expression
    # pattern which must match the file extensions that last-rendition
    # actions will be applied to.
    local EXTENSION=$(${CLI_FUNCNAME}_getConfigOption "$ACTION" '2')

    # Define the command string that will be evaluated as
    # last-rendition action. Only commands that perform in-place
    # modifications can be passed here.
    local COMMAND=$(${CLI_FUNCNAME}_getConfigOption "$ACTION" '3-')

    # Define the list of files to process. This value contain all the
    # files in the output directory which extension match the
    # extension pattern previously defined.
    local FILE=''
    local FILES=$(cli_getFilesList $OUTPUT --pattern=".+\.${EXTENSION}")

    for FILE in $FILES;do

        # Identify file before processing it. Only formats recognized
        # by ImageMagick are supported. In case the file isn't
        # supported by ImageMagick, continue with the next file in the
        # list.
        identify -quiet ${FILE} > /dev/null
        if [[ $? -ne 0 ]];then
            continue
        fi

        # Print action message.
        cli_printMessage "${FILE}" --as-updating-line

        # Execute mogrify action on all files inside the same
        # directory structure.
        eval ${COMMAND} ${FILE}

        # Be sure the command was executed correctly. Otherwise stop
        # script execution.
        if [[ $? -ne 0 ]];then
            exit
        fi

    done

}
