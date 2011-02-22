#!/bin/bash
#
# manual_getActions.sh -- This function interpretes arguments passed
# to `manual' functionality and calls actions accordingly.
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

function manual_getActions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="read:,search:,edit:,delete:,update:,copy:,to:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            --read )
                ACTIONVAL="$2"
                ACTIONNAM="${FUNCNAM}_searchNode"
                shift 2
                ;;

            --search )
                ACTIONVAL="$2"
                ACTIONNAM="${FUNCNAM}_searchIndex"
                shift 2
                ;;
    
            --edit )
                ACTIONVAL="$2"
                ACTIONNAM="${FUNCNAM}_editEntry"
                shift 2
                ;;
    
            --delete )
                ACTIONVAL="$2"
                ACTIONNAM="${FUNCNAM}_deleteEntry"
                shift 2
                ;;
    
            --update )
                ACTIONVAL="$2"
                ACTIONNAM="${FUNCNAM}_updateOutputFiles"
                shift 2
                ;;
    
            --copy )
                ACTIONVAL="$2"
                ACTIONNAM="${FUNCNAM}_copyEntry"
                shift 2
                ;;

            --to )
                FLAG_TO="$2"
                shift 2
                ;;

            * )
                # Break options loop.
                break
        esac
    done

    # Check action value passed through the command-line using source
    # directory definition as reference.
    cli_checkRepoDirSource

    # Define documentation entry.
    ENTRY=$(manual_getEntry)

    # Define directory for documentation manual. This is the place the
    # specific documentation manual we are working with is stored in.
    MANUAL_DIR=$(echo $ENTRY | cut -d / -f-7)

    # Define directory to store documentation entries.  At this point,
    # we need to take a desition about documentation design, in order
    # to answer the question: How do we assign chapters, sections and
    # subsections automatically, based on the repository structure?
    # and also, how such design could be adapted to changes in the
    # repository structure?
    #
    # One solution would be: represent the repository's first level
    # structure in three chapters only (i.e., trunk, branches, and
    # tags) and handle everything else inside them as sections. Sub
    # and subsub section will not have their own files, they will be
    # written inside section files instead.
    MANUAL_DIR_CHAPTER=$(echo $ENTRY | cut -d / -f-8)

    # Define chapter name for the documentation entry we are working
    # with.
    MANUAL_CHA_NAME=$(basename "$MANUAL_DIR_CHAPTER")

    # Define base name for documentation manual files. This is the
    # main file name used to build texinfo related files (.info, .pdf,
    # .xml, etc.).
    MANUAL_BASEFILE=$(echo $ENTRY | cut -d / -f-7)
    MANUAL_BASEFILE=${MANUAL_BASEFILE}/$(cli_getRepoName "${MANUAL_BASEFILE}" 'f')

    # Syncronize changes between the working copy and the central
    # repository to bring down changes.
    cli_commitRepoChanges ${MANUAL_DIR}

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Syncronize changes between the working copy and the central
    # repository to commit up changes.
    cli_commitRepoChanges ${MANUAL_DIR}

}
