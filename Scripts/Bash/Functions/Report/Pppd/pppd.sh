#!/bin/bash
#
# pppd.sh -- This functionality parses /var/log/messages and returns
# time reports for pppd.
#
# Copyright (C) 2012 Alain Reguera Delgado
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
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function pppd {

    local MESSAGES_PATH=''
    local ENTRY=''
    local ENTRY_ID=''
    local ENTRIES=''
    local ENTRIES_IDS=''
    local INTERFACE=""
    local INTERFACES_REGEX=""

    # Initizalice the flags used in this functionality.
    local FLAG_INTERFACES=''
    local FLAG_MONTH=$(LANG=C;date | gawk '{print $2}')
    local FLAG_FIRSTDAY=$(LANG=C;date | gawk '{print $3}')
    local FLAG_LASTDAY=${FLAG_FIRSTDAY}

    # Interpret arguments and options passed through command-line.
    pppd_getOptions

    # Be sure the first day isn't greater than the last day used. In
    # case it does, use the last day value as first day value.
    # Otherwise no record would be output.
    if [[ $FLAG_FIRSTDAY > $FLAG_LASTDAY ]];then
        FLAG_FIRSTDAY=$FLAG_LASTDAY
    fi

    # Define absolute path to log messages.
    MESSAGES_PATH='/var/log/messages*'

    # Store log messages for later processing. Because messages
    # required root privilages it is necessary to make a sudo action
    # to read it. To avoid doing sudo actions constantly agains the
    # same file, make just one sudo action to read the log messages
    # and store the result in order for all other commands to be able
    # read the information. Also, it is convenient to work with a
    # unique source information instance from begining to end.
    MESSAGES=$(sudo cat ${MESSAGES_PATH} \
        | gawk '{if ($5 ~ /^pppd\[[0-9]+]:$/ \
            && $1 == "'${FLAG_MONTH}'" \
            && $2 >= '${FLAG_FIRSTDAY}' \
            && $2 <= '${FLAG_LASTDAY}') print $0 }')

    # Be sure the interface isn't an empty value. When no interface
    # value is passed as argument to this function, use `ppp0'
    # interface as default value.
    if [[ ! $FLAG_INTERFACES ]];then
        FLAG_INTERFACES="ppp0"
    fi

    # Be sure the interface meets the correct format. When a malformed
    # interface is passed as first argument to this function, use
    # `ppp0' interface as default value.
    for INTERFACE in $FLAG_INTERFACES;do
        if [[ $INTERFACE =~ '^ppp[0-9]$' ]];then
            INTERFACE_REGEX="${INTERFACE_REGEX}${INTERFACE}|"
        else
            continue
        fi
    done

    # Build regular expression pattern to match interfaces passed as
    # argument to pppd function.
    INTERFACE_REGEX=$(echo $INTERFACE_REGEX | sed -r 's/\|$//')
    INTERFACE_REGEX="(${INTERFACE_REGEX})"

    # Execute action names based on whether they were provided or not.
    if [[ $ACTIONNAMS == '' ]];then

        # When action names are not provided, define action names that
        # will take place, explicitly. This is the default behaviour.
        return

    else

        # When action names are provided, loop through them and
        # execute them one by one.
        for ACTIONNAM in $ACTIONNAMS;do

            # Excecute action name.
            ${CLI_SUBFUNC}_${ACTIONNAM}

        done

    fi

}
