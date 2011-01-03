#!/bin/bash
#
# cli_checkFiles.sh -- This function standardizes file verifications
# inside centos-art.sh script.  If file verification fails in anyway,
# centos-art.sh script complains about it and ends up script
# execution.
#
# Usage:
#
# cli_checkFiles FILE [TYPE]
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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

function cli_checkFiles {

    # Get absolute path to file/directory.
    local FILE="$1"

    # Get verification type.
    local TYPE="$2"

    # Initialize message output.
    local MESSAGE=''

    # Check number of paramaters passed to cli_checkFiles function. At
    # least one argument should be passed.
    if [[ $# -lt 1 ]];then
        cli_printMessage "cli_checkFiles: `gettext "You need to provide one argument at least."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Check value passed as file to cli_checkFiles function. The file
    # value cannot be empty.
    if [[ $FILE == '' ]];then
        cli_printMessage "cli_checkFiles: `gettext "The first argument cannot be empty."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Perform file verification using FILE and TYPE variables.
    case $TYPE in

        d | directory )
            # File exists and is a directory
            if [[ ! -d $FILE ]];then
                cli_printMessage "`eval_gettext "The directory \\\"\\\$FILE\\\" doesn't exist."`"
                cli_printMessage "`gettext "Do you want to create it now?"`" 'AsYesOrNoRequestLine'
                mkdir -p $FILE
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

        x | execution )
            # To exist, file should be executable.
            if [[ ! -x $FILE ]];then
                MESSAGE="`eval_gettext "The file \\\"\\\$FILE\\\" is not executable."`"
            fi
            ;;

        fh )
            # To exist, file should be a regular file or a symbolic link.
            if [[ ! -f $FILE ]];then
                if [[ ! -h $FILE ]];then
                    MESSAGE="`eval_gettext "The path \\\"\\\$FILE\\\" doesn't exist."`"
                fi
            fi
            ;;

        fd )
            # To exist, file should be a regular file or a directory.
            if [[ ! -f $FILE ]];then
                if [[ ! -d $FILE ]];then
                    MESSAGE="`eval_gettext "The path \\\"\\\$FILE\\\" doesn't exist."`"
                fi
            fi
            ;;

        isInWorkingCopy )
            # To exist, file should be inside the working copy.
            if [[ ! $FILE =~ "^/home/centos/artwork/.+$" ]];then
                MESSAGE="`eval_gettext "The path \\\"\\\$FILE\\\" doesn't exist inside the working copy."`"
            fi
            ;;

        * )
            # File exists.
            if [[ ! -a $FILE ]];then
                MESSAGE="`eval_gettext "The path \\\"\\\$FILE\\\" doesn't exist."`"
            fi

    esac

    # If file verification fails in anyway, output message information
    # and end up script execution. Otherwise, continue with script
    # normal flow.
    if [[ "$MESSAGE" != '' ]];then
        cli_printMessage "$MESSAGE" "AsErrorLine"
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

}
