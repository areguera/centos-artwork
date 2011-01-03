#!/bin/bash
#
# path_getActions.sh -- This function interpretes arguments passed to
# `path' functionality and calls actions accordingly.
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
    
function path_getActions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="copy:,move:,delete:,to:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            --copy )

                # Define action value passed through the command-line.
                ACTIONVAL="$2"

                # Check action value passed through the command-line
                # using source directory definition as reference.
                cli_checkRepoDirSource

                # Define action name using action value as reference.
                ACTIONNAM="${FUNCNAM}_doCopy"

                # Look for related sub-options.
                while true; do
                    case "$3" in

                        --to )

                            # Redefine target directory.
                            TARGET="$4"

                            # Verify target directory.
                            cli_checkRepoDirTarget

                            # Rotate positional parameters.
                            shift 4
                            ;;

                        * )
                            # Break sub-options loop.
                            break
                            ;;
                    esac
                done

                # Break options loop.
                break
                ;;

            --move )

                # Define action value passed through the command-line.
                ACTIONVAL="$2"

                # Check action value passed through the command-line
                # using source directory definition as reference.
                cli_checkRepoDirSource

                # Define action name using action value as reference.
                ACTIONNAM="${FUNCNAM}_doMove"

                # Look for related sub-options.
                while true; do
                    case "$3" in

                        --to )

                            # Redefine target directory.
                            TARGET="$4"

                            # Verify target directory.
                            cli_checkRepoDirTarget

                            # Rotate positional parameters.
                            shift 4
                            ;;

                        * )
                            # Break sub-options loop.
                            break
                            ;;
                    esac
                done

                # Break options loop.
                break
                ;;

            --delete )

                # Define action value passed through the command-line.
                ACTIONVAL="$2"

                # Check action value passed through the command-line
                # using source directory definition as reference.
                cli_checkRepoDirSource

                # Define action name using action value as reference.
                ACTIONNAM="${FUNCNAM}_doDelete"

                # Break options loop.
                break
                ;;

            * )
                # Break options loop.
                break
        esac
    done

    # Verify action value variable.
    if [[ $ACTIONVAL == '' ]];then
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
