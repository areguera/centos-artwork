#!/bin/bash
#
# texinfo_getEntryNode.sh -- This function cleans up the action value
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

function texinfo_getEntryNode {

    # Define documentation entry.
    local MANUAL_ENTRY="$1"

    # Verify documentation entry.
    if [[ $MANUAL_ENTRY == '' ]];then
        cli_printMessage "`gettext "The first positional parameter cannot be empty."`" --as-error-line
    fi

    # Define node from documentation entry.
    local NODE=$(echo "$MANUAL_ENTRY" | sed -r \
        -e "s!^${MANUAL_BASEDIR_L10N}/!!" \
        -e "s/\.${MANUAL_EXTENSION}$//" \
        -e "s!chapter!!" \
        -e 's!(/|-)! !g' \
        -e 's!\<([[:alpha:]]+)\>!\u\1!g' \
        -e 's!^[[:space:]]+!!')

    echo "$NODE"

}

