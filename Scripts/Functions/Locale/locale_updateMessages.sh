#!/bin/bash
#
# locale_updateMessages.sh -- This function extracts translatable
# strings from both XML-based files (using xml2po) and shell scripts
# (using xgettext). Translatable strings are initially stored in
# portable objects templates (.pot) which are later merged into
# portable objects (.po) in order to be optionally converted as
# machine objects (.mo).
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

function locale_updateMessages {

    local ACTIONNAM=''

    # Evaluate working directory to determine whether to use xml2po to
    # extract translatable strings from XML-based files or to use
    # xgettext to extract translatable strings from shell script
    # files.
    if [[ $WORKDIR =~ "^${BASEDIR}/(Identity|Manual)/$(cli_getCurrentLocale)" ]];then

        # Update translatable strings inside portable object templates
        # for XML-based files (e.g., scalable vector graphics).
        ACTIONNAM="${FUNCNAM}_updateMessageXml"

    elif [[ $WORKDIR =~ "^${BASEDIR}/Scripts/$(cli_getCurrentLocale)" ]];then

        # Update translatable strings inside portable object templates
        # for shell scripts (e.g., centos-art.sh script).
        ACTIONNAM="${FUNCNAM}_updateMessageShell"

    else
        cli_printMessage "`gettext "The path provided doesn't support localization."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Execute action name.
    if [[ $ACTIONNAM =~ "^${FUNCNAM}_[A-Za-z]+$" ]];then
        eval $ACTIONNAM
    else
        cli_printMessage "`gettext "A valid action is required."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
