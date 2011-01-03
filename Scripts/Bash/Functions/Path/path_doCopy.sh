#!/bin/bash
#
# path_doCopy.sh -- This function duplicates files inside the working
# copy using subversion commands.
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

function path_doCopy {

    local -a SRC
    local -a DST
    local -a DOC
    local COUNT=0

    # Verify target variable. We can't continue if target is empty.
    if [[ $TARGET == '' ]];then
        cli_printMessage "`gettext "There is no target to work with."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Define source locations. Start with parent directory at position
    # zero and continue with related parallel directories.
    SRC[0]=$ACTIONVAL
    SRC[1]=$(cli_getRepoDirParallel "${SRC[0]}" "$(cli_getRepoTLDir "${SRC[0]}")/Manuals/$(cli_getCurrentLocale)/Texinfo/Repository/$(cli_getRepoTLDir "${SRC[0]}" "--relative")").texi
    SRC[2]=$(cli_getRepoDirParallel "${SRC[0]}" "$(cli_getRepoTLDir "${SRC[0]}")/Scripts/Bash/Functions/Render/Config")
    SRC[3]=$(cli_getRepoDirParallel "${SRC[0]}" "$(cli_getRepoTLDir "${SRC[0]}")/Translations")

    # Define target locations. Start with parent directory at position
    # zero and continue with related parallel directories.
    DST[0]=$TARGET
    DST[1]=$(cli_getRepoDirParallel "${DST[0]}" "$(cli_getRepoTLDir "${DST[0]}")/Manuals/$(cli_getCurrentLocale)/Texinfo/Repository/$(cli_getRepoTLDir "${DST[0]}" "--relative")").texi
    DST[2]=$(cli_getRepoDirParallel "${DST[0]}" "$(cli_getRepoTLDir "${DST[0]}")/Scripts/Bash/Functions/Render/Config")
    DST[3]=$(cli_getRepoDirParallel "${DST[0]}" "$(cli_getRepoTLDir "${DST[0]}")/Translations")

    # Define documentation files that need to be counted inside
    # changes commited up to central repository.
    DOC[0]=/home/centos/artwork/trunk/Manuals/$(cli_getCurrentLocale)/Texinfo/Repository/$(cli_getRepoTLDir "${DST[0]}" '--relative')/chapter-menu.texi
    DOC[1]=/home/centos/artwork/trunk/Manuals/$(cli_getCurrentLocale)/Texinfo/Repository/$(cli_getRepoTLDir "${DST[0]}" '--relative')/chapter-nodes.texi

    # Syncronize changes between working copy and central repository.
    cli_commitRepoChanges "${SRC[@]} ${DST[@]} ${DOC[@]}"

    # Print preamble with affected entries.
    cli_printMessage "`ngettext "The following entry will be created" \
        "The following entries will be created" "${#DST[*]}"`"
    while [[ $COUNT -lt ${#DST[*]} ]];do
        # Print affected entry.
        cli_printMessage "${DST[$COUNT]}" 'AsResponseLine'
        # Increment counter.
        COUNT=$(($COUNT + 1))
    done

    # Request confirmation before continue with action.
    cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'

    # Reset counter.
    COUNT=0

    while [[ $COUNT -lt ${#DST[*]} ]];do

        # Verify relation between source and target locations. We
        # cannot duplicate an entry if its parent directory doesn't
        # exist as entry inside the working copy.
        if [[ -f ${SRC[$COUNT]} ]];then
            if [[ ! -d $(dirname ${DST[$COUNT]}) ]];then
                mkdir -p $(dirname ${DST[$COUNT]})
                svn add $(dirname ${DST[$COUNT]}) --quiet
            fi
        fi

        # Print action message.
        cli_printMessage "${DST[$COUNT]}" 'AsCreatingLine'

        # Perform action.
        svn copy ${SRC[$COUNT]} ${DST[$COUNT]} --quiet

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done 

    # Update texinfo documentation structure.
    . /home/centos/bin/centos-art manual --update-structure="${DST[0]}"

    # Syncronize changes between working copy and central repository.
    cli_commitRepoChanges "${SRC[@]} ${DST[@]} ${DOC[@]}"

}
