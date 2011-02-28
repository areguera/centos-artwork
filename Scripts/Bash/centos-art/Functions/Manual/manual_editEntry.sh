#!/bin/bash
#
# manual_editEntry.sh -- This function implements the edition flow of
# documentation entries inside the working copy.
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

function manual_editEntry {

    # Verify definition of manual chapters. Definition of manual
    # chapters sets how many chapters does the manual has and the
    # directory and file structure required to make them active part
    # of a texinfo manual.
    if [[ ! -d $MANUAL_CHAPTER_DIR ]];then

        # Print confirmation question.
        cli_printMessage "`gettext "The following documentation chapter will be created:"`"
        cli_printMessage "$MANUAL_CHAPTER_DIR" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

        # Update manual chapter related files.
        manual_updateChaptersFiles

        # Update manual chapter related menu.
        manual_updateChaptersMenu

        # Update manual chapter related nodes (based on chapter
        # related menu).
        manual_updateChaptersNodes

    fi

    # Verify definition of chapter sections. Definition of chapter
    # sections sets how many sections does each chapter, inside the
    # manual, has.
    if [[ ! -f $ENTRY ]];then

        # Print confirmation question. 
        cli_printMessage "`gettext "The following documentation section will be created:"`"
        cli_printMessage "$ENTRY" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

        # Print action message.
        cli_printMessage "$ENTRY" 'AsCreatingLine'

        # Update chapter section related menu.
        manual_updateMenu

        # Update chapter section related nodes (based on chapter
        # section related menu).
        manual_updateNodes

        # Update old missing cross references. If for some reason a
        # documentation entry is removed by mistake, and that mistake
        # is fixing by adding the removed documentation entry back
        # into the repository, rebuild the missing cross reference
        # message to use the correct link to the documentation
        # section.
        manual_restoreCrossReferences

    else

        # Print action message.
        cli_printMessage "$ENTRY" 'AsUpdatingLine'

    fi

    # Use default text editor to edit the documentation entry.
    eval $EDITOR $ENTRY

    # Print separator line.
    cli_printMessage '-' 'AsSeparatorLine'

    # Rebuild output files to propagate recent changes.
    manual_updateOutputFiles

}
