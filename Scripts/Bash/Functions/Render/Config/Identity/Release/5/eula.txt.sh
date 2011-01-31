#!/bin/bash
#
# render_loadConfig.sh -- This function specifies translation markers
# and replacements for EULA in plain-text format.
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
# $Id: splash.png.sh 963 2011-01-26 17:25:47Z al $
# ----------------------------------------------------------------------

function render_loadConfig {

    local INDEX=''

    # Define translation markers.
    SRC[0]='=TITLE='
    for INDEX in {1..2};do
        SRC[$INDEX]="=P${INDEX}="
    done

    # Define replacements for translation markers.
    DST[0]="`gettext "CentOS =RELEASE= EULA"`"

    DST[1]="`gettext "CentOS =RELEASE= comes with no guarantees or
    warranties of any sorts, either written or implied."`"

    DST[2]="`gettext "The Distribution is released as GPL. Individual
    packages in the distribution come with their own licences."`"

}
