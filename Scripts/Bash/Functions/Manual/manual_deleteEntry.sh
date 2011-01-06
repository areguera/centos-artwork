#!/bin/bash
#
# manual_deleteEntry.sh -- This function removes a documentation entry
# from your working copy documentation structure.
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

function manual_deleteEntry {

    # Define variables as local to avoid conflicts outside.
    local ENTRIES=''
    local LOCATION=''

    # Check if the entry has been already removed.
    cli_checkFiles $ENTRY 'f'

    # Define entries. Start with the one being processed currently.
    ENTRIES=$ENTRY

    # Define root location to look for entries.
    LOCATION=$(echo $ENTRY | sed -r 's!\.texi$!!')

    # Redefine location to match the chapter's root directory. This
    # applies when you try to remove the whole chapter from the
    # working copy (e.g., centos-art manual --delete=/home/centos/artwork/trunk/).
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
        done
    fi

    # Remove duplicated lines from entries list.
    ENTRIES=$(echo "$ENTRIES" | tr ' ' "\n" | sort -r | uniq)

    # Print action preamble.
    cli_printActionPreamble "$ENTRIES" 'doDelete' 'AsResponseLine'

    # Redefine ENTRY using affected entries as reference.
    for ENTRY in $ENTRIES;do

        # Verify entry inside the working copy. 
        if [[ $(cli_getRepoStatus "$ENTRY") =~ '^( |\?)' ]];then

            # Print action message.
            cli_printMessage "$ENTRY" "AsDeletingLine"

        else

            # Do not remove a versioned documentation entry with
            # changes inside. Print a message about it and stop script
            # execution instead.
            cli_printMessage "`gettext "There are pendent changes that need to be committed first."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'

        fi

        # Remove documentation entry. At this point, documentation
        # entry can be under version control or not versioned at all.
        # Here we need to decide how to remove documentation entries
        # based on wether they are under version control or not.
        if [[ "$(cli_getRepoStatus "$ENTRY")" == ' ' ]];then

            # Documentation entry is under version control and there
            # is no change to be commited up to central repository. We
            # are safe to schedule it for deletion.
            svn del "$ENTRY" --quiet

        elif [[ "$(cli_getRepoStatus "$ENTRY")" == '?' ]];then

            # Documentation entry is not under version control, so we
            # don't care about changes inside it. If you say
            # centos-art.sh script to remove an unversion
            # documentation entry it will do so, using convenctional
            # `rm' command.
            rm -r "$ENTRY"

        fi

        # Remove entry on section's menu and nodes to reflect the
        # fact that documentation entry has been removed.
        manual_updateMenu "remove-entry"
        manual_updateNodes

        # Remove entry cross references from documentation manual.
        manual_deleteCrossReferences

    done
 
    # Update chapter's menu and nodes in the master texinfo document.
    # This is mainly applied when one of the chapters (e.g., trunk/,
    # tags/, or branches/) is removed.
    if [[ ! -d $ENTRYCHAPTER ]];then
        manual_updateChaptersMenu 'remove-entry'
        manual_updateChaptersNodes
    fi

}
