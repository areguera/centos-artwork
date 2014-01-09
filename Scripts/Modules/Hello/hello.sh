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

# Print greeting messages and exit successfully.
function hello {

    # Define default greeting message.
    local HELLO_WORLD="`gettext "Hello, World!"`"

    # Define actions variable. Here is where actions related to
    # module-specific options are stored in for further processing.
    local ACTIONS=''

    # Interpret module-specific options and store related actions.
    hello_getOptions

    # Print greeting message
    if [[ -z ${ACTIONS} ]];then
        # Using parent module.
        tcar_printMessage "${HELLO_WORLD}" --as-stdout-line
    else
        # Using child module.
        tcar_setModuleEnvironment -m 'output' -t 'child'
    fi

}
