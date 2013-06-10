#!/bin/bash
#
# locale_editMessages.sh -- This function edits portable objects (.po)
# using default text editor.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function locale_editMessages {

    local PO_FILE=''
    local PO_FILES=''

    # Define location where translation files will be stored in
    # without language information in it. The language information is
    # put later, when we build the list of files.
    local L10N_WORKDIR=$(cli_getLocalizationDir "${ACTIONVAL}" "--no-lang")

    # Prepare working directory to receive translation files. Don't do
    # this here. It is already done as part the update actions, but we
    # need it here for those cases when no update action is run and
    # one execute the edit option.
    locale_prepareWorkingDirectory ${L10N_WORKDIR}

    # Define list of PO files to process based on paths provided as
    # non-option arguments through centos-art.sh script command-line.
    if [[ $ACTIONVAL =~ "^${TCAR_WORKDIR}/(Documentation/Models/(Docbook|Svg)|Identity/Models)/.*$" ]];then

        # Do not create MO files for XML-based files.
        FLAG_DONT_CREATE_MO='true'

    fi
     
    # Define list of PO files we want to work with. Don't forget to
    # include the language information here.
    PO_FILES=$(cli_getFilesList ${L10N_WORKDIR} --type="f" \
        --pattern=".+/${FLAG_FILTER}/${CLI_LANG_LC}/messages\.po$")

    # Verify list of PO files.
    if [[ $PO_FILES = "" ]];then
        cli_printMessage "`gettext "The path provided hasn't translations yet."`" --as-error-line
    else
        cli_printMessage '-' --as-separator-line
    fi

    # Synchronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_synchronizeRepoChanges "${PO_FILES}"

    # Loop through list of PO files to process in order to edit them
    # one by one using user's default text editor.
    for PO_FILE in ${PO_FILES};do

        # Print the file we are editing.
        cli_printMessage "${PO_FILE}" --as-updating-line

        # Use default text editor to edit the PO file.
        eval ${EDITOR} ${PO_FILE}

    done

    # At this point some changes might be realized inside the PO file,
    # so we need to update the related MO file based on recently
    # updated PO files here in order for `centos-art.sh' script to
    # print out the most up to date revision of localized messages.
    # Notice that this is required only if we were localizing shell
    # scripts.
    locale_updateMessageBinary

    # Synchronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_synchronizeRepoChanges "${PO_FILES}"

}
