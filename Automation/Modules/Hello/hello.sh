#!/bin/bash
######################################################################
#
#   hello.sh -- Print greetings and exit successfully.
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

function hello {

    # Define default message we want to print.
    local HELLO_GREETING="`gettext "Hello, World!"`"

    # Define actions variable. Here is where actions related to
    # module-specific options are stored in.
    local HELLO_ACTIONS=''

    # Interpret module-specific options and store related actions.
    hello_getOptions

    # Initiate actions sub-module.
    if [[ -n ${HELLO_ACTIONS} ]];then
        tcar_setModuleEnvironment -m 'output' -t 'sub-module'
    fi

}
