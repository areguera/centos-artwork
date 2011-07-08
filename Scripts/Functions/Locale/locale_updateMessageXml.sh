#!/bin/bash
#
# locale_updateMessageXml.sh -- This function parses XML-based files
# (e.g., scalable vector graphics), retrives translatable strings and
# creates/update gettext portable objects.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
    local FILE="${WORKDIR}/messages"

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
    cli_printMessage "${FILE}.pot" --as-updating-line

    # Normalize XML files and expand entities before retriving
    # translatable strings and creating the portable object template
    # (.pot).  The translatable strings are retrived from the
    # normalized output of files, not files themselves (because of
    # this, we don't include `#: filename:line' output on .pot files).
    # Entity expansion is also necessary for DocBook documents to be
    # processed correctly. Notice that some long DocBook document
    # structures might use entities to split the document structure
    # into smaller pieces so they could be easier to maintain.
    xmllint --valid --noent ${FILES} | xml2po -a - \
        | msgcat --output=${FILE}.pot --width=70 --no-location -

    # Verify, initialize or merge portable objects from portable
    # object templates.
    ${FUNCNAM}_updateMessagePObjects "${FILE}"

}
