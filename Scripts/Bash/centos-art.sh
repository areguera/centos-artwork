#!/bin/bash
#
# centos-art.sh -- The CentOS Artwork Repository automation tool.
#
# Copyright (C) 2009-2012 The CentOS Project
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

# Initialize script-specific configuration variables.
declare -xr CLI_NAME='centos-art'
declare -xr CLI_PPID=$$
declare -xr CLI_VERSION='1.0'
declare -xr CLI_USRCONF=${HOME}/.${CLI_NAME}.conf
declare -xr CLI_TEMPDIR='/tmp'

# Initialize user-specific path information.
declare -x  CLI_WRKCOPY=${HOME}/Projects/CentOS
declare -x  COPYRIGHT_HOLDER="The CentOS Project"
declare -x  COPYRIGHT_YEAR_FIRST="2009"
declare -x  BRAND_FILENAME="centos"
if [[ -x ${CLI_USRCONF} ]];then 
    . ${CLI_USRCONF}
fi
declare -xr CLI_BASEDIR="${CLI_WRKCOPY}/trunk/Scripts/Bash"
declare -xr CLI_FUNCDIR=${CLI_BASEDIR}/Functions

# Initialize internazionalization through GNU gettext.
. gettext.sh
declare -xr TEXTDOMAIN=${CLI_NAME}.sh
declare -xr TEXTDOMAINDIR=${CLI_WRKCOPY}/trunk/Locales/Scripts

# Initialize command-line interface.
if [[ -x ${CLI_FUNCDIR}/Commons/init.sh ]];then
    . ${CLI_FUNCDIR}/Commons/init.sh; export -f init ; init "$@"
fi
