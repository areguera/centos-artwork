#!/bin/bash
#
# prepare_pathToFonts.sh -- This function checks user's fonts
# directory. In order for some artworks to be rendered correctly,
# denmark font needs to be available. By default, denmark font doesn't
# come with CentOS distribution so create a symbolic link (from the
# one we have inside repository) to make it available if it isn't yet.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
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

function prepare_pathToFonts {

    # Define variables as local to avoid conflicts outside.
    local -a REPODIRS
    local -a REPOFILES
    local -a REPOLINKS
    local FILE=''

    # Define font related directories.
    REPODIRS[0]=${HOME}/.fonts
    REPODIRS[1]=$(cli_getRepoTLDir)/Identity/Fonts/Ttf

    # Define font related files.
    REPOFILES[0]=${REPODIRS[1]}/denmark.ttf

    # Define font related symbolic links.
    REPOLINKS[0]=${REPODIRS[0]}/denmark.ttf

    # Check defined directories.
    for FILE in "${REPODIRS[@]}";do
        cli_checkFiles $FILE 'd'
    done

    # Check defined files.
    for FILE in "${REPOFILES[@]}";do
        cli_checkFiles $FILE 'f'
    done

    # Check defined symbolic links.
    for FILE in "${REPOLINKS[@]}";do
        cli_checkFiles $FILE 'h'
    done

}
