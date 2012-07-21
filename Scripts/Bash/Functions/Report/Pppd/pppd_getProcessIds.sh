#!/bin/bash
#
# pppd_getProcessIds.sh --- This function parses the pppd's log
# messages and returns the process ids of each pppd connection.
#
# This function works with regular pppd log messages like the following:
#
#    Jul 13 00:04:42 projects pppd[8076]: pppd 2.4.4 started by root, uid 0
#    Jul 13 00:04:42 projects pppd[8076]: Using interface ppp0
#    Jul 13 00:04:42 projects pppd[8076]: local  IP address 10.64.64.64
#    Jul 13 00:04:42 projects pppd[8076]: remote IP address 10.112.112.112
#    Jul 13 00:04:58 projects pppd[8076]: Starting link
#    Jul 13 00:05:34 projects pppd[8076]: Serial connection established.
#    Jul 13 00:05:34 projects pppd[8076]: Connect: ppp0 <--> /dev/ttyACM0
#    Jul 13 00:05:36 projects pppd[8076]: PAP authentication succeeded
#    Jul 13 00:05:36 projects pppd[8076]: Local IP address changed to 200.55.159.1
#    Jul 13 00:05:36 projects pppd[8076]: Remote IP address changed to 192.168.254.182
#    Jul 13 01:53:30 projects pppd[8076]: Terminating on signal 15
#    Jul 13 01:53:30 projects pppd[8076]: Connect time 107.9 minutes.
#    Jul 13 01:53:30 projects pppd[8076]: Sent 2243056 bytes, received 21047698 bytes.
#    Jul 13 01:53:36 projects pppd[8076]: Connection terminated.
#    Jul 13 01:53:37 projects pppd[8076]: Terminating on signal 15
#    Jul 13 01:53:37 projects pppd[8076]: Exit.
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

function pppd_getProcessIds {

    echo "$MESSAGES" | gawk '{print $5}' \
        | sed -r 's!pppd\[([0-9]+)]:!\1!' | sort | uniq

}
