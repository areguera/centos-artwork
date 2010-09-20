#!/bin/bash
#
# cli_checkOptionValue.sh -- This function provides input validation
# for the option value (OPTIONVAL) variable.
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
# $Id: cli_checkOptionValue.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function cli_checkOptionValue {

    # Check option value before making an absolute path from it. 
    if [[ $OPTIONVAL =~ '(\.\.(/)?)' ]];then
        cli_printMessage "`gettext "The path provided can't be processed."`"
        cli_printMessage "trunk/Scripts/Bash/Functions --filter='cli_checkOptionValue.sh" "AsToKnowMoreLine"
    fi
    if [[ ! $OPTIONVAL =~ '^[A-Za-z0-9\./-]+$' ]];then
        cli_printMessage "`gettext "The path provided can't be processed."`"
        cli_printMessage "trunk/Scripts/Bash/Functions --filter='cli_checkOptionValue.sh" "AsToKnowMoreLine"
    fi

    # Re-define option value to match the correct absolute path. As we
    # are removing /home/centos/artwork/ from all centos-art.sh output
    # (in order to save space), we need to be sure that all strings
    # begining with trunk/..., branches/..., and tags/... use the
    # correct absolute path. That is, you can refer trunk's entries
    # using both /home/centos/artwork/trunk/... or just trunk/..., the
    # /home/centos/artwork/ part is automatically added here. 
    if [[ $OPTIONVAL =~ '^(trunk|branches|tags)' ]];then
        OPTIONVAL=/home/centos/artwork/$OPTIONVAL
    fi

    # Build absolute path from option value. It is required for the
    # option value to point a valid directory. Otherwise leave a
    # message and quit script execution.
    if [[ -d $OPTIONVAL ]];then

        # Add directory to the top of the directory stack.
        pushd "$OPTIONVAL" > /dev/null

        # Re-define option value using absolute path.
        OPTIONVAL=$(pwd)

        # Remove directory from the directory stack.
        popd > /dev/null

    else
        cli_printMessage "`gettext "The path provided is not a valid directory."`"
        cli_printMessage "trunk/Scripts/Bash/Functions --filter='cli_checkOptionValue.sh" "AsToKnowMoreLine"
    fi

}
