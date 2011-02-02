#!/bin/bash
#
# render_loadConfig.sh -- This function specifies translation
# markers and replacements for anaconda progress `05-centosplus.png'
# slide.
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

    local INDEX=''

    # Define translation markers.
    SRC[0]='=TITLE='
    for INDEX in {1..6};do
        SRC[$INDEX]="=TEXT${INDEX}="
    done
    SRC[7]='=URL='

    # Define replacements for translation markers.
    DST[0]="`gettext "CentOS Plus Repository"`"

    DST[1]="`gettext "This repository is for items that actually upgrade certain base CentOS components. This repo will change CentOS to not be exactly like the upstream providers content."`"
    
    DST[2]="`gettext "The CentOS development team has tested every item in this repo, and they build and work under CentOS =MAJOR_RELEASE=. They have not been tested by the upstream provider, and are not available in the upstream products."`"

    DST[3]="`gettext "You should understand that use of the components removes the 100% binary compatibility with the upstream
    products."`"

    DST[4]=''
    DST[5]=''
    DST[6]=''

    DST[7]="=URL_WIKI=AdditionalResources/Repositories/CentOSPlus/"

}
