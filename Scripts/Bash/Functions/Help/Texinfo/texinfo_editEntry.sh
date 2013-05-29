#!/bin/bash
#
# texinfo_editEntry.sh -- This function implements the edition flow of
# documentation entries inside the working copy.
#
# Copyright (C) 2009-2013 The CentOS Project
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

    # Verify section definition inside chapters. 
    if [[ ! -f $MANUAL_ENTRY ]];then

        # Verify chapter related to documentation entry. Inside
        # manuals, all documentation entries are stored directly under
        # its chapter directory. There is no more levels deep so it is
        # possible to perform a direct chapter verification here.
        if [[ ! -a $(dirname $MANUAL_ENTRY).${MANUAL_EXTENSION} ]];then
            texinfo_createChapter
        fi

        # Print confirmation question. 
        cli_printMessage "`gettext "The following documentation section doesn't exist:"`" --as-stdout-line
        cli_printMessage "$MANUAL_ENTRY" --as-response-line
        cli_printMessage "`gettext "Do you want to create it now?"`" --as-yesornorequest-line

        # Print action message.
        cli_printMessage "$MANUAL_ENTRY" --as-updating-line

        # Update section menu, nodes and cross references based on
        # changes in order for manual structure to remain consistent.
        texinfo_updateStructureSection "$MANUAL_ENTRY"

        # Use default text editor to write changes on documentation entry.
        $EDITOR $MANUAL_ENTRY

    else

        # Print action message.
        cli_printMessage "$MANUAL_ENTRY" --as-updating-line

        # Rebuild section menu definitions before editing the
        # documentation entry. This way, if there is any change in the
        # section menu definition, it will be visible to you on
        # edition.
        texinfo_makeSeeAlso "$MANUAL_ENTRY"

        # Use default text editor to write changes on documentation entry.
        $EDITOR $MANUAL_ENTRY

        # Rebuild section menu definitions after editing the
        # documentation entry. This way, if there is any change or
        # expansion to realize in the section menu definition, it be
        # applied right now. Don't see a reason for waiting until the
        # next edition for expansions to happen.
        texinfo_makeSeeAlso "$MANUAL_ENTRY"

    fi

    # Rebuild output files to propagate recent changes, if any.
    texinfo_updateOutputFiles

}
