#!/bin/bash
#
# verify_doLinkReport.sh -- This function outputs information about
# missing links that need to be installed and a confirmation question
# for users to accept the installation action. 
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
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function verify_doLinkReport {

    local LINK=''
    local LINKS_MISSING_MAX=0

    # Define max number of missing links.
    LINKS_MISSING_MAX=${#LINKS_MISSING[*]}

    # Output list header.
    cli_printMessage "`ngettext "The following link will be installed" \
        "The following links will be installed" "$LINKS_MISSING_MAX"`:"

    # Output list body.
    for LINK in ${LINKS_MISSING[@]};do
        cli_printMessage "${LINK}" 'AsResponseLine' 
    done

    # Request confirmation for further link installation.
    cli_printMessage "`gettext "Do you want to continue"`" 'AsYesOrNoRequestLine'

}
