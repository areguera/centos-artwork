#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Standardize source files maintenance.
function tuneup {

    # Define file extensions tuneup module will look for processing.
    local FILE_EXTENSION_REGEX='\.(svgz|svg|shtml|xhtml|html|sh)$'

    tuneup_getOptions

    for ARGUMENT in ${TCAR_MODULE_ARGUMENT};do

        # Sanitate non-option arguments to be sure they match the
        # directory conventions established by tcar.sh script
        # against source directory locations in the working copy.
        local ARGUMENT=$(tcar_checkWorkDirSource ${ARGUMENT})

        # Build list of files to process.
        if [[ -f ${ARGUMENT} ]];then
            local FILES=${ARGUMENT}
        elif [[ -d ${ARGUMENT} ]];then
            local FILES=$(tcar_getFilesList -p ".+${FILE_EXTENSION_REGEX}" -t 'f' ${ARGUMENT} \
                | egrep ${TCAR_FLAG_FILTER})
        else
            tcar_printMessage "`gettext "The argument provided isn't valid."`" --as-error-line
        fi

        # Process list of files.
        for FILE in ${FILES};do

            # Print action message.
            tcar_printMessage "${FILE}" --as-tuningup-line

            # Retrieve module name to apply based on file extension .
            local FILE_EXTENSION=$(echo ${FILE} \
                | sed -r "s/.+${FILE_EXTENSION_REGEX}/\1/")

            # Set module aliases. 
            if [[ ${FILE_EXTENSION} =~ '(shtml|html|htm)' ]];then
                FILE_EXTENSION='xhtml'
            fi

            # Initiate module's environment for processing file.
            tcar_setModuleEnvironment -m "${FILE_EXTENSION}" -t "child" "${FILE}"

        done

    done

}
