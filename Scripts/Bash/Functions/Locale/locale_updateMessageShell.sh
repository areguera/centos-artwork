#!/bin/bash
#
# locale_updateMessageShell.sh -- This function parses shell scripts
# source files under action value and retrives translatable strings in
# order to creates/updates both the portable object template (.pot)
# and the portable object (.po) related.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

    # Define regular expression to match extensions of shell scripts
    # we use inside the repository.
    local EXTENSION='sh'

    # Define list of absolute paths to function directories.
    local FNDIRS=$(cli_getFilesList ${ACTIONVAL}/Functions \
        --maxdepth=1 --mindepth=1 --type='d' --pattern="/${FLAG_FILTER}$")

    for FNDIR in $FNDIRS;do

        # Define function name.
        local FNNAME=$(basename $FNDIR)

        # Define absolute path to directory used as reference to store
        # portable objects.
        local L10N_DIR=${L10N_WORKDIR}/Functions/${FNNAME}

        # Prepare working directory to receive translation files.
        locale_prepareWorkingDirectory ${L10N_DIR}

        # Define absolute path to file used as reference to create
        # portable objects.
        local MESSAGES="${L10N_DIR}/messages"

        # Print action message.
        cli_printMessage "${MESSAGES}.pot" --as-updating-line

        # Build list of files to process. When you build the pattern,
        # be sure the value passed through `--filter' will be exactly
        # evaluated with the extension as prefix. Otherwise it would
        # be difficult to match files that share the same characters
        # in their file names (e.g., it would be difficult to match
        # only `hello.sh' if `hello-world.sh' also exists in the same
        # location).
        local FILES=$(cli_getFilesList ${FNDIR} --pattern="\.${EXTENSION}$")

        # Retrive translatable strings from shell script files and
        # create the portable object template (.pot) from them.
        xgettext --output=${MESSAGES}.pot \
            --copyright-holder="${COPYRIGHT_HOLDER}" \
            --width=70 --sort-by-file ${FILES}

        # Sanitate metadata inside the POT file.
        locale_updateMessageMetadata "${MESSAGES}.pot"

        # Verify, initialize or update portable objects from portable
        # object templates.
        locale_updateMessagePObjects "${MESSAGES}"

    done

    # At this point some changes might be realized inside the PO file,
    # so we need to update the related MO file based on recently
    # updated PO files here in order for `centos-art.sh' script to
    # print out the most up to date revision of localized messages.
    # Notice that this is required only if we were localizaing shell
    # scripts.
    locale_updateMessageBinary

}
