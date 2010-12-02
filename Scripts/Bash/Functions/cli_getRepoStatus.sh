#!/bin/bash
#
# cli_getRepoStatus.sh -- This function requests the working copy
# using the `svn status' command to return the first character on each
# output line, as described in `svn help status`. Use this function to
# know which status, the first argument passed to this function, has.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_getRepoStatus {

    local FILE="$1"
    local STATUS=''

    # Verify the file used as source to retrive its status
    # information. We only use regular files or directories inside the
    # working copy.
    cli_checkFiles "$FILE" 'fd'

    # Use subversion `status' command to retrive the first character
    # in the output.
    STATUS=$(svn status "$FILE" --quiet | sed -r 's/^( |A|C|D|I|M|R|X|\?|!|~]).+/\1/' )

    # Outout status information.
    echo -n "$STATUS"

}
