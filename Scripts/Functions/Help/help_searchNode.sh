#!/bin/bash
#
# help_searchNode.sh -- This function does a node search inside the
# info document.
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

function help_searchNode {

    # Print action message.
    cli_printMessage "${MANUAL_BASEFILE}.info.bz2" 'AsReadingLine'

    # Check entry inside documentation structure. If the entry
    # exits use the info reader to open the info file at the
    # specified node. Otherwise, ask the user for create it.
    if [[ -f "$ENTRY" ]];then
        /usr/bin/info --node="Repository $(help_getNode)" --file=${MANUAL_BASEFILE}.info.bz2
    else
        help_editEntry
    fi

}
