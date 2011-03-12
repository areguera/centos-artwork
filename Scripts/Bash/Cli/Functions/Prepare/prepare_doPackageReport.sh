#!/bin/bash
#
# prepare_doPackageReport.sh -- This function receives one list of
# missing packages and another list of packages from third party
# repository that were marked as missing packages.
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

function prepare_doPackageReport {

    local PACKAGE=''
    local WARNING=''

    cli_printMessage "`ngettext "The following package needs to be installed" \
        "The following packages need to be installed" \
        "$PACKAGES_COUNT"`:"

    for PACKAGE in ${PACKAGES_MISSING[@]};do

        # Is this package from third party?
        if [[ $PACKAGE =~ $PACKAGES_THIRD_FLAG_FILTER ]];then
            WARNING=" (`gettext "requires third party repository!"`)"
        fi

        cli_printMessage "${PACKAGE}${WARNING}" 'AsResponseLine'
        
    done

    cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'

}
