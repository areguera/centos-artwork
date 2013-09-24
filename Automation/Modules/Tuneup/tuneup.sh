#!/bin/bash
######################################################################
#
#   tuneup.sh -- This module standardizes source code file
#   maintainance inside the repository.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Artwork SIG
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
######################################################################

function tuneup {

    # Define file extensions tuneup module will look for processing.
    local FILE_EXTENSION_REGEX='\.(svgz|svg|shtml|xhtml|html|sh)$'

    tuneup_getOptions "${@}"

    eval set -- "${TCAR_ARGUMENTS}"

    for ARGUMENT in ${@};do

        # Sanitate non-option arguments to be sure they match the
        # directory conventions established by centos-art.sh script
        # against source directory locations in the working copy.
        local ARGUMENT=$(tcar_checkRepoDirSource ${ARGUMENT})

        # Build list of files to process.
        if [[ -f ${ARGUMENT} ]];then
            local FILES=${ARGUMENT}
        else
            tcar_checkFiles -ed ${ARGUMENT}
            local FILES=$(tcar_getFilesList ${ARGUMENT} \
                --pattern=".+${FILE_EXTENSION_REGEX}" \
                --type='f' | egrep ${TCAR_FLAG_FILTER})
        fi

        # Process list of files.
        for FILE in ${FILES};do
            
            # Print action message.
            tcar_printMessage "${FILE}" --as-tuningup-line

            # Retrieve module name to apply based on file extension .
            local SUBMODULE_NAME=$(echo ${FILE} \
                | sed -r "s/.+${FILE_EXTENSION_REGEX}/\1/")

            # Set module aliases. 
            if [[ ${SUBMODULE_NAME} =~ '(shtml|html|htm)' ]];then
                SUBMODULE_NAME='xhtml'
            fi

            # Initiate module's environment for processing file.
            tcar_setSubModuleEnvironment "${SUBMODULE_NAME}" "${@}"

        done

    done

}
