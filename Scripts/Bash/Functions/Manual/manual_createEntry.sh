#!/bin/bash
#
# manual_createEntry.sh -- This function creates a new documentation
# entry based on action value (ACTIONVAL).
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

function manual_createEntry {

    # Check chapter structure for this entry.
    manual_checkChapter

    # Update chapter-menu for this entry.
    manual_updateMenu

    # Update chapter-nodes (based on chapter-menu).
    manual_updateNodes

    # Update old missing cross references. If for some reason a
    # documentation entry is removed by mistake, and that mistake is
    # fixing by adding the removed documentation entry back into the
    # repository, rebuild the missing cross reference message to use
    # the correct link to the documentation section.
    manual_restoreCrossReferences

}
