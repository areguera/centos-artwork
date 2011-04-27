#!/bin/bash
#
# cli_checkRepoDirTarget.sh -- This function provides input validation
# to repository entries considered as target location.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
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

function cli_checkRepoDirTarget {

    local LOCATION="$1"

    # Redefine target value to build repository absolute path from
    # repository top level on. As we are removing
    # /home/centos/artwork/ from all centos-art.sh output (in order to
    # save horizontal output space), we need to be sure that all
    # strings begining with trunk/..., branches/..., and tags/... use
    # the correct absolute path. That is, you can refer trunk's
    # entries using both /home/centos/artwork/trunk/... or just
    # trunk/..., the /home/centos/artwork/ part is automatically added
    # here. 
    if [[ $LOCATION =~ '^(trunk|branches|tags)/.+$' ]];then
        LOCATION=${HOME}/artwork/$LOCATION 
    fi

    # Print target location.
    echo $LOCATION

}
