#!/bin/bash
#
# locale_updateMessageXml.sh -- This function parses XML-based files
# (e.g., scalable vector graphics), retrives translatable strings and
# creates/update gettext portable objects.
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

function locale_updateMessageXml {

    local FILE=''
    local FILES=''

    # Define filename used to create both portable object templates
    # (.pot) and portable objects (.po) files.
    FILE="${WORKDIR}/$(cli_getCurrentLocale)"

    # Redefine filter flag to specify the extension of files the
    # translatable messages are retrived from and so limiting the
    # list of files to process to the number of files we want to
    # retrive translatable messages from. Use action value as
    # reference to find out different shell files.
    if [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Identity/.+" ]];then
        FLAG_FILTER=".*${FLAG_FILTER}.*\.svg"
    elif [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Manuals/.+" ]];then
        FLAG_FILTER=".*${FLAG_FILTER}.*\.xml"
    else
        cli_printMessage "`gettext "The path provided can't be processed."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Build list of files to process.
    cli_getFilesList

    # Print action preamble.
    cli_printActionPreamble "${FILES}" "doLocale" 'AsResponseLine'
    
    # Print action message.
    cli_printMessage "${FILE}.pot" 'AsUpdatingLine'

    # Retrive translatable strings from XML-based files and
    # create the portable object template (.pot) from them.
    /usr/bin/xml2po ${FILES} | msgcat --output=${FILE}.pot --width=70 --sort-by-file -

    # Verify, initialize or merge portable objects from portable
    # object templates.
    locale_updateMessagePObjects "${FILE}"

}
