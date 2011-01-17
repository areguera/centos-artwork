#!/bin/bash
#
# cli_readFileContent.sh -- This function outputs content files, passed
# as first argument, to standard output as specified by second
# argument.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function cli_readFileContent {

    local FILES="$1"

    # Verify existence of files.
    cli_checkFiles "$FILES"

    # Print content of files to standard output. 
    case "$2" in

        '--first-line' )
            cat "$FILES" | head -n 1
            ;;

        '--last-line' )
            cat "$FILES" | tail -n 1
            ;;

        '--copyright' )
            # This option prints the first line of a file, if it has a
            # copyright format. This option is mainly used to retrive
            # artistic motif author copyright note from artistic
            # motifs `authors.txt' file.
            local PATTERN='^Copyright (\(C\)|©) [0-9]+(-[0-9]+)? .+$'
            if [[ $(cli_readFileContent "$FILES" '--first-line') =~ "${PATTERN}" ]];then
                cli_readFileContent "$FILES" '--first-line'
            fi
            ;;

        '--all-lines' | * )
            cat "$FILES"
    esac

}
