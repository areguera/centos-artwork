#!/bin/bash
#
# render_doSvgPostActions.sh -- This function performs
# post-rendition actions for SVG files.
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

function render_doSvgPostActions {

    local ACTION=''

    # Define SVG-directory-specific post-rendition actions processing
    # as local to this function. Otherwise it may confuse command-line
    # post-rendition actions.
    local -a POSTACTIONS

    # Execute SVG directory-specific post-rendition actions to the
    # list of post actions and last actions. This is required in order
    # to provide a predictable way of producing content inside the
    # repository and save you the time of writing long option
    # combinations each time you need to produce images inside the
    # repository.
    if [[ $TEMPLATE =~ "Backgrounds/.+\.svg$" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='convertPngTo: jpg'
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='groupSimilarFiles: png jpg'
    elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent '--release-pattern')/Syslinux/.+\.svg$" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='renderSyslinux'
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='renderSyslinux:-floyd'
    elif [[ $TEMPLATE =~ "Grub" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='renderGrub'
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='renderGrub:-floyd'
    elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent '--release-pattern')/Ksplash/.+\.svg$" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='renderKsplash'
    fi

    # Execute SVG command-line-specific post-rendition actions passed
    # from command-line and add them, if any, to post-rendition list
    # of actions.
    if [[ $FLAG_CONVERT_TO != '' ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]="convertPngTo:${FLAG_CONVERT_TO}"
    fi

    for ACTION in "${POSTACTIONS[@]}"; do

        case "${ACTION}" in

            convertPngTo:* )
                render_convertPngTo
                ;;

            renderSyslinux* )
                render_doSyslinux 
                ;;

            renderGrub* )
                render_doGrub 
                ;;

            renderBrands )
                render_doBrands 
                ;;

            groupSimilarFiles:* )
                render_groupSimilarFiles
                ;;

        esac

    done

}
