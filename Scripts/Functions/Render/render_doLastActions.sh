#!/bin/bash
#
# render_doLastActions.sh -- This function provides last-rendition
# actions to files produced as result of base-rendition and
# post-rendition output. Actions take place through any command you
# specify in the `--last-rendition' option  (e.g., the `mogrify'
# command from ImageMagick tool set.
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

function render_doLastActions {

    # Verify position of file being produced in the list of files been
    # currently processed.
    if [[ $THIS_FILE_DIR == $NEXT_FILE_DIR ]];then
        return
    fi

    # Define file extensions the last-rendition action will be applied
    # to.
    local EXTENSION=$(render_getConfigOption "$ACTION" '2')

    # Define the command string that will be evaluated as last-rendition.
    local COMMAND=$(render_getConfigOption "$ACTION" '3-')

    # Define list of files the last-rendition action will be applied
    # to.
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
