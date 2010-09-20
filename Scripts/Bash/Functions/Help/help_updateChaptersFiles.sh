#!/bin/bash
#
# help_updateChaptersFiles.sh -- This function updates chapter related
# files.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
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
# 
# ----------------------------------------------------------------------
# $Id: help_updateChaptersFiles.sh 44 2010-09-17 05:58:18Z al $
# ----------------------------------------------------------------------

function help_updateChaptersFiles {

    # Define chapter's generic structure. 
    local CHAPTERBODY="\
        @node $CHAPTERNAME
        @chapter $CHAPTERNAME
        @cindex $(echo $CHAPTERNAME | tr '[[:upper:]]' '[[:lower:]]')
        @include $CHAPTERNAME/${MANUALS_FILE[7]}
        @include $CHAPTERNAME/${MANUALS_FILE[8]}
        @include $CHAPTERNAME/${MANUALS_FILE[9]}"

    # Remove any space/tabs at the begining of @... lines.
    CHAPTERBODY=$(echo "$CHAPTERBODY" | sed -r 's!^[[:space:]]+@!@!')

    # Create directory to store chapter files.
    if [[ ! -d $ENTRYCHAPTER ]];then
        mkdir $ENTRYCHAPTER
    fi

    # Create files to store chapter information. If chapter files
    # already exist, they will be re-written and any previous
    # information inside them will be lost.
    echo "$CHAPTERBODY" > $ENTRYCHAPTER/${MANUALS_FILE[6]}
    echo "" > $ENTRYCHAPTER/${MANUALS_FILE[8]}
    echo "" > $ENTRYCHAPTER/${MANUALS_FILE[9]}

    # Initialize chapter instroduction using template file.
    cp ${MANUALS_DIR[6]}/repository-chapter-intro.texi $ENTRYCHAPTER/${MANUALS_FILE[7]}
    sed -r -i \
        -e "s!=GOALS=!`gettext "Goals"`!g" \
        -e "s!=USAGE=!`gettext "Usage"`!g" \
        -e "s!=CONCEPTS=!`gettext "Concepts"`!g" \
        -e "s!=DIRECTORIES=!`gettext "Directories"`!g" \
        $ENTRYCHAPTER/${MANUALS_FILE[7]}
}
