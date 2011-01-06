#!/bin/bash
#
# manual_doCopy.sh -- This function copies documentation entries and
# update documentation structure to reflect changes.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function manual_doCopy {

    # Verify target directory.
    cli_checkRepoDirTarget

    # Transform FLAG_TO path into a documentation entry.
    FLAG_TO=$(manual_getEntry "${FLAG_TO}")

    # Print action preamble.
    cli_printActionPreamble "${FLAG_TO}" 'doCreate' 'AsResponeLine'

    # Print action message.
    cli_printMessage "$FLAG_TO" 'AsCreatingLine'

    # Copy documentation entry.
    svn cp "${ENTRY}" "${FLAG_TO}" --quiet

    # Redefine documentation ENTRY variable in order to update
    # documentation structure based on the new documentation entry
    # specified by FLAG_TO path. At this point the new documentation
    # entry should be created and available inside the working copy,
    # so we are safe to update documentation structure using the new
    # documentation entry as regular documentation entry.
    ENTRY="${FLAG_TO}"

    # Update Texinfo menu information.
    manual_updateMenu

    # Update Texinfo nodes information.
    manual_updateNodes

    # Update Texinfo cross-reference information.
    manual_restoreCrossReferences

}
