#!/bin/bash
#
# about_getActions.sh -- This function initializes license
# functionalities, using the action value of centos-art.sh script as
# reference.
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
# $Id: about_getActions.sh 538 2010-11-26 11:12:33Z al $
# ----------------------------------------------------------------------
    
function about_getActions {

    local FILE=''

    # Evaluate action name and define which actions does centos-art.sh
    # script supports.
    case $ACTIONNAM in

        '--license' )
            FILE='/home/centos/artwork/trunk/Scripts/Bash/Functions/About/Config/license.txt'
            ;;
        '--history' )
            FILE='/home/centos/artwork/trunk/Scripts/Bash/Functions/About/Config/history.txt'
            ;;
        '--authors' )
            FILE='/home/centos/artwork/trunk/Scripts/Bash/Functions/About/Config/authors.txt'
            ;;
        '--copying' )
            FILE='/home/centos/artwork/trunk/Scripts/Bash/Functions/About/Config/copying.txt'
            ;;
        * )
            cli_printMessage "`gettext "The option provided is not valid."`" 'AsErrorLine'
            cli_printMessage "$(caller)" 'AsToKnowMoreLine'
            ;;
    esac

    # Print file for user to read.
    less $FILE

}
