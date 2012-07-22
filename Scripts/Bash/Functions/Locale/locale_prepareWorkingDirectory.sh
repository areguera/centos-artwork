#!/bin/bash
#
# locale_prepareWorkingDirectory.sh -- This function prepares the
# working directory where translation files should be stored.
#
# Copyright (C) 2012 The CentOS Project
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

function locale_prepareWorkingDirectory {

    if [[ ! -d ${L10N_WORKDIR} ]];then

        # Create localization working directory making parent
        # directories as needed. Subversion doesn't create directories
        # recursively, so we use the system's `mkdir' command and then
        # subversion to register the changes.
        mkdir -p ${L10N_WORKDIR}

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges "${L10N_BASEDIR}"

    fi

}
