#!/bin/bash
#
# locale_editMessages.sh -- This function edits portable objects (.po)
# using default text editor.
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

function locale_editMessages {

    local FILES=''

    # Define list of files to process.  In order to make edition
    # easier for translators, the current locale information is used
    # to determine which portable object to edit.  If filter flag is
    # set to something else but its default value (i.e., it was
    # specified in the command line), the value entered is used
    # instead.
    if [[ $FLAG_FILTER == '.+' ]];then
        FILES=$(cli_getFilesList "${WORKDIR}" "${TEXTDOMAIN}\.po")
    else
        FILES=$(cli_getFilesList "${WORKDIR}" "${FLAG_FILTER}\.po")
    fi

    # Set action preamble.
    cli_printActionPreamble "${FILES}" "doEdit" 'AsResponseLine'

    # Use default text editor to edit files.
    eval ${EDITOR} ${FILES}

    # Update machine object (.mo) from portable object (.po).
    locale_updateMessageBinary ${FILES}

}
