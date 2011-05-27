#!/bin/bash
#
# texinfo_updateChaptersFiles.sh -- This function updates chapter related
# files.
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

function texinfo_updateChaptersFiles {

    # Define chapter's generic structure. 
    local CHAPTERBODY="\
        @node $MANUAL_CHAPTER_NAME
        @chapter $MANUAL_CHAPTER_NAME
        @cindex $(echo $MANUAL_CHAPTER_NAME | tr '[[:upper:]]' '[[:lower:]]')
        @include $MANUAL_CHAPTER_NAME/chapter-intro.$FLAG_BACKEND
        @include $MANUAL_CHAPTER_NAME/chapter-menu.$FLAG_BACKEND
        @include $MANUAL_CHAPTER_NAME/chapter-nodes.$FLAG_BACKEND"

    # Remove any space/tabs at the begining of @... lines.
    CHAPTERBODY=$(echo "$CHAPTERBODY" | sed -r 's!^[[:space:]]+@!@!')

    # Create directory to store chapter files.
    if [[ ! -d $MANUAL_CHAPTER_DIR ]];then
        mkdir $MANUAL_CHAPTER_DIR
    fi

    # Create files to store chapter information. If chapter files
    # already exist, they will be re-written and any previous
    # information inside them will be lost.
    echo "$CHAPTERBODY" > $MANUAL_CHAPTER_DIR/chapter.${FLAG_BACKEND}
    echo "" > $MANUAL_CHAPTER_DIR/chapter-menu.${FLAG_BACKEND}
    echo "" > $MANUAL_CHAPTER_DIR/chapter-nodes.${FLAG_BACKEND}

    # Initialize chapter instroduction using template file.
    cp ${MANUAL_TEMPLATE}/manual-chapter-intro.${FLAG_BACKEND} $MANUAL_CHAPTER_DIR/chapter-intro.${FLAG_BACKEND}

}
