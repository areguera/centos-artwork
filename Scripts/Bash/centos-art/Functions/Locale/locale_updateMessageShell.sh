#!/bin/bash
#
# locale_updateMessageShell.sh -- This function parses shell scripts
# under action value, retrives translatable strings and
# creates/updates both portable object templates (.pot) and portable
# objects (.po).
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

function locale_updateMessageShell {

    local FILE=''
    local FILES=''

    # Define file name used as reference to create portable object
    # templates (.pot), portable objects (.po) and machine objects
    # (.mo).
    FILE="${WORKDIR}/$(cli_getCurrentLocale)/${TEXTDOMAIN}"

    # Verify directory used to store locale-specific translation
    # messages. If it doesn't exist, create it.
    if [[ ! -d $(dirname ${FILE}) ]];then
        mkdir -p $(dirname ${FILE})
    fi

    # Build list of files to process.
    if [[ $ACTIONVAL =~ "^${CLI_BASEDIR}" ]];then
        FILES=$(cli_getFilesList "$ACTIONVAL" "${FLAG_FILTER}\.sh")
    else
        cli_printMessage "`gettext "The path provided can't be processed."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Set action preamble.
    cli_printActionPreamble "${FILES}" "doLocale" 'AsResponseLine'
    
    # Print action message.
    cli_printMessage "${FILE}.pot" 'AsUpdatingLine'

    # Prepare directory structure to receive .po files.
    if [[ ! -d $(dirname ${FILE}) ]];then
        mkdir -p $(dirname ${FILE})
    fi

    # Retrive translatable strings from shell script files and create
    # the portable object template (.pot) from them.
    /usr/bin/xgettext --output=${FILE}.pot \
        --copyright-holder="CentOS Documentation SIG" \
        --width=70 --sort-by-file ${FILES}

    # Verify, initialize or update portable objects from portable
    # object templates.
    locale_updateMessagePObjects "${FILE}"

}
