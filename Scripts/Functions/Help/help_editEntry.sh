#!/bin/bash
#
# texinfo_editEntry.sh -- This function implements the edition flow of
# documentation entries inside the working copy.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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

function texinfo_editEntry {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Verify section definition inside chapters. 
    if [[ ! -f $MANUAL_ENTRY ]];then

        # Verify the parent directory of documentation entry. If the
        # parent directory of the current documentation entry doesn't
        # exist, create it and be sure it is added to version control.
        # Also, verify that the parent directory of the documentation
        # entry can be created. Otherwise, stop script execution with
        # an error for the user to be aware of it.
        if [[ ! -d $(dirname $(dirname $MANUAL_ENTRY)) ]];then
            cli_printMessage "`gettext "The documentation entry provided hasn't a parent directory."`" --as-error-line
        elif [[ ! -d $(dirname $MANUAL_ENTRY) ]];then
            svn mkdir $(dirname ${MANUAL_ENTRY}) --quiet
        fi

        # Print confirmation question. 
        cli_printMessage "`gettext "The following documentation section will be created:"`"
        cli_printMessage "$MANUAL_ENTRY" --as-response-line
        cli_printMessage "`gettext "Do you want to continue?"`" --as-yesornorequest-line

        # Update chapter section related menu.
        ${FLAG_BACKEND}_updateMenu

        # Update chapter section related nodes (based on chapter
        # section related menu).
        ${FLAG_BACKEND}_updateNodes

        # Update old missing cross references. If for some reason a
        # documentation entry is removed by mistake, and that mistake
        # is fixing by adding the removed documentation entry back
        # into the repository, rebuild the missing cross reference
        # message to use the correct link to the documentation
        # section.
        ${FLAG_BACKEND}_restoreCrossReferences $MANUAL_ENTRY

    else

        # Print action message.
        cli_printMessage "$MANUAL_ENTRY" --as-updating-line

    fi

    # Use default text editor to edit the documentation entry.
    eval $EDITOR $MANUAL_ENTRY

}
