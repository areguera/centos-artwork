#!/bin/bash
#
# help_searchIndex.sh -- This function does an index search inside the
# info document.
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
# $Id: help_searchIndex.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function help_searchIndex {

    # Define search pattern format
    local PATTERN='^[[:alnum:],]+$'

    # Re-define default REGEX value. If the regular expression was not
    # provided in the third argument its value is set to '.+' which is
    # not very useful in info --index-search contest. So, re-define
    # this value to an empty value ('').
    if [[ ! $REGEX =~ $PATTERN ]];then
        cli_printMessage "`gettext "Enter the search pattern:"` " "AsRequestLine"
        read REGEX
    fi

    # Validate search pattern. In this (help_searchIndex) function
    # contest, the REGEX variable is used as info search pattern, not
    # a regular expression pattern.
    if [[ ! "$REGEX" =~ $PATTERN ]];then
        cli_printMessage "`gettext "The search pattern is not valid."`"
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # There is no need to check the entry inside documentation
    # structure here.  Just provide a word to look if there is any
    # index matching in the info document.
    info --index-search="$REGEX" --file=${MANUALS_FILE[4]}

}
