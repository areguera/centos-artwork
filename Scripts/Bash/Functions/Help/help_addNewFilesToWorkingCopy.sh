#!/bin/bash
#
# help_addNewFilesToWorkingCopy.sh -- This function looks for files
# under the root documentation structure that are not versioned and
# adds them to the working copy under version control.
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

function help_addNewFilesToWorkingCopy {

    local LOCATION=$1

    # Restrict files addition to your working copy only.
    if [[ ! $LOCATION =~ '^/home/centos/artwork/' ]];then
        cli_printMessage "`gettext "Only files under /home/centos/artwork please."`"
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Update your working copy first.
    svn update $LOCATION --quiet

    # Add new files to your working copy.
    for FILE in $(svn status $LOCATION | egrep '^\?' | cut -d ' ' -f7);do
        svn add $FILE --quiet
    done

}
