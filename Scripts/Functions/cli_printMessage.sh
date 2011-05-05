#!/bin/bash
#
# cli_printMessage.sh -- This function outputs information in
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

function cli_printMessage {

    # Verify `--quiet' option.
    if [[ "$FLAG_QUIET" == 'true' ]];then
        return
    fi

    # Verify number of positional parameters. The first argument is
    # required.
    if [[ $# -eq 0 ]];then
        cli_printMessage "`gettext "The first argument is required."`" --as-error-line
    fi

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='message:,as-separator-line,as-banner-line,as-updating-line,as-cropping-line,as-tuningup-line,as-deleting-line,as-checking-line,as-creating-line,as-reading-line,as-savedas-line,as-linkto-line,as-movedto-line,as-translation-line,as-design-line,as-configuration-line,as-palette-line,as-response-line,as-request-line,as-error-line,as-toknowmore-line,as-yesornorequest-line,as-notrailingnew-line,as-regular-line,'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_doParseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Initialize message variable locally using non-option arguments.
    local MESSAGE=$(echo $@ | sed -r 's!^(.*[[:space:]]*--[[:space:]]+)?!!')

    # Verify message variable, it cannot have an empty value.
    if [[ $MESSAGE == '' ]];then
        cli_printMessage "`gettext "The message cannot be empty."`" --as-error-line
    fi

    # Reverse character codification performed when the list of
    # arguments wast built at cli_doParseArgumentsReDef.sh.
    MESSAGE=$(echo $MESSAGE | sed "s/\\\0x27/'/g")
                
    # Reduce paths inside output messages. The main purpose for this
    # is to free horizontal space in output messages.
    MESSAGE=$(echo "$MESSAGE" \
        | sed -r "s!${HOME}/artwork/(trunk|branches|tags)/!\1/!g")

    # Remove leading blank spaces from output messages.
    MESSAGE=$(echo "$MESSAGE" | sed -r 's!^[[:space:]]+!!')

    # Look for options passed through positional parameters.
    while true; do

        case "$1" in

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

                shift 2
                break
                ;;

            --as-banner-line )
                cli_printMessage '-' --as-separator-line
                cli_printMessage "$MESSAGE"
                cli_printMessage '-' --as-separator-line
                shift 2
                break
                ;;

            --as-updating-line )
                cli_printMessage "`gettext "Updating"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-cropping-line )
                cli_printMessage "`gettext "Cropping from"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-tuningup-line )
                cli_printMessage "`gettext "Tuning-up"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-checking-line )
                cli_printMessage "`gettext "Checking"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-creating-line )
                cli_printMessage "`gettext "Creating"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-deleting-line )
                cli_printMessage "`gettext "Deleting"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-reading-line )
                cli_printMessage "`gettext "Reading"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-savedas-line )
                cli_printMessage "`gettext "Saved as"`: $MESSAGE"
                shift 2
                break
                ;;
            
            --as-linkto-line )
                cli_printMessage "`gettext "Linked to"`: $MESSAGE"
                shift 2
                break
                ;;
        
            --as-movedto-line )
                cli_printMessage "`gettext "Moved to"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-translation-line )
                cli_printMessage "`gettext "Translation"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-design-line )
                cli_printMessage "`gettext "Design"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-configuration-line )
                cli_printMessage "`gettext "Configuration"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-palette-line )
                cli_printMessage "`gettext "Palette"`: $MESSAGE"
                shift 2
                break
                ;;

            --as-response-line )
                cli_printMessage "--> $MESSAGE"
                shift 2
                break
                ;;

            --as-request-line )
                cli_printMessage "${MESSAGE}: " --as-notrailingnew-line
                shift 2
                break
                ;;

            --as-error-line )
                # This option is used to print error messsages.
                echo "${CLI_PROGRAM} (${FUNCNAME[1]}): ${MESSAGE}" > /dev/stderr
                cli_printMessage "${FUNCDIRNAM}" --as-toknowmore-line
                shift 2
                break
                ;;

            --as-toknowmore-line )
                # This option receives the output of bash's caller
                # built-in as message value and produces the
                # documentation entry from it.
                MESSAGE="trunk/Scripts/Functions/$MESSAGE"
                cli_printMessage '-' --as-separator-line
                cli_printMessage "`gettext "To know more, run the following command"`:"
                cli_printMessage "centos-art help --read $MESSAGE"
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
                # different from possitive answer is passed, the
                # script terminates its execution immediatly.
                if [[ ! ${ANSWER} =~ "^${Y}" ]];then
                    exit
                fi

                shift 2
                break
                ;;

            --as-notrailingnew-line )
                printf "$MESSAGE" > /dev/stderr
                shift 2
                break
                ;;

            --as-regular-line | * )
                echo "$MESSAGE" \
                        | awk 'BEGIN { FS=": " }
                            { 
                            if ( $0 ~ /^-+$/ ) 
                                print $0
                            else
                                printf "%-15s\t%s\n", $1, $2 
                            }
                            END {}' > /dev/stderr
                shift 2
                break
                ;;

        esac

    done

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

}
