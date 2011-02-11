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

    local DIR=''
    local DIRS="$1"
    local ACTION="$2"
    local FORMAT="$3"
    local COUNT_DIRS=0

    # Redefine total number of directories.
    COUNT_DIRS=$(echo "$DIRS" | sed -r "s! +!\n!g" | wc -l)

    # Redefine preamble messages based on action.
    case $ACTION in

        'doCreate' )
            ACTION="`ngettext "The following entry will be created" \
            "The following entries will be created" $COUNT_DIRS`:"
            ;;

        'doDelete' )
            ACTION="`ngettext "The following entry will be deleted" \
            "The following entries will be deleted" $COUNT_DIRS`:"
            ;;

        'doLocale' )
            ACTION="`ngettext "Translatable strings will be retrived from the following entry" \
            "Translatable strings will be retrived from the following entries" $COUNT_DIRS`:"
            ;;

        'doEdit' )
            ACTION="`ngettext "The following file will be edited" \
            "The following files will be edited" $COUNT_DIRS`:"
            ;;

        * )
            cli_printMessage "cli_printActionPreamble: `gettext "The second argument is not valid."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'
            ;;
    esac

    # Print preamble message.
    cli_printMessage "$ACTION"
    for DIR in $(echo $DIRS);do
        cli_printMessage "$DIR" "$FORMAT"
    done
    cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'

}
