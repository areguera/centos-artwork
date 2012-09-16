#!/bin/bash
#
# locale_editMessages.sh -- This function edits portable objects (.po)
# using default text editor.
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

function locale_editMessages {

    # Verify current locale information to avoid English messages from
    # being localized to themselves.  The English language is used as
    # reference to write translatable strings inside the source files.
    if [[ $(cli_getCurrentLocale) =~ '^en' ]];then
        cli_printMessage "`gettext "The English language cannot be localized to itself."`" --as-error-line
    fi

    # Verify directory passed as non-option argument to be sure it
    # supports localization.
    locale_isLocalizable "${ACTIONVAL}"
    if [[ $? -ne 0 ]];then
        cli_printMessage "`gettext "The path provided does not support localization."`" --as-error-line
    fi

    local PO_FILE=''
    local PO_FILES=''

    # Prepare working directory to receive translation files.
    locale_prepareWorkingDirectory ${L10N_WORKDIR}

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    ${CLI_NAME} svn --sync "${L10N_WORKDIR}"

    # Define list of PO files to process based on paths provided as
    # non-option arguments through centos-art.sh script command-line.
    if [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/(Documentation/Models/Docbook|Identity/Models)/.*$" ]];then

        # Define list of PO files for XML-based files.
        PO_FILES=$(cli_getFilesList ${L10N_WORKDIR} --type="f" --pattern="messages\.po$")

        # Do not create MO files for XML-based files.
        FLAG_DONT_CREATE_MO='true'

    elif [[ $ACTIONVAL =~ "^$(cli_getRepoTLDir)/Scripts/Bash$" ]];then

        # Define list of PO files for script files.
        PO_FILES=$(cli_getFilesList ${L10N_WORKDIR} --pattern="${FLAG_FILTER}/messages\.po$")

    else
        cli_printMessage "`gettext "The path provided does not support localization."`" --as-error-line
    fi

    # Verify list of PO files.
    if [[ $PO_FILES = "" ]];then
        cli_printMessage "`gettext "The path provided hasn't translations yet."`" --as-error-line
    else
        cli_printMessage '-' --as-separator-line
    fi

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
    # Notice that this is required only if we were localizaing shell
    # scripts.
    locale_updateMessageBinary

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    ${CLI_NAME} svn --sync "${L10N_WORKDIR}"

}
