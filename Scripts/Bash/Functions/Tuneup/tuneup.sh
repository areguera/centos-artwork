#!/bin/bash
#
# tuneup.sh -- This function standardizes maintainance tasks for files
# inside the repository. Maintainance tasks are applied to files using
# file extension as reference.
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

function tuneup {

    local ACTIONNAM=''
    local ACTIONVAL=''

    # Initialize name of rendition format as an empty value. The name
    # of rendition format is determined automatically based on
    # template file extension, later, when files are processed.
    local TUNEUP_FORMAT=''

    # Initialize absolute path to format's base directory, the place
    # where format-specific directories are stored in.
    local TUNEUP_BASEDIR="${CLI_FUNCDIR}/${CLI_FUNCDIRNAM}"

    # Initialize list of supported file extensions. This is, the file
    # extensions we want to perform maintenance tasks for.
    local TUNEUP_EXTENSIONS='svg xhtml sh'

    # Interpret arguments and options passed through command-line.
    tuneup_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Define action name. No matter what option be passed to
    # centos-art, there is only one action to perform (i.e., build the
    # list of files and interpretation of file extensions for further
    # processing).
    ACTIONNAM="tuneup_doBaseActions"

    # Define action value. We use non-option arguments to define the
    # action value (ACTIONVAL) variable.
    for ACTIONVAL in "$@";do
        
        # Sanitate non-option arguments to be sure they match the
        # directory conventions established by centos-art.sh script
        # against source directory locations in the working copy.
        ACTIONVAL=$(cli_checkRepoDirSource ${ACTIONVAL})

        # Verify source location absolute path. It should point to
        # existent directories under version control inside the
        # working copy.  Otherwise, if it doesn't point to an existent
        # file under version control, finish the script execution with
        # an error message.
        cli_checkFiles ${ACTIONVAL} -d --is-versioned

        # Synchronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_synchronizeRepoChanges "${ACTIONVAL}"

        # Execute action name.
        ${ACTIONNAM}

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_synchronizeRepoChanges "${ACTIONVAL}"

    done

}
