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
    FILE="${WORKDIR}/messages"

    # Define regular expression to match extensions of XML files we
    # use inside the repository.
    local EXTENSIONS='(svg|xml|xhtml|docbook)'

    # Build list of files to process.
    if [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Identity/(Models|Manual|Themes/Models)/.+$" ]];then
        FILES=$(cli_getFilesList "$ACTIONVAL" "${FLAG_FILTER}\.${EXTENSIONS}")
    else
        cli_printMessage "`gettext "The path provided can't be processed."`" 'AsErrorLine'
        cli_printMessage "${FUNCDIRNAM}" 'AsToKnowMoreLine'
    fi

    # Set action preamble.
    cli_printActionPreamble "${FILES}" "doLocale" 'AsResponseLine'

    # Print action message.
    cli_printMessage "${FILE}.pot" 'AsUpdatingLine'

    # Prepare directory structure to receive .po files.
    if [[ ! -d $(dirname ${FILE}) ]];then
        mkdir -p $(dirname ${FILE})
    fi

    # Retrive translatable strings from XML-based files and
    # create the portable object template (.pot) from them.
    /usr/bin/xml2po ${FILES} | msgcat --output=${FILE}.pot --width=70 --sort-by-file -

    # Verify, initialize or merge portable objects from portable
    # object templates.
    locale_updateMessagePObjects "${FILE}"

}
