#!/bin/bash
#
# render_getIdentityBase.sh -- This function initiates rendition features
# taking BASEACTIONS as reference.
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

function render_getIdentityBase {

    local FILES=''
    local PARENTDIR=''
    local TEMPLATE=''
    local COMMONDIR=''
    local COMMONDIRCOUNT=0
    local -a COMMONDIRS

    # Redefine parent directory for current workplace.
    PARENTDIR=$(basename "$ACTIONVAL")

    # Define base location of template files.
    render_getIdentityDirTemplate
    
    # Define list of files to process. 
    FILES=$(cli_getFilesList "${TEMPLATE}" "${FLAG_FILTER}.*\.(svgz|svg)")

    # Set action preamble.
    cli_printActionPreamble "${FILES}"

    # Define common absolute paths in order to know when centos-art.sh
    # is leaving a directory structure and entering into another. This
    # information is required in order for centos-art.sh to know when
    # to apply last-rendition actions.
    for COMMONDIR in $(dirname "$FILES" | sort | uniq);do
        COMMONDIRS[$COMMONDIRCOUNT]=$(dirname "$COMMONDIR")
        COMMONDIRCOUNT=$(($COMMONDIRCOUNT + 1))
    done

    # Execute base-rendition action.
    render_doIdentityImages

}
