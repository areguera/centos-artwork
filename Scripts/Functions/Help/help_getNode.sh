#!/bin/bash
#
# help_getNode.sh -- This function cleans up the action value
# (ACTIONVAL) directory to make a node name from it.
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

function help_getNode {

    local NODE=$(echo "$ACTIONVAL" \
        | sed -r "s!^${HOME}/artwork/!!" \
        | sed -r 's!/! !g' | sed -r 's!^[[:space:]]+!!')

    echo "$NODE"
}

