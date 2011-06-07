#!/bin/bash
#
# cli_parseArguments.sh -- This function redefines arguments
# (ARGUMENTS) global variable using getopt(1) output.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function cli_parseArguments {

    # Reset positional parameters using optional arguments.
    eval set -- "$ARGUMENTS"

    # Parse optional arguments using getopt.
    ARGUMENTS=$(getopt -o "$ARGSS" -l "$ARGSL" -n "$CLI_PROGRAM (${FUNCNAME[1]})" -- "$@")

    # Be sure getout parsed arguments successfully.
    if [[ $? != 0 ]]; then 
        cli_printMessage "${FUNCDIRNAM}" --as-toknowmore-line
    fi

}
