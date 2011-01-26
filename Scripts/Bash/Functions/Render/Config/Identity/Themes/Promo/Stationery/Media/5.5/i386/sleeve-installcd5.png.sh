#!/bin/bash
#
# render_loadConfig.sh -- This function specifies translation markers
# and replacements for installation media sleeves.
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
    SRC[1]='=MESSAGE1_HEAD='
    SRC[2]='=MESSAGE1_P1='
    SRC[3]='=MESSAGE1_P2='
    SRC[4]='=MESSAGE1_P3='
    SRC[5]='=ARCH='

    # Define replacement for specitif translation markers.
    DST[0]="`gettext "Install CD 5 of 6"`"

    DST[1]="`gettext "What is CentOS?"`"

    DST[2]="`gettext "CentOS is an Enterprise Linux distribution based
    on the freely available sources from Red Hat Enterprise Linux.
    Each CentOS version is supported for 7 years (by means of
    security updates)."`"

    DST[3]="`gettext "A new CentOS version is released every 2 years
    and each CentOS version is regularly updated (every 6 months) to
    support newer hardware."`"

    DST[4]="`gettext "This results in a secure, low-maintenance,
    reliable, predictable and reproducible environment."`"

    DST[5]="`gettext "for =ARCH= architectures"`"

}
