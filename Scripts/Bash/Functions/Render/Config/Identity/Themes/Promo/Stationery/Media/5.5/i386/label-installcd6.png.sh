#!/bin/bash
#
# render_loadConfig.sh -- This function specifies translation markers
# and replacements for installation media labels.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function render_loadConfig {

    # Define specific translation markers.
    SRC[0]='=TEXT='
    SRC[1]='=ARCH='

    # Define replacement for specitif translation markers.
    DST[0]="`gettext "Install CD 6 of 6"`"
    DST[1]="`gettext "for =ARCH= architectures"`"

}
