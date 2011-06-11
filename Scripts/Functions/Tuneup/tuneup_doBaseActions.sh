#!/bin/bash
#
# tuneup_doBaseActions.sh -- This function builds one list of files to
# process for each file extension supported and applies maintainance
# tasks file by file for each one of them.
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

function tuneup_doBaseActions {

    local TUNEUP_EXTENSION=''
    local FILE=''
    local FILES=''

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    for TUNEUP_EXTENSION in ${TUNEUP_EXTENSIONS};do

        # Redefine name of tuneup backend based on the file extension
        # of file being processed.
        if [[ $TUNEUP_EXTENSION == 'svg' ]];then
            TUNEUP_BACKEND='svg'
        elif [[ $TUNEUP_EXTENSION == 'xhtml' ]];then
            TUNEUP_BACKEND='xhtml'
        elif [[ $TUNEUP_EXTENSION == 'sh' ]];then
            TUNEUP_BACKEND='shell'
        else
           cli_printMessage "`gettext "No file to tune up found."`" --as-error-line 
        fi

        # Build list of files to process using action value as reference.
        FILES=$(cli_getFilesList ${ACTIONVAL} --pattern="${FLAG_FILTER}\.${TUNEUP_EXTENSION}")

        # Verify list of files to process. Assuming no file is found,
        # evaluate the next supported file extension.
        if [[ $FILES == '' ]];then
            continue
        fi

        # Initialize backend-specific functionalities.
        cli_exportFunctions "${TUNEUP_BACKEND_DIR}/$(cli_getRepoName \
            ${TUNEUP_BACKEND} -d)" "${TUNEUP_BACKEND}"

        # Apply backend-specific maintainance tasks.
        for FILE in $FILES;do
            cli_printMessage "$FILE" --as-tuningup-line
            ${TUNEUP_BACKEND}
        done

        # Unset backend-specific functionalities from environment.
        # This is required to prevent end up with more than one
        # backend-specifc function initialization, in those cases when
        # different template files are rendered in just one execution
        # of `centos-art.sh' script.
        cli_unsetFunctions "${TUNEUP_BACKEND_DIR}/$(cli_getRepoName \
            ${TUNEUP_BACKEND} -d)" "${TUNEUP_BACKEND}"

    done

}
