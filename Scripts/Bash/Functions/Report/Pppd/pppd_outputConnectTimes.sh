#!/bin/bash
#
# pppd_outputConnectTime.sh -- Output connect time report for pppd
# interfaces.
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

function pppd_outputConnectTimes {

    local HOURS=0
    local MINUTES=0

    # Build list of entries. This list contains the information will
    # parse to build the connect time report.
    pppd_getEntries

    # Define number of minutes.
    MINUTES=$(echo "$ENTRIES" \
        | egrep 'Connect time [0-9.]+ minutes\.' \
        | cut -d' ' -f8 \
        | gawk '{ x += $1 }; END { print x }')

    # Define number of hours.
    HOURS=$(echo "$MINUTES" | gawk '{print $1 / 60}')

    # Build connect time report.
    cli_printMessage '-' --as-separator-line
    cli_printMessage "`eval_gettext "Connect time through interfaces: \\\$INTERFACES"`"
    cli_printMessage '-' --as-separator-line
    echo "$ENTRIES" | egrep 'Connect time [0-9.]+ minutes.'
    cli_printMessage '-' --as-separator-line
    cli_printMessage "`eval_gettext "You have consumed \\\$MINUTES minutes (\\\${HOURS} hours)."`"
    cli_printMessage '-' --as-separator-line

}
