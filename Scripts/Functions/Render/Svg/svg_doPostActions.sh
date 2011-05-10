#!/bin/bash
#
# svg_doPostActions.sh -- This function performs
# post-rendition actions for SVG files.
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

function svg_doPostActions {

    local ACTION=''
    
    # Define SVG-directory-specific post-rendition actions processing
    # as local to this function. Otherwise it may confuse command-line
    # post-rendition actions.
    local -a POSTACTIONS

    # Define SVG post-rendition actions that modify base-rendition
    # output in place.
    [[ $FLAG_COMMENT != '' ]] && POSTACTIONS[((++${#POSTACTIONS[*]}))]="mogrifyPngToComment"
    [[ $FLAG_SHARPEN != '' ]] && POSTACTIONS[((++${#POSTACTIONS[*]}))]="mogrifyPngToSharpen"

    # Define SVG directory-specific rendition. Directory-specfic
    # rendition provides a predictable way of producing content inside
    # the repository.
    if [[ $TEMPLATE =~ "Backgrounds/.+\.svg$" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='convertPngTo:jpg'
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='groupSimilarFiles:png jpg'
    elif [[ $TEMPLATE =~ "Concept/.+\.svg$" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='convertPngTo:jpg pdf'
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='convertPngToThumbnail:250'
    elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent --release-pattern)/Syslinux/.+\.svg$" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='doSyslinux:'
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='doSyslinux:-floyd'
    elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent --release-pattern)/Grub/.+\.svg$" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='doGrub:'
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='doGrub:-floyd'
    elif [[ $TEMPLATE =~ "Posters/.+\.svg$" ]];then
        POSTACTIONS[((++${#POSTACTIONS[*]}))]='convertPngTo:jpg pdf'
    fi

    # Define SVG post-rendition actions that create new files from
    # base-rendition output.
    [[ $FLAG_CONVERT != '' ]] && POSTACTIONS[((++${#POSTACTIONS[*]}))]="convertPngTo:$FLAG_CONVERT"

    # Execute SVG post-rendition actions.
    for ACTION in "${POSTACTIONS[@]}"; do
        ${FUNCNAM}_$(echo "$ACTION" | cut -d: -f1)
    done

}
