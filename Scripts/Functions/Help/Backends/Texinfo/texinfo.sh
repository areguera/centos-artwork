#!/bin/bash
#
# texinfo.sh -- This function redefines backend-specific variables.
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
    
function texinfo {

    # Define documentation entry.
    ENTRY=$(${FLAG_BACKEND}_getEntry)

    # Define directory to store documentation entries.
    MANUAL_CHAPTER_DIR=$(${FLAG_BACKEND}_getChapterDir "$ENTRY")

    # Define chapter name for documentation entry we're working with.
    MANUAL_CHAPTER_NAME=$(basename "$MANUAL_CHAPTER_DIR")

    # Define documentation entry directory. This is the directory
    # where the entry file is stored.  When the file extension be
    # removed, consider that several backends could be used.
    ENTRY_DIR=$(dirname ${ENTRY} | sed -r "s/\.${FLAG_BACKEND}$//")

    # Define documentation entry file (without extension).
    ENTRY_FILE=$(basename ${ENTRY} | sed -r "s/\.${FLAG_BACKEND}$//")

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncroRepoChanges ${MANUAL_CHAPTER_DIR}

    # Verify action name against the file ought to be initialized
    # from. If the file exists it is very sure that it has been
    # already initialized, so execute the action name. Otherwise, if
    # the file doesn't exist, print an error message. It is not
    # possible to execute a function which definition hasn't been
    # initialized.
    if [[ -f ${FUNCDIR}/${FUNCDIRNAM}/${ACTIONNAM}.sh  ]];then
        $ACTIONNAM 
    else
        cli_printMessage "`gettext "A valid action is required."`" --as-error-line 
    fi

    # Commit changes from working copy to central repository only.  At
    # this point, changes in the repository are not merged in the
    # working copy, but chages in the working copy do are committed up
    # to repository.
    cli_commitRepoChanges ${MANUAL_CHAPTER_DIR}

}
