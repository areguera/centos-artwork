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

# Initialize processing of configuration files when the argument
# provided in the command-line points to a directory.
function directories {

    local DIRECTORY=$(tcar_printPath "${1}")

    local CONFIGURATION_FILES=$(tcar_getFilesList -p '.+/.+\.conf$' -t 'f' ${DIRECTORY})

    local CONFIGURATION_SYMLINKS=$(tcar_getFilesList -p '.+/.+\.conf$' -t 'l' ${DIRECTORY})

    local CONFIGURATIONS="${CONFIGURATION_FILES} ${CONFIGURATION_SYMLINKS}"

    # Verify existence of configuration files. Take care that
    # tcar_getFilesList might return empty values sometimes (e.g.,
    # when no file is found).
    tcar_checkFiles -e "${CONFIGURATIONS}"

    # Process configuration file, one by one.
    for CONFIGURATION in ${CONFIGURATIONS};do
        tcar_setModuleEnvironment -m 'files' -t 'sibling' -g "${CONFIGURATION}"
    done

}
