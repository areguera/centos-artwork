#!/bin/bash
#
# verify_getActions.sh -- This function defines prepare actions.
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
# $Id$
# ----------------------------------------------------------------------

function verify_getActions {

    case $OPTIONNAM in

        --packages )
            verify_doPackages
            ;;

        --links )
            verify_doLinks
            ;;

        --environment )
            ;;

        --all )
            verify_doPackages
            verify_doLinks
            ;;

        * )
            cli_printMessage "`gettext "The option provided is not valid."`"
            cli_printMessage "$(caller)" "AsToKnowMoreLine"

    esac

}

