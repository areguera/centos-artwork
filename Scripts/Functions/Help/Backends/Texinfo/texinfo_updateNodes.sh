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

            # Define absolute path to section templates assignment
            # file. This is the file that hold the relation between
            # section template files and repository paths when
            # documentation entries are created.
            local CONFFILE="${MANUAL_TEMPLATE}/${MANUAL_NAME}.conf" 

            # Verify existence of configuration file.
            cli_checkFiles $CONFFILE

            # Retrive configuration lines from configuration file. Be
            # sure no line begining with `#' or space remain in the
            # line. Otherwise, it would be difficult to loop through
            # configuration lines.
            local CONFLINE=''
            local CONFLINES=$(cat ${CONFFILE} \
                | egrep -v '#' \
                | egrep -v '^[[:space:]]*$' \
                | sed -r 's![[:space:]]*!!g')

            # Initialize both left hand side and right hand side
            # configuration values.
            local CONFLHS=''
            local CONFRHS=''

            # Initialize absolute path to final texinfo template.
            local TEMPLATE=''

            # Define what section template to apply using
            # documentation entry absolute path and values provided by
            # configuration line. Be sure to break the loop in the
            # first match.
            for CONFLINE in $CONFLINES;do

                CONFLHS=$(echo $CONFLINE \
                    | gawk 'BEGIN{FS = "="}; { print $1 }' \
                    | sed -r 's![[:space:]]*!!g')

                CONFRHS=$(echo $CONFLINE \
                    | gawk 'BEGIN{FS = "="}; { print $2 }' \
                    | sed -r 's![[:space:]]*!!g' | sed -r 's!^"(.+)"$!\1!')

                if [[ ${MANUAL_BASEDIR}/${INCL} =~ $CONFRHS ]];then
                    TEMPLATE="${MANUAL_TEMPLATE}/${CONFLHS}"
                    break
                fi

            done

            # Verify existence of texinfo template file. If no
            # template is found, stop script execution with an error
            # message. We cannot continue without it.
            cli_checkFiles $TEMPLATE

            # Create documentation entry using texinfo template as
            # reference.
            svn cp ${TEMPLATE} ${MANUAL_BASEDIR}/$INCL --quiet

            # Expand common translation markers in documentation entry.
            cli_replaceTMarkers "${MANUAL_BASEDIR}/$INCL"

            # Expand `Goals' subsection translation markers in
            # documentation entry.
            sed -i -r "s!=SECT=!${SECT}!g" "${MANUAL_BASEDIR}/$INCL"

            # Expand `See also' subsection translation markers in
            # documentation entry.
            ${FLAG_BACKEND}_makeSeeAlso "${MANUAL_BASEDIR}/$INCL" "$NODE"

        fi

        # Verify existence of chapter-nodes template files. If no
        # chapter-nodes template is found, stop script execution with
        # an error message. We cannot continue without it.
        cli_checkFiles ${MANUAL_TEMPLATE}/${MANUAL_CHAPTER_NAME}/chapter-nodes.${FLAG_BACKEND}

        # Output node information chapter-nodes template file using
        # the current texinfo menu information.
        cat ${MANUAL_TEMPLATE}/${MANUAL_CHAPTER_NAME}/chapter-nodes.${FLAG_BACKEND} \
            | sed -r -e "s!=NODE=!${NODE}!g" -e "s!=SECT=!${SECT}!g" \
                     -e "s!=CIND=!${CIND}!g" -e "s!=INCL=!${INCL}!g"

    # Dump node definitions into document structure.
    done > $MANUAL_CHAPTER_DIR/chapter-nodes.${FLAG_BACKEND}

}
