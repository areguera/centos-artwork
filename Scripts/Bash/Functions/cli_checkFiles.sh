#!/bin/bash
#
# cli_checkFiles.sh -- This function checks file(s) existence.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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
# $Id: cli_checkFiles.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function cli_checkFiles {

    # Define variables as local to avoid conflicts outside.
    local FILE=''
    local FILES="$1"
    local TYPE="$2"
    local ACTION="$3"
    local MESSAGE=''

    # Check amount of paramaters passed. At least one argument should
    # be passed.
    if [[ $# -lt 1 ]];then
        cli_printMessage "`gettext "cli_checkFiles: At least one argument should be passed."`"
        cli_printMessage "trunk/Scripts/Bash/Functions --filter='cli_checkFiles.sh" "AsToKnowMoreLine"
    fi

    # If action is not specified, assume `Checking' as default.
    if [[ ! "$3" ]] || [[ "$3" == '' ]];then
        ACTION=`gettext "Checking"`
    fi

    for FILE in $FILES;do
      
        case $TYPE in

            d | directory )
                # File exists and is a directory
                if [[ ! -d $FILE ]];then
                    MESSAGE="The directory \"$FILE\" doesn't exist."
                fi
                ;;

            f | regular-file )
                # File exists and is a regular file.
                if [[ ! -f $FILE ]];then
                    MESSAGE="The file \"$FILE\" is not a regular file."
                fi
                ;;

            h | symbolic-link )
                # File exists and is a symbolic link.
                if [[ ! -h $FILE ]];then
                    MESSAGE="The file \"$FILE\" is not a symbolic link."
                fi
                ;;

            fh )
                # To exist, file should be a regular file or a symbolic link.
                if [[ ! -f $FILE ]];then
                    if [[ ! -h $FILE ]];then
                        MESSAGE="The file \"$FILE\" doesn't exist."
                    fi
                fi
                ;;

            * )
                # File exists.
                if [[ ! -a $FILE ]];then
                    MESSAGE="The file \"$FILE\" doesn't exist."
                fi

        esac

        # If there is some message print it and continue with the next
        # FILE in the loop (2). We wouldn't continue if a file is
        # missing.
        if [ "$MESSAGE" == '' ];then
            cli_printMessage "${ACTION}: $FILE"
        else
            cli_printMessage "${ACTION}: $MESSAGE"
            continue 2;
        fi

   done

}
