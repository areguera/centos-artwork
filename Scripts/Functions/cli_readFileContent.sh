#!/bin/bash
#
# cli_readFileContent.sh -- This function outputs content of files,
# passed as first argument, to standard output as specified by second
# argument.
#
# Copyright (C) 2009-2011 The CentOS Project
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

function cli_readFileContent {

    local FILES="$1"
    local PATTERN='Copyright (\(C\)|©) [0-9]+(-[0-9]+)? .+'

    # Verify existence of files but don't stop if it doesn't exist.
    cli_checkFiles "$FILES"

    # Print content of files to standard output.
    case "$2" in

        '--copyright-line' )
            cat "$FILES" | egrep "^ +${PATTERN}$" | head -n 1 | sed -r 's!^ +!!'
            ;;

        '--last-line' )
            cat "$FILES" | tail -n 1
            ;;

        '--copyright-year' )
            if [[ $(cli_readFileContent "$FILES" '--copyright-line') =~ "^${PATTERN}$" ]];then
                cli_readFileContent "$FILES" '--copyright-line' | cut -d' ' -f3
            fi
            ;;

        '--copyright-holder' )
            if [[ $(cli_readFileContent "$FILES" '--copyright-line') =~ "^${PATTERN}$" ]];then
                cli_readFileContent "$FILES" '--copyright-line' | cut -d' ' -f4-
            fi
            ;;

        '--all-lines' | * )
            cat "$FILES"
            ;;

    esac

}
