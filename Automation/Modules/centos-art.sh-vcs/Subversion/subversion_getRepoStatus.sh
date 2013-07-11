#!/bin/bash
#
# subversion_getRepoStatus.sh -- This function requests the working
# copy using the svn status command and returns the first character in
# the output line, as described in svn help status, for the LOCATION
# specified. Use this function to perform verifications based a
# repository LOCATION status. 
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

function subversion_getRepoStatus {

    local LOCATION=$(cli_checkRepoDirSource "$1")

    # Verify source location absolute path. It should point either to
    # existent files or directories both under version control inside
    # the working copy.  Otherwise, if it doesn't point to an existent
    # file under version control, finish the script execution with an
    # error message.
    cli_checkFiles ${LOCATION} -e --is-versioned

    # Define regular expression pattern to retrieve first column,
    # returned by subversion status command. This column is one
    # character column as describes `svn help status' command.
    local PATTERN='^( |A|C|D|I|M|R|X|!|~).+$'

    # Output specific state of location using subversion `status'
    # command.
    ${COMMAND} status "$LOCATION" -N --quiet | sed -r "s/${PATTERN}/\1/"

}
