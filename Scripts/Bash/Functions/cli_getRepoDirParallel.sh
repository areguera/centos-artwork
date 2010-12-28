#!/bin/bash
#
# cli_getRepoDirParallel.sh -- This function returns the parallel
# directory of path passed through action value variable. This
# function implements the parallel directory conceptual idea.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function cli_getRepoDirParallel {

    # Initialize bond string.
    local BOND=$1

    # Initialize parallel directory using first argument.
    local DIR=$2

    # Remove top level directory from action value to create the bond.
    BOND=$(echo $BOND | sed -r "s!^.+/(trunk|branches|tags)/!!")

    # Concatenate parallel-directory base location and bond
    # information in order to produce the final parallel-directory
    # path.
    echo $DIR/$BOND

}
