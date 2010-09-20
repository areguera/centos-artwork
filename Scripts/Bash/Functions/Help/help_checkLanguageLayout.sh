#!/bin/bash
#
# help_checkLanguageLayout.sh -- This function checks the language
# layout used to store texinfo documentation inside CentOS Artwork
# Repository.  If the language layout doesn't exists inside the
# documentation structure, ask the user to create it.  
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
# $Id: help_checkLanguageLayout.sh 44 2010-09-17 05:58:18Z al $
# ----------------------------------------------------------------------

function help_checkLanguageLayout {

    if [[ ! -d ${MANUALS_DIR[2]} ]];then

        cli_printMessage "`gettext "The following documentation entry will be created:"`"
        cli_printMessage "${MANUALS_DIR[2]}" "AsResponseLine"
        cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"

        help_createLanguageLayout
        help_addNewFilesToWorkingCopy ${MANUALS_DIR[1]}

    fi

}
