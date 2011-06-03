#!/bin/bash
#
# texinfo_updateNodes.sh -- This function updates chapter's nodes
# definition using the chapter's menu as reference.
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

function texinfo_updateNodes {

    local TEXINFO_TEMPLATE=''

    # Retrive nodes' entries from chapter-menu.texinfo file.
    local NODES=$(cat $MANUAL_CHAPTER_DIR/chapter-menu.${FLAG_BACKEND} \
        | sed -r 's!^\* !!' | sed -r 's!:{1,2}.*$!!g' \
        | egrep -v '^@(end )?menu$' | sed -r 's! !:!g' | sort | uniq)

    # Re-build node structure based on menu information.
    for NODE in $NODES;do

        NODE=$(echo "${NODE}" | sed -r 's!:! !g')
        SECT=$(echo "${NODE}" | cut -d' ' -f2- | sed -r 's! !/!g')
        INCL=$(echo "${NODE}" | sed -r 's! !/!g').${FLAG_BACKEND}
        CIND=$(echo "${NODE}")

        # Create texinfo section file using templates, only if the
        # section file doesn't exist and hasn't been marked for
        # deletion.  Otherwise, when the files have been marked for
        # deletion, they will be created again from texinfo template
        # to working copy and that might create confusion.
        if [[ ! -f ${MANUAL_BASEDIR}/$INCL ]] \
            && [[ $(cli_getRepoStatus ${MANUAL_BASEDIR}/$INCL) != 'D' ]];then

            # Define what template to apply using the absolute path of
            # the documentation entry as reference.
            if [[ ${MANUAL_BASEDIR}/${INCL} =~ 'trunk/Scripts/Functions/[[:alnum:]]+$' ]];then
                TEXINFO_TEMPLATE="${MANUAL_TEMPLATE}/${MANUAL_CHAPTER_NAME}/section-functions.${FLAG_BACKEND}"
            else
                TEXINFO_TEMPLATE="${MANUAL_TEMPLATE}/${MANUAL_CHAPTER_NAME}/section.${FLAG_BACKEND}"
            fi

            # Verify texinfo template.
            cli_checkFiles $TEXINFO_TEMPLATE

            # Copy texinfo template to its destination.
            svn cp ${TEXINFO_TEMPLATE} ${MANUAL_BASEDIR}/$INCL --quiet

            # Expand common translation markers.
            cli_replaceTMarkers "${MANUAL_BASEDIR}/$INCL"

            # Expand texinfo-specific translation markers.
            ${FLAG_BACKEND}_makeSeeAlso "${MANUAL_BASEDIR}/$INCL" "$NODE"

        fi
        
        # Output node information based on texinfo menu.
        echo "@node $NODE"
        echo "@section `eval_gettext "The @file{\\\$SECT} Directory"`"
        echo "@cindex $CIND"
        echo "@include $INCL"
        echo ""

    # Dump node information into chapter node file.
    done > $MANUAL_CHAPTER_DIR/chapter-nodes.${FLAG_BACKEND}

}
