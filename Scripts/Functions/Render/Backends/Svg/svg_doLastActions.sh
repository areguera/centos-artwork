#!/bin/bash
#
# render_svg_doLastActions.sh -- This function performs
# last-rendition actions for SVG files.
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

function render_svg_doLastActions {

    # Verify position of file being produced in the list of files been
    # currently processed.
    if [[ $THIS_FILE_DIR == $NEXT_FILE_DIR ]];then
        return
    fi

    local ACTION=''

    # Redefine SVG last-rendition actions as local to avoid undesired
    # concatenation when massive rendition is performed.
    local -a LASTACTIONS

    # Define SVG directory-specific actions. This is required in order
    # to provide a predictable way of producing content inside the
    # repository and save you the time of writing long several
    # commands each time you need to produce images inside the
    # repository.
    if [[ $FLAG_DONT_DIRSPECIFIC == 'false' ]];then
        if [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent --release-pattern)/Gdm/.+\.svg$" ]];then
            LASTACTIONS[((++${#LASTACTIONS[*]}))]='svg_convertPngToDm:Gdm:800x600 1024x768 1280x1024 1360x768 2048x1536 2560x1240'
        elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent --release-pattern)/Kdm/.+\.svg$" ]];then
            LASTACTIONS[((++${#LASTACTIONS[*]}))]='svg_convertPngToDm:Kdm:800x600 1024x768 1280x1024 1360x768 2048x1536 2560x1240'
        elif [[ $TEMPLATE =~ "Distro/$(cli_getPathComponent --release-pattern)/Ksplash/.+\.svg$" ]];then
            LASTACTIONS[((++${#LASTACTIONS[*]}))]='svg_convertPngToKsplash:'
        fi
    fi

    # Define SVG last-rendition actions. Since last-rendition makes
    # use of all files in the output directory structure and
    # directory-specific rendition modifies all the files in the
    # output directory structure as well, these actions must be
    # defined after the directory-specific definition. Otherwise,
    # modifications impossed by these actions may interfier the whole
    # purpose of having a directory-specific rendition.
    [[ $FLAG_LASTRENDITION != '' ]] && LASTACTIONS[((++${#LASTACTIONS[*]}))]="doLastActions:(png|jpg):${FLAG_LASTRENDITION}"

    # At this point centos-art.sh should be producing the last file
    # from the same unique directory structure, so, before producing
    # images for the next directory structure lets execute the list of
    # last-rendition actions for the current directory structure. 
    for ACTION in "${LASTACTIONS[@]}"; do
        ${FUNCNAM}_$(echo "$ACTION" | cut -d: -f1)
    done

}
