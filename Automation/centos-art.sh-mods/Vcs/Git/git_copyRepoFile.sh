#!/bin/bash
#
# git_copyRepoFile.sh -- This function standardizes the way files
# (including directories) are duplicated inside the working copy. This
# function is an interface for git's `copy' command.
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

function git_copyRepoFile {

    local SOURCE=$(cli_checkRepoDirSource ${1})
    local TARGET=$(cli_checkRepoDirSource ${2})

    # Verify source location absolute path. It should point to
    # existent files or directories. They don't need to be under
    # version control.
    cli_checkFiles ${SOURCE} -e

    # Print action reference.
    if [[ -f ${SOURCE} ]];then
        cli_printMessage "${TARGET}/$(basename ${SOURCE})" --as-creating-line
    else
        cli_printMessage "${TARGET}" --as-creating-line
    fi

    # Copy source location to its target using version control. I
    # didn't find a copy command for Git. If you know a better way to
    # track a copy action through Git, set it here.
    /bin/cp ${SOURCE} ${TARGET}
    if [[ $? -eq 0 ]];then
        ${COMMAND} add ${TARGET}
    fi
 
}
