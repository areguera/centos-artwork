#!/bin/bash
#
# cli_doParseArguments.sh -- This function redefines arguments
# (ARGUMENTS) global variable using getopt(1) output.
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

function cli_doParseArguments {

    local ARG1=''
    local ARG2=''
    local COUNT=0

    # Verify no option has been passed twice in the command-line.
    for ARG1 in $ARGUMENTS;do
        ARG1=$(echo $ARG1 | sed -r "s!^'(--[[:alpha:]-]+)=?.+'!\1!")
        for ARG2 in $ARGUMENTS;do
            ARG2=$(echo $ARG2 | sed -r "s!^'(--[[:alpha:]-]+)=?.+'!\1!")
            if [[ $ARG1 == $ARG2 ]];then
                COUNT=$(($COUNT + 1))
            fi
            #echo "$ARG1 : $ARG2 : $COUNT"
            if [[ $COUNT -gt 1 ]];then
                cli_printMessage "`eval_gettext "The option \\\`\\\$ARG1' can't be duplicated."`" 'AsErrorLine'
                cli_printMessage "$(caller)" 'AsToKnowMoreLine'
            fi
        done
        COUNT=0
    done

    # Reset positional parameters using optional arguments.
    eval set -- "$ARGUMENTS"

    # Parse optional arguments using getopt.
    ARGUMENTS=$(getopt -o "$ARGSS" -l "$ARGSL" -n $CLINAME -- "$@")

    # Be sure getout parsed arguments successfully.
    if [[ $? != 0 ]]; then 
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
