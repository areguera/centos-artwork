#!/bin/bash
######################################################################
#
#   tcar_checkFiles.sh -- This function standardizes the way file
#   conditional expressions are applied to files.  Here is where
#   centos-art.sh script answers questions like: is the file a regular
#   file or a directory?  Or, is it a symbolic link? Or even, does it
#   have execution rights, etc.  If the verification fails somehow at
#   any point, an error message is output and centos-art.sh script
#   finishes its execution. 
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
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
######################################################################

function tcar_checkFiles {

    # Initialize local array variables.
    local -a CONDITION_COMMAND
    local -a CONDITION_PATTERN
    local -a CONDITION_MESSAGE

    # Initialize local counter.
    local COUNTER=0

    OPTIND=1
    while getopts "i:,r,m:,n,d,e,f,h,x" OPTION ${@}; do

        case "${OPTION}" in

            d )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-d'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a directory."`"
                ;;

            e )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-e'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "doesn't exist."`"
                ;;

            f )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-f'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a regular file."`"
                ;;

            h )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-h'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a symbolic link."`"
                ;;

            x )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-x'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't an executable file."`"
                ;;

            i )
                local MIME=${OPTARG}
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/file'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-bi'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`eval_gettext "isn't a \\\"\\\${MIME}\\\" file."`"
                ;;

            m )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='match'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="${OPTARG}"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`eval_gettext "doesn't match its pattern."`"
                ;;

            n )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]="/bin/rpm"
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="-q --quiet"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't installed in the system."`"
                ;;

        esac
    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( ${OPTIND} - 1 ))

    # Define list of files we want to apply verifications to, now that
    # all option-like arguments have been removed from positional
    # parameters list so we are free to go with the verifications.
    local FILE=''
    local FILES=${@}

    for FILE in ${FILES};do

        until [[ ${COUNTER} -eq ${#CONDITION_PATTERN[*]} ]];do

            case ${CONDITION_COMMAND[${COUNTER}]} in

                "/usr/bin/test" | "/bin/rpm" )
                ${CONDITION_COMMAND[${COUNTER}]} ${CONDITION_PATTERN[${COUNTER}]} ${FILE} \
                    || tcar_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                ;;

                "centos-art" )
                # Don't create another level for error messages here
                # (that would duplicate them unnecessarily).  Instead,
                # set error messages inside specific functionalities
                # and use them directly from there.
                tcar_setFnEnvironment ${CONDITION_PATTERN[${COUNTER}]} ${FILE}
                ;;

                "/usr/bin/file" )
                if [[ ! $(${CONDITION_COMMAND[${COUNTER}]} ${CONDITION_PATTERN[${COUNTER}]} ${FILE}) =~ "^${MIME}" ]];then
                    tcar_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                fi
                ;;

                "match" )
                if [[ ! ${FILE} =~ "${CONDITION_PATTERN[${COUNTER}]}" ]];then
                    tcar_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                fi
                ;;

                * )
                tcar_printMessage "`gettext "The condition command provided isn't supported."`" --as-error-line
                ;;

            esac

            COUNTER=$((${COUNTER} + 1))

        done

    done

}
