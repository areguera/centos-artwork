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

    local FILES="$1"
    local ACTION="$2"
    local FORMAT="$3"
    local FILE=''
    local NEGATIVE=''
    local POSITIVE=''
    local COUNT=0

    # Redefine total number of directories.
    COUNT=$(echo "$FILES" | sed -r "s! +!\n!g" | wc -l)

    # Redefine preamble messages based on action.
    case $ACTION in

        'doCreate' )
            if [[ $FILES == '' ]];then
                NEGATIVE="`gettext "There is no entry to create."`"
            else
                POSITIVE="`ngettext "The following entry will be created" \
                    "The following entries will be created" $COUNT`:"
            fi
            ;;

        'doDelete' )
            if [[ $FILES == '' ]];then
                NEGATIVE="`gettext "There is no file to delete."`"
            else
                POSITIVE="`ngettext "The following entry will be deleted" \
                    "The following entries will be deleted" $COUNT`:"
            fi
            ;;

        'doLocale' )
            if [[ $FILES == '' ]];then
                NEGATIVE="`gettext "There is no file to locale."`"
            else
                POSITIVE="`ngettext "Translatable strings will be retrived from the following entry" \
                    "Translatable strings will be retrived from the following entries" $COUNT`:"
            fi
            ;;

        'doEdit' )
            if [[ $FILES == '' ]];then
                NEGATIVE="`gettext "There is no file to edit."`"
            else
                POSITIVE="`ngettext "The following file will be edited" \
                    "The following files will be edited" $COUNT`:"
            fi
            ;;

        * )
            # Check list of files to process.  If we have an empty
            # list of files, inform about that and stop the script
            # execution.  Otherwise, check all files in the list to be
            # sure they are regular files.
            if [[ "$FILES" == '' ]];then
                NEGATIVE="`gettext "There is no file to process."`"
            fi
            ;;

    esac

    # Print preamble message.
    if [[ $POSITIVE != '' ]] &&  [[ $NEGATIVE == '' ]];then
        cli_printMessage "$POSITIVE"
        cli_printMessage "$FILES" "$FORMAT"
        cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'
    elif [[ $POSITIVE == '' ]] &&  [[ $NEGATIVE != '' ]];then
        cli_printMessage "$NEGATIVE" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
