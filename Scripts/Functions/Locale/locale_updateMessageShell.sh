#!/bin/bash
#
# locale_updateMessageShell.sh -- This function parses shell scripts
# source files under action value and retrives translatable strings in
# order to creates/updates both the portable object template (.pot)
# and the portable object (.po) related.
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

function locale_updateMessageShell {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Define file name used as reference to create portable object
    # templates (.pot), portable objects (.po) and machine objects
    # (.mo).
    local FILE="${L10N_WORKDIR}/${TEXTDOMAIN}"

    # Define regular expression to match extensions of XML files we
    # use inside the repository.
    local EXTENSION='sh'

    # Build list of files to process. When building the patter, be
    # sure the value passed through `--filter' be exactly evaluated
    # with the extension as prefix. Otherwise it would be difficult to
    # match files that share the same characters in their file names
    # (e.g., it would be difficult to match only `hello.sh' if
    # `hello-world.sh' also exists in the same location).
    local FILES=$(cli_getFilesList $ACTIONVAL --pattern="${FLAG_FILTER}\.${EXTENSION}")

    # Print action message.
    cli_printMessage "${FILE}.pot" --as-updating-line

    # Retrive translatable strings from shell script files and create
    # the portable object template (.pot) from them.
    /usr/bin/xgettext --output=${FILE}.pot \
        --copyright-holder="The CentOS L10n SIG" \
        --width=70 --sort-by-file ${FILES}

    # Sanitate portable object template metadata.
    locale_updateMessageMetadata "${FILE}.pot"

    # Verify, initialize or update portable objects from portable
    # object templates.
    locale_updateMessagePObjects "${FILE}"

}
