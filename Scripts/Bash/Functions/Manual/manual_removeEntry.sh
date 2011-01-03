#!/bin/bash
#
# manual_removeEntry.sh -- This function removes a documentation entry
# from your working copy documentation structure.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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

function manual_removeEntry {

    # Define variables as local to avoid conflicts outside.
    local ENTRIES=''
    local ENTRIES_COUNTER=1
    local LOCATION=''

    # Check changes in the working copy.
    cli_commitRepoChanges "$ENTRY"

    # Check if the entry has been already removed.
    if [[ ! -f $ENTRY ]];then
        cli_printMessage "`eval_gettext "The entry \\\`\\\$ENTRY' doesn't exist."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Define entries. Start with the one being processed currently.
    ENTRIES=$ENTRY

    # Define root location to look for entries.
    LOCATION=$(echo $ENTRY | sed -r 's!\.texi$!!')

    # Re-define location to match the chapter's root directory. This
    # applies when you try to remove the whole chapter from the
    # working copy (e.g., centos-art manual --remove=/home/centos/artwork/trunk/).
    if [[ $ENTRY =~ "${MANUALS_FILE[7]}$" ]];then
        LOCATION=$(dirname $ENTRY)
    fi

    # Look for dependent entries. In this context, dependent entries
    # are all files ending in .texi which have a directory name that
    # matches the file name (without .texi extension) of the entry
    # being processed currently. See LOCATION default definition
    # above.  If location directory doesn't exist it is probably
    # because there is no dependent entries.
    if [[ -d $LOCATION ]];then
        for ENTRY in $(find $LOCATION -name '*.texi');do
            ENTRIES="$ENTRIES $ENTRY $(dirname $ENTRY)"
            ENTRIES_COUNTER=$(($ENTRIES_COUNTER + 1))
        done
    fi

    # Remove duplicated lines from entries list.
    ENTRIES=$(echo "$ENTRIES" | tr ' ' "\n" | sort -r | uniq)

    # Show a verification message before doing anything.
    cli_printMessage "`ngettext "The following entry will be deleted" \
        "The following entries will be deleted" $ENTRIES_COUNTER`:"
 
    # Show list of affected entries.
    for ENTRY in $ENTRIES;do
        cli_printMessage "$ENTRY" "AsResponseLine"
    done

    cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

    # Re-define ENTRY using affected entries as reference.
    for ENTRY in $ENTRIES;do

        # Show which entry is being removed.
        cli_printMessage "$ENTRY" "AsDeletingLine"

        # Remove documentation entry. At this point, documentation
        # entry can be under version control or not versioned at all.
        # Here we need to decide how to remove documentation entries
        # based on whether they are under version control or not.
        if [[ "$(cli_getRepoStatus "$ENTRY")" == ' ' ]];then

            # Documentation entry is under version control and clean
            # of changes. Only if documentation entry is clean of
            # changes we can mark it for deletion. So use subversion's
            # `del' command to do so.
            svn del "$ENTRY" --quiet

        elif [[ "$(cli_getRepoStatus "$ENTRY")" == '?' ]];then

            # Documentation entry is not under version control, so we
            # don't care about changes inside unversioned
            # documentation entries at all. If you say centos-art.sh
            # script to remove an unversion documentation entry it
            # will do so, using convenctional `rm' command.
            if [[ -d "$ENTRY" ]];then
                rm -r "$ENTRY"
            else
                rm "$ENTRY"
            fi

        else

            # Documentation entry is under version control and it does
            # have changes. We don't remove a versioned documentation
            # entry with changes. So print a message about it and stop
            # script execution.
            cli_printMessage "`eval_gettext "The entry \\\`\\\$ENTRY' cannot be deleted."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'

        fi

        # Remove entry on section's menu and nodes to reflect the
        # fact that documentation entry has been removed.
        manual_updateMenu "remove-entry"
        manual_updateNodes

        # Remove entry cross references from documentation manual.
        manual_removeCrossReferences

    done
 
    # Update chapter's menu and nodes in the master texinfo document.
    # This is mainly applied when one of the chapters (e.g., trunk/,
    # tags/, or branches/) is removed.
    if [[ ! -d $ENTRYCHAPTER ]];then
        manual_updateChaptersMenu 'remove-entry'
        manual_updateChaptersNodes
    fi

    # Update manuals' related output files.
    manual_updateOutputFiles

}
