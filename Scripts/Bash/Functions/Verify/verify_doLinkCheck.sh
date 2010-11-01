#!/bin/bash
#
# verify_doLinkCheck.sh -- This function receives a list of required
# symbolic links and verifies them. This function enforces relation
# between link names and their targets (previously defined in
# verify_doLinks.sh function).
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
# $Id$
# ----------------------------------------------------------------------

function verify_doLinkCheck {

    local -a LINKS_TARGET
    local LINKS_COUNT=0

    until [[ $LINKS_COUNT -eq ${#LINKS[*]} ]];do

        if [[ -h ${LINKS[$LINKS_COUNT]} ]]; then

            # At this point the required link does exist but we don't
            # know if its target is the one it should be. Get target
            # from required link in order to check it later.
            LINKS_TARGET[$LINKS_COUNT]=$(stat --format='%N' ${LINKS[$LINKS_COUNT]} \
                | tr '`' ' ' | tr "'" ' ' | tr -s ' ' | cut -d' ' -f4)

            # Check required target from required link in order to
            # know if it is indeed the one it should be. Otherwise add
            # required link to list of missing links.
            if [[ ${LINKS_TARGET[$LINKS_COUNT]} != ${TARGETS[$LINKS_COUNT]} ]] ;then
                LINKS_MISSING[$LINKS_COUNT]=${LINKS[$LINKS_COUNT]}
                LINKS_MISSING_ID="$LINKS_MISSING_ID $LINKS_COUNT"
            fi

        else

            # At this point the required link doesn't exist at all.
            # Add required link to list of missing links.
            LINKS_MISSING[$LINKS_COUNT]=${LINKS[$LINKS_COUNT]}
            LINKS_MISSING_ID="$LINKS_MISSING_ID $LINKS_COUNT"

        fi

        # Increase link counter.
        LINKS_COUNT=$(($LINKS_COUNT + 1))
        
    done

    # Stript out leading spaces from missing links ids.
    LINKS_MISSING_ID=$(echo $LINKS_MISSING_ID | sed 's!^ +!!')

    # If there is no missing link, end script execution with a
    # descriptive output.
    if [[ ${#LINKS_MISSING[*]} -eq 0 ]];then
        cli_printMessage "`gettext "The required links are already installed."`"
        cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

}
