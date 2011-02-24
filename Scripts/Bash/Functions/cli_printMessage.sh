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

    local MESSAGE="$1"
    local FORMAT="$2"

    # Reduce paths inside output messages. The main purpose for this
    # is to free horizontal space in output messages.
    MESSAGE=$(echo "$MESSAGE" \
        | sed -r 's!/home/centos/artwork/(trunk|branches|tags)/!\1/!g')

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
            cli_printMessage '-' 'AsSeparatorLine'
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
            echo "${CLINAME}: ${MESSAGE}" > /dev/stderr
            ;;

        'AsToKnowMoreLine' )
            # This option receives the output of bash's caller
            # built-in as message value and produces the documentation
            # entry from it.
            MESSAGE=$(cli_getRepoName "$(echo $MESSAGE | cut -d ' ' -f2-)" 'd')
            cli_printMessage '-' 'AsSeparatorLine'
            cli_printMessage "`gettext "To know more, run the following command"`:"
            cli_printMessage "centos-art manual --read='$MESSAGE'"
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

            if [[ $FLAG_ANSWER == 'false' ]];then

                # Print the question.
                cli_printMessage "$MESSAGE [${Y}/${N}]: " 'AsNoTrailingNewLine'

                # Wait for user's answer to be entered.
                read FLAG_ANSWER

            fi

            # Verify user's answer. Only positive answer let the
            # script flow to continue. Otherwise, if something
            # different from possitive answer is passed, the
            # script terminates its execution immediatly.
            if [[ ! ${FLAG_ANSWER} =~ "^${Y}" ]];then
                exit
            fi
            ;;

        'AsSeparatorLine' )

            if [[ "$FLAG_QUIET" == 'false' ]];then

                # Define separator width.
                local MAX=70

                # Draw separator.
                until [[ $MAX -eq 0 ]];do
                    printf "${MESSAGE}" > /dev/stderr
                    MAX=$(($MAX - 1))
                done

                # Output newline to end separator.
                echo "" > /dev/stderr

            fi
            ;;

        'AsNoTrailingNewLine' )
            if [[ "$FLAG_QUIET" == 'false' ]];then
                printf "$MESSAGE" > /dev/stderr
            fi
            ;;

        'AsRegularLine' | * )
            if [[ "$FLAG_QUIET" == 'false' ]];then
                echo "$MESSAGE" \
                    | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk \
                    > /dev/stderr
            fi
            ;;

    esac

}
