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

# Make a list of all the supported files inside the directory provided
# as argument in the command-line. They it passed each file found to
# files module, where they are processed one by one.
function directories {

    local FILES=''

    # Sanitate non-option arguments to be sure they match the
    # directory conventions established by centos-art.sh script
    # against source directory locations in the working copy.
    local DIRECTORY=$(tcar_checkWorkDirSource ${1})

    # Define regular expression used by locale module to determine the
    # file extension that it can retrieve translatable strings from,
    # when a directory as argument is provided in the command-line.
    #
    # Don't include file extensions for script files here.
    #
    # Scripts files shouldn't be localized when a directory has been
    # passed argument in the command-line because when we are
    # processing directories, each file inside it is processed
    # individually.  For example, modules might involve several script
    # files but they should have only one PO file for all the files
    # they are made of.  Using directory processing would create one
    # PO file for each script file in the directory and that is what
    # should not happen.  For this reason don't include any file
    # extension related to script files here.
    #
    # Don't include file extensions for asciidoc files here.
    #
    # Asciidoc documents need configuration files in order to be
    # localized in coordination with render module. If you list
    # asciidoc documents here, the configuration files won't be read
    # and it will be localized in a way that may or may not match the
    # way it is produced through render module.
    local LOCALE_SUPPORTED_FILES='.+/.+\.(svgz|svg)$'

    # Build list of supported files which locale module will extract
    # translatable strings from.
    if [[ ${LOCALE_FLAG_RECURSIVE} == 'true' ]];then
        FILES=$(tcar_getFilesList  -t 'f' -p "${LOCALE_SUPPORTED_FILES}" ${DIRECTORY} \
            | egrep "${TCAR_FLAG_FILTER}")
    else
        FILES=$(tcar_getFilesList -i 1 -a 1 -t 'f' -p "${LOCALE_SUPPORTED_FILES}" ${DIRECTORY} \
            | egrep "${TCAR_FLAG_FILTER}")
    fi

    # Verify found files. In case no file is found, print an error
    # message describing it.
    tcar_checkFiles -ef ${FILES}

    # Execute files module to process files found, one by one.
    for FILE in ${FILES};do
        tcar_setModuleEnvironment -m 'files' -t 'sibling' -g ${FILE}
    done

}
