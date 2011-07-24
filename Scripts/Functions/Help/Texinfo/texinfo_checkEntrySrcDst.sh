#!/bin/bash
#
# texinfo_checkEntrySrcDst.sh -- This function standardizes
# verification actions of source and target locations for tasks like
# copying and renaming.
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

function texinfo_checkEntrySrcDst {

    # Initialize entry source absolute path.
    local MANUAL_ENTRY_SRC="$1"

    # Initialize entry target absolute path.
    local MANUAL_ENTRY_DST="$2"

    # Verify existence of source location.
    if [[ ! -a ${MANUAL_ENTRY_SRC} ]];then
        cli_printMessage "`gettext "The source location doesn't exist."`" --as-error-line
    fi

    # Verify source and target locations to be sure they are different
    # one another. We cannot copy a source location to itself.
    if [[ $MANUAL_ENTRY_SRC == $MANUAL_ENTRY_DST ]];then
        cli_printMessage "`gettext "The source and target locations cannot be the same."`" --as-error-line
    fi

    # Verify source location to be sure it is under version control
    # and there isn't pending change to be committed first.
    if [[ $(cli_isVersioned ${MANUAL_ENTRY_SRC}) == 'true' ]];then
        if [[ $(cli_getRepoStatus ${MANUAL_ENTRY_SRC}) != '' ]];then
            cli_printMessage "`gettext "The source location has pending changes."`" --as-error-line
        fi
    else
        cli_printMessage "`gettext "The source location isn't under version control."`" --as-error-line
    fi

    # Verify target directory where the source will be duplicated in.
    # The target directory must exist before copying the source
    # location into it. If it doesn't exist, use subversion to create
    # it it.
    if [[ ! -d $(dirname ${MANUAL_ENTRY_DST}) ]];then
        svn mkdir $(dirname ${MANUAL_ENTRY_DST}) --quiet
    fi

    # Verify existence of target location.
    if [[ -a ${MANUAL_ENTRY_DST} ]];then
        cli_printMessage "`gettext "The target location already exists."`" --as-error-line
    fi

}
