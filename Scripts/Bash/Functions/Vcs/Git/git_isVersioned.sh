#!/bin/bash
#
# git_isVersioned.sh -- This function determines whether a location is
# under version control or not. When the location is under version
# control, this function returns `0'. When the location isn't under
# version control, this function returns `1'.
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

function git_isVersioned {

    # Define the location absolute path we want to determine whether
    # it is under version control or not. Only the first non-option
    # argument passed to centos-art.sh command-line will be used.
    local LOCATION=$(cli_checkRepoDirSource "${1}")

    # Use Git to determine whether the location is under version
    # control or not.
    local OUTPUT=$(${COMMAND} status --porcelain ${LOCATION} \
        | egrep "\?\? ${LOCATION}")

    # If there are unversioned files inside location, stop the script
    # execution with an error message. All files must be under version
    # control except those set in the `.git/info/exclude/' file.
    if [[ ! -z ${OUTPUT} ]];then
        cli_printMessage "${LOCATION} `gettext " contains untracked files."`" --as-error-line
    fi

}
