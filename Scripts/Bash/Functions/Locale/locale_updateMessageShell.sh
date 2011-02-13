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

    # Redefine locales work directory to store locale-specific files.
    # The redefinition should be done locally to avoid undesired
    # concatenations.
    local WORKDIR=${WORKDIR}/$(cli_getCurrentLocale)

    # Create locales work directory if it doesn't exist.
    if [[ ! -d ${WORKDIR} ]];then
        mkdir -p ${WORKDIR}
    fi

    # Define file-name used as reference to create portable object
    # templates (.pot), portable objects (.po) and machine objects
    # (.mo).
    local FILE="${WORKDIR}/${TEXTDOMAIN}"

    # Redefine filter pattern in order to get shell scripts only.
    # Since centos-art.sh is written in Bash, centos-art.sh does
    # retrive translatable strings from shell scripts written in Bash
    # only.
    if [[ $ACTIONVAL =~ "$(cli_getRepoTLDir)/Scripts/Bash/.*$" ]];then
        FLAG_FILTER="${FLAG_FILTER}.*\.sh"
    else
        cli_printMessage "`gettext "The path provided can't be processed."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Build list of XML-base files which we want retrive translatable
    # strings from.
    cli_getFilesList

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
