#!/bin/bash
#
# cli_doParseArgumentsCommon.sh -- This function parses positional
# parameters to divide arguments in common argumetns and specific
# arguments. Common arguments might be used by all specific
# functionalities.  There is no need to have all common argument
# definitions duplicated in each specific functionality individually.
# Once the value of common arguments have been retrived in FLAG_
# variables they are removed from ARGUMENTS positional parameters, in
# order to leave the specific arguments that specific functionalities
# most interpret.
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

function cli_doParseArgumentsCommon {

    local -a SHORT
    local -a LONG
    local -a REQUIRED
    local ARGUMENT=''
    local ARGUMENTS_DEFAULT=''
    local COMMONS=''
    local COMMON=''
    local ARGSS=''
    local ARGSL=''
    local PATTERN=''
    local COUNT=0

    # Define local array to store short definition of common arguments.
    SHORT[0]='f'
    SHORT[1]='q'
    SHORT[2]='y'

    # Define local array to store long definition of common arguments.
    LONG[0]='filter'
    LONG[1]='quiet'
    LONG[2]='answer-yes'

    # Define local array to store definition of whether the common
    # argument is required [one colon], optional [two colons] or not
    # required at all [empty]).
    REQUIRED[0]=':'
    REQUIRED[1]=''
    REQUIRED[2]=''

    # Save default arguments passed to centos-art.sh command-line.
    # Since ARGUMENTS variable is used as convenction when arguments
    # are redefined (see cli_doParseArgumentsReDef), it is required to
    # use an intermediate-pattern variable in order to create the
    # common and non-comon arguments information from it.
    ARGUMENTS_DEFAULT=$ARGUMENTS

    # Build list of common arguments.
    for ARGUMENT in $ARGUMENTS_DEFAULT;do

        while [[ $COUNT -lt ${#LONG[*]} ]];do

            # Be specific about the pattern used to match both long
            # and short arguments. Notice that when arguments values
            # are required we add an equal sign (`=') and a space (`
            # ') character to the end of pattern in order to match
            # both long and short arguments respectively.
            if [[ ${REQUIRED[$COUNT]} =~ '^:$' ]];then
                PATTERN="^'(--${LONG[$COUNT]}=|-${SHORT[$COUNT]} )"
            else
                PATTERN="^'(--${LONG[$COUNT]}|-${SHORT[$COUNT]})"
            fi

            # Check argument against common argument pattern.
            if [[ $ARGUMENT =~ "${PATTERN}" ]];then
                if [[ $COMMONS == '' ]];then
                    COMMONS="${ARGUMENT}"
                else
                    COMMONS="${COMMONS} ${ARGUMENT}"
                fi
            fi

            # Increment counter.
            COUNT=$(($COUNT + 1))

        done

        # Reset counter.
        COUNT=0

    done

    # Reset positional paramenters to start using common arguments and
    # this way be able of performing common arguments verification
    # independently from non-common arguments verification (which is
    # done inside specific functionalities).
    eval set -- "$COMMONS"

    # Redefine positional parameters stored inside ARGUMENTS variable
    # to use common arguments only.
    cli_doParseArgumentsReDef "$@"

    # Define short and long arguments variables using getopt format.
    # This information is passed to getopt in order to now which the
    # common arguments are.
    while [[ $COUNT -lt ${#LONG[*]} ]];do

        # Define short arguments.
        if [[ $ARGSS == '' ]];then
            ARGSS=${SHORT[$COUNT]}${REQUIRED[$COUNT]}
        else
            ARGSS="${ARGSS},${SHORT[$COUNT]}${REQUIRED[$COUNT]}"
        fi

        # Define long arguments.
        if [[ $ARGSL == '' ]];then
            ARGSL=${LONG[$COUNT]}${REQUIRED[$COUNT]}
        else
            ARGSL="${ARGSL},${LONG[$COUNT]}${REQUIRED[$COUNT]}"
        fi
        
        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in

            --filter )

                # Redefine flag.
                FLAG_FILTER="$2"

                # Break while loop.
                shift 2
                ;;

            --quiet )

                # Redefine flag.
                FLAG_QUIET="true"

                # Break while loop.
                shift 1
                ;;

            --answer-yes )

                # Redefine flag.
                FLAG_YES="true"

                # Break while loop.
                shift 1
                ;;

            * )
                break
                ;;
        esac
    done

    # Redefine ARGUMENTS to use no-common arguments. Common arguments
    # has been already parsed, so free specific functions from parsing
    # them (there is no need to parse them twice).
    if [[ $COMMONS != '' ]];then

        # Escape special regular expression characters that might be
        # passed through common arguments like `--filter' in order to
        # interpreted them literally. Otherwise they might be
        # interpreted when they be stript out from default arguments.
        COMMONS=$(echo $COMMONS | sed -r 's!(\[|\{|\.|\+|\*)!\\\1!g')

        # Stript out common arguments from default arguments. 
        eval set -- "$(echo $ARGUMENTS_DEFAULT | sed -r "s!${COMMONS}!!g")"

    else

        # Use just default arguments. No common argument was passed.
        eval set -- "${ARGUMENTS_DEFAULT}"

    fi

    # Redefine positional parameters stored inside ARGUMENTS variable.
    cli_doParseArgumentsReDef "$@"

}
