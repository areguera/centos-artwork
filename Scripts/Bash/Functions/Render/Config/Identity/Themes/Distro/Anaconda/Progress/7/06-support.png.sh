#!/bin/bash
#
# render_loadConfig.sh -- This function specifies translation
# markers and replacements for anaconda progress `06-support.png'
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
    DST[0]="`gettext "Help with CentOS"`"

    DST[1]="`gettext "You can get help with CentOS in several ways, including:"`"

    DST[2]="`gettext "<flowSpan style=\\\"font-weight:bold\\\">Internet Relay Chat (IRC)</flowSpan> - #centos, #centos-social and
    #centos-devel on irc.freenode.net."`"

    DST[3]="`gettext "<flowSpan style=\\\"font-weight:bold\\\">Mailing Lists</flowSpan> - CentOS, CentOS-Devel, CentOS-Annouces and non-English localized language lists from http://centos.org/."`"

    DST[4]="`gettext "<flowSpan
    style=\\\"font-weight:bold\\\">Forums</flowSpan> - Available at http://centos.org/forums/."`"
    
    DST[5]="`gettext "<flowSpan style=\\\"font-weight:bold\\\">Wiki</flowSpan> - Available at http://centos.org/wiki/."`"

    DST[6]=''

    DST[7]='=URL_WIKI=GettingHelp'

}
