#!/bin/bash
#
# cli_checkFiles.sh -- This function checks file existence.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function cli_checkFiles {

    # Define variables as local to avoid conflicts outside.
    local FILE="$1"
    local TYPE="$2"
    local ACTION="$3"
    local OPTIONS="$4"
    local MESSAGE=''

    # Check amount of paramaters passed. At least one argument should
    # be passed.
    if [[ $# -lt 1 ]];then
        cli_printMessage "cli_checkFiles: `gettext "You need to provide one argument at least."`"
        cli_printMessages "$(caller)" "AsToKnowMoreLine"
    fi

    # Define default action to take, if it is not specified.
    if [[ ! "$3" ]] || [[ "$3" == '' ]];then
        ACTION=`gettext "Checking"`
    fi

    # Check file provided.
    if [[ $FILE == '' ]];then
        MESSAGE="`gettext "Unknown"`"
        cli_printMessage "${ACTION}: $MESSAGE" "AsRegularLine"
        return 1
    fi

    # Check file types.
    case $TYPE in

        d | directory )
            # File exists and is a directory
            if [[ ! -d $FILE ]];then
                MESSAGE="`eval_gettext "The directory \\\"\\\$FILE\\\" doesn't exist."`"
            fi
            ;;

        f | regular-file )
            # File exists and is a regular file.
            if [[ ! -f $FILE ]];then
                MESSAGE="`eval_gettext "The file \\\"\\\$FILE\\\" is not a regular file."`"
            fi
            ;;

        h | symbolic-link )
            # File exists and is a symbolic link.
            if [[ ! -h $FILE ]];then
                MESSAGE="`eval_gettext "The file \\\"\\\$FILE\\\" is not a symbolic link."`"
            fi
            ;;

        fh )
            # To exist, file should be a regular file or a symbolic link.
            if [[ ! -f $FILE ]];then
                if [[ ! -h $FILE ]];then
                    MESSAGE="`eval_gettext "The file \\\"\\\$FILE\\\" doesn't exist."`"
                fi
            fi
            ;;

        * )
            # File exists.
            if [[ ! -a $FILE ]];then
                MESSAGE="`eval_gettext "The file \\\"\\\$FILE\\\" doesn't exist."`"
            fi

    esac

    # If there is some message print it when there is no `--quiet'
    # option passed as fourth argument. 
    if [[ "$MESSAGE" == '' ]];then
        for OPTION in $OPTIONS;do 
            case $OPTION in
                '--quiet' )
                    return 0
            esac
        done
        cli_printMessage "${ACTION}: $FILE" "AsRegularLine"
        return 0
    else
        for OPTION in $OPTIONS;do 
            case $OPTION in
                '--quiet' )
                    return 1
            esac
        done
        cli_printMessage "${ACTION}: $MESSAGE" "AsRegularLine"
        return 1
    fi

}
