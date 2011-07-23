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

        # Verify chapter related to documentation entry. Inside
        # manuals, all documentation entries are stored directly under
        # its chapter directory. There is no more levels deep so it is
        # possible to perform a direct chapter verification here.
        if [[ ! -a $(dirname $MANUAL_ENTRY)/chapter.${MANUAL_EXTENSION} ]];then
            ${FLAG_BACKEND}_createChapter
        fi

        # Print confirmation question. 
        cli_printMessage "`gettext "The following documentation section will be created:"`"
        cli_printMessage "$MANUAL_ENTRY" --as-response-line
        cli_printMessage "`gettext "Do you want to continue?"`" --as-yesornorequest-line

        # Update section menu, nodes and cross references based on
        # changes in order for manual structure to remain cosistent.
        ${FLAG_BACKEND}_updateStructureSection "$MANUAL_ENTRY"

    else

        # Print action message.
        cli_printMessage "$MANUAL_ENTRY" --as-updating-line

        # Rebuild section menu definitions before editing the
        # documentation entry. This way, if there is any change in the
        # section menu definition, it will be visible to you on
        # edition.
        ${FLAG_BACKEND}_makeSeeAlso "$MANUAL_ENTRY"

    fi

    # Use default text editor to write changes on documentation entry.
    $EDITOR $MANUAL_ENTRY

}
