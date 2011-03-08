#!/bin/bash
#
# identity_renderLastActions.sh -- This function performs
# last-rendition actions for all files.
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

function identity_renderLastActions {

    local ACTION=''

    # Verify position of file being produced in the list of files been
    # currently processed.
    if [[ $THIS_FILE_DIR != $NEXT_FILE_DIR ]];then

        # At this point centos-art.sh should be producing the last
        # file from the same unique directory structure, so, before
        # producing images for the next directory structure lets
        # execute last-rendition actions for the current directory
        # structure. 
        for ACTION in "${LASTACTIONS[@]}"; do

            case "${ACTION}" in

                groupSimilarFiles:* )
                    identity_groupSimilarFiles
                    ;;
            esac

        done

    fi

}
