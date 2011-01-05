#!/bin/bash
#
# verify_pathToCli.sh -- This function 
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

function verify_pathToCli  {

    # Define variables as local to avoid conflicts outside.
    local -a REPODIRS
    local -a REPOFILES
    local -a REPOLINKS
    local FILE=''

    # Define directories required by the centos-art.sh script command
    # line interface. 
    REPODIRS[0]=/home/centos
    REPODIRS[1]=/home/centos/bin
    REPODIRS[2]=/home/centos/artwork/trunk/Scripts/Bash

    # Define files required by the centos-art.sh script command line
    # interface.
    REPOFILES[0]=${REPODIRS[2]}/centos-art.sh

    # Define symbolic links required by the centos-art.sh script
    # command line interface.
    REPOLINKS[0]=${REPODIRS[1]}/centos-art

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
