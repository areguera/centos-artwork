#!/bin/bash
#
# verify_doPackageInstall.sh -- This function receives a list of
# missing packages and installs them using sudo yum.
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
# $Id$
# ----------------------------------------------------------------------

function verify_doPackageInstall {

    # Verify `yum' command existence.
    cli_checkFiles '/usr/bin/yum' 'f' '' '--quiet'
    if [[ $? -ne 0 ]];then
        cli_printMessage "`gettext "The yum package manager is not installed."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Use sudo to install packages in your system through yum.
    sudo yum install ${PACKAGES_MISSING[*]}

}
