#!/bin/bash
#
# manual_getEntry.sh -- This function builds a documentation entry based
# on a location specified. Location specification can be both action
# value (ACTIONVAL) variable or a value passed as first positional
# parameter.
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

function manual_getEntry {

    # Define variables as local to avoid conflicts outside.
    local DIR=''
    local FILE=''
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

    # Build directory to store documenation entry.
    DIR=$(echo $LOCATION | sed -r 's!^/home/centos/artwork/!!')
    DIR=$(dirname "$DIR")
    DIR=${MANUALS_DIR[2]}/$DIR

    # Build file for documentation entry. Notice that directory
    # structure convenction is not used here through cli_getRepoName.
    # This is because documentation structures mirror other directory
    # structures inside the repository. So, if we are documenting
    # trunk/Identity/Brands/ directory we don't want to have the
    # trunk/Identity/brands.texi documentation entry, but
    # trunk/Identity/Brands.texi in order to reflect the fact that we
    # are documenting a directory structure. Something similar occurs
    # with files, but using repository file convenction instead. This
    # way we just use basename to find out the last component in the
    # path without sanitation. We assume it has been already
    # sanitated.
    FILE=$(basename "$LOCATION").texi

    # Combine both directory (DIR) and file (FILE) to build entry's
    # absolute path. When the entry's absolute path is built for the
    # current location, the string "." is returned by cli_getRepoName
    # and used as current directory to store the .texi file.  This is
    # not desirable because we are using absolute path already and the
    # "." string adds another level in the path (e.g.,
    # /home/centos/artwork/trunk/Manuals/Texinfo/en/./trunk/chapter.texi).
    # This extra level in the path confuses the script when it tries
    # to find out where the chapter's directory is. In the example
    # above, the chapter's directory is "trunk/" not "./". So, remove
    # the string './' from entry's absolute path in order to build the
    # entry's absolute path correctly.
    ENTRY=$(echo $DIR/$FILE | sed -r 's!\./!!')

    # Re-define documentation entry if it is the chapter entry.
    # TODO: automate the verification, in order to accept any other
    # structure in the first level.
    if [[ $ENTRY =~ "(trunk|branches|tags)\.texi$" ]];then
        ENTRY=$(echo $ENTRY \
            | sed -r "s/(trunk|branches|tags)\.texi$/\1\/${MANUALS_FILE[7]}/")
    fi

    # Output entry's absolute path.
    echo $ENTRY

}
