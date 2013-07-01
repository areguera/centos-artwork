#!/bin/bash
#
# cli_runFnEnvironment.sh -- This function standardizes the way
# centos-art.sh script is called to itself. The main purpose of this
# somehow own interface is to control the parent script flow based on
# specific function environments exit status.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_runFnEnvironment {

    # Execute specific function environment.
    ${CLI_NAME} $@

    # Retrieve exit status.
    local STATUS=$?

    # Finish script execution based on exit status.
    if [[ ${STATUS} -ne 0 ]];then
        exit ${STATUS}
    fi

}
