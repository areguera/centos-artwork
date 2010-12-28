#!/bin/bash
#
# cli_doParseArgumentsReDef.sh -- This function initiates/reset
# positional parameters based on `$@' variable.
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

function cli_doParseArgumentsReDef {

    local ARG

    # Clean up arguments global variable.
    ARGUMENTS=''

    # Fill up arguments global variable with current positional
    # parameter  information. To avoid interpretation problems, use
    # single quotes to enclose each argument (ARG) from command-line
    # idividually.
    for ARG in "$@"; do
        ARGUMENTS="$ARGUMENTS '$ARG'"
    done

}
