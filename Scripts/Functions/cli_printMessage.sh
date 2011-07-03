#!/bin/bash
#
# cli_printMessage.sh -- This function standardizes the way messages
# are printed out from centos-art.sh script.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
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

    # Verify message variable, it cannot have an empty value.
    if [[ $MESSAGE == '' ]];then
        cli_printMessage "`gettext "The message cannot be empty."`" --as-error-line
    fi

    # Reverse the codification performed on characters that may affect
    # parsing options and non-option arguments. This codification is
    # realized before building the ARGUMENTS variable, at
    # cli_parseArgumentsReDef, and we need to reverse it back here
    # in order to show the correct character when the message be
    # printed out on the screen.
    MESSAGE=$(echo $MESSAGE | sed -e "s/\\\0x27/'/g")

    # Remove empty spaces from message.
    MESSAGE=$(echo $MESSAGE | sed -e 's!^[[:space:]]+!!')

    # Print out messages based on format.
    case "$FORMAT" in

        --as-separator-line )

        # Define width of separator line.
        local MAX=70

        # Build the separator line. 
        MESSAGE=$(\
            until [[ $MAX -eq 0 ]];do
                echo -n "$MESSAGE"
                MAX=$(($MAX - 1))
            done)

        # Draw the separator line.
        echo "$MESSAGE" > /dev/stderr
        ;;

        --as-banner-line )
            cli_printMessage '-' --as-separator-line
            cli_printMessage "$MESSAGE"
            cli_printMessage '-' --as-separator-line
            ;;

        --as-cropping-line )
            cli_printMessage "`gettext "Cropping from"`: $MESSAGE"
            ;;

        --as-tuningup-line )
            cli_printMessage "`gettext "Tuning-up"`: $MESSAGE"
            ;;

        --as-checking-line )
            cli_printMessage "`gettext "Checking"`: $MESSAGE"
            ;;

        --as-creating-line | --as-updating-line )
            if [[ -a "$MESSAGE" ]];then
                cli_printMessage "`gettext "Updating"`: $MESSAGE"
            else
                cli_printMessage "`gettext "Creating"`: $MESSAGE"
            fi
            ;;

        --as-deleting-line )
            cli_printMessage "`gettext "Deleting"`: $MESSAGE"
            ;;

        --as-reading-line )
            cli_printMessage "`gettext "Reading"`: $MESSAGE"
            ;;

        --as-savedas-line )
            cli_printMessage "`gettext "Saved as"`: $MESSAGE"
            ;;
            
        --as-linkto-line )
            cli_printMessage "`gettext "Linked to"`: $MESSAGE"
            ;;
        
        --as-movedto-line )
            cli_printMessage "`gettext "Moved to"`: $MESSAGE"
            ;;

        --as-translation-line )
            cli_printMessage "`gettext "Translation"`: $MESSAGE"
            ;;

        --as-validating-line )
            cli_printMessage "`gettext "Validating"`: $MESSAGE"
            ;;

        --as-template-line )
            cli_printMessage "`gettext "Template"`: $MESSAGE"
            ;;

        --as-configuration-line )
            cli_printMessage "`gettext "Configuration"`: $MESSAGE"
            ;;

        --as-palette-line )
            cli_printMessage "`gettext "Palette"`: $MESSAGE"
            ;;

        --as-response-line )
            cli_printMessage "--> $MESSAGE"
            ;;

        --as-request-line )
            cli_printMessage "${MESSAGE}: " --as-notrailingnew-line
            ;;

        --as-error-line )
            # Define where the error was originated inside the
            # centos-art.sh script. Print out the function name and
            # line from the caller.
            local ORIGIN="${CLI_PROGRAM} ($(caller 1 | gawk '{ print $2 " " $1 }'))"

            # Build the error message.
            cli_printMessage "${ORIGIN}: ${MESSAGE}" --as-stderr-line
            cli_printMessage "${FUNCDIRNAM}" --as-toknowmore-line
            ;;

        --as-toknowmore-line )
            cli_printMessage '-' --as-separator-line
            cli_printMessage "`gettext "To know more, run the following command"`:"
            cli_printMessage "centos-art help --read trunk/Scripts/Functions/$MESSAGE"
            cli_printMessage '-' --as-separator-line
            exit # <-- ATTENTION: Do not remove this line. We use this
                 #                option as convenction to end script
                 #                execution.
            ;;
    
        --as-yesornorequest-line )
            # Define positive answer.
            local Y="`gettext "yes"`"

            # Define negative answer.
            local N="`gettext "no"`"

            # Define default answer.
            local ANSWER=${N}

            if [[ $FLAG_ANSWER == 'true' ]];then

                ANSWER=${Y}

            else

                # Print the question.
                cli_printMessage "$MESSAGE [${Y}/${N}]: " --as-notrailingnew-line

                # Redefine default answer based on user's input.
                read ANSWER

            fi

            # Verify user's answer. Only positive answer let the
            # script flow to continue. Otherwise, if something
            # different from possitive answer is passed, the script
            # terminates its execution immediatly.
            if [[ ! ${ANSWER} =~ "^${Y}" ]];then
                exit
            fi
            ;;

        --as-notrailingnew-line )
            echo -n "$MESSAGE" > /dev/stderr
            ;;

        --as-stdout-line )
            echo "$MESSAGE"
            ;;

        --as-stderr-line )
            echo "$MESSAGE" > /dev/stderr
            ;;

        * )

            # Default printing format. This is the format used when no
            # other specification is passed to this function. As
            # convenience, we transform absolute paths into relative
            # paths in order to free horizontal space on final output
            # messages.
            echo "$MESSAGE" | sed -r \
                -e "s!${HOME}/artwork/(trunk|branches|tags)/!\1/!g" \
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
