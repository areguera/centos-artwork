#!/bin/bash
######################################################################
#
#   prepare_setConfiguration.sh -- This function builds a list of
#   configuration files and calls the render module for processing it.
#   The list of configuration files is built using the first argument
#   provided to this function as reference.
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
#
# Copyright (C) 2009-2013 The CentOS Project
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

function prepare_setConfiguration {

    local FILENAME=${1}
    
    # Verify the file  name passed to this function. Just to avoid
    # trickery when building the list of configuration files.
    cli_checkFiles "${FILENAME}" --match="^(images|links|manual)$"

    # Build list of configuration files to be produced.
    local CONFIGURATION_FILES=$(cli_getFilesList \
        ${TCAR_BASEDIR} --type="f" --pattern=".+/${FILENAME}\.conf")

    # Verify list of configuration files.
    if [[ -z ${CONFIGURATION_FILES} ]];then
        return
    fi

    # CAUTION: The order in which configuration files are processed is
    # relevant to final production result. For example, in order for
    # theme images to hold the branding information the
    # `Artworks/Brands' directory must be rendered before the
    # `Artworks/Themes' directory.  The reason of this is that brand
    # images are not drawn inside theme design models themselves, but
    # combined with theme images using the ImageMagick tool suite once
    # they both have been rendered as PNG files.

    # Rebuild the list of configuration files to grant brand correct
    # production order when they are included in the list of files to
    # produce.
    echo "${CONFIGURATION_FILES}" | grep "${TCAR_BASEDIR}/Artworks/Brands" > /dev/null
    if [[ $? -eq 0 ]];then
        CONFIGURATION_FILES="${TCAR_BASEDIR}/Artworks/Brands
            $(echo "${CONFIGURATION_FILES}" | grep -v "${TCAR_BASEDIR}/Artworks/Brands")"
    fi

    # Process configuration files using render module.
    cli_runFnEnvironment render ${CONFIGURATION_FILES}

}
