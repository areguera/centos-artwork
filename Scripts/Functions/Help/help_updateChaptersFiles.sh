#!/bin/bash
#
# help_updateChaptersFiles.sh -- This function updates chapter related
# files.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_updateChaptersFiles {

    # Define chapter's generic structure. 
    local CHAPTERBODY="\
        @node $MANUAL_CHAPTER_NAME
        @chapter $MANUAL_CHAPTER_NAME
        @cindex $(echo $MANUAL_CHAPTER_NAME | tr '[[:upper:]]' '[[:lower:]]')
        @include $MANUAL_CHAPTER_NAME/chapter-intro.texi
        @include $MANUAL_CHAPTER_NAME/chapter-menu.texi
        @include $MANUAL_CHAPTER_NAME/chapter-nodes.texi"

    # Remove any space/tabs at the begining of @... lines.
    CHAPTERBODY=$(echo "$CHAPTERBODY" | sed -r 's!^[[:space:]]+@!@!')

    # Create directory to store chapter files.
    if [[ ! -d $MANUAL_CHAPTER_DIR ]];then
        mkdir $MANUAL_CHAPTER_DIR
    fi

    # Create files to store chapter information. If chapter files
    # already exist, they will be re-written and any previous
    # information inside them will be lost.
    echo "$CHAPTERBODY" > $MANUAL_CHAPTER_DIR/chapter.texi
    echo "" > $MANUAL_CHAPTER_DIR/chapter-menu.texi
    echo "" > $MANUAL_CHAPTER_DIR/chapter-nodes.texi

    # Initialize chapter instroduction using template file.
    cp ${FUNCCONFIG}/manual-cha-intro.texi $MANUAL_CHAPTER_DIR/chapter-intro.texi

}
