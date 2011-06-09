#!/bin/bash
#
# render_svg_doPostActions.sh -- This function performs
# post-rendition actions for SVG files.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function render_svg_doPostActions {

    local ACTION=''

    # Redefine SVG post-rendition actions as local to avoid undesired
    # concatenation when massive rendition is performed.
    local -a POSTACTIONS

    # Define default comment written to base-rendition output.
    local COMMENT="`gettext "Created in CentOS Arwork Repository"` ($(cli_printUrl '--projects-artwork'))"

    # Define SVG post-rendition actions. Since these actions are
    # applied to base-rendition output and base-rendition output is
    # used as reference to perform directory-specific rendition, these
    # action must be defined before directory-specific rendition.
    # Otherwise it wouldn't be possible to propagate changes impossed
    # by these actions to new files produced as result of
    # directory-specific rendition.
    POSTACTIONS[((++${#POSTACTIONS[*]}))]="doPostActions:png:mogrify -comment '$COMMENT'"
    [[ $FLAG_POSTRENDITION != '' ]] && POSTACTIONS[((++${#POSTACTIONS[*]}))]="doPostActions:png:${FLAG_POSTRENDITION}"

    # Define SVG directory-specific rendition. Directory-specfic
    # rendition provides a predictable way of producing content inside
    # the repository.
    if [[ $FLAG_DONT_DIRSPECIFIC == 'false' ]];then
        if [[ $TEMPLATE =~ "Backgrounds/.+\.svg$" ]];then
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngTo:jpg'
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_groupBy:png jpg'
        elif [[ $TEMPLATE =~ "Concept/.+\.svg$" ]];then
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngTo:jpg pdf'
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngToThumbnail:250'
        elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent --release-pattern)/Syslinux/.+\.svg$" ]];then
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngToSyslinux:'
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngToSyslinux:-floyd'
        elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent --release-pattern)/Grub/.+\.svg$" ]];then
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngToGrub:'
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngToGrub:-floyd'
        elif [[ $TEMPLATE =~ "Posters/.+\.svg$" ]];then
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngTo:jpg pdf'
        elif [[ $TEMPLATE =~ "trunk/Identity/Models/Brands/.+\.svg$" ]];then
            POSTACTIONS[((++${#POSTACTIONS[*]}))]='svg_convertPngToBrands'
        fi
    fi

    # Execute SVG post-rendition actions.
    for ACTION in "${POSTACTIONS[@]}"; do
        ${FUNCNAM}_$(echo "$ACTION" | cut -d: -f1)
    done

}
