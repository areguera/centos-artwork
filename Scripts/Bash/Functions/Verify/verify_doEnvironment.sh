#!/bin/bash
#
# verify_doEnvironment.sh -- This function outputs a brief description
# of environment variables used by `centos-art.sh' script.
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

function verify_doEnvironment {

    local -a VARS
    local -a INFO
    local COUNT=0

    # Define name of environment variables used by centos-art.sh
    # script.
    VARS[0]='EDITOR'
    VARS[1]='TZ'
    VARS[2]='TEXTDOMAIN'
    VARS[3]='TEXTDOMAINDIR'
    VARS[4]='LANG'

    # Define description of environment variables.
    INFO[0]="`gettext "Default text editor"`"
    INFO[1]="`gettext "Default time zone representation"`"
    INFO[2]="`gettext "Default domain used to retrieve translated messages"`"
    INFO[3]="`gettext "Default directory used to retrive translated messages"`"
    INFO[4]="`gettext "Default locale information"`"

    until [[ $COUNT -eq ${#VARS[*]} ]];do

        # Let user to reduce output using regular expression as
        # reference.
        if [[ ${VARS[$COUNT]} =~ $REGEX ]];then

            # Output list of environment variables using indirect
            # expansion (what a beautiful feature!) to output variable
            # value.
            cli_printMessage "${INFO[$COUNT]}:"
            cli_printMessage "${VARS[$COUNT]}=${!VARS[$COUNT]}" 'AsResponseLine'

        fi

        # Increment counter.
        COUNT=$(($COUNT + 1))

    done

}
