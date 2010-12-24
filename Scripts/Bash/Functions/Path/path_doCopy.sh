#!/bin/bash
#
# path_doCopy.sh -- This function duplicates files inside the working
# copy using subversion commands.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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
# $Id$
# ----------------------------------------------------------------------

function path_doCopy {

    local -a SRC
    local -a DST
    local COUNT=0
 
    # Define source locations.
    SRC[0]=$SOURCE
    SRC[1]=$(cli_getRepoDirParallel ${SRC[0]} "$(cli_getRepoTLDir)/Manuals/$(cli_getCurrentLocale)/Texinfo/Repository/$(cli_getRepoTLDir '--basename')").texi
    SRC[2]=$(cli_getRepoDirParallel ${SRC[0]} "$(cli_getRepoTLDir)/Scripts/Bash/Functions/Render/Config")
    SRC[3]=$(cli_getRepoDirParallel ${SRC[0]} "$(cli_getRepoTLDir)/Translations")

    # Define target locations.
    DST[0]=$TARGET
    DST[1]=$(cli_getRepoDirParallel ${DST[0]} "$(cli_getRepoTLDir)/Manuals/$(cli_getCurrentLocale)/Texinfo/Repository/$(cli_getRepoTLDir '--basename')").texi
    DST[2]=$(cli_getRepoDirParallel ${DST[0]} "$(cli_getRepoTLDir)/Scripts/Bash/Functions/Render/Config")
    DST[3]=$(cli_getRepoDirParallel ${DST[0]} "$(cli_getRepoTLDir)/Translations")

    # Syncronize changes between working copy and central repository.
    cli_commitRepoChanges "${SRC[@]} ${DST[@]}"

    # Output entries affected by action.
    cli_printMessage "`ngettext "The following entry will be created:" \
        "The following entries will be created:" \
        "${#DST[*]}"`"
    while [[ $COUNT -lt ${#SRC[*]} ]];do
        cli_printMessage "${DST[$COUNT]}" 'AsResponseLine'
        COUNT=$(($COUNT + 1))
    done

    # Request confirmation to perform action.
    cli_printMessage "`gettext "Do you want to continue?"`" 'AsYesOrNoRequestLine'

    # Reset counter.
    COUNT=0

    # Perform action.
    while [[ $COUNT -lt ${#SRC[*]} ]];do

        cli_printMessage ${DST[$COUNT]} 'AsCreatingLine'

        # Verify repository entry. We cannot duplicate an entry if its
        # parent directory doesn't exist as entry inside the working
        # copy.
        if [[ -f ${SRC[$COUNT]} ]];then
            if [[ -d $(dirname ${SRC[$COUNT]}) ]];then
                if [[ ! -d $(dirname ${DST[$COUNT]}) ]];then
                    mkdir -p $(dirname ${DST[$COUNT]})
                    svn add $(dirname ${DST[$COUNT]}) --quiet
                fi
            fi
        elif [[ -d ${SRC[$COUNT]} ]];then
            if [[ -d ${DST[$COUNT]} ]];then
                cli_printMessage "`gettext "cannot create "` \`${DST[$COUNT]}': `gettext "Directory already exists."`" 'AsErrorLine'
                cli_printMessage "$(caller)" 'AsToKnowMoreLine'
            fi
        fi

        # Copy using subversion command.
        svn copy ${SRC[$COUNT]} ${DST[$COUNT]} --quiet

        # Increase counter.
        COUNT=$(($COUNT + 1))

    done

    # Update documentation chapter, menu and nodes inside Texinfo
    # documentation structure.
    . ~/bin/centos-art manual --update-structure=${DST[0]}

    # Syncronize changes between working copy and central repository.
    cli_commitRepoChanges "${DST[@]}"

}
