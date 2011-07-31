#!/bin/bash
#
# cli_getRepoName.sh -- This function standardize file and directories
# name convenction inside the working copy of CentOS Artowrk
# Repository. As convenction, regular files are written in lower case
# and directories are written in lower case but with the first letter
# in upper case.  Use this function to sanitate the name of regular
# files and directory components of paths you work with.
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

function cli_getRepoName {

    # Define the name we want to apply verifications to.
    local NAME="$1"

    # Avoid using options as it were names. When name value is empty
    # but an option is provided, the option becomes the first
    # positional argument and is evaluated as it were a name which is
    # something we need to prevent from happening.
    if [[ $NAME =~ '^-' ]];then
        return
    fi

    # Look for options passed through positional parameters.
    case "$2" in

        -f|--basename )

            # Reduce the path passed to use just the non-directory
            # part of it (i.e., the last component in the path; _not_
            # the last "real" directory in the path).
            NAME=$(basename $NAME)

            # Clean value.
            NAME=$(echo $NAME \
                | tr -s ' ' '_' \
                | tr '[:upper:]' '[:lower:]')
            ;;

        -d|--dirname )

            local DIR=''
            local DIRS=''
            local CLEANDIRS=''
            local PREFIXDIR=''

            # In order to sanitate each directory in a path, it is
            # required to break off the path string so each component
            # can be worked out individually and later combine them
            # back to create a clean path string.
                
            # Reduce path information passed to use the directory part
            # of it only.  Of course, this is applied if there is a
            # directory part in the path.  Assuming there is no
            # directory part but a non-empty value in the path, use
            # that value as directory part and clean it up.
            if [[ $NAME =~ '.+/.+' ]];then

                # When path information is reduced, we need to
                # consider that absolute paths contain some
                # directories outside the working copy directory
                # structure that shouldn't be sanitated  (e.g., /home,
                # /home/centos, /home/centos/artwork,
                # /home/centos/artwork/turnk, trunk, etc.) So, we keep
                # them unchaged for later use.
                PREFIXDIR=$(echo $NAME \
                    | sed -r "s,^(($(cli_getRepoTLDir)/)?(trunk|branches|tags)/).+$,\1,")

                # ... and remove them from the path information we do
                # want to sanitate.
                DIRS=$(dirname "$NAME" \
                    | sed -r "s!^${PREFIXDIR}!!" \
                    | tr '/' ' ')

            else
                
                # At this point, there is not directory part in the
                # information passed, so use the value passed as
                # directory part as such. 
                DIRS=$NAME

            fi

            for DIR in $DIRS;do

                # Sanitate directory component.
                if [[ $DIR =~ '^[a-z]' ]];then
                    DIR=$(echo ${DIR} \
                        | tr -s ' ' '_' \
                        | tr '[:upper:]' '[:lower:]' \
                        | sed -r 's/^([[:alpha:]])/\u\1/')
                fi

                # Rebuild path using sanitated values.
                CLEANDIRS="${CLEANDIRS}/$DIR"

            done

            # Redefine path using sanitated values.
            NAME=$(echo ${CLEANDIRS} | sed -r "s!^/!!")

            # Add prefix directory information to sanitated path
            # information.
            if [[ "$PREFIXDIR" != '' ]];then
                NAME=${PREFIXDIR}${NAME}
            fi
        ;;

    esac

    # Print out the clean path string.
    echo $NAME

}
