#!/bin/bash
#
# help_editEntry.sh -- This function edits documentation entry based
# on entry pattern.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function help_editEntry {

    # Check chapter existence. In order to create/edit a section the
    # chapter of that section needs to exist first. If the chapter
    # hasn't been created, where are you going to store the section
    # files?  Put the chapter's checker here.
    help_checkChapter

    # Check section existence.
    help_checkEntry

    # Use default text editor to edit the documentation entry.
    eval $EDITOR $ENTRY

    # Re-build output files to propagate recent changes.
    help_updateOutputFiles

}
