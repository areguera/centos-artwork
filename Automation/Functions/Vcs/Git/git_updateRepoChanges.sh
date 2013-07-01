#!/bin/bash
#
# git_updateRepoChanges.sh -- This function standardizes the way
# changes are merged into the repository's local working copy.
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

function git_updateRepoChanges {

    # Print action message.
    cli_printMessage "`gettext "Bringing changes from the repository into the working copy"`" --as-banner-line

    # Update working copy and retrieve update output.  When we use
    # git, it is not possible to bring changes for specific
    # directories trees but the whole repository tree. So, we need to
    # position the script in the local working copy directory and
    # execute the pull command therein.
    #
    # NOTE: The `${COMMAND} pull' command triggers the error `Unable
    # to determine absolute path of git directory' while fetch and
    # merge equivalents seems to do what we expect without any visible
    # error.
    ${COMMAND} fetch
    ${COMMAND} merge FETCH_HEAD

}
