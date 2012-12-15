#!/bin/bash
#
# locale.sh -- This function provides internationalization features
# for centos-art.sh script through GNU gettext standard processes.
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

function locale {

    local ACTIONNAMS=''
    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize machine object flag (`--dont-create-mo').  This flag
    # controls whether the centos-art.sh script does create/update
    # machine object (MO) files from related portable object (PO)
    # files or not. By default, MO files are created.
    local FLAG_DONT_CREATE_MO='false'

    # Define localization (l10n) base directory. This is the place
    # where all translation messages are organized in. Translation
    # messages are organized herein using the same layout of the
    # components they represent under the `Identity',
    # `Documentation/Manuals' or `Scripts' directory structures.  The
    # localization base directory must be used as source location for
    # control version system operations (e.g., status, update, commit,
    # etc.).  Otherwise, it would be difficult to add directory
    # structures that have several levels down from the localization
    # base directory up to the repository (e.g.,
    # subversion-1.4.2-4.el5_3.1.i386.rpm doesn't support recursive
    # creation of directories which parent directories doesn't
    # exist.).
    local L10N_BASEDIR="${TCAR_WORKDIR}/Locales"

    # Interpret arguments and options passed through command-line.
    locale_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "${ARGUMENTS}"

    # Loop through non-option arguments passed to centos-art.sh script
    # through its command-line.
    for ACTIONVAL in "$@";do

        # Sanitate non-option arguments to be sure they match the
        # directory conventions established by centos-art.sh script
        # against source directory locations in the working copy.
        ACTIONVAL=$(cli_checkRepoDirSource ${ACTIONVAL})

        # Verify non-option arguments passed to centos-art.sh
        # command-line. It should point to an existent directory under
        # version control inside the working copy.  Otherwise, if it
        # doesn't point to a directory under version control, finish
        # the script execution with an error message.
        cli_checkFiles ${ACTIONVAL} -d --is-versioned

        # Define localization working directory using directory passed
        # as non-option argument. The localization working directory
        # is the place where POT and PO files are stored inside the
        # working copy.
        L10N_WORKDIR=$(echo "${ACTIONVAL}" \
            | sed -r -e "s!(Identity|Scripts|Documentation)!Locales/\1!")/${CLI_LANG_LC}

        # Execute localization actions provided to centos-art.sh
        # script through its command-line. Notice that localization
        # actions will be executed in the same order they were
        # provided in the command-line.
        for ACTIONNAM in ${ACTIONNAMS};do
            ${ACTIONNAM}
        done

    done

}
