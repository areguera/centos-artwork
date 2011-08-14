#!/bin/bash
#
# shell.sh -- This function standardizes maintainance tasks for Shell
# script files.
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

function shell {

    # Define backend-specific configuration directory.
    local CONFIG_DIR="${TUNEUP_BACKEND_DIR}/$(cli_getRepoName ${TUNEUP_BACKEND} -d)/Config"

    # Rebuild top comment inside shell scripts, mainly to update
    # copyright information.
    shell_doTopComment

}
