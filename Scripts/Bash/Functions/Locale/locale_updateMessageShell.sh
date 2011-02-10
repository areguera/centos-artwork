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

    # Redefine filter pattern in order to reduce match to scalable
    # vector graphics only.
    local FLAG_FILTER="${FLAG_FILTER}.*\.(sh|py|pl)"

    # Define location where shell script files (e.g., Bash, Python,
    # Perl, etc.), we want to have translation for, are place in.
    local LOCATION="$(echo ${ACTIONVAL} \
        | sed -r "s!trunk/Locales/Scripts!trunk/Scripts!")"

    # Define name of file used to create both portable object
    # templates (.pot) and portable objects (.po) files.
    local FILE="${ACTIONVAL}/$(cli_getCurrentLocale)/${TEXTDOMAIN}"

    # Verify existence of directory where .pot, .po, and .mo files
    # will be stored.
    if [[ ! -d $(dirname $FILE) ]];then
        mkdir -p $(dirname $FILE)
    fi

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
    /usr/bin/xgettext --output=${FILE}.pot \
        --copyright-holder="CentOS Documentation SIG" \
        --width=70 --sort-by-file ${FILES}

    # Verify xgettext exit status.
    if [[ $? != 0 ]];then
        cli_printMessage "`eval_gettext "The .pot \\\`\\\$FILE' could not be created."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

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
