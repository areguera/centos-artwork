#!/bin/bash
#
# render_loadConfig.sh -- This function defines KDE display manager
# (KDM) pre-rendition configuration script.
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

function render_loadConfig {

    # Define rendition actions.
    ACTIONS[0]='BASE:renderImage'
    ACTIONS[1]="LAST:renderDm:KDM:800x600 1024x768 1280x1024 1360x768 \
        1680x1050 2048x1536 2560x960 2560x1240 3271x1227"

    # Define matching list.
    MATCHINGLIST=''

    # Deifne theme model.
    #THEMEMODEL='Default'

}
