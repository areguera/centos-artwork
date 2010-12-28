#!/bin/bash
#
# manual_updateTexinfoStructure.sh -- This function updates texinfo
# documentation structure based on a documentation entry. This
# function is useful to keep documentation structure syncronized with
# repository directory structure. 
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

function manual_updateTexinfoStructure {

    # Update Texinfo menu information.
    manual_updateMenu

    # Update Texinfo nodes information.
    manual_updateNodes

    # Update Texinfo cross-reference information.
    manual_restoreCrossReferences

    # Update Texinfo output.
    manual_updateOutputFiles

}
