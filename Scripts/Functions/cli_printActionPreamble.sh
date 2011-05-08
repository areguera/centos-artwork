#!/bin/bash
#
# cli_printActionPreamble -- This function standardizes the way
# preamble messages are printed out. Preamble messages are used before
# actions (e.g., file elimination, edition, creation, actualization,
# etc.) and provide a way for the user to control whether the action
# is performed or not.
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

function cli_printActionPreamble {

    # Define short options.
    local ARGSS=''

    # Define long options.
    local ARGSL='to-create,to-delete,to-locale,to-edit'

    # Initialize arguments with an empty value and set it as local
    # variable to this function scope.
    local ARGUMENTS=''

    # Initialize message.
    local MESSAGE=''

    # Initialize message options.
    local OPTIONS=''

    # Initialize file variable as local to avoid conflicts outside.
    # We'll use the file variable later, to show the list of files
    # that will be affected by the action.
    local FILE=''

    # Redefine ARGUMENTS variable using current positional parameters. 
    cli_doParseArgumentsReDef "$@"

    # Redefine ARGUMENTS variable using getopt output.
    cli_doParseArguments

    # Redefine positional parameters using ARGUMENTS variable.
    eval set -- "$ARGUMENTS"

    # Define the location we want to apply verifications to.
    local FILES=$(echo $@ | sed -r 's!^.*--[[:space:]](.+)$!\1!')

    # Initialize counter with total number of files.
    local COUNT=$(echo $FILES | wc -l)

    # Look for options passed through positional parameters.
    while true;do

        case "$1" in

            --to-create )
                if [[ $FILES == '--' ]];then
                    MESSAGE="`gettext "There is no entry to create."`"
                    OPTIONS='--as-error-line'
                else
                    MESSAGE="`ngettext "The following entry will be created" \
                        "The following entries will be created" $COUNT`:"
                    OPTIONS=''
                fi
                shift 2
                break
                ;;

            --to-delete )
                if [[ $FILES == '--' ]];then
                    MESSAGE="`gettext "There is no file to delete."`"
                    OPTIONS='--as-error-line'
                else
                    MESSAGE="`ngettext "The following entry will be deleted" \
                        "The following entries will be deleted" $COUNT`:"
                    OPTIONS=''
                fi
                shift 2
                break
                ;;

            --to-locale )
                if [[ $FILES == '--' ]];then
                    MESSAGE="`gettext "There is no file to locale."`"
                    OPTIONS='--as-error-line'
                else
                    MESSAGE="`ngettext "Translatable strings will be retrived from the following entry" \
                        "Translatable strings will be retrived from the following entries" $COUNT`:"
                    OPTIONS=''
                fi
                shift 2
                break
                ;;

            --to-edit )
                if [[ $FILES == '--' ]];then
                    MESSAGE="`gettext "There is no file to edit."`"
                    OPTIONS='--as-error-line'
                else
                    MESSAGE="`ngettext "The following file will be edited" \
                        "The following files will be edited" $COUNT`:"
                    OPTIONS=''
                fi
                shift 2
                break
                ;;

            -- )
                if [[ $FILES == '--' ]];then
                    MESSAGE="`gettext "There is no file to process."`"
                    OPTIONS='--as-error-line'
                else
                    MESSAGE="`ngettext "The following file will be processed" \
                        "The following files will be processed" $COUNT`:"
                    OPTIONS=''
                fi
                shift 1
                break
                ;;
        esac
    done

    # Print out the preamble message.
    cli_printMessage ${OPTIONS} ${MESSAGE}
    for FILE in $FILES;do
        cli_printMessage $FILE --as-response-line
    done
    cli_printMessage "`gettext "Do you want to continue"`" --as-yesornorequest-line

}
