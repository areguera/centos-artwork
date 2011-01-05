#!/bin/bash
#
# manual_checkChapter.sh -- This function checks chapter structure. If
# it doesn't exist, create it.  Inside CentOS Artwork Repository
# chapters are the base structure used to organize documentation.
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

function manual_checkChapter {

    # Check chapter's directory existence.
    if [[ ! -d $ENTRYCHAPTER ]];then

        cli_printMessage "`gettext "The following documentation chapter will be created:"`"
        cli_printMessage "$ENTRYCHAPTER" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

        manual_updateChaptersFiles
        manual_updateChaptersMenu
        manual_updateChaptersNodes

    fi

}
