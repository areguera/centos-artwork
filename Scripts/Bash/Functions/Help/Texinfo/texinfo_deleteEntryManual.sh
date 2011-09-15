#!/bin/bash
#
# texinfo_deleteEntryManual.sh -- This function standardized manual
# deletion inside the working copy.
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

function texinfo_deleteEntryManual {

    # Print action message.
    cli_printMessage "$MANUAL_ENTRY" --as-deleting-line

    # Verify existence of documentation entry before deleting it. We
    # cannot delete an entry which doesn't exist.
    cli_checkFiles "$MANUAL_ENTRY"

    # Revert pending changes before deleting.
    svn revert ${MANUAL_BASEDIR_L10N} --quiet --recursive

    # Remove locale-specific documentation manual directory from the
    # working copy. Using subversion to register the change. Be sure
    # that related output files are removed too.
    svn del ${MANUAL_BASEDIR_L10N} --quiet --force

    # Verify manual base directory. When the locale-specific
    # documentaion manual is the last one inside the manual base
    # directory, remove the manual base directory from the working
    # copy.  There is no need to have an empty manual base directories
    # inside the working copy.
    if [[ $(ls -1 $MANUAL_BASEDIR | wc -l) -le 1 ]];then

        # Remove manual base directory.
        svn del ${MANUAL_BASEDIR} --quiet --force

        # Redefine absolute paths to changed directory.  This is
        # required in order for `cli_commitRepoChanges' to be aware
        # that we are deleting MANUAL_BASEDIR, not
        # MANUAL_BASEDIR_L10N.
        MANUAL_CHANGED_DIRS="${MANUAL_BASEDIR}"

    fi

}
