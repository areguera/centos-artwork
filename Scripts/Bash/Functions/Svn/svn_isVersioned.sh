#!/bin/bash
#
# svn_isVersioned.sh -- This function determines whether a location is
# under version control or not. When the location is under version
# control, this function returns `true'. when the location isn't under
# version control, this function returns `false'.
#
# Copyright (C) 2009, 2010, 2011, 2012 The CentOS Project
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

function svn_isVersioned {

    # Use subversion to determine whether the location is under
    # version control or not.
    ${SVN} info $ACTIONVAL > /dev/null 2>&1

    # Verify subversion exit status and print output.
    echo $?

}
