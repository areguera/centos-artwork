#!/bin/bash
#
# texinfo_createChapterFiles.sh -- This function creates the
# chapters' base directory structure using templates as reference.
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

function texinfo_createChapterFiles {

    local MANUAL_CHAPTER_DIR=''

    # Define list of chapter templates files used as base to create
    # the chapters' documentation manual.
    local FILE=''
    local FILES=$(cli_getFilesList ${MANUAL_TEMPLATE} \
        --pattern='\.texinfo' --mindepth='2')

    # Loop through chapter structures and create them.
    for FILE in $FILES;do

        # Redefine chapter directory based on template files.
        MANUAL_CHAPTER_DIR=$(basename $(dirname ${FILE}))

        # Verify texinfo templates used as based to build the chapter.
        # Be sure they are inside the working copy of CentOS Artwork
        # Repository (-w) and under version control (-n), too.
        cli_checkFiles ${FILE} -wn

        # Verify chapter's directory. If it doesn't exist, create it.
        if [[ ! -d ${MANUAL_BASEDIR}/${MANUAL_CHAPTER_DIR} ]];then
            svn mkdir ${MANUAL_BASEDIR}/${MANUAL_CHAPTER_DIR} --quiet
        fi

        # Copy template files into chapter's directory.
        svn cp ${FILE} ${MANUAL_BASEDIR}/${MANUAL_CHAPTER_DIR} --quiet

    done

}

