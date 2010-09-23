#!/bin/bash
#
# prepare_forUsingPathFonts.sh -- This function checks user's fonts
# directory. In order for some artworks to be rendered correctly,
# denmark font needs to be available. By default, denmark font doesn't
# come with CentOS distribution so create a symbolic link (from the
# one we have inside repository) to make it available if it isn't yet.
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

function prepare_forUsingPathFonts {

    # Define variables as local to avoid conflicts outside.
    local -a REPODIRS
    local -a REPOFILES
    local -a REPOLINKS

    # Define font related directories.
    REPODIRS[0]=/home/centos/.fonts
    REPODIRS[1]=/home/centos/artwork/trunk/Identity/Fonts/Ttf

    # Define font related files.
    REPOFILES=${REPODIRS[0]}/denmark.ttf

    # Define font related symbolic links.
    REPOLINKS=${REPODIRS[1]}/denmark.ttf

    # Check defined directories, files, and symbolic links.
    cli_checkFiles "${REPODIRS[@]}" 
    cli_checkFiles "${REPOFILES[@]}"
    cli_checkFiles "${REPOLINKS[@]}"

}
