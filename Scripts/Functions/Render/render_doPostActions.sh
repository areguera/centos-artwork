#!/bin/bash
#
# render_doPostActions.sh -- This function standardizes the way
# post-rendition actions are applied to base-rendition output.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function render_doPostActions {

    # Define the file extension of base-rendition output.
    local EXTENSION=$(render_getConfigOption "$ACTION" '2')

    # Define the command string.
    local COMMAND=$(render_getConfigOption "$ACTION" '3-')

    # Verify the file fullname of base-rendition output.
    cli_checkFiles ${FILE}.${EXTENSION}

    # Execute the command string on base-rendition output.
    eval $COMMAND ${FILE}.${EXTENSION}

    # Be sure the command string was executed correctly. Otherwise
    # stop the script execution.
    if [[ $? -ne 0 ]];then
        exit
    fi

}
