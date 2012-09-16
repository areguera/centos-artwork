#!/bin/bash
#
# svn.sh -- This function standardizes subversion tasks inside the
# repository.
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

function svn {

    local ACTIONNAM=''
    local ACTIONNAMS=''
    local ACTIONVAL=''

    # Define absolute path to Subversion command.
    SVN=/usr/bin/svn

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Interpret arguments and options passed through command-line.
    svn_getOptions

    # Define action value. We use non-option arguments to define the
    # action value (ACTIONVAL) variable.
    for ACTIONVAL in "$@";do
        
        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        ACTIONVAL=$(cli_checkRepoDirSource $ACTIONVAL)

        # Execute action names.
        for ACTIONNAM in $ACTIONNAMS;do
            $ACTIONNAM
        done

    done

}
