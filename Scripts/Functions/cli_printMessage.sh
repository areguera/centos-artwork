#!/bin/bash
#
# cli_printMessage.sh -- This function outputs information in
# predifined formats to standard error. This function is the standard
# way to output information inside centos-art.sh script.
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

function cli_printMessage {

    # Verify `--quiet' option.
    if [[ "$FLAG_QUIET" == 'true' ]];then
        return
    fi

    local MESSAGE="$1"
    local FORMAT="$2"

    # Reduce paths inside output messages. The main purpose for
    # this is to free horizontal space in output messages.
    MESSAGE=$(echo "$MESSAGE" \
        | sed -r "s!${HOME}/artwork/(trunk|branches|tags)/!\1/!g")

    # Remove blank spaces from lines' begining.
    MESSAGE=$(echo "$MESSAGE" | sed -r 's!^[[:space:]]+!!')

    # Define message formats.
    case $FORMAT in

    'AsUpdatingLine' )
        cli_printMessage "`gettext "Updating"`: $MESSAGE"
        ;;

    'AsDeletingLine' )
        cli_printMessage "`gettext "Deleting"`: $MESSAGE"
        ;;

    'AsCheckingLine' )
        cli_printMessage "`gettext "Checking"`: $MESSAGE"
        ;;

    'AsCreatingLine' )
        cli_printMessage "`gettext "Creating"`: $MESSAGE"
        ;;

    'AsReadingLine' )
        cli_printMessage "`gettext "Reading"`: $MESSAGE"
        ;;

    'AsSavedAsLine' )
        cli_printMessage "`gettext "Saved as"`: $MESSAGE"
        ;;
            
    'AsLinkToLine' )
        cli_printMessage "`gettext "Linked to"`: $MESSAGE"
        ;;
        
    'AsMovedToLine' )
        cli_printMessage "`gettext "Moved to"`: $MESSAGE"
        ;;

    'AsTranslationLine' )
        cli_printMessage "`gettext "Translation"`: $MESSAGE"
        ;;

    'AsDesignLine' )
        cli_printMessage "`gettext "Design"`: $MESSAGE"
        ;;

    'AsConfigurationLine' )
        cli_printMessage "`gettext "Configuration"`: $MESSAGE"
        ;;

    'AsPaletteLine' )
        cli_printMessage "`gettext "Palette"`: $MESSAGE"
        ;;

    'AsResponseLine' )
        cli_printMessage "--> $MESSAGE"
        ;;

    'AsRequestLine' )
        cli_printMessage "${MESSAGE}: " 'AsNoTrailingNewLine'
        ;;

    'AsErrorLine' )
        # This option is used to print error messsages.
        echo "${CLI_PROGRAM}: ${MESSAGE}" > /dev/stderr
        ;;

    'AsToKnowMoreLine' )
        # This option receives the output of bash's caller built-in as
        # message value and produces the documentation entry from it.
        MESSAGE="trunk/Scripts/Functions/$MESSAGE"
        cli_printMessage '-' 'AsSeparatorLine'
        cli_printMessage "`gettext "To know more, run the following command"`:"
        cli_printMessage "centos-art help $MESSAGE"
        cli_printMessage '-' 'AsSeparatorLine'
        exit # <-- ATTENTION: Do not remove this line. We use this
             #                option as convenction to end script
             #                execution.
        ;;
    
    'AsYesOrNoRequestLine' )

        # Define positive answer.
        local Y="`gettext "yes"`"

        # Define negative answer.
        local N="`gettext "no"`"

        # Define default answer.
        local ANSWER=${FLAG_ANSWER}

        if [[ $ANSWER == 'false' ]];then

            # Print the question.
            cli_printMessage "$MESSAGE [${Y}/${N}]: " 'AsNoTrailingNewLine'

            # Redefine default answer based on user's input.
            read ANSWER

        fi

        # Verify user's answer. Only positive answer let the script
        # flow to continue. Otherwise, if something different from
        # possitive answer is passed, the script terminates its
        # execution immediatly.
        if [[ ! ${ANSWER} =~ "^${Y}" ]];then
            exit
        fi
        ;;

    'AsSeparatorLine' )

        # Define separator width.
        local MAX=70

        # Draw separator.
        until [[ $MAX -eq 0 ]];do
            printf "${MESSAGE}" > /dev/stderr
            MAX=$(($MAX - 1))
        done

        # Output newline to end separator.
        echo "" > /dev/stderr
        ;;

    'AsNoTrailingNewLine' )
        printf "$MESSAGE" > /dev/stderr
        ;;

    'AsRegularLine' | * )
        echo "$MESSAGE" \
            | awk 'BEGIN { FS=": " }
                    { 
                    if ( $0 ~ /^-+$/ ) 
                        print $0
                    else
                        printf "%-15s\t%s\n", $1, $2 
                    }
                    END {}' > /dev/stderr
        ;;

    esac

}
