#!/bin/bash
#
# locale_updateMessageXml.sh -- This function parses XML-based files
# (e.g., scalable vector graphics), retrives translatable strings and
# creates/update gettext portable objects.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function locale_updateMessageXml {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Define filename used to create both portable object templates
    # (.pot) and portable objects (.po) files.
    local MESSAGES="${L10N_WORKDIR}/messages"

    # Define regular expression to match the file extension of all
    # XML-based source files that can be localized inside the working
    # copy.  Be aware that sometimes, source files and output files
    # are stored in the same location (e.g., when rendering
    # `tcar-ug.docbook' file the `tcar-ug.xhtml' is saved in the same
    # location). Avoid using output files as if they were source
    # files, when retriving translatable strings.
    local EXTENSION='(svg|docbook)'

    # Build list of files to process. When building the patter, be
    # sure the value passed through `--filter' be exactly evaluated
    # with the extension as prefix. Otherwise it would be difficult to
    # match files that share the same characters in their file names
    # (e.g., it would be difficult to match only `hello.docbook' if
    # `hello-world.docbook' also exists in the same location).
    local FILES=$(cli_getFilesList ${ACTIONVAL} \
        --pattern="${FLAG_FILTER}\.${EXTENSION}" \
        --maxdepth='1' --type="f" \
        | egrep -v '/[[:alpha:]]{2}_[[:alpha:]]{2}/')

    # Print action message.
    cli_printMessage "${MESSAGES}.pot" --as-updating-line

    # Normalize XML files, expand entities before retriving
    # translatable strings and create the portable object template
    # (.pot) from such output.  The translatable strings are retrived
    # from the normalized output of files, not files themselves
    # (because of this, we don't include `#: filename:line' output on
    # .pot files).  Entity expansion is also necessary for DocBook
    # documents to be processed correctly. Notice that some long
    # DocBook document structures might use entities to split the
    # document structure into smaller pieces so they could be easier
    # to maintain. Also, don't validate svg files the same way you
    # validate docbook files; Docbook files have a DOCTYPE definition
    # while svg files don't. Without a DOCTYPE definition, it isn't
    # possible for `xmllint' to validate the document. 
    if [[ $ACTIONVAL =~ '^.+/(branches|trunk)/Manuals/.+$' ]];then

        # Another issue to consider is the amount of source files that
        # are being processed through xml2po. When there are more than
        # one file, xml2po interprets only the first one and discards
        # the rest in the list. This way, when more than one file
        # exists in the list, it isn't convenient to provide xmllint's
        # output to xml2po's input. Once here, we can say that
        # in order to expand DocBook entities it is required that only
        # one file must be provided at localization time (e.g., using
        # the `--filter' option). Otherwise translation messages are
        # retrived from all files, but no entity expansion is realized
        # because xmllint wouldn't be used in such case.
        if [[ $(echo "$FILES" | wc -l) -eq 1 ]];then

            xmllint --valid --noent ${FILES} | xml2po -a - \
                | msgcat --output=${MESSAGES}.pot --width=70 --no-location -

        else

            xml2po -a ${FILES} \
                | msgcat --output=${MESSAGES}.pot --width=70 --no-location -

        fi

    elif [[ $ACTIONVAL =~ '^.+/(branches|trunk)/Identity/Models/.+$' ]];then

        xml2po -a ${FILES} \
            | msgcat --output=${MESSAGES}.pot --width=70 --no-location -

    else

        cli_printMessage "`gettext "The path provided doesn't support localization."`" --as-error-line

    fi

   # Verify, initialize or merge portable objects from portable object
   # templates.
   locale_updateMessagePObjects "${MESSAGES}"

}
