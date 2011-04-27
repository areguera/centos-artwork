#!/bin/bash
#
# help_updateNodes.sh -- This function updates chapter's nodes
# definition using the chapter's menu as reference.
#
# Copyright (C) 2009-2011 The CentOS Project
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

function help_updateNodes {

    # Retrive nodes' entries from chapter-menu.texi file.
    local NODES=$(cat $MANUAL_CHAPTER_DIR/chapter-menu.texi \
        | sed -r 's!^\* !!' | sed -r 's!:{1,2}.*$!!g' \
        | egrep -v '^@(end )?menu$' | sed -r 's! !:!g' | sort | uniq)

    # Re-build node structure based on menu information.
    for NODE in $NODES;do

        NODE=$(echo "${NODE}" | sed -r 's!:! !g')
        SECT=$(echo "$NODE" | sed -r 's! !/!g' | sed "s!${MANUAL_CHAPTER_NAME}/!!")
        INCL=$(echo "$NODE" | sed -r 's! !/!g').texi
        CIND=$(echo "$NODE")

        # Create an empty directory to store texinfo files.
        if [[ ! -d ${MANUAL_BASEDIR}/$(dirname "$INCL") ]];then
             mkdir -p ${MANUAL_BASEDIR}/$(dirname "$INCL")
        fi

        # Create texinfo section file using its template.
        if [[ ! -f ${MANUAL_BASEDIR}/$INCL ]];then
            cp ${FUNCCONFIG}/manual-section.texi ${MANUAL_BASEDIR}/$INCL
        fi

        # Output node information based on texinfo menu.
        echo "@node $NODE"
        echo "@section `eval_gettext "The @file{\\\$SECT} Directory"`"
        echo "@cindex $CIND"
        echo "@include $INCL"
        echo ""

    # Dump node information into chapter node file.
    done > $MANUAL_CHAPTER_DIR/chapter-nodes.texi

}

