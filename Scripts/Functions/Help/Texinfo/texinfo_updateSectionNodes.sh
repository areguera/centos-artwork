#!/bin/bash
#
# texinfo_updateSectionNodes.sh -- This function updates section's
# nodes definition files using section's menu definition file both
# inside the same chapter.
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

function texinfo_updateSectionNodes {

    # Build list of chapter nodes using entries from chapter menu as
    # reference.
    local NODES=$(cat $MANUAL_CHAPTER_DIR/chapter-menu.${MANUAL_EXTENSION} \
        | sed -r 's!^\* !!' | sed -r 's!:{1,2}.*$!!g' \
        | egrep -v '^@(end )?menu$' | sed -r 's! !:!g')

    # Build chapter nodes based on chapter menu.
    for NODE in $NODES;do

        NODE=$(echo "${NODE}" | sed -r 's!:! !g')
        INCL=$(echo "${NODE}" | sed -r 's! !/!' | sed -r 's! !-!g' | sed -r 's!/(.+)!/\L\1!').${MANUAL_EXTENSION}
        SECT=$(echo "${NODE}" | cut -d' ' -f2- )
        CIND=$(echo "${SECT}" | sed -r 's!^([[:alpha:]]+) (.+)!\u\1 \L\2!')

        # Create texinfo section file using templates, only if the
        # section file doesn't exist and hasn't been marked for
        # deletion.  Otherwise, when the files have been marked for
        # deletion, they will be created again from texinfo template
        # to working copy and that might create confusion.
        if [[ ! -f ${MANUAL_BASEDIR}/$INCL ]] \
            && [[ $(cli_getRepoStatus ${MANUAL_BASEDIR}/$INCL) != 'D' ]];then

            # Define absolute path to template assignment file. This
            # is the file that controls the way texinfo template files
            # are applied to documentation entries once they have been
            # created.
            local CONFFILE="${MANUAL_TEMPLATE}/manual.conf" 

            # Verify existence of configuration file.
            cli_checkFiles $CONFFILE

            # Retrive configuration lines from configuration file. Be
            # sure no line begining with `#' or space remain in the
            # line. Otherwise, it would be difficult to loop through
            # configuration lines.
            local CONFLINE=''
            local CONFLINES=$(cat ${CONFFILE} \
                | egrep -v '^#' \
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
                    | gawk 'BEGIN{FS="="}; { print $1 }' \
                    | sed -r 's![[:space:]]*!!g')

                CONFRHS=$(echo $CONFLINE \
                    | gawk 'BEGIN{FS="="}; { print $2 }' \
                    | sed -r 's![[:space:]]*!!g' | sed -r 's!^"(.+)"$!\1!')

                if [[ ${MANUAL_BASEDIR}/${INCL} =~ $CONFRHS ]];then
                    TEMPLATE="${MANUAL_TEMPLATE_L10N}/${CONFLHS}"
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

        fi

        # Expand common translation markers in documentation entry.
        cli_replaceTMarkers "${MANUAL_BASEDIR}/$INCL"

        # Replace node, section and concept index definitions already
        # defined with node, section and concept index translation
        # markers. Otherwise, incorrect sectioning may happen.
        sed -i -r \
            -e '/@node/c@node =NODE=' \
            -e '/@section/c@section =SECT=' \
            -e '/@cindex/c@cindex =CIND=' \
            "${MANUAL_BASEDIR}/$INCL"

        # Expand noce, section and concept index translation
        # markers in documentation entry.
        sed -i -r \
            -e "s!=NODE=!${NODE}!g" \
            -e "s!=SECT=!${SECT}!g" \
            -e "s!=CIND=!${CIND}!g" \
            "${MANUAL_BASEDIR}/$INCL"

        # Verify existence of chapter-nodes template files. If no
        # chapter-nodes template is found, stop script execution with
        # an error message. We cannot continue without it.
        cli_checkFiles ${MANUAL_TEMPLATE_L10N}/Chapters/chapter-nodes.${MANUAL_EXTENSION}

        # Output node information chapter-nodes template file using
        # the current texinfo menu information.
        cat ${MANUAL_TEMPLATE_L10N}/Chapters/chapter-nodes.${MANUAL_EXTENSION} \
            | sed -r "s!=INCL=!${INCL}!g"

    # Dump node definitions into document structure.
    done > $MANUAL_CHAPTER_DIR/chapter-nodes.${MANUAL_EXTENSION}

}
