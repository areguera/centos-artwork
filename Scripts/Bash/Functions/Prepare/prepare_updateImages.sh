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
        --mindepth="1" --type="d" --pattern=".+/[[:alnum:]]+$")

    # Execute the render functionality of centos-art.sh script to
    # produce images inside each directory.  Using directories one by
    # one to render images is important because themes directories are
    # produced in a different way compared to others image
    # directories.  Thus, if we pass the list of directories to
    # centos-art.sh script, it is possible for it to know how to
    # produce each specific directory passed correctly. As default, in
    # the image preparation process, all images that need to hold
    # branding information will be rendered using The CentOS Brand in
    # it.
    ${CLI_BASEDIR}/${TCAR_CLI_NAME}.sh render $DIRS --dont-commit-changes --with-brands

}
