#!/bin/bash
#
# help_editEntry.sh -- This function implements the edition flow of
# documentation entries inside the working copy.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_editEntry {

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Verify chapter definition inside manual.
    if [[ ! -d $MANUAL_CHAPTER_DIR ]];then

        # Print confirmation question.
        cli_printMessage "`gettext "The following documentation chapter will be created:"`"
        cli_printMessage "$MANUAL_CHAPTER_DIR" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

        # Update manual chapter related files.
        help_updateChaptersFiles

        # Update manual chapter related menu.
        help_updateChaptersMenu

        # Update manual chapter related nodes (based on chapter
        # related menu).
        help_updateChaptersNodes

    fi

    # Verify section definition inside chapters. 
    if [[ ! -f $ENTRY ]];then

        # Print confirmation question. 
        cli_printMessage "`gettext "The following documentation section will be created:"`"
        cli_printMessage "$ENTRY" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

        # Update chapter section related menu.
        help_updateMenu

        # Update chapter section related nodes (based on chapter
        # section related menu).
        help_updateNodes

        # Update old missing cross references. If for some reason a
        # documentation entry is removed by mistake, and that mistake
        # is fixing by adding the removed documentation entry back
        # into the repository, rebuild the missing cross reference
        # message to use the correct link to the documentation
        # section.
        help_restoreCrossReferences

    else

        # Print action message.
        cli_printMessage "$ENTRY" 'AsUpdatingLine'

    fi

    # Use default text editor to edit the documentation entry.
    eval $EDITOR $ENTRY

    # Rebuild output files to propagate recent changes.
    help_updateOutputFiles

}
