#!/bin/bash
######################################################################
#
#   conf.sh -- This module prepares configuration files used by both
#   render and locale modules. 
#
#   To build the configuration file, this module creates a list of
#   files to process based on the arguments provided in the
#   command-line line. With this list, then, it creates the
#   configuration file using configuration templates for each file
#   extension supported inside the repository.
#
#   The configuration file this module creates doesn't include options
#   like brand which require information about the image you are about
#   to produce. The intention of this module is create the
#   configuration files you need to produce content right away in the
#   simplest way possible and then letting you improve it as needed.
#
#   The name and location of the final configuration file is that
#   passed as argument to prepare module in the command-line.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2013
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

function conf {

    # Verify that a configuration file was provided as argument.
    if [[ $# -eq 0 ]];then
        tcar_printMessage "`gettext "The configuration file wasn't provided."`" --as-error-line
    fi

    # Define configuration file.
    local CONF_FILE=$(tcar_checkRepoDirSource "${1}")
    tcar_checkFiles -m "\.conf$" ${CONF_FILE}

    # Define parent directory of configuration file.
    local CONF_DIR=$(dirname ${CONF_FILE})
    tcar_checkFiles -ed "${CONF_DIR}"

    # Build the list of files to process. This is all the source files
    # we want to produce th configuration file for.
    local SOURCE_FILES=$(tcar_getFilesList ${CONF_DIR} \
        --mindepth=1 --maxdepth=1 --type=f \
        --pattern='.+\.(svgz|svg|asciidoc)$')

    # Verify the list of files to process.
    tcar_checkFiles -ef ${SOURCE_FILES}

    # Print action message.
    tcar_printMessage "${CONF_FILE}" --as-creating-line

    # Process list of files.
    for SOURCE_FILE in ${SOURCE_FILES};do

        local CONF_FILE_NAME=$(tcar_getFileName "${SOURCE_FILE}")
        local CONF_FILE_EXTENSION=$(tcar_getFileExtension "${SOURCE_FILE}")
        local CONF_FILE_TEMPLATE=${TCAR_MODULE_DIR_CONFIGS}/${CONF_FILE_EXTENSION}.render.conf.tpl

        sed -r "s/=SECTION=/${CONF_FILE_NAME}/g" ${CONF_FILE_TEMPLATE} >> ${CONF_FILE}

    done

}
