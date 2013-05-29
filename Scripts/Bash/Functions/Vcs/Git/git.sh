#!/bin/bash
#
# git.sh -- This function standardizes Git tasks inside the
# repository.
#
# Copyright (C) 2009-2013 The CentOS Project
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

function git {

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Don't realize action value verification here. There are actions
    # like `copy' and `rename' that require two arguments from which
    # the last one doesn't exist at the moment of executing the
    # command. This will provoke the second action value verification
    # to fail when indeed is should not. Thus, go to action names
    # processing directly.

    # Execute action names. This is required in order to realize
    # actions like copy and rename which need two values as argument.
    # Otherwise, it wouldn't be possible to execute them because
    # action values would be processed one a time. Thus, lets work
    # with `$@' instead.
    for ACTIONNAM in $ACTIONNAMS;do
        $ACTIONNAM "$@"
    done

}
