#!/bin/bash
#
# docbook_editEntry.sh -- This function standardizes the way
# documentation entries are edited inside docbook repository
# documentation manual.
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
# $Id: docbook_editEntry.sh 2946 2011-05-26 23:30:00Z al $
# ----------------------------------------------------------------------

function docbook_editEntry {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Verify chapter definition inside manual.
    if [[ ! -d $MANUAL_CHAPTER_DIR ]];then

        # Print confirmation question.
        cli_printMessage "`gettext "The following documentation chapter will be created:"`"
        cli_printMessage "$MANUAL_CHAPTER_DIR" --as-response-line
        cli_printMessage "`gettext "Do you want to continue?"`" --as-yesornorequest-line

        # Update manual chapter related files.
        #docbook_updateChaptersFiles

        # Update manual chapter related menu.
        #docbook_updateChaptersMenu

        # Update manual chapter related nodes (based on chapter
        # related menu).
        #docbook_updateChaptersNodes

    fi

    # Verify section definition inside chapters. 
    if [[ ! -f $MANUAL_ENTRY ]];then

        # Print confirmation question. 
        cli_printMessage "`gettext "The following documentation section will be created:"`"
        cli_printMessage "$MANUAL_ENTRY" --as-response-line
        cli_printMessage "`gettext "Do you want to continue?"`" --as-yesornorequest-line

        # Update chapter section related menu.
        #docbook_updateMenu

        # Update chapter section related nodes (based on chapter
        # section related menu).
        #docbook_updateNodes

        # Update old missing cross references. If for some reason a
        # documentation entry is removed by mistake, and that mistake
        # is fixing by adding the removed documentation entry back
        # into the repository, rebuild the missing cross reference
        # message to use the correct link to the documentation
        # section.
        #docbook_restoreCrossReferences

    else

        # Print action message.
        cli_printMessage "$MANUAL_ENTRY" --as-updating-line

    fi

    # Use default text editor to edit the documentation entry.
    eval $EDITOR $MANUAL_ENTRY

    # Rebuild output files to propagate recent changes.
    docbook_updateOutputFiles

}
