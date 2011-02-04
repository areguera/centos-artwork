#!/bin/bash
#
# cli_getRepoName.sh -- This function sets naming convenction. Inside
# CentOS Artowrk Repository, regular files are written in lower case
# and directories are written in lower case but with the first letter
# in upper case. Use this function to sanitate the name of regular
# files and directory components of paths you work with.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function cli_getRepoName {

    local NAME="$1"
    local TYPE="$2"
    local DIRS=''
    local DIR=''
    local CLEANDIRS=''
    local PREFIXDIR=''

    case $TYPE in

        f | basename )

            # Reduce the path passed to use just the non-directory
            # part of it (i.e., the last component in the path; _not_
            # the last "real" directory in the path).
            NAME=$(basename $NAME)

            # Clean value.
            NAME=$(echo $NAME \
                | tr -s ' ' '_' \
                | tr '[:upper:]' '[:lower:]')
            ;;

        d | dirname )

            # Reduce path information passed to use just the directory
            # part of it.  Of course, this is applied only if there is
            # a directory part in the path. However, if there is no
            # directory part but there is a non-empty value in the
            # path, assume that value as directory part and clean it
            # up.
            if [[ $NAME =~ '/.+' ]];then

                # When path information is reduced, we need to take
                # into account that absolute path may be provided.
                # Absolute paths include directory structures outside
                # the repository directory structure we don't want to
                # sanitate (e.g., /home/, /home/centos/,
                # /home/centos/artwork, /home/centos/artwork/turnk/,
                # trunk/, etc.). In these cases, it is required that
                # those path component remain untouched. So, in the
                # sake of keeping path components, outside repository
                # directory structure untouched, we use the PREFIXDIR
                # variable to temporarly store the prefix directory
                # structure we don't want to sanitate.
                PREFIXDIR=$(echo $NAME \
                    | sed -r "s,^((${HOME}/artwork/)?(trunk|branches|tags)/).+$,\1,")

                # ... and remove it from the path information we do
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

                # Sanitate path component.
                DIR=$(echo ${DIR} \
                    | tr -s ' ' '_' \
                    | tr '[:upper:]' '[:lower:]' \
                    | sed -r 's/^([[:alpha:]])/\u\1/')

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

        fd | basename-to-dirname )

            # Retrive non-directory part.
            NAME=$(cli_getRepoName $NAME 'f')

            # Retrive cleaned directory part from non-directory part.
            NAME=$(cli_getRepoName $NAME 'd')
            ;;

        df | dirname-to-basename )

            # Retrive cleaned directory part from non-directory part.
            NAME=$(cli_getRepoName $NAME 'd')

            # Retrive non-directory part.
            NAME=$(cli_getRepoName $NAME 'f')
    
    esac

    # Output clean path information.
    echo $NAME

}
