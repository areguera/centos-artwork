#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Standardize the way messages are printed by tcar.sh script.
function tcar_printMessage {

    local MESSAGE="${1}"
    local FORMAT="${2}"

    # Verify message variable, it cannot have an empty value.
    if [[ -z ${MESSAGE} ]];then
        tcar_printMessage "`gettext "The message cannot be empty."`" --as-error-line
    fi

    # Define message horizontal width. This is the max number of
    # horizontal characters the message will use to be displayed on
    # the screen.
    local MESSAGE_WIDTH=66

    # Remove empty spaces from message.
    #MESSAGE=$(printf %s "${MESSAGE}" | sed -r -e 's!^[[:space:]]+!!')

    # Print messages that will always be printed no matter what value
    # the TCAR_FLAG_QUIET variable has.
    case "${FORMAT}" in

        --as-stdout-line* )

            local MARGIN_LEFT=15
            if [[ ${FORMAT} =~ '--as-stdout-line=[[:digit:]]+' ]];then
                MARGIN_LEFT=$(echo ${FORMAT} | cut -d'=' -f2)
            fi

            # Default printing format. This is the format used when no
            # other specification is passed to this function. As
            # convenience, we transform absolute paths into relative
            # paths in order to free horizontal space on final output
            # messages.
            printf %s "${MESSAGE}" | sed -r \
                -e "s!${TCAR_BASEDIR}/!!g" \
                -e "s!> /!> !g" \
                -e "s!/{2,}!/!g" \
                | gawk 'BEGIN { FS=": " }
                    { 
                        if ( $0 ~ /^-+$/ )
                            print $0
                        else
                            printf "%-'${MARGIN_LEFT}'s\t%s\n", $1, $2
                    }
                    END {}'
            ;;

        --as-error-line )

            # Build the error trail. This is very useful for tracking
            # the error down.
            tcar_printMessage '-' --as-separator-line
            tcar_printMessage "${FUNCNAME[*]}" --as-tree-line

            # Build the error message.
            tcar_printMessage '-' --as-separator-line
            tcar_printMessage "$(tcar_printCaller 1) ${MESSAGE}" --as-stderr-line
            tcar_printMessage '-' --as-separator-line

            # Finish script execution with exit status 1 (SIGHUP) to
            # imply the script finished because an error.  We are
            # using this as convention to finish the script execution.
            # So, don't remove the following line, please.
            exit 1
            ;;

        --as-debugger-line )
            if [[ ${TCAR_FLAG_DEBUG} == 'true' ]];then
                tcar_printMessage "$(date +"%c") ${MESSAGE}" --as-stdout-line=60
            else
                return
            fi
            ;;

        --as-tree-line )
            local NAME
            local -a FN
            for NAME in ${MESSAGE};do
                FN[++((${#FN[*]}))]=${NAME}
            done
            local COUNT=$(( ${#FN[*]} - 2 ))
            local SEPARATOR='`--'
            local SPACES=0
            echo "${0}" 1>&2
            while [[ ${COUNT} -gt 0  ]];do
                if [[ ${COUNT} -eq $(( ${#FN[*]} - 2 )) ]];then
                    echo ${SEPARATOR} ${FN[${COUNT}]} 1>&2
                else
                    echo ${FN[${COUNT}]} \
                        | gawk '{ printf "%'${SPACES}'s%s %s\n", "", "'${SEPARATOR}'", $1 }' 1>&2
                fi
                COUNT=$((${COUNT} - 1))
                SPACES=$((${SPACES} + 4))
            done
            ;;

        --as-toknowmore-line )
            tcar_printMessage "`gettext "To know more, run"` ${TCAR_SCRIPT_NAME} ${MESSAGE} --help" --as-stderr-line
            ;;

        --as-yesornorequest-line )

            # Define positive answer.
            local Y="`gettext "yes"`"

            # Define negative answer.
            local N="`gettext "no"`"

            # Define default answer.
            local ANSWER=${N}

            if [[ ${TCAR_FLAG_YES} == 'true' ]];then

                ANSWER=${Y}

            else

                # Print the question to standard error.
                tcar_printMessage "${MESSAGE} [${Y}/${N}]" --as-request-line

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
                echo ${NAME}
                break
            done
            ;;

        --as-response-line )
            tcar_printMessage "--> ${MESSAGE}" --as-stderr-line
            ;;

        --as-request-line )
            tcar_printMessage "${MESSAGE}:\040" --as-notrailingnew-line
            ;;

        --as-notrailingnew-line )
            echo -e -n "${MESSAGE}" | sed -r \
                -e "s!${TCAR_BASEDIR}/!!g" 1>&2
            ;;

        --as-stderr-line )
            echo "${MESSAGE}" | sed -r \
                -e "s!${TCAR_BASEDIR}/!!g" 1>&2
            ;;

    esac

    # Verify quiet option. The quiet option controls whether messages
    # are printed or not.
    if [[ "${TCAR_FLAG_QUIET}" == 'true' ]];then
        return
    fi

    # Print messages that will be printed only when the TCAR_FLAG_QUIET
    # variable is provided to tcar.sh script.
    case "${FORMAT}" in

        --as-separator-line )

            # Build the separator line.
            MESSAGE=$(\
                until [[ ${MESSAGE_WIDTH} -eq 0 ]];do
                    echo -n "$(echo ${MESSAGE} | sed -r 's!(.).*!\1!')"
                    MESSAGE_WIDTH=$((${MESSAGE_WIDTH} - 1))
                done) 

            # Draw the separator line.
            echo "${MESSAGE}" 1>&2
            ;;

        --as-banner-line )
            tcar_printMessage '-' --as-separator-line
            tcar_printMessage "${MESSAGE}" --as-stdout-line
            tcar_printMessage '-' --as-separator-line
            ;;

        --as-processing-line )
            tcar_printMessage "`gettext "Processing"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-cropping-line )
            tcar_printMessage "`gettext "Cropping from"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-tuningup-line )
            tcar_printMessage "`gettext "Tuning-up"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-checking-line )
            tcar_printMessage "`gettext "Checking"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-combining-line )
            tcar_printMessage "`gettext "Combining"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-editing-line )
            tcar_printMessage "`gettext "Editing"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-creating-line | --as-updating-line )
            if [[ -a "${MESSAGE}" ]];then
                tcar_printMessage "`gettext "Updating"`: ${MESSAGE}" --as-stdout-line
            else
                tcar_printMessage "`gettext "Creating"`: ${MESSAGE}" --as-stdout-line
            fi
            ;;

        --as-deleting-line )
            tcar_printMessage "`gettext "Deleting"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-reading-line )
            tcar_printMessage "`gettext "Reading"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-savedas-line )
            tcar_printMessage "`gettext "Saved as"`: ${MESSAGE}" --as-stdout-line
            ;;
            
        --as-linkto-line )
            tcar_printMessage "`gettext "Linked to"`: ${MESSAGE}" --as-stdout-line
            ;;
        
        --as-movedto-line )
            tcar_printMessage "`gettext "Moved to"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-translation-line )
            tcar_printMessage "`gettext "Translation"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-translating-line )
            tcar_printMessage "`gettext "Translating"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-validating-line )
            tcar_printMessage "`gettext "Validating"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-template-line )
            tcar_printMessage "`gettext "Template"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-configuration-line )
            tcar_printMessage "`gettext "Configuration"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-palette-line )
            tcar_printMessage "`gettext "Palette"`: ${MESSAGE}" --as-stdout-line
            ;;

    esac

}
