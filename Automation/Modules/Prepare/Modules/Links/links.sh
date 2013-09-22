#!/bin/bash
######################################################################
#
#   links.sh -- This function renders configuration files inside
#   automation scripts directory structure, using the render module.
#   These configuration files are mainly used to connect content
#   inside the repository with applications outside the repository,
#   using symbolic links.
#
#   Written by:
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#
# Copyright (C) 2009-2013 The CentOS Project
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
######################################################################

function links {

    # Define base location where configuration files will be searched
    # from. You can provide more than one location here.
    local DIRS="/"

    # Define the name of the option you want to look configuration
    # files for.
    local NAME='render-type'

    # Define the value of the option you want to look configuration
    # files for.
    local VALUE='symlink'

    # Render configuration files that match specified options and
    # values in the search directories.
    prepare_setRenderEnvironment -o "${NAME}" -v "${VALUE}" "${DIRS}" 

}

