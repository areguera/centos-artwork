#!/bin/bash
#
# copy.sh -- This function copies files inside the repository and
# updates menu, nodes and cross references inside repository
# documentation manual for each file copied.
#
# When a copying action is performed inside the repository,
# centos-art.sh script verifies whether the file being copied (the
# source file) is a regular file or a directory.
#
# When a regular file is the source of copying actions, the target
# location can be anything accepted by subversion copy command.
# However, when the source location is a directory, centos-art.sh
# verifies whether that directory is empty or not. If the directory is
# empty, then it is copied to target. However, when there is one or
# more files inside, centos-art.sh loops recursively through all files
# inside that directory, builds a list of files to process and copy
# file by file to target location creating parents directories for
# target files when it be needed.
#
# Copyright (C) 2009, 2010, 2011 The CentOS Artwork SIG
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
    
function copy {

    local ACTIONNAM=''
    local ACTIONVAL=''
    local -a ACTIONVALS
    local -a SRC
    local DST=''
    local COUNT=0

    # Interpret arguments and options passed through command-line.
    copy_getOptions

    # Redefine positional parameters using ARGUMENTS. At this point,
    # option arguments have been removed from ARGUMENTS variable and
    # only non-option arguments remain in it. 
    eval set -- "$ARGUMENTS"

    # Store remaining arguments into an array. This way it is possible
    # to find out which is the last argument in the list. The last
    # argument in the list is considered the target location while all
    # other arguments are considered source locations.
    for ACTIONVAL in "$@";do
        ACTIONVALS[((++${#ACTIONVALS[*]}))]="$ACTIONVAL"
    done

    # Define list of source locations using remaining arguments.
    while [[ ${COUNT} -lt $((${#ACTIONVALS[*]} - 1)) ]];do
        SRC[((++${#SRC[*]}))]=${ACTIONVALS[$COUNT]}
        COUNT=$(($COUNT + 1))
    done

    # Define target location.
    DST=$(cli_checkRepoDirTarget "${ACTIONVALS[((${#ACTIONVALS[*]} - 1))]}")

    # Loop through source locations and copy them to target location.
    for ACTIONVAL in "${SRC[@]}";do
        
        # Check action value. Be sure the action value matches the
        # convenctions defined for source locations inside the working
        # copy.
        cli_checkRepoDirSource

        # Syncronize changes between repository and working copy. At
        # this point, changes in the repository are merged in the
        # working copy and changes in the working copy committed up to
        # repository.
        cli_syncroRepoChanges "$ACTIONVAL $DST"

        # Copy source location to target location.
        echo "svn copy $ACTIONVAL $DST"

        # Commit changes from working copy to central repository only.
        # At this point, changes in the repository are not merged in
        # the working copy, but chages in the working copy do are
        # committed up to repository.
        cli_commitRepoChanges "$ACTIONVAL $DST"

        # Update repository documentation manual structure.
        centos-art help "$ACTIONVAL" "$DST" --copy

    done

}
