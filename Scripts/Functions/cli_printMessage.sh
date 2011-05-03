#!/bin/bash
#
# cli_doPrint.sh -- This function outputs information in
# predifined formats to standard error. This function is the standard
# way to output information inside centos-art.sh script.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
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

function cli_doPrint {

    # Verify `--quiet' option.
    if [[ "$FLAG_QUIET" == 'true' ]];then
        return
    fi

    # Initialize message variable as empty.
    local MESSAGE=''

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='message:,as-separator-line,as-banner-line,as-updating-line,as-cropping-line,as-tuningup-line,as-deleting-line,as-checking-line,as-creating-line,as-reading-line,as-savedas-line,as-linkto-line,as-movedto-line,as-translation-line,as-design-line,as-configuration-line,as-palette-line,as-response-line,as-request-line,as-error-line,as-toknowmore-line,as-yesornorequest-line,as-notrailingnew-line,as-regular-line,'

    # Define ARGUMENTS as local variable in order to parse options
    # from this function internlally.
    local ARGUMENTS=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_doParseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through positional parameters.
    while true; do

        case "$1" in

            '--message' )

                # Redefine message.
                MESSAGE="$2"

                # Reduce paths inside output messages. The main
                # purpose for this is to free horizontal space in
                # output messages.
                MESSAGE=$(echo "$MESSAGE" \
                    | sed -r "s!${HOME}/artwork/(trunk|branches|tags)/!\1/!g")

                # Remove blank spaces from lines' begining.
                MESSAGE=$(echo "$MESSAGE" | sed -r 's!^[[:space:]]+!!')

                shift 2
                ;;

            '--as-separator-line' )

                # Define separator width.
                local MAX=70

                # Draw separator.
                until [[ $MAX -eq 0 ]];do
                    printf "$MESSAGE" > /dev/stderr
                    MAX=$(($MAX - 1))
                done

                # Output newline to end separator.
                echo "" > /dev/stderr

                break
                ;;

            '--as-banner-line' )
                cli_doPrint --message='-' --as-separator-line
                cli_doPrint --message="$MESSAGE"
                cli_doPrint --message='-' --as-separator-line
                break
                ;;

            '--as-updating-line' )
                cli_doPrint --message="`gettext "Updating"`: $MESSAGE"
                break
                ;;

            '--as-cropping-line' )
                cli_doPrint --message="`gettext "Cropping from"`: $MESSAGE"
                break
                ;;

            '--as-tuningup-line' )
                cli_doPrint --message="`gettext "Tuning-up"`: $MESSAGE"
                break
                ;;

            '--as-deleting-line' )
                cli_doPrint --message="`gettext "Deleting"`: $MESSAGE"
                break
                ;;

            '--as-checking-line' )
                cli_doPrint --message="`gettext "Checking"`: $MESSAGE"
                break
                ;;

            '--as-creating-line' )
                cli_doPrint --message="`gettext "Creating"`: $MESSAGE"
                break
                ;;

            '--as-reading-line' )
                cli_doPrint --message="`gettext "Reading"`: $MESSAGE"
                break
                ;;

            '--as-savedas-line' )
                cli_doPrint --message="`gettext "Saved as"`: $MESSAGE"
                break
                ;;
            
            '--as-linkto-line' )
                cli_doPrint --message="`gettext "Linked to"`: $MESSAGE"
                break
                ;;
        
            '--as-movedto-line' )
                cli_doPrint --message="`gettext "Moved to"`: $MESSAGE"
                break
                ;;

            '--as-translation-line' )
                cli_doPrint --message="`gettext "Translation"`: $MESSAGE"
                break
                ;;

            '--as-design-line' )
                cli_doPrint --message="`gettext "Design"`: $MESSAGE"
                break
                ;;

            '--as-configuration-line' )
                cli_doPrint --message="`gettext "Configuration"`: $MESSAGE"
                break
                ;;

            '--as-palette-line' )
                cli_doPrint --message="`gettext "Palette"`: $MESSAGE"
                break
                ;;

            '--as-response-line' )
                cli_doPrint --message="--> $MESSAGE"
                break
                ;;

            '--as-request-line' )
                cli_doPrint --message="${MESSAGE}: " --as-notrailingnew-line
                break
                ;;

            '--as-error-line' )
                # This option is used to print error messsages.
                echo "${CLI_PROGRAM} (${FUNCNAME[1]}): ${MESSAGE}" > /dev/stderr
                cli_doPrint --message="${FUNCDIRNAM}" --as-toknowmore-line
                break
                ;;

            '--as-toknowmore-line' )
                # This option receives the output of bash's caller
                # built-in as message value and produces the
                # documentation entry from it.
                MESSAGE="trunk/Scripts/Functions/$MESSAGE"
                cli_doPrint --message='-' --as-separator-line
                cli_doPrint --message="`gettext "To know more, run the following command"`:"
                cli_doPrint --message="centos-art help --read $MESSAGE"
                cli_doPrint --message='-' --as-separator-line
                exit # <-- ATTENTION: Do not remove this line. We use this
                     #                option as convenction to end script
                     #                execution.
                ;;
    
            '--as-yesornorequest-line' )
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
                    cli_doPrint --message="$MESSAGE [${Y}/${N}]: " --as-notrailingnew-line

                    # Redefine default answer based on user's input.
                    read ANSWER

                fi

                # Verify user's answer. Only positive answer let the
                # script flow to continue. Otherwise, if something
                # different from possitive answer is passed, the
                # script terminates its execution immediatly.
                if [[ ! ${ANSWER} =~ "^${Y}" ]];then
                    exit
                fi

                break
                ;;

            '--as-notrailingnew-line' )
                printf "$MESSAGE" > /dev/stderr
                break
                ;;

            '--as-regular-line' | * )
                echo "$MESSAGE" \
                        | awk 'BEGIN { FS=": " }
                            { 
                            if ( $0 ~ /^-+$/ ) 
                                print $0
                            else
                                printf "%-15s\t%s\n", $1, $2 
                            }
                            END {}' > /dev/stderr
                break
                ;;

            '--' )
                shift 1
                break
                ;;

        esac

    done

}
