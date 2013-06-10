#!/bin/bash
#
# cli_printMessage.sh -- This function standardizes the way messages
# are printed by centos-art.sh script.
#
# Copyright (C) 2009-2013 The CentOS Project
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

    local MESSAGE="$1"
    local FORMAT="$2"

    # Verify message variable, it cannot have an empty value.
    if [[ $MESSAGE == '' ]];then
        cli_printMessage "`gettext "The message cannot be empty."`" --as-error-line
    fi

    # Define message horizontal width. This is the max number of
    # horizontal characters the message will use to be displayed on
    # the screen.
    local MESSAGE_WIDTH=66

    # Remove empty spaces from message.
    MESSAGE=$(echo $MESSAGE | sed -r -e 's!^[[:space:]]+!!')

    # Print messages that will always be printed no matter what value
    # the FLAG_QUIET variable has.
    case "$FORMAT" in

        --as-stdout-line )

            # Default printing format. This is the format used when no
            # other specification is passed to this function. As
            # convenience, we transform absolute paths into relative
            # paths in order to free horizontal space on final output
            # messages.
            echo "$MESSAGE" | sed -r \
                -e "s!${TCAR_WORKDIR}/!!g" \
                -e "s!> /!> !g" \
                -e "s!/{2,}!/!g" \
                | awk 'BEGIN { FS=": " }
                    { 
                        if ( $0 ~ /^-+$/ )
                            print $0
                        else
                            printf "%-15s\t%s\n", $1, $2
                    }
                    END {}'
            ;;

        --as-error-line )

            # Define where the error was originated inside the
            # centos-art.sh script. Print out the function name and
            # line from the caller.
            local ORIGIN="$(caller 1 | gawk '{ print $2 " L." $1 }')"

            # Build the error message.
            cli_printMessage "${CLI_NAME} (${ORIGIN}):" --as-stdout-line
            cli_printMessage "${MESSAGE}" --as-response-line
            cli_printMessage "${CLI_FUNCNAME}" --as-toknowmore-line

            # Finish script execution with exit status 1 (SIGHUP) to
            # imply the script finished because an error.  We are
            # using this as convention to finish the script execution.
            # So, don't remove the following line, please.
            exit 1
            ;;

        --as-toknowmore-line )
            cli_printMessage '-' --as-separator-line
            cli_printMessage "`gettext "To know more, run"` ${CLI_NAME} ${MESSAGE} --help" --as-stdout-line
            cli_printMessage '-' --as-separator-line
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

                # Print the question to standard error.
                cli_printMessage "$MESSAGE [${Y}/${N}]" --as-request-line

                # Redefine default answer based on user's input.
                read ANSWER

            fi

            # Verify user's answer. Only positive answer let the
            # script flow to continue. Otherwise, if something
            # different from positive answer is passed, the script
            # terminates its execution immediately.
            if [[ ! ${ANSWER} =~ "^${Y}" ]];then
                exit
            fi
            ;;

        --as-selection-line )
            # Create selection based on message.
            local NAME=''
            select NAME in ${MESSAGE};do
                echo $NAME
                break
            done
            ;;

        --as-response-line )
            cli_printMessage "--> $MESSAGE" --as-stdout-line
            ;;

        --as-request-line )
            cli_printMessage "${MESSAGE}:\040" --as-notrailingnew-line
            ;;

        --as-notrailingnew-line )
            echo -e -n "${MESSAGE}" | sed -r \
                -e "s!${TCAR_WORKDIR}/!!g"
            ;;

        --as-stderr-line )
            echo "$MESSAGE" | sed -r \
                -e "s!${TCAR_WORKDIR}/!!g" 1>&2
            ;;

    esac

    # Verify verbose option. The verbose option controls whether
    # messages are printed or not.
    if [[ "$FLAG_QUIET" == 'true' ]];then
        return
    fi

    # Print messages that will be printed only when the FLAG_QUIET
    # variable is provided to centos-art.sh script.
    case "$FORMAT" in

        --as-separator-line )

            # Build the separator line.
            MESSAGE=$(\
                until [[ $MESSAGE_WIDTH -eq 0 ]];do
                    echo -n "$(echo $MESSAGE | sed -r 's!(.).*!\1!')"
                    MESSAGE_WIDTH=$(($MESSAGE_WIDTH - 1))
                done)

            # Draw the separator line.
            echo "$MESSAGE"
            ;;

        --as-banner-line )
            cli_printMessage '-' --as-separator-line
            cli_printMessage "$MESSAGE" --as-stdout-line
            cli_printMessage '-' --as-separator-line
            ;;

        --as-processing-line )
            cli_printMessage "`gettext "Processing"`: $MESSAGE" --as-stdout-line
            ;;

        --as-cropping-line )
            cli_printMessage "`gettext "Cropping from"`: $MESSAGE" --as-stdout-line
            ;;

        --as-tuningup-line )
            cli_printMessage "`gettext "Tuning-up"`: $MESSAGE" --as-stdout-line
            ;;

        --as-checking-line )
            cli_printMessage "`gettext "Checking"`: $MESSAGE" --as-stdout-line
            ;;

        --as-combining-line )
            cli_printMessage "`gettext "Combining"`: $MESSAGE" --as-stdout-line
            ;;

        --as-creating-line | --as-updating-line )
            if [[ -a "$MESSAGE" ]];then
                cli_printMessage "`gettext "Updating"`: $MESSAGE" --as-stdout-line
            else
                cli_printMessage "`gettext "Creating"`: $MESSAGE" --as-stdout-line
            fi
            ;;

        --as-deleting-line )
            cli_printMessage "`gettext "Deleting"`: $MESSAGE" --as-stdout-line
            ;;

        --as-reading-line )
            cli_printMessage "`gettext "Reading"`: $MESSAGE" --as-stdout-line
            ;;

        --as-savedas-line )
            cli_printMessage "`gettext "Saved as"`: $MESSAGE" --as-stdout-line
            ;;
            
        --as-linkto-line )
            cli_printMessage "`gettext "Linked to"`: $MESSAGE" --as-stdout-line
            ;;
        
        --as-movedto-line )
            cli_printMessage "`gettext "Moved to"`: $MESSAGE" --as-stdout-line
            ;;

        --as-translation-line )
            cli_printMessage "`gettext "Translation"`: $MESSAGE" --as-stdout-line
            ;;

        --as-validating-line )
            cli_printMessage "`gettext "Validating"`: $MESSAGE" --as-stdout-line
            ;;

        --as-template-line )
            cli_printMessage "`gettext "Template"`: $MESSAGE" --as-stdout-line
            ;;

        --as-configuration-line )
            cli_printMessage "`gettext "Configuration"`: $MESSAGE" --as-stdout-line
            ;;

        --as-palette-line )
            cli_printMessage "`gettext "Palette"`: $MESSAGE" --as-stdout-line
            ;;

        --as-inkscape-line )
            cli_printMessage "$MESSAGE" --as-stdout-line
            ;;

    esac

}
