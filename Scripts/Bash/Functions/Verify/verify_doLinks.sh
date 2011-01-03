#!/bin/bash
#
# verify_doLinks.sh -- This function verifies required links your
# workstation needs in order to run the centos-art command correctly.
# If any required link is missing, the `centos-art.sh' script asks you
# to confirm their installation. When installing links, the
# `centos-art.sh' script uses the `ln' command to achieve the task.
#
# Copyright (C) 2009-2011  Alain Reguera Delgado
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

function verify_doLinks {

    local -a LINKS
    local -a TARGETS
    local -a LINKS_MISSING
    local LINKS_MISSING_ID=''

    # Define link names.
    LINKS[0]=/home/centos/bin/centos-art
    LINKS[1]=/home/centos/.fonts/denmark.ttf
    LINKS[2]=/home/centos/.inkscape/palettes/CentOS.gpl
    LINKS[3]=/home/centos/.$(rpm -q gimp | cut -d. -f-2)/palettes/CentOS.gpl
    LINKS[4]=/home/centos/artwork/branches/Scripts

    # Define link targets. Use array index as reference to know
    # relation between link names and targets. Be sure both link names
    # and link targets use the same array index value.
    TARGETS[0]=/home/centos/artwork/trunk/Scripts/Bash/centos-art.sh
    TARGETS[1]=/home/centos/artwork/trunk/Identity/Fonts/Ttf/denmark.ttf
    TARGETS[2]=/home/centos/artwork/trunk/Identity/Colors/CentOS.gpl
    TARGETS[3]=${TARGETS[2]}
    TARGETS[4]=/home/centos/artwork/trunk/Scripts/

    verify_doLinkCheck
    verify_doLinkReport
    verify_doLinkInstall

    # At this point all required links must be installed. To confirm
    # required links installation let's verify them once more.
    verify_doLinks

}
