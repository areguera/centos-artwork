#!/bin/bash
#
# prepare_forUsingInkscape.sh -- This function prepares user's
# ~/.inkscape configurations directory to use CentOS defaults (e.g.,
# palettes, patterns, etc).
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function prepare_forUsingInkscape {

    # Define variables as local to avoid conflicts outside.
    local -a REPODIRS
    local -a REPOFILES
    local -a REPOLINKS

    # Define directories required by the centos-art.sh script command
    # line interface. 
    REPODIRS[0]=/home/centos/.inkscape/palettes
    REPODIRS[1]=/home/centos/artwork/trunk/Identity/Colors

    # Define files required by the centos-art.sh script command line
    # interface.
    REPOFILES=${REPODIRS[1]}/CentOS.gpl

    # Define symbolic links required by the centos-art.sh script
    # command line interface.
    REPOLINKS=${REPODIRS[0]}/CentOS.gpl

    # Check defined directories, files, and symbolic links.
    cli_checkFiles "${REPODIRS[@]}"
    cli_checkFiles "${REPOFILES[@]}"
    cli_checkFiles "${REPOLINKS[@]}"

}
