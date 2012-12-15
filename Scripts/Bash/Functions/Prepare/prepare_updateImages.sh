#!/bin/bash
#
# prepare_updateImages.sh -- This option initializes image files inside
# the working copy. When you provide this option, the centos-art.sh
# scripts renders image files from all design models available in the
# working copy. This step is required in order to satisfy dependencies
# from different components inside the working copy.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function prepare_updateImages {

    # Define list of directories that need to be rendered.
    local DIRS=$(cli_getFilesList \
        ${TCAR_WORKDIR}/Identity/Images --maxdepth="1" \
        --mindepth="1" --type="d" --pattern=".+/[[:alnum:]]+")

    # CAUTION: The order in which the image components are rendered is
    # very important. For example, in order for theme images to hold
    # the branding information the `Identity/Images/Brands' directory
    # must be rendered before the `Identity/Images/Themes' directory.
    # The reason of this is that brand images are not draw inside
    # theme design models themselves, but combined with theme images
    # using the ImageMagick tool suite once both have been rendered.

    # Update list of directories to be sure that brands will always be
    # rendered as first image component. Here we remove the brand
    # component from the list and add it explicitly on top of all
    # other directories in the list.
    DIRS="${TCAR_WORKDIR}/Identity/Images/Brands
        $(echo "$DIRS" | grep -v 'Identity/Images/Brands')"

    # Render image components using the list of directories.
    cli_runFnEnvironment render ${DIRS} --with-brands

}
