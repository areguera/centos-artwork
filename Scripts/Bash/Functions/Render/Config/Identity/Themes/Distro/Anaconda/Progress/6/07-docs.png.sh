#!/bin/bash
#
# render_loadConfig.sh -- This function specifies translation
# markers and replacements for anaconda progress `07-docs.png' slide.
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
    for INDEX in {1..17};do
        SRC[$INDEX]="=TEXT${INDEX}="
    done
    SRC[18]='=URL='

    # Define replacements for translation markers.
    DST[0]="`gettext "CentOS Documentation"`"
    DST[1]="`gettext "The following documentation is available for CentOS:"`"
    DST[2]="• `gettext "Deployment Guide"`"
    DST[3]="• `gettext "Installation Guide"`"
    DST[4]="• `gettext "Virtualization Guide"`"
    DST[5]="• `gettext "Cluster Suite Overview"`"
    DST[6]="• `gettext "Cluster Administration"`"
    DST[7]="• `gettext "Cluster Logical Volume Manager"`"
    DST[8]="• `gettext "Global File System"`"
    DST[9]="• `gettext "Global Network Block Device"`"
    DST[10]="• `gettext "Virtual Server Administration"`"
    DST[11]="• `gettext "Managing Software with yum"`"
    DST[12]="• `gettext "Using YumEx"`"
    DST[13]="• `gettext "Release notes for all software"`"

    DST[14]=''
    DST[15]=''
    DST[16]=''
    DST[17]=''

    DST[18]="=URL_DOCS==MAJOR_RELEASE=/"

}
