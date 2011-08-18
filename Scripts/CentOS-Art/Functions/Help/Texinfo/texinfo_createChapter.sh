#!/bin/bash
#
# texinfo_createChapter.sh -- This function standardizes chapter
# creation insdie the manual structure.
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

function texinfo_createChapter {

    # Verify chapter directory inside the manual structure.  The
    # chapter directory is where chapter-specific information (e.g.,
    # chapter definition files and sections) are stored in.  If this
    # directory already exist, assume it was created correctly in the
    # past. Otherwise, request confirmation for creating it.
    if [[ -d $MANUAL_CHAPTER_DIR ]];then
        return
    else
        cli_printMessage "`gettext "The following documentation chapter will be created:"`"
        cli_printMessage "${MANUAL_CHAPTER_DIR}" --as-response-line
        cli_printMessage "`gettext "Do you want to continue?"`" --as-yesornorequest-line
    fi

    # Initialize chapter node, chapter index and chapter title.
    local MANUAL_CHAPTER_NODE=''
    local MANUAL_CHAPTER_TITLE=''
    local MANUAL_CHAPTER_CIND=''

    # Request the user to enter a chapter title.
    cli_printMessage "`gettext "Chapter Title"`" --as-request-line
    read MANUAL_CHAPTER_TITLE

    # Sanitate chapter node, chapter index and chapter title.
    MANUAL_CHAPTER_NODE=$(texinfo_getEntryNode "$MANUAL_CHAPTER_NAME")
    MANUAL_CHAPTER_CIND=$(texinfo_getEntryIndex "$MANUAL_CHAPTER_TITLE")
    MANUAL_CHAPTER_TITLE=$(texinfo_getEntryTitle "$MANUAL_CHAPTER_TITLE")

    # Print action message.
    cli_printMessage "-" --as-separator-line
    cli_printMessage "`gettext "Creating chapter files."`" --as-response-line

    # Define list of template files used to build the chapter main
    # definition files.
    local FILE=''
    local FILES=$(cli_getFilesList "${MANUAL_TEMPLATE_L10N}/Chapters" \
        --maxdepth='1' \
        --pattern="chapter(-menu|-nodes)?\.${MANUAL_EXTENSION}")

    # Create chapter directory using subversion. This is the place
    # where all chapter-specific files will be stored in.
    if [[ ! -d ${MANUAL_CHAPTER_DIR} ]];then
        svn mkdir ${MANUAL_CHAPTER_DIR} --quiet
    fi

    # Create chapter-specific files using template files as reference.
    for FILE in $FILES;do

        # Verify texinfo templates used as based to build the chapter
        # structure.  Be sure they are inside the working copy of
        # The CentOS Artwork Repository (-w) and under version control
        # (-n), too.
        cli_checkFiles ${FILE} -wn

        # Copy template files into the chapter directory.
        svn cp ${FILE} ${MANUAL_CHAPTER_DIR} --quiet

    done

    # Before expanding chapter information, be sure the slash (/)
    # character be scaped. Otherwise, if the slashes aren't scape,
    # they will be interpreted as sed's separator and might provoke
    # sed to complain.
    MANUAL_CHAPTER_NODE=$(echo "$MANUAL_CHAPTER_NODE" | sed -r 's/\//\\\//g')
    MANUAL_CHAPTER_CIND=$(echo "$MANUAL_CHAPTER_CIND" | sed -r 's/\//\\\//g')
    MANUAL_CHAPTER_TITLE=$(echo "$MANUAL_CHAPTER_TITLE" | sed -r 's/\//\\\//g')
    MANUAL_CHAPTER_NAME=$(echo "$MANUAL_CHAPTER_NAME" | sed -r 's/\//\\\//g')

    # Expand translation markers inside chapter main definition file.  
    sed -i -r \
        -e "s/=CHAPTER_NODE=/${MANUAL_CHAPTER_NODE}/" \
        -e "s/=CHAPTER_TITLE=/${MANUAL_CHAPTER_TITLE}/" \
        -e "s/=CHAPTER_CIND=/${MANUAL_CHAPTER_CIND}/" \
        -e "s/=CHAPTER_NAME=/${MANUAL_CHAPTER_NAME}/" \
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
    texinfo_updateChapterMenu
    texinfo_updateChapterNodes

}
