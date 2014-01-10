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

# Standardize definition of file instances inside the render module.
function render_setInstances {

    local FILE=${1}
    local FILE_EXTENSION_PATTERN=${2:-asciidoc}
    local FILE_EXTENSION_REPLACE=${3:-docbook}

    # Verify existence and extension of design model.
    tcar_checkFiles -ef -m "\.${FILE_EXTENSION_PATTERN}$" "${FILE}"

    # Define file base name.
    local FILE_BASENAME=$(basename ${FILE})

    # Define absolute path  to source instance.
    SOURCE_INSTANCES[${COUNTER}]=$(tcar_getTemporalFile ${FILE_BASENAME})

    # Define absolute path to target instance.
    TARGET_INSTANCES[${COUNTER}]=$(tcar_getTemporalFile ${FILE_BASENAME} \
        | sed -r "s/\.${FILE_EXTENSION_PATTERN}$/.${FILE_EXTENSION_REPLACE}/")

}
