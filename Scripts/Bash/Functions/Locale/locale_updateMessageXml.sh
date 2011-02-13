#!/bin/bash
#
# locale_updateMessageXml.sh -- This function parses XML-based files
# (e.g., scalable vector graphics), retrives translatable strings and
# creates/update portable objects.
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

    # Define name of file used to create both portable object
    # templates (.pot) and portable objects (.po) files.
    local FILE="${WORKDIR}/$(cli_getCurrentLocale)"

    # Redefine filtering pattern in order to get XML-based files only
    # using repository directory structures as reference.
    if [[ $ACTIONVAL =~ 'trunk/Identity/.+' ]];then
        FLAG_FILTER="${FLAG_FILTER}.*\.svg"
    else
        FLAG_FILTER="${FLAG_FILTER}.*\.xml"
    fi

    # Build list of XML-base files we want retrive translatable
    # strings from.
    cli_getFilesList

    # Print action preamble.
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
