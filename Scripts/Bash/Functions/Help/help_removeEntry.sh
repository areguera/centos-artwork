#!/bin/bash
#
# help_removeEntry.sh -- This function removes a documentation entry
# from your working copy documentation structure.
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
# $Id: help_removeEntry.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function help_removeEntry {

    # Define variables as local to avoid conflicts outside.
    local ENTRIES=''
    local ENTRIES_COUNTER=0
    local LOCATION=''

    # Check if the entry has been already removed.
    if [[ ! -f $ENTRY ]];then
        cli_printMessage "`gettext "The following entry doesn't exist:"`"
        cli_printMessage "$ENTRY" "AsResponseLine"
        cli_printMessage "trunk/Scripts/Bash/Functions/Help --filter='help_removeEntry.sh" "AsToKnowMoreLine"
    fi

    # Define entries. Start with the one being processed currently.
    ENTRIES=$ENTRY

    # Define root location to look for entries.
    LOCATION=$(echo $ENTRY | sed -r 's!\.texi$!!')

    # Re-define location to match the chapter's root directory. This
    # applies when you try to remove the whole chapter from the
    # working copy (e.g., centos-art help --remove=/home/centos/artwork/trunk/).
    if [[ $ENTRY =~ "${MANUALS_FILE[7]}$" ]];then
        LOCATION=$(dirname $ENTRY)
    fi

    # Look for dependent entries. In this contest, dependent entries
    # are all files ending in .texi which have a directory name that
    # matches the file name (without .texi extension) of the entry
    # being processed currently. See LOCATION default definition
    # above.  If location directory doesn't exist is probably because
    # there is no dependent entries.
    if [[ -d $LOCATION ]];then
        for ENTRY in $(find $LOCATION -name '*.texi');do
            ENTRIES="$ENTRIES $ENTRY $(dirname $ENTRY)"
            ENTRIES_COUNTER=$(($ENTRIES_COUNTER + 1))
        done
    fi

    # Remove duplicated lines from entries list.
    ENTRIES=$(echo "$ENTRIES" | tr ' ' "\n" | sort -r | uniq)

    # Show a verification message before doing anything.
    cli_printMessage "`ngettext "The following entry will be removed:" \
                               "The following entries will be removed:" \
                               $ENTRIES_COUNTER`"
 
    # Show list of affected entries.
    for ENTRY in $ENTRIES;do
        cli_printMessage "$ENTRY" "AsResponseLine"
    done

    cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

    # Re-define ENTRY using affected entries as reference.
    for ENTRY in $ENTRIES;do

        # Show which entry is being removed.
        cli_printMessage "$ENTRY" "AsRemovingLine"

        # Try to remove it from working copy using subversion's
        # del command.
        eval svn del $ENTRY --force --quiet

    done
        
    # Update menu and nodes in order to produce output files
    # correctly.
    if [[ -d $ENTRYCHAPTER ]];then
        # At this point the chapter directory was not removed but
        # we need to update its menu and nodes to reflect the fact
        # that some documentation entries were removed inside it.
        help_updateMenu "remove-entry"
        help_updateNodes
    else
        # At this point the chapter directory and all its sections
        # were removed. Update the menu and nodes in the master
        # texinfo document to reflect that fact.
        help_updateChaptersMenu 'remove-entry'
        help_updateChaptersNodes
    fi

    # Update manuals' related output files.
    help_updateOutputFiles

}
