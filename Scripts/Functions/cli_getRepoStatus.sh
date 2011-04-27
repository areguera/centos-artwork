#!/bin/bash
#
# cli_getRepoStatus.sh -- This function requests the working copy
# using the svn status command and returns the first character in the
# output line, as described in svn help status, for the LOCATION
# specified. Use this function to perform verifications based a
# repository LOCATION status. 
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

function cli_getRepoStatus {

    local LOCATION="$1"
    local STATUS=''

    # Define regular expression pattern to retrive first column,
    # returned by subversion status command. This column is one
    # character column as describes `svn help status' command.
    local PATTERN='^( |A|C|D|I|M|R|X|\?|!|~).+$'

    # Verify the file used as source to retrive its status
    # information. We only use regular files or directories inside the
    # working copy.
    cli_checkFiles "$LOCATION" 'fd'
    cli_checkFiles "$LOCATION" 'isInWorkingCopy'

    # Use subversion `status' command to retrive the first character
    # in the output. Discard standard error output.
    STATUS="$(svn status "$LOCATION" | sed -r "s/${PATTERN}/\1/" 2>/dev/null)"

    # Outout status information.
    echo -n "$STATUS"

}
