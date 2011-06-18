#!/bin/bash
#
# help_createChapters.sh -- This function creates the chapters'
# base directory structure using templates as reference.
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

function help_createChapters {

    local MANUAL_CHAPTER_NAME=''

    # Define list of chapter templates files used as base to create
    # the chapters' documentation manual.
    local FILE=''
    local FILES=$(cli_getFilesList ${MANUAL_TEMPLATE} \
        --pattern='chapter(-menu|-nodes)?\.texinfo' --mindepth='2')

    # Loop through chapter structures and create them.
    for FILE in $FILES;do

        # Redefine chapter directory based on template files.
        MANUAL_CHAPTER_NAME=$(basename $(dirname ${FILE}))

        # Verify texinfo templates used as based to build the chapter.
        # Be sure they are inside the working copy of CentOS Artwork
        # Repository (-w) and under version control (-n), too.
        cli_checkFiles ${FILE} -wn

        # Verify chapter's directory. If it doesn't exist, create it.
        if [[ ! -d ${MANUAL_BASEDIR}/${MANUAL_CHAPTER_NAME} ]];then
            svn mkdir ${MANUAL_BASEDIR}/${MANUAL_CHAPTER_NAME} --quiet
        fi

        # Copy template files into chapter's directory.
        svn cp ${FILE} ${MANUAL_BASEDIR}/${MANUAL_CHAPTER_NAME} --quiet

        # Remove content from `chapter-nodes.texinfo' instance to
        # start with a clean node structure. This file is also used by
        # to create new repository documentation entries, but we don't
        # need that information right now (when the `Directories'
        # chapter structure is created), just an empty copy of the
        # file. The node structure of `Directories' chapter is created
        # automatically based on repository directory structure.
        if [[ $FILE =~ "Directories/chapter-nodes\.texinfo$" ]];then
            echo "" > ${MANUAL_BASEDIR}/${MANUAL_CHAPTER_NAME}/chapter-nodes.${MANUAL_EXTENSION}
        fi

    done

}
