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
        ${TCAR_WORKDIR}/trunk/Identity/Images --maxdepth="1" \
        --mindepth="1" --type="d" --pattern=".+/[[:alnum:]]+")

    # CAUTION: The order in which images are rendered is very
    # important. For example, in order for themed images to hold the
    # branding information the trunk/Identity/Images/Brands directory
    # must be rendered before trunk/Identity/Images/Themes directory.

    # Render images using the centos-art.sh script itself. 
    ${CLI_BASEDIR}/${CLI_NAME}.sh render $DIRS --with-brands

}
