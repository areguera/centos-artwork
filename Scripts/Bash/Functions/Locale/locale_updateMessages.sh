#!/bin/bash
#
# locale_updateMessages.sh -- This function extracts translatable
# strings from both XML-based files (using xml2po) and shell scripts
# (using xgettext). Translatable strings are initially stored in
# portable objects templates (.pot) which are later merged into
# portable objects (.po) in order to be optionally converted as
# machine objects (.mo).
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

function locale_updateMessages {

    # Verify current locale information to avoid English messages from
    # being localized to themselves.  The English language is used as
    # reference to write translatable strings inside the source files.
    if [[ ${CLI_LANG_LC} =~ '^en' ]];then
        cli_printMessage "`gettext "The English language cannot be localized to itself."`" --as-error-line
    fi

    # Verify directory passed as non-option argument to be sure it
    # supports localization.
    locale_isLocalizable "${ACTIONVAL}"
    if [[ $? -ne 0 ]];then
        cli_printMessage "`gettext "The path provided does not support localization."`" --as-error-line
    fi

    # Prepare working directory to receive translation files.
    locale_prepareWorkingDirectory ${L10N_WORKDIR}

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncronizeRepoChanges "${L10N_WORKDIR}"

    # Evaluate action value to determine whether to use xml2po to
    # extract translatable strings from XML-based files or to use
    # xgettext to extract translatable strings from shell script
    # files.
    if [[ $ACTIONVAL =~ "^${TCAR_WORKDIR}/trunk/(Documentation/Models/Docbook|Identity/Models)/.*$" ]];then

        # Update translatable strings inside the portable object
        # template related to XML-based files (e.g., scalable vector
        # graphics).
        locale_updateMessageXml

    elif [[ $ACTIONVAL =~ "^${TCAR_WORKDIR}/trunk/Scripts/Bash$" ]];then

        # Update translatable strings inside the portable object
        # template related to shell scripts (e.g., the centos-art.sh
        # script).
        locale_updateMessageShell

    else
        cli_printMessage "`gettext "The path provided doesn't support localization."`" --as-error-line
    fi

    # Syncronize changes between repository and working copy. At this
    # point, changes in the repository are merged in the working copy
    # and changes in the working copy committed up to repository.
    cli_syncronizeRepoChanges "${L10N_WORKDIR}"

}
