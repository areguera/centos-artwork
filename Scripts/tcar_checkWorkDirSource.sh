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

# Prepare non-option arguments passed through the command-line for
# further processing.  When the argument provided is not an absolute
# path this function transforms it into an absolute path using the
# current working directory.
function tcar_checkWorkDirSource {

    local LOCATION=${1}

    # Append the current working directory when the location provided
    # isn't absolute.
    if [[ ! ${LOCATION} =~ '^/' ]];then
        LOCATION=${PWD}/${LOCATION}
    fi

    # Remove both consecutive slashes and trailing slashes from final
    # location.
    echo "${LOCATION}" | sed -r -e 's,/+,/,g' -e 's,/+$,,g'

    # The single slash form doesn't point to repository's root
    # directory anymore. Instead, when a single slash is passed
    # as argument through the command-line, it preserves its regular
    # meaning which is pointing the workstation's file system.

    # The path verification isn't appropriate here because this
    # function is commonly used inside variable assignments and flow
    # control doesn't take place in such situation. In case path
    # verification fails here, the script wouldn't end its execution
    # which contradicts the expected behaviour.

}
