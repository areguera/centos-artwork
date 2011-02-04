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

    # Verify language layout.
    manual_checkLanguageLayout

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="read:,search:,edit:,delete:,update,copy:,to:,quiet,yes"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            --read )

                # Define action value passed through the command-line.
                ACTIONVAL="$2"

                # Define action name using action value as reference.
                ACTIONNAM="${FUNCNAM}_searchNode"

                # Rotate positional parameters.
                shift 2
                ;;

            --search )

                # Define action value passed through the command-line.
                ACTIONVAL="$2"

                # Define action name using action value as reference.
                ACTIONNAM="${FUNCNAM}_searchIndex"

                # Rotate positional parameters.
                shift 2
                ;;
    
            --edit )

                # Define action value passed through the command-line.
                ACTIONVAL="$2"

                # Define action name using action value as reference.
                ACTIONNAM="${FUNCNAM}_editEntry"

                # Rotate positional parameters.
                shift 2
                ;;
    
            --delete )

                # Define action value passed through the command-line.
                ACTIONVAL="$2"

                # Define action name.
                ACTIONNAM="${FUNCNAM}_deleteEntry"

                # Rotate positional parameters.
                shift 2
                ;;
    
            --update )

                # Execute action name. There is no need of action
                # value here, so let's execute the action right now.
                manual_updateOutputFiles

                # End script execution flow. There is nothing else to
                # do after updating documentation output.
                exit
                ;;
    
            --copy )

                # Define action value passed through the command-line.
                ACTIONVAL="$2"

                # Define action name using action value as reference.
                ACTIONNAM="${FUNCNAM}_copyEntry"

                # Rotate positional parameters.
                shift 2
                ;;

            --to )
                
                # Redefine target flag.
                FLAG_TO="$2"

                # Rotate positional parameters.
                shift 2
                ;;

            --quiet )
                
                # Redefine target flag.
                FLAG_QUIET='true'

                # Rotate positional parameters.
                shift 1
                ;;

            --yes )
                
                # Redefine target flag.
                FLAG_YES='true'

                # Rotate positional parameters.
                shift 1
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

    # Define directory used to store chapter's documentation entries.
    # At this point, we need to take a desition about
    # documentation-design, in order to answer the question: How do we
    # assign chapters, sections and subsections automatically, based
    # on the repository structure? 
    #
    # One solution would be: to use three chapters only to represent
    # the repository's first level structure (i.e., trunk,
    # branches, and tags) and handle everything else as sections. Sub
    # and subsub section will not have their own files, they will be
    # written inside section files instead.
    ENTRYCHAPTER=$(echo $ENTRY | cut -d / -f-10)

    # Define chapter name for this documentation entry.
    CHAPTERNAME=$(basename "$ENTRYCHAPTER")

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
