#!/bin/bash
#
# render_getFilesList.sh -- This function re-defines list of
# files that will be rendered using matching list and translation path
# information as reference.
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

function render_getFilesList {

    # Define short options we want to support.
    local ARGSS=""

    # Define long options we want to support.
    local ARGSL="filter:"

    # Parse arguments using getopt(1) command parser.
    cli_doParseArguments

    # Reset positional parameters using output from (getopt) argument
    # parser.
    eval set -- "$ARGUMENTS"

    # Define action to take for each option passed.
    while true; do
        case "$1" in
            --filter )
               REGEX="$2" 
               shift 2
               ;;
            * )
                break
        esac
    done

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
        EXTENSION='sed'
    
    elif [[ "${MATCHINGLIST}" != "" ]] \
        && [[ "${TRANSLATIONPATH}" != "" ]];then
    
        # Use translations as source location.
        LOCATION="${TRANSLATIONPATH}"
        EXTENSION='sed'
    
    fi
    
    # Re-define regular expression to match files with specific
    # extensions inside specific locations.
    REGEX="^$LOCATION/${REGEX}.*\.${EXTENSION}$"

    # Define list of files to process.
    cli_getFilesList "$LOCATION"

}
