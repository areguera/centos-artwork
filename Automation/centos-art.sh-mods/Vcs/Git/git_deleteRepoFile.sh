#!/bin/bash
#
# git_deleteRepoFile.sh -- This function standardizes the way
# centos-art.sh script deletes files and directories inside the
# working copy.
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

function git_deleteRepoFile {

    local TARGET=$(cli_checkRepoDirSource ${1})

    # Print action reference.
    cli_printMessage "${TARGET}" --as-deleting-line

    # Reset target to its default status before remove it from the
    # work copy.
    if [[ $(cli_runFnEnvironment vcs --status ${TARGET}) =~ '^(A|M|R)$' ]];then
        ${COMMAND} reset HEAD ${TARGET} --quiet
    fi

    # Remove target based on whether it is under version control or
    # not.
    if [[ $(cli_runFnEnvironment vcs --status ${TARGET}) =~ '^\?\?$' ]];then
        # Target isn't under version control.
        if [[ -d ${TARGET} ]];then
            rm -r ${TARGET}
        else
            rm ${TARGET} 
        fi 
    else
        # Target is under version control.
        if [[ -d ${TARGET} ]];then
            ${COMMAND} rm ${TARGET} -r --force --quiet
        else
            ${COMMAND} rm ${TARGET} --force --quiet
        fi 
    fi

}
