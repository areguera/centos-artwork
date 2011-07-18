#!/bin/bash
#
# texinfo_createChapter.sh -- This function creates manual's chapters
# based on templates.
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

function texinfo_createChapter {

    # Verify chapter's directory inside the manual.  The chapter's
    # directory is where chapter-specific information (e.g., manual's
    # sections) are stored in.  If this directory already exist,
    # assume it was created correctly in the past. Otherwise, prompt
    # its creation.
    if [[ -d $MANUAL_CHAPTER_DIR ]];then
        return
    else
        cli_printMessage "`gettext "The following documentation chapter will be created:"`"
        cli_printMessage "${MANUAL_CHAPTER_DIR}" --as-response-line
        cli_printMessage "`gettext "Do you want to continue?"`" --as-yesornorequest-line
    fi

    # Initialize chapter information (e.g., title).
    local MANUAL_CHAPTER_TITLE=''

    # Retrive manual's information from standard input.
    cli_printMessage "`gettext "Enter chapter's title"`" --as-request-line
    read MANUAL_CHAPTER_TITLE

    # Print action message.
    cli_printMessage "-" --as-separator-line
    cli_printMessage "`gettext "Creating chapter's files."`" --as-response-line

    # Define list of template files used to build chapter's main
    # definition files.
    local FILE=''
    local FILES=$(cli_getFilesList "${MANUAL_TEMPLATE_L10N}/Chapters" \
        --maxdepth='1' \
        --pattern="chapter(-menu|-nodes)?\.${MANUAL_EXTENSION}")

    # Create chapter's directory using subversion. This is the place
    # where all chapter-specific files will be stored in.
    if [[ ! -d ${MANUAL_CHAPTER_DIR} ]];then
        svn mkdir ${MANUAL_CHAPTER_DIR} --quiet
    fi

    # Create chapter's files using template files as reference.
    for FILE in $FILES;do

        # Verify texinfo templates used as based to build the chapter.
        # Be sure they are inside the working copy of CentOS Artwork
        # Repository (-w) and under version control (-n), too.
        cli_checkFiles ${FILE} -wn

        # Copy template files into chapter's directory.
        svn cp ${FILE} ${MANUAL_CHAPTER_DIR} --quiet

    done

    # Expand translation markers inside chapter's main definition
    # file.  Before expanding chapter information, be sure the slash
    # (/) character be scaped. Otherwise, if the slashes aren't scape,
    # they will be interpreted as sed's separator and provoke sed to
    # fail.
    sed -i -r \
        -e 's/ \// \\\//g' \
        -e "s/=CHAPTER_NAME=/${MANUAL_CHAPTER_NAME}/" \
        -e "s/=CHAPTER_TITLE=/${MANUAL_CHAPTER_TITLE}/" \
        ${MANUAL_CHAPTER_DIR}/chapter.${MANUAL_EXTENSION}

    # Remove content from `chapter-nodes.texinfo' file to start with a
    # clean node structure. This file is also used to create new
    # documentation entries, but we don't need that information right
    # now (when the chapter structure is created), just an empty copy
    # of the file. The node structure of chapter is created
    # automatically based on action value.
    echo "" > ${MANUAL_CHAPTER_DIR}/chapter-nodes.${MANUAL_EXTENSION}

    # Print action maessage.
    cli_printMessage "`gettext "Updating chapter menu and nodes inside manual structure."`" --as-response-line

    # Update chapter information inside the manual's texinfo
    # structure.
    ${FLAG_BACKEND}_updateChapterMenu
    ${FLAG_BACKEND}_updateChapterNodes

}
