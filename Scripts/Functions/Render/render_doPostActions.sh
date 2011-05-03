#!/bin/bash
#
# render_doPostActions.sh -- This function performs post-rendition
# actions for all files.
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

function render_doPostActions {

    local ACTION=''

    # Define common post-rendition actions.
    if [[ $FLAG_GROUPED_BY != '' ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]="groupSimilarFiles:${FLAG_GROUPED_BY}"
    fi

    # Execute common post-rendition actions.
    for ACTION in "${POSTACTIONS[@]}"; do
        ${FUNCNAM}_$(echo "$ACTION" | cut -d: -f1)
    done

}
