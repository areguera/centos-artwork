#!/bin/bash
#
# subversion_isVersioned.sh -- This function determines whether a
# location is under version control or not. When the location is under
# version control, this function returns `0'. When the location isn't
# under version control, this function returns `1'.
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

function subversion_isVersioned {

    # Define the location absolute path we want to determine whether
    # it is under version control or not. Only the first non-option
    # argument passed to centos-art.sh command-line will be used.
    local LOCATION=$(cli_checkRepoDirSource "${1}")

    # Use Subversion to determine whether the location is under
    # version control or not.
    ${COMMAND} info ${LOCATION} > /dev/null 2>&1

    # Verify Subversion's exit status.
    if [[ $? -ne 0 ]];then
        cli_printMessage "${LOCATION} `gettext "isn't under version control."`" --as-error-line
    fi

}
