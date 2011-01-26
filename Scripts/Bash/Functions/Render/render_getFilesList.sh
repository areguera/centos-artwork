#!/bin/bash
#
# render_getFilesList.sh -- This function redefines the list of files
# that will be rendered using matching list and translation path
# information as reference.
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

function render_getFilesList {

    local COMMONDIR=''
    local COMMONDIRCOUNT=0

    # Define source location to look files for. In order to define
    # source location we evaluate both matching list and translation
    # path information, and based on them, we set which is the source
    # location and extension used as reference to build list of file
    # names (without extension) to process for.
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
        EXTENSION='png\.sh'
    
    elif [[ "${MATCHINGLIST}" != "" ]] \
        && [[ "${TRANSLATIONPATH}" != "" ]];then
    
        # Use translations as source location.
        LOCATION="${TRANSLATIONPATH}"
        EXTENSION='png\.sh'
    
    fi

    # Make regular expression (FLAG_FILTER) variable local (to avoid
    # concatenation the next time cli_getFilesList function be
    # called), and redefine it to match files with specific extensions
    # inside specific locations.
    local FLAG_FILTER="${FLAG_FILTER}.*\.${EXTENSION}"

    # Define list of files to process.
    cli_getFilesList "$LOCATION"

    # Define common absolute paths in order to know when centos-art.sh
    # is leaving a directory structure and entering into another. This
    # information is required in order for centos-art.sh to know when
    # to apply last-rendition actions.
    for COMMONDIR in $(dirname "$FILES" | sort | uniq);do
        COMMONDIRS[$COMMONDIRCOUNT]=$(dirname $COMMONDIR)
        COMMONDIRCOUNT=$(($COMMONDIRCOUNT + 1))
    done

}
