#!/bin/bash
#
# render_loadConfig.sh -- This function specifies translation
# markers and replacements for anaconda progress `01-welcome.png'
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
    DST[0]="`gettext "Welcome to CentOS =MAJOR_RELEASE=!"`"

    DST[1]="`gettext "Thank you for installing CentOS =MAJOR_RELEASE=."`"

    DST[2]="`gettext "CentOS is an enterprise-class Linux Distribution derived from sources freely provided to the public by a prominent North American Enterprise Linux vendor."`"

    DST[3]="`gettext "CentOS conforms fully with the upstream vendors redistribution policy and aims to be 100% binary compatible."`"

    DST[4]="`gettext "CentOS mainly changes packages to remove upstream vendor branding and artwork."`"

    DST[5]=''
    DST[6]=''

    DST[7]="=URL=/=URLLOCALE="

}
