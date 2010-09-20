#!/bin/bash
#
# render_loadConfig.sh -- This function defines graphical boot (RHGB)
# pre-rendering configuration script.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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
# $Id: render.conf.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function render_loadConfig {

    # Define base rendering action.
    ACTIONS[0]='renderImage'

    # Define post-rendering actions.
    #ACTIONS[1]=''

    # Define matching list.
    MATCHINGLIST=''

    # Deifne theme model.
    #THEMEMODEL='Default'

}
