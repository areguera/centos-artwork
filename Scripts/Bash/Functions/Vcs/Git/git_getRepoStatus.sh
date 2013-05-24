#!/bin/bash
#
# git_getRepoStatus.sh -- This function requests the working copy
# using the status command and returns the first character in the
# output line, as described in git help status, for the LOCATION
# specified. Use this function to perform verifications based a
# repository LOCATION status. 
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function git_getRepoStatus {

    local LOCATION=$(cli_checkRepoDirSource "$1")

    # Verify source location absolute path. It should point either to
    # existent files or directories both under version control inside
    # the working copy.  Otherwise, if it doesn't point to an existent
    # file under version control, finish the script execution with an
    # error message.
    cli_checkFiles ${LOCATION} -e

    # Define regular expression pattern to retrieve the work tree
    # status. This is the second character of the first column
    # returned by `git status --porcelain' command.
    local PATTERN='^(.)(.)[[:space:]]+.+$'

    # Output the work tree status.
    ${COMMAND} status "$LOCATION" --porcelain \
        | sed -r "s/${PATTERN}/\2/"

}
