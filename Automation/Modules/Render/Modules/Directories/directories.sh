#!/bin/bash
######################################################################
#
#   directories.sh -- This module initializes processing of
#   configuration files when the argument provided in the command-line
#   points to a directory.
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

function directories {

    local DIRECTORY="${1}"

    local CONFIGURATION_FILES=$(tcar_getFilesList ${DIRECTORY} \
        --pattern=".+/.+\.conf$" --type='f')

    local CONFIGURATION_SYMLINKS=$(tcar_getFilesList ${DIRECTORY} \
        --pattern=".+/.+\.conf$" --type='l')

    local CONFIGURATIONS="${CONFIGURATION_FILES} ${CONFIGURATION_SYMLINKS}"

    # Verify existence of configuration files. Take care that
    # tcar_getFilesList might return empty values sometimes (e.g.,
    # when no file is found).
    tcar_checkFiles -e "${CONFIGURATIONS}"

    # Process each configuration file.
    for CONFIGURATION in ${CONFIGURATIONS};do
        tcar_setModuleEnvironment -m 'files' -t 'sibling' -g "${CONFIGURATION}"
    done

}
