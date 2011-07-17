#!/bin/bash
#
# texinfo_createStructureChapters.sh -- This function initiates the
# chapter documentation structure of a manual, using the current
# language and template files as reference.
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

function texinfo_createStructureChapters {

    local MANUAL_CHAPTER_DIR=''

    # Define list of chapter templates files used to build the
    # documentation manual. Do not include the `Chapters' directory
    # here. It is used to build chapters based on value passed though
    # `--chapter' option passed in the command-line.
    local FILE=''
    local FILES=$(cli_getFilesList ${MANUAL_TEMPLATE_L10N} \
        --pattern='chapter(-menu|-nodes)?\.texinfo' --mindepth='2' \
        | grep -v '/Chapters/')

    # Loop through chapter structures and create them inside the
    # manual.
    for FILE in $FILES;do

        # Redefine manual's chapter directory based on template files.
        MANUAL_CHAPTER_DIR=${MANUAL_BASEDIR_L10N}/$(basename $(dirname ${FILE}))

        # Verify texinfo templates used as based to build the chapter.
        # Be sure they are inside the working copy of CentOS Artwork
        # Repository (-w) and under version control (-n), too.
        cli_checkFiles ${FILE} -wn

        # Verify chapter's directory. If it doesn't exist, create it.
        if [[ ! -d ${MANUAL_CHAPTER_DIR} ]];then
            svn mkdir ${MANUAL_CHAPTER_DIR} --quiet
        fi

        # Copy template files into chapter's directory.
        svn cp ${FILE} ${MANUAL_CHAPTER_DIR} --quiet

    done

}
