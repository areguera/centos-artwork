#!/bin/bash
#
# svg.sh -- This function provides very basic SVG manipulations to
# help maintain svg files inside the repository.
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
    
function svg {

    local FILES=''

    # Define list of scalable vector graphic files to process using
    # option value as reference.
    if [[ -d $OPTIONVAL ]];then
        FILES=$(find $OPTIONVAL -regextype posix-egrep -type f -regex "^${REGEX}\.svg$")
    elif [[ -f $OPTIONVAL ]];then
        FILES=$OPTIONVAL
    fi

    # Check list of files to process. If list of files is empty there
    # is nothing to do except to print a message and end script
    # execution.
    if [[ $FILES == '' ]];then
        cli_printMessage "`gettext "There is no file to process."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Define command line interface for svg-based actions.
    svg_getActions

}
