#!/bin/bash
#
# cli_getActions.sh -- This function loads funtionalities supported by
# centos-art.sh script.
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
# $Id$
# ----------------------------------------------------------------------

function cli_getActions {

    # Define variables as local to avoid conflicts outside.
    local ACTIONDIR=''
    local ACTIONFILES=''
    local ACTIONSCRIPT=''
    local ACTIONFUN=''
    local REPOFUNDIR=''

    # Define path to directory where actions are stored inside the
    # repository.
    REPOFUNDIR=/home/centos/artwork/trunk/Scripts/Bash/Functions

    # Define action directory. 
    ACTIONDIR=$(cli_getRepoName $ACTION 'd')

    # Define action file name.
    ACTIONSCRIPT=${REPOFUNDIR}/${ACTIONDIR}/${ACTION}.sh

    # Check action existence.
    if [[ ! -f $ACTIONSCRIPT ]];then
        cli_printMessage "`gettext "The action provided is not valid."`"
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Build action-specifc script file list.
    ACTIONFILES=$(ls ${REPOFUNDIR}/${ACTIONDIR}/${ACTION}*.sh)

    for FILE in $ACTIONFILES;do

        if [[ -x ${FILE} ]];then

            # Initialize action-specific functions.
            . $FILE

            # Export action-specific functions to current shell script
            # environment.
            ACTIONFUN=$(grep '^function ' $FILE | cut -d' ' -f2)
            export -f $ACTIONFUN

        else

            cli_printMessage "`eval_gettext "The \\\$FILE hasn't execution rights."`"
            cli_printMessage "$(caller)" "AsToKnowMoreLine"

        fi

    done

    # Execute action passed to centos-art.sh script.
    eval $ACTION

}
