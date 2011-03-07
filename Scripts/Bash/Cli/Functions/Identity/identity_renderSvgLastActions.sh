#!/bin/bash
#
# identity_renderSvgLastActions.sh -- This function performs
# last-rendition actions for SVG files.
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

function identity_renderSvgLastActions {

    local ACTION=''

    # Verify position of file being produced in the list of files been
    # currently processed.
    if [[ $THIS_FILE_DIR == $NEXT_FILE_DIR ]];then
        return
    fi

    # Define SVG-directory-specific last-rendition actions processing
    # as local to this function. Otherwise it may confuse command-line
    # last-rendition actions.
    local -a LASTACTIONS

    # Add directory-specific last-rendition actions to the list of
    # post actions and last actions. This is required in order to
    # provide a predictable way of producing content inside the
    # repository and save you the time of writing long option
    # combinations each time you need to produce images inside the
    # repository.
    if [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent '--release-pattern')/Gdm/.+\.svg$" ]];then
        LASTACTIONS[((++${#LASTACTIONS[*]}))]='renderDm:Gdm:800x600 1024x768 1280x1024 1360x768 2048x1536 2560x1240'
    elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent '--release-pattern')/Kdm/.+\.svg$" ]];then
        LASTACTIONS[((++${#LASTACTIONS[*]}))]='renderDm:Kdm:800x600 1024x768 1280x1024 1360x768 2048x1536 2560x1240'
    elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent '--release-pattern')/Ksplash/.+\.svg$" ]];then
        LASTACTIONS[((++${#LASTACTIONS[*]}))]='renderKsplash'
    fi

    # At this point centos-art.sh should be producing the last file
    # from the same unique directory structure, so, before producing
    # images for the next directory structure lets execute
    # last-rendition actions for the current directory structure. 
    for ACTION in "${LASTACTIONS[@]}"; do

        case "${ACTION}" in

            renderKsplash )
                identity_renderKsplash
                ;;

            renderDm:* )
                identity_renderDm
                ;;

        esac

    done

}
