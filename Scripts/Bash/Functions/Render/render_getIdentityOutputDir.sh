#!/bin/bash
#
# render_getIdentityOutputDir.sh -- This function re-defines final
# output directory used to store rendered identity artworks.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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

function render_getIdentityOutputDir {

    # By default rendered identity artworks are stored immediatly
    # under identity entry structure.
    IMG=$ACTIONVAL

    # But if Img/ or Txt/ directory exists, use it instead.
    if [[ -d $ACTIONVAL/Img ]]; then
        IMG=$ACTIONVAL/Img
    elif [[ -d $ACTIONVAL/Txt ]]; then
        IMG=$ACTIONVAL/Txt
    fi

}
