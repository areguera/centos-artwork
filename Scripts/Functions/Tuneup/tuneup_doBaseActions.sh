#!/bin/bash
#
# tuneup_doBaseActions.sh -- This function builds one list of files to
# process for each file extension supported and applies maintainance
# tasks file by file for each one of them.
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

function tuneup_doBaseActions {

    local TUNEUP_CONFIG_DIR=''
    local TUNEUP_BACKEND_DIR=''
    local TUNEUP_BACKEND_INIT=''
    local TUNEUP_EXTENSION=''
    local FILE=''
    local FILES=''

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Loop through list of supported file extensions. 
    for TUNEUP_EXTENSION in ${TUNEUP_EXTENSIONS};do

        # Define backend name based on supported file extensions.
        TUNEUP_BACKEND="${TUNEUP_EXTENSION}"

        # Define absolute path to directory where backend-specific
        # functionalities are stored in.
        TUNEUP_BACKEND_DIR="${TUNEUP_BASEDIR}/$(cli_getRepoName \
            ${TUNEUP_BACKEND} -d)"

        # Define absolute path to backend initialization script.
        TUNEUP_BACKEND_INIT="${TUNEUP_BACKEND_DIR}/$(cli_getRepoName ${TUNEUP_BACKEND} -f)"

        # Verify absolute path to backend initialization script.  When
        # a file extension is provided, but no backend initialization
        # script exists for it, continue with the next file extension
        # in the list.
        if [[ ! -f ${TUNEUP_BACKEND_INIT} ]];then
            continue
        fi

        # Define absolute path to directory where backend-specific
        # configurations are retrived from.
        TUNEUP_CONFIG_DIR="${TUNEUP_BACKEND_DIR}/Config"

        # Build list of files to process using action value as
        # reference.
        FILES=$(cli_getFilesList ${ACTIONVAL} --pattern="${FLAG_FILTER}\.${TUNEUP_EXTENSION}")

        # Verify list of files to process. Assuming no file is found,
        # evaluate the next supported file extension.
        if [[ $FILES == '' ]];then
            continue
        fi

        # Export backend-specific functionalities up to the
        # execution environment.
        cli_exportFunctions "${TUNEUP_BASEDIR}/$(cli_getRepoName \
            ${TUNEUP_BACKEND} -d)" "${TUNEUP_BACKEND}"

        # Execute backend-specific maintainance tasks.
        for FILE in $FILES;do
            cli_printMessage "$FILE" --as-tuningup-line
            ${TUNEUP_BACKEND}
        done

        # Unset backend-specific functionalities from execution
        # environment.  This is required to prevent end up with more
        # than one backend-specifc function initialization, in those
        # cases when different template files are rendered in just one
        # execution of `centos-art.sh' script.
        cli_unsetFunctions "${TUNEUP_BASEDIR}/$(cli_getRepoName \
            ${TUNEUP_BACKEND} -d)" "${TUNEUP_BACKEND}"

    done

}
