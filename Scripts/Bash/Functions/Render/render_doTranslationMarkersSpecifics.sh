#!/bin/bash
#
# render_doTranslationMarkersSpecifics.sh -- This function
# standardizes replacements for specific translation markers.
# Raplacements are applied to temporal instances used to produce the
# final file.
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

function render_doTranslationMarkersSpecifics {

    # Initialize variables.
    local -a SRC
    local -a DST
    local COUNT=0

    # Initialize specific translation markers (SRC) variable, and
    # replacement (DST) variable using the appropriate translation
    # file as reference.
    if [[ -x ${TRANSLATION} ]];then
        # Initialize action-specific functions.
        . $TRANSLATION
    else
        cli_printMessage "`eval_gettext "The \\\$TRANSLATION hasn't execution rights."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Execute function to retrive specific translation markers and
    # specific replacement values.
    eval render_loadConfig

    # Apply specific replacements for specific translation markers.
    while [[ ${COUNT} -lt ${#SRC[*]} ]];do

        # Escape the character used as separator inside sed's
        # replacement command.
        DST[$COUNT]=$(echo ${DST[$COUNT]} | sed -r 's/!/\\!/g' )

        # Use sed to replace specific translation markers inside the
        # design model instance.
        sed -r -i "s!${SRC[$COUNT]}!${DST[$COUNT]}!g" $INSTANCE

        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

    # Unset specific translation markers and specific replacement
    # variables in order to clean them up. Otherwise, undesired values
    # may ramain from one file to another.
    unset SRC
    unset DST

}
