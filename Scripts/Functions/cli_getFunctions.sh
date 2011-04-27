#!/bin/bash
#
# cli_getFunctions.sh -- This function loads funtionalities supported by
# centos-art.sh script.
#
# Copyright (C) 2009-2011 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_getFunctions {

    # Define variables as local to avoid conflicts outside.
    local FUNCNAMCALL=''
    local FUNCFILES=''

    # Build action-specifc script file list.
    FUNCFILES=$(ls ${FUNCDIR}/${FUNCDIRNAM}/${FUNCNAM}*.sh)

    for FILE in $FUNCFILES;do

        if [[ -x ${FILE} ]];then

            # Initialize action-specific functions.
            . $FILE

            # Export action-specific functions to current shell script
            # environment.
            FUNCNAMCALL=$(grep '^function ' $FILE | cut -d' ' -f2)
            export -f $FUNCNAMCALL

        else

            cli_printMessage "`eval_gettext "The \\\$FILE hasn't execution rights."`" 'AsErrorLine'
            cli_printMessage "${FUNCDIRNAM}" "AsToKnowMoreLine"

        fi

    done

    # Execute action passed to centos-art.sh script.
    if [[ $FUNCNAM != '' ]];then
        eval $FUNCNAM
    fi

}
