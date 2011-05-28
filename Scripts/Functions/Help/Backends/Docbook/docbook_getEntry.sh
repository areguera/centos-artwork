#!/bin/bash
#
# docbook_getEntry.sh -- This function builds a documentation entry
# based on a location specified. Location specification can be both
# action value (ACTIONVAL) variable or a value passed as first
# positional parameter.
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

function docbook_getEntry {

    # Define variables as local to avoid conflicts outside.
    local ENTRY=''
    local LOCATION=''

    # Redefine location in order to make this function reusable not
    # just for action value variable but whatever value passed as
    # first possitional argument.
    if [[ "$1" != '' ]];then
        LOCATION="$1"
    else
        LOCATION="$ACTIONVAL"
    fi

    # Define relative path of entry, from trunk directory on.
    ENTRY=$(echo $LOCATION | sed -r "s!^${HOME}/artwork/!!")

    # Verify the entry relative path to find out which documentation
    # manual we are acting on. As convenction, whatever documentation
    # entry you provide outside trunk/Manuals/ directory structure is
    # considered as you are documenting the repository directory
    # structure. Otherwise, if an entry inside trunk/Manuals/ is
    # provided, the directory structure provided is used as default
    # documentation manual.
    if [[ ${ENTRY} =~ "\.docbook$" ]];then
        ENTRY=$(echo ${ENTRY} | sed 's!trunk/Manuals/Docbook/!!')
    else
        ENTRY=$(dirname Entities/Repository/Directories/${ENTRY})/$(basename $LOCATION).docbook
    fi

    # Re-define entry to set absolute path to manuals base directory
    # structure.
    ENTRY=${MANUAL_BASEDIR}/${ENTRY}

    # Output entry's absolute path.
    echo ${ENTRY}

}
