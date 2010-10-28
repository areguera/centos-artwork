#!/bin/bash
#
# cli_commitRepoChanges.sh -- This function looks for changes inside
# absolute path passed as option value and ask you to commit them up
# to central repository. Use this function at the end of whatever
# function you make a change to repository files. It is better to
# commit small changes than long ones.
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

function cli_commitRepoChanges {

    local FILES=''
    local COUNT=0

    # Define list of changed files.
    FILES=$(svn status $OPTIONVAL | egrep '^M' | cut -d' ' -f7)

    # Define number of changed files.
    COUNT=$(echo "$FILES" | wc | sed -r 's!^ *!!' | cut -d' ' -f1)

    # Check list of changed files and ask the user to commit changes
    # if there is any.
    if [[ $COUNT -gt 0 ]];then

        cli_printMessage "`ngettext "The following file was changed" \
            "The following files were changed" $COUNT`:"

        # Show list of affected entries.
        for FILE in $FILES;do
            cli_printMessage "$FILE" "AsResponseLine"
        done

        # Verify changes.
        cli_printMessage "`gettext "Do you want to see these changes now?"`" "AsYesOrNoRequestLine"
        svn diff $FILES | less

        # Commit changes.
        cli_printMessage "`gettext "Do you want commit these changes now?"`" "AsYesOrNoRequestLine"
        svn commit $FILES
    fi

}
