#!/bin/bash
#
# path_getActions.sh -- This function defines the command-line
# interface used to manipulate repository files.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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
    
function path_getActions {

    # Define source location we are going to work with.
    local SOURCE="$ACTIONVAL"

    # Evaluate action name and define which actions does centos-art.sh
    # script supports.
    while true; do
        case "$ACTIONNAM" in

            '--copy' )
                # Duplicate something in working copy or repository,
                # remembering history.
                path_doCopy
                break
                ;;

            '--move' )
                # Move and/or rename something in working copy or
                # repository.
                # --- path_doMove
                ;;

            '--delete' )
                # Remove files and directories from version control.
                # --- path_doDelete
                ;;
    
            '--sync' )
                # Syncronize parallel dirctories with parent directory.
                # --- path_doSync
                ;;

            * )
                cli_printMessage "`gettext "The option provided is not valid."`" 'AsErrorLine'
                cli_printMessage "$(caller)" 'AsToKnowMoreLine'
                ;;

        esac
    done
    
}
