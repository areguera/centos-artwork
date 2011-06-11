#!/bin/bash
#
# tuneup_doBaseActions.sh -- This function builds the list of files to
# process and performs maintainance tasks, file by file.
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

    # Define file extensions we'll look files for. This is, the
    # extension of files we want to perform maintainance tasks for.
    local EXTENSION='(svg|xhtml|sh)'

    # Build list of files to process using action value as reference.
    local FILE=''
    local FILES=$(cli_getFilesList ${ACTIONVAL} --pattern="${FLAG_FILTER}\.${EXTENSION}")

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Process list of files and perform maintainance tasks
    # accordingly.
    for FILE in $FILES;do

        # Print action message.
        cli_printMessage "$FILE" --as-tuningup-line

        # Redefine name of tuneup backend based on the file extension
        # of file being processed.
        if [[ $FILE =~ '\.svg$' ]];then
            TUNEUP_BACKEND='svg'
        elif [[ $FILE =~ '\.xhtml$' ]];then
            TUNEUP_BACKEND='xhtml'
        elif [[ $FILE =~ '\.sh$' ]];then
            TUNEUP_BACKEND='shell'
        fi

        # Initialize backend-specific functionalities.
        cli_exportFunctions "${TUNEUP_BACKEND_DIR}/$(cli_getRepoName \
            ${TUNEUP_BACKEND} -d)" "${TUNEUP_BACKEND}"

        # Perform backend base-rendition.
        ${TUNEUP_BACKEND}

        # Unset backend-specific functionalities from environment.
        # This is required to prevent end up with more than one
        # backend-specifc function initialization, in those cases when
        # different template files are rendered in just one execution
        # of `centos-art.sh' script.
        cli_unsetFunctions "${TUNEUP_BACKEND_DIR}/$(cli_getRepoName \
            ${TUNEUP_BACKEND} -d)" "${TUNEUP_BACKEND}"

    done

}
