#!/bin/bash
######################################################################
#
#   cli_checkFiles.sh -- This function standardizes the way file
#   conditional expressions are applied to files.  Here is where
#   centos-art.sh script answers questions like: is the file a regular
#   file or a directory?  Or, is it a symbolic link? Or even, does it
#   have execution rights, etc.  If the verification fails somehow at
#   any point, an error message is output and centos-art.sh script
#   finishes its execution. 
#
#   Written by: 
#   * Alain Reguera Delgado <al@centos.org.cu>, 2009-2013
#     Key fingerprint = D67D 0F82 4CBD 90BC 6421  DF28 7CCE 757C 17CA 3951
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

function cli_checkFiles {

    # Define short options.
    local ARGSS='i:,r,m:,n,d,e,f,h,x'

    # Define long options.
    local ARGSL='mime:,is-versioned,match:,is-installed'

    # Initialize local array variables.
    local -a CONDITION_COMMAND
    local -a CONDITION_PATTERN
    local -a CONDITION_MESSAGE

    # Initialize local counter.
    local COUNTER=0

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope. Doing this is very important to
    # avoid any clash with higher execution environments. This
    # variable is shared for different function environments.
    local TCAR_ARGUMENTS=''
    
    # Redefine arguments using current positional parameters. 
    cli_setArguments "${@}"

    # Redefine positional parameters using arguments variable.
    eval set -- "${TCAR_ARGUMENTS}"

    # Look for options passed through positional parameters.
    while true; do

        case "${1}" in

            -d )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-d'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a directory."`"
                shift 1
                ;;

            -e )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-e'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "doesn't exist."`"
                shift 1
                ;;

            -f )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-f'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a regular file."`"
                shift 1
                ;;

            -h )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-h'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a symbolic link."`"
                shift 1
                ;;

            -x )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-x'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't an executable file."`"
                shift 1
                ;;

            -i | --mime )
                local MIME=${2}
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='file'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-bi'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`eval_gettext "isn't a \\\"\\\${MIME}\\\" file."`"
                shift 2
                ;;

            -m | --match )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='match'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="${2}"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`eval_gettext "doesn't match its pattern."`"
                shift 2
               ;;

            -r | --is-versioned )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]="centos-art"
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="vcs --is-versioned"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]=""
                shift 1
                ;;

            -n | --is-installed )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]="rpm"
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="-q --quiet"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't installed in the system."`"
                shift 1
                ;;

            -- )
                shift 1
                break
                ;;

        esac
    done

    # Define list of files we want to apply verifications to, now that
    # all option-like arguments have been removed from positional
    # parameters list so we are free to go with the verifications.
    local FILE=''
    local FILES=${@}

    for FILE in ${FILES};do

        until [[ ${COUNTER} -eq ${#CONDITION_PATTERN[*]} ]];do

            case ${CONDITION_COMMAND[${COUNTER}]} in

                "test" | "rpm" )
                ${CONDITION_COMMAND[${COUNTER}]} ${CONDITION_PATTERN[${COUNTER}]} ${FILE} \
                    || cli_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                ;;

                "centos-art" )
                # Don't create another level for error messages here
                # (that would duplicate them unnecessarily).  Instead,
                # set error messages inside specific functionalities
                # and use them directly from there.
                cli_runFnEnvironment ${CONDITION_PATTERN[${COUNTER}]} ${FILE}
                ;;

                "file" )
                if [[ ! $(${CONDITION_COMMAND[${COUNTER}]} ${CONDITION_PATTERN[${COUNTER}]} ${FILE}) == "${MIME}" ]];then
                    cli_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                fi
                ;;

                "match" )
                if [[ ! ${FILE} =~ "${CONDITION_PATTERN[${COUNTER}]}" ]];then
                    cli_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                fi
                ;;

                * )
                cli_printMessage "`gettext "The condition command provided isn't supported."`" --as-error-line
                ;;

            esac

            COUNTER=$((${COUNTER} + 1))

        done

    done

}
