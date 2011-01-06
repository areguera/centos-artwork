#!/bin/bash
#
# render_getActions.sh -- This function interprets arguments passed to
# render functionality and calls actions accordingly.
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

function render_getActions {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="identity:,translation:,filter:,copy:,to:,quiet,yes"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Look for options passed through command-line.
    while true; do

        case "$1" in

            --identity )

                # Redefine action value.
                ACTIONVAL="$2"

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_getActionsIdentity"

                # Rotate positional parameters
                shift 2
                ;;

            --translation )

                # Redefine action value.
                ACTIONVAL="$2"

                # Redefine action name.
                ACTIONNAM="${FUNCNAM}_getActionsTranslations"

                # Rotate positional parameters
                shift 2
                ;;

            --filter )

                # Redefine filter (regular expression) flag.
                FLAG_FILTER="$2"
                
                # Rotate positional parameters
                shift 2
                ;;

            --copy )
            
                # Redefine action value variable.
                ACTIONVAL="$2"

                # Redefine action name variable.
                ACTIONNAM="${FUNCNAME}_doCopy"

                # Rotate positional parameters
                shift 2
                ;;

            --to )
            
                # Redefine target value flag.
                FLAG_TO="$2"

                # Rotate positional parameters
                shift 2
                ;;

            --quiet )

                # Redefine quiet flag.
                FLAG_QUIET='true'

                # Rotate positional parameters
                shift 1
                ;;

            --yes )

                # Redefine answer flag.
                FLAG_YES='true'

                # Rotate positional parameters
                shift 1
                ;;

            * )
                # Break options loop.
                break
        esac
    done

    # Check action value. Be sure the action value matches the
    # convenctions defined for source locations inside the working
    # copy.
    cli_checkRepoDirSource

    # Redefine pre-rendition configuration directory. Pre-rendition
    # configuration directory is where we store render.conf.sh
    # scripts. The render.conf.sh scripts define how each artwork is
    # rendered.
    local ARTCONF=$(echo "$ACTIONVAL" \
        | sed -r -e 's!/(Identity|Translations)!/Scripts/Bash/Functions/Render/Config/\1!' \
                 -e "s!Motifs/$(cli_getThemeName)/?!!")

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`eval_gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
