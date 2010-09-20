#!/bin/bash
#
# render_getIdentityFileslist.sh -- This function re-defines list of
# files that will be rendered using matching list and translation path
# information as reference.
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
# $Id: render_getIdentityFileslist.sh 53 2010-09-17 10:51:42Z al $
# ----------------------------------------------------------------------

function render_getIdentityFileslist {

    if [[ "${MATCHINGLIST}" != "" ]] \
        && [[ "${TRANSLATIONPATH}" == "" ]];then

        # Use design template as source location.
        LOCATION="$SVG"
        EXTENSION='svg'

    elif [[ "${MATCHINGLIST}" == "" ]] \
        && [[ "${TRANSLATIONPATH}" == "" ]];then
          
        # Use design template as source location.
        LOCATION="$SVG"
        EXTENSION='svg'
    
    elif [[ "${MATCHINGLIST}" == "" ]] \
        && [[ "${TRANSLATIONPATH}" != "" ]];then
        
        # Use translations as source location.
        LOCATION="${TRANSLATIONPATH}"
        EXTENSION='sed'
    
    elif [[ "${MATCHINGLIST}" != "" ]] \
        && [[ "${TRANSLATIONPATH}" != "" ]];then
    
        # Use translations as source location.
        LOCATION="${TRANSLATIONPATH}"
        EXTENSION='sed'
    
    fi

    # Re-define filter string to apply.  
    FILTER="^$LOCATION/${REGEX}.*\.${EXTENSION}$"

    # Re-define list of file to render using filter string.
    FILES=$(find $LOCATION -regextype posix-egrep -regex "$FILTER" | sort )

}
