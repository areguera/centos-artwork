#!/bin/bash
#
# cli_checkFiles.sh -- This function standardizes the way file
# conditional expressions are applied inside centos-art.sh script.
# Here is where we answer questions like: is the file a regular file
# or a directory?  or, is it a symbolic link? or even, does it have
# execution rights, etc.  If the verification fails somehow at any
# point, an error message is output and centos-art.sh script ends its
# execution. 
#
# More than one file can be passed to this function, so we want to
# process them all as specified by the options. Since we are using
# getopt output it is possible to determine where options and
# non-option arguments are in the list of arguments  (e.g., options
# are on the left side of ` -- ' and non-options on the rigth side of
# ` -- '). Non-options are the files we want to verify and options how
# we want to verify them.
#
# Another issue to consider, when more than one file is passed to this
# function, is that we cannot shift positional parameters as we
# frequently do whe just one argument is passsed, doing so would
# annulate the validation for the second and later files passed to the
# function. So, in order to provide verification to all files passed
# to the function, the verification loop must be set individual for
# each option in this function.
#
# Assuming no option be passed to the function, a general verification
# is performed to determine whether or not the file exists without
# considering the file type just its existence.
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

function cli_checkFiles {

    # Define short options.
    local ARGSS='d,r,h,x,w'

    # Define long options.
    local ARGSL='directory,regular-file,symbolic-link,execution,working-copy'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Initialize file variable as local to avoid conflicts outside
    # this function scope. In the file variable will set the file path
    # we'r going to verify.
    local FILE=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_doParseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Look for options passed through positional parameters.
    while true; do

        case "$1" in

            -d|--directory )
                for FILE in $(echo $@ | gawk 'BEGIN{FS=" -- "}{print $2}' );do
                    if [[ ! -d $FILE ]];then
                        cli_printMessage "`eval_gettext "The directory \\\"\\\$FILE\\\" does not exist."`" --as-error-line
                    fi
                done
                shift 1
                ;;

            -f|--regular-file )
                for FILE in $(echo $@ | gawk 'BEGIN{FS=" -- "}{print $2}' );do
                    if [[ ! -f $FILE ]];then
                        cli_printMessage "`eval_gettext "The file \\\"\\\$FILE\\\" is not a regular file."`" --as-error-line
                    fi
                done
                shift 1
                ;;

            -h|--symbolic-link )
                for FILE in $(echo $@ | gawk 'BEGIN{FS=" -- "}{print $2}' );do
                    if [[ ! -h $FILE ]];then
                        cli_printMessage "`eval_gettext "The file \\\"\\\$FILE\\\" is not a symbolic link."`" --as-error-line
                    fi
                done
                shift 1
                ;;

            -x|--execution )
                for FILE in $(echo $@ | gawk 'BEGIN{FS=" -- "}{print $2}' );do
                    if [[ ! -x $FILE ]];then
                        cli_printMessage "`eval_gettext "The file \\\"\\\$FILE\\\" is not executable."`" --as-error-line
                    fi
                done
                shift 1
                ;;

            -w|--working-copy )
                for FILE in $(echo $@ | gawk 'BEGIN{FS=" -- "}{print $2}' );do
                    if [[ ! $FILE =~ "^${HOME}/artwork/.+$" ]];then
                        cli_printMessage "`eval_gettext "The path \\\"\\\$FILE\\\" does not exist inside the working copy."`" --as-error-line
                    fi
                done
                shift 1
                ;;

            -- )
                for FILE in $(echo $@ | gawk 'BEGIN{FS=" -- "}{print $2}' );do
                    if [[ ! -a $FILE ]];then
                        cli_printMessage "`eval_gettext "The path \\\"\\\$FILE\\\" does not exist."`" --as-error-line
                    fi
                done
                shift 1
                break
                ;;

        esac
    done

}
