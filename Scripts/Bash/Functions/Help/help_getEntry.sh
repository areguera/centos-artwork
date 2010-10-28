#!/bin/bash
#
# help_getEntry.sh -- This function builds a documentation entry based
# on option value (OPTIONVAL) variable.
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

function help_getEntry {

    # Define variables as local to avoid conflicts outside.
    local DIR=''
    local FILE=''
    local ENTRY=''

    # Build directory for documenation entry.
    DIR=$(echo $OPTIONVAL | sed -r 's!^/home/centos/artwork/!!')
    DIR=$(dirname $DIR)
    DIR=${MANUALS_DIR[2]}/$DIR

    # Build file for documentation entry.
    FILE=$(basename $OPTIONVAL).texi

    # Combine both directory (DIR) and file (FILE) to build entry's
    # absolute path. When the entry's absolute path is built for the
    # current location, the string "." is returned by dirname and used
    # as current directory to store the .texi file.  This is not
    # desirable because we are using absolute path already and the "."
    # string adds another level in the path (e.g.,
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
