#!/bin/bash
#
# help_getActions.sh -- This function initializes documentation
# functionalities, using option value as reference.
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
# $Id: help_getActions.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function help_getActions {

    help_checkLanguageLayout

    case $OPTIONNAM in
    
    --search )
        help_searchIndex
        ;;
    
    --edit )
        help_editEntry
        ;;
    
    --remove )
        help_removeEntry
        ;;
    
    --update )
        help_updateOutputFiles
        ;;
    
    --read )
        help_searchNode
        ;;

    * )
        cli_printMessage "`gettext "The option provided is not valid."`"
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
        ;;
    
    esac

}
