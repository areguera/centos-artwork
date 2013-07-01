#!/bin/bash
#
# subversion_copyRepoFile.sh -- This function standardizes the way
# files (including directories) are duplicated inside the working
# copy. This function is an interface for subversion's `copy' command.
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

function subversion_copyRepoFile {

    local SOURCE=$(cli_checkRepoDirSource ${1})
    local TARGET=$(cli_checkRepoDirSource ${2})

    # Verify source location absolute path. It should point either to
    # existent files or directories both under version control inside
    # the working copy.  Otherwise, if it doesn't point to an existent
    # file under version control, finish the script execution with an
    # error message.
    cli_checkFiles ${SOURCE} -e --is-versioned

    # Print action reference.
    if [[ -f ${SOURCE} ]];then
        cli_printMessage "${TARGET}/$(basename ${SOURCE})" --as-creating-line
    else
        cli_printMessage "${TARGET}" --as-creating-line
    fi

    # Copy source location to its target using version control.
    ${COMMAND} copy ${SOURCE} ${TARGET} --quiet

}
