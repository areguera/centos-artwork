#!/bin/bash
#
# locale_updateMessageXml.sh -- This function parses scalable vector
# graphics files, retrives translatable strings and creates/update
# portable object templates for each one of them.
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

    # Redefine filter pattern in order to reduce match to scalable
    # vector graphics only.
    local FLAG_FILTER="${FLAG_FILTER}.*\.(xml|svg)"

    # Define location where XML-based files (e.g., scalable vector
    # graphics), we want to have translation for, are place in.
    local LOCATION="${ACTIONVAL}"

    # Define name of file used to create both portable object
    # templates (.pot) and portable objects (.po) files.
    local FILE="${ACTIONVAL}/$(cli_getCurrentLocale)"

    # Build list of XML-base files which we want retrive translatable
    # strings from.
    cli_getFilesList "${LOCATION}"

    # Print out action preamble. Since the `--filter' option can be
    # supplied, it is useful to know which files we are getting
    # translatable strings from.
    cli_printActionPreamble "${FILES}" "doLocale" 'AsResponseLine'
    
    # Print action message.
    cli_printMessage "${FILE}.pot" 'AsUpdatingLine'

    # Retrive translatable strings from XML-based files and
    # create the portable object template (.pot) for them.
    /usr/bin/xml2po ${FILES} \
        | msgcat --output=${FILE}.pot --width=70 --sort-by-file -

    if [[ ! -f ${FILE}.po ]];then

        # Create portable object using portable object template, at
        # the same time we use output to print the action message.
        # There is no --quiet option for msginit command that let to
        # separate both printing action message and creation command
        # apart one from another).
        cli_printMessage $(msginit -i ${FILE}.pot -o ${FILE}.po --width=70 \
            --no-translator 2>&1 | cut -d' ' -f2 | sed -r 's!\.$!!') 'AsCreatingLine'

        # Sanitate portable object metadata.
        locale_updateMessageMetadata "${FILE}.po"

    else

        # Print action message.
        cli_printMessage "${FILE}.po" 'AsUpdatingLine'

        # Update portable object merging both portable object and
        # portable object template.
        msgmerge --output="${FILE}.po" "${FILE}.po" "${FILE}.pot" --quiet

    fi

}
