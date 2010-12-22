#!/bin/bash
#
# about_doLicense.sh -- This function provide the interface to read
# license information.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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
# $Id: about_doLicense.sh 538 2010-11-26 11:12:33Z al $
# ----------------------------------------------------------------------


function about_doLicense {

    local GPL_LARGE="/home/centos/artwork/trunk/Scripts/Bash/Functions/About/Config/copying"
    local GPL_SHORT="/home/centos/artwork/trunk/Scripts/Bash/Functions/About/Config/copying-short"

    # Build license message.
    local CLILICENSE="$CLINAME ($CLIVERSION) -- $CLIDESCRIP

        $CLICOPYRIGHT

        $(cat $GPL_SHORT)"

    # Output brief license message.
    cli_printMessage "$CLILICENSE" "AsHeadingLine"

    # Output full license message.
    cli_printMessage "`gettext "Do you want to read the full license?"`" 'AsYesOrNoRequestLine'
    less $GPL_LARGE

}
