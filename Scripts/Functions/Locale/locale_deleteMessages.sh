#!/bin/bash
#
# locale_deleteMessages.sh -- This function deletes the source files'
# localization directory from the working copy in conjunction with all
# portable objects and machine objects inside it. 
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

function locale_deleteMessages {

    # Print separator line.
    cli_printMessage '-' --as-separator-line

    # Print action message.
    cli_printMessage "$WORKDIR" --as-deleting-line

    # Verify existence of localization working directory. We cannot
    # remove translation files that don't exist.
    cli_checkFiles "$WORKDIR"

    # Delete localization working directory using subversion quietly.
    svn del "$WORKDIR" --quiet

}
