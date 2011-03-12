#!/bin/bash
#
# document_searchIndex.sh -- This function does an index search inside the
# info document.
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

function document_searchIndex {

    # Check flag filter. By default flag filter has the `.+' value
    # which is not very descriptive in the sake of an index-search.
    # So, when no value is passed through --filter option use top node
    # as default value for index-search.
    if [[ "$FLAG_FILTER" == '.+' ]];then
        cli_printMessage "`gettext "Use the \\\`--filter' option to define the search pattern."`" 'AsErrorLine'
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Print action message.
    cli_printMessage "${MANUAL_BASEFILE}.info.bz2" 'AsReadingLine'

    # Execute info command to perform an index-search.
    /usr/bin/info --index-search="$FLAG_FILTER" --file=${MANUAL_BASEFILE}.info.bz2

}
