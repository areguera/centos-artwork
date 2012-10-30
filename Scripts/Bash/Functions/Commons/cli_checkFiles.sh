#!/bin/bash
#
# cli_checkFiles.sh -- This function standardizes the way file
# conditional expressions are applied inside centos-art.sh script.
# Here is where we answer questions like: is the file a regular file
# or a directory?  Or, is it a symbolic link? Or even, does it have
# execution rights, etc.  If the verification fails somehow at any
# point, an error message is output and centos-art.sh script finishes
# its execution. 
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function cli_checkFiles {

    # Define short options.
    local ARGSS='i:,r,m:,d,e,f,h,x'

    # Define long options.
    local ARGSL='mime:,is-versioned,match:'

    # Initialize array variables.
    local -a CONDITION_COMMAND
    local -a CONDITION_PATTERN
    local -a CONDITION_MESSAGE

    # Initialize array variable counter.
    local COUNTER=0

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope. Doing this is very important to
    # avoid any clash with higher execution environments.
    local ARGUMENTS=''

    # Prepare ARGUMENTS for getopt.
    cli_parseArgumentsReDef "$@"

    # Redefine ARGUMENTS using getopt(1) command parser.
    cli_parseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through positional parameters.
    while true; do

        case "$1" in

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
                local MIME=$2
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='file'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-bi'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`eval_gettext "isn't a \\\"\\\$MIME\\\" file."`"
                shift 2
                ;;

            -m | --match )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='match'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="$2"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`eval_gettext "doesn't match its pattern."`"
                shift 2
                ;;

            -r | --is-versioned )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]="Svn"
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='svn_isVersioned'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't under version control."`"
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
    local FILES=$@

    for FILE in $FILES;do

        while [[ ${COUNTER} -lt ${#CONDITION_PATTERN[*]} ]];do

            case ${CONDITION_COMMAND[$COUNTER]} in

                "Svn" )
                cli_exportFunctions "${CONDITION_COMMAND[${COUNTER}]}/${CONDITION_PATTERN[$COUNTER]}"
                if [[ $(${CONDITION_PATTERN[$COUNTER]} ${FILE}) -ne 0 ]];then \
                    cli_printMessage "${FILE} ${CONDITION_MESSAGE[$COUNTER]}" --as-error-line
                fi
                cli_unsetFunctions "${CONDITION_COMMAND[${COUNTER}]}/${CONDITION_PATTERN[$COUNTER]}"
                ;;

                "test" )
                ${CONDITION_COMMAND[$COUNTER]} ${CONDITION_PATTERN[$COUNTER]} ${FILE} \
                    || cli_printMessage "${FILE} ${CONDITION_MESSAGE[$COUNTER]}" --as-error-line
                ;;

                "file" )
                if [[ ! $(${CONDITION_COMMAND[$COUNTER]} ${CONDITION_PATTERN[$COUNTER]} ${FILE}) == "$MIME" ]];then
                    cli_printMessage "${FILE} ${CONDITION_MESSAGE[$COUNTER]}" --as-error-line
                fi
                ;;

                "match" )
                if [[ ! ${FILE} =~ "${CONDITION_PATTERN[$COUNTER]}" ]];then
                    cli_printMessage "${FILE} ${CONDITION_MESSAGE[$COUNTER]}" --as-error-line
                fi
                ;;

                * )
                cli_printMessage "`gettext "The condition command provided isn't supported."`" --as-error-line
                ;;
            esac

            COUNTER=$(($COUNTER + 1))

        done

    done

}
