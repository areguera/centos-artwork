#!/bin/bash
#
# cli_doParseArgumentsReDef.sh -- This function initiates/reset and
# sanitates positional parameters passed to this function and creates
# the the list of arguments that getopt will process.
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

function cli_doParseArgumentsReDef {

    local ARG

    # Clean up arguments global variable.
    ARGUMENTS=''

    # Fill up arguments global variable with current positional
    # parameter  information. To avoid interpretation problems, use
    # single quotes to enclose each argument (ARG) from command-line
    # idividually.
    for ARG in "$@"; do

        # Sanitate option arguments before process them.  Be sure that
        # no option argument does contain any single quote (U+0027)
        # inside; that would break option parsing.  Remember that we
        # are using single quotes to enclose option arguments in order
        # to let getopt to interpret option arguments with spaces
        # inside.  To solve this issue, we replace all single quotes
        # in the arguments list with their respective codification and
        # reverse the process back when doPrint them out.
        ARG=$(echo $ARG | sed "s/'/\\\0x27/g")

        # Concatenate arguments and encolose them to let getopt to
        # process them when they have spaces inside.
        ARGUMENTS="$ARGUMENTS '$ARG'"

    done

}
