#!/bin/bash
#
# identity_loadConfig.sh -- This function defines GNOME display manager
# (GDM) pre-rendition configuration script.
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

function identity_loadConfig {

    # Deifne theme model.
    #THEMEMODEL='Default'

    # Define rendition actions. 
    ACTIONS[0]="LAST:renderDm:Gdm:800x600 1024x768 1280x1024 1360x768 \
        1680x1050 2048x1536 2560x960 2560x1240 3271x1227"

    return

}
