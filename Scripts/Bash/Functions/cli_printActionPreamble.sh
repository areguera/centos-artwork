#!/bin/bash
#
# cli_printActionPreamble -- This function standardizes action
# preamble messages. Action preamble messages provides a confirmation
# message that illustrate what files will be affected in the action.
#
# Generally, actions are applied to parent directories. Each parent
# directory has parallel directories associated. If one parent
# directory is created/deleted, the parallel directories associated do
# need to be created/deleted too.
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

function cli_printActionPreamble {

    local FILE=''
    local COUNT=0
    local FILES="$1"
    local ACTION="$2"
    local FORMAT="$3"

    # Check list of files to process. If we have an empty list of
    # files, inform about it and stop script execution. Otherwise
    # print list of files.
    if [[ "$FILES" == '' ]];then
        cli_printMessage "`gettext "There is no file to process."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Verify that all function parameters are passed. If they are not,
    # there is nothing else to do here.
    if [[ $# -ne 3 ]];then
        return
    fi

    # Redefine total number of directories.
    COUNT=$(echo "$FILES" | sed -r "s! +!\n!g" | wc -l)

    # Redefine preamble messages based on action.
    case $ACTION in

        'doCreate' )
            ACTION="`ngettext "The following entry will be created" \
            "The following entries will be created" $COUNT`:"
            ;;

        'doDelete' )
            ACTION="`ngettext "The following entry will be deleted" \
            "The following entries will be deleted" $COUNT`:"
            ;;

        'doLocale' )
            ACTION="`ngettext "Translatable strings will be retrived from the following entry" \
            "Translatable strings will be retrived from the following entries" $COUNT`:"
            ;;

        'doEdit' )
            ACTION="`ngettext "The following file will be edited" \
            "The following files will be edited" $COUNT`:"
            ;;

    esac

    # Print preamble message.
    cli_printMessage "$ACTION"
    for FILE in $FILES;do
        cli_printMessage "$FILE" "$FORMAT"
    done
    cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'

}
