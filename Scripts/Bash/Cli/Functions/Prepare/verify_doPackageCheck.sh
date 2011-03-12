#!/bin/bash
#
# verify_doPackageCheck.sh -- This function receives a list of
# packages and verifies if they are currently installed in your
# system. Third party package verification is also done here.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function verify_doPackageCheck {

    local PACKAGE=''

    # Check package manager command existance.
    cli_checkFiles '/bin/rpm' 'x'

    for PACKAGE in $PACKAGES;do

        # Query your system's RPM database.
        rpm -q --queryformat "%{NAME}\n" $PACKAGE --quiet

        # Define missing packages.
        if [[ $? -ne 0 ]];then
            PACKAGES_MISSING[$PACKAGES_COUNT]=$PACKAGE
        fi

        # Increase package counter.
        PACKAGES_COUNT=$(($PACKAGES_COUNT + 1))

    done

    # In there is no missing package, end script execution with a
    # descriptive output.
    if [[ ${#PACKAGES_MISSING[*]} -eq 0 ]];then
        cli_printMessage "`gettext "The required packages are already installed."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
